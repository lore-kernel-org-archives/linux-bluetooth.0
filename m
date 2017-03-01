Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+XivaqFmfGvXfkS4vY7WBRHkU9FhpkgYPkaP-4GYArgQ@mail.gmail.com>
References: <1488330416-10463-1-git-send-email-juha.kuikka@synapse.com>
 <1488330416-10463-4-git-send-email-juha.kuikka@synapse.com> <CABBYNZ+XivaqFmfGvXfkS4vY7WBRHkU9FhpkgYPkaP-4GYArgQ@mail.gmail.com>
From: Juha Kuikka <juha.kuikka@synapse.com>
Date: Wed, 1 Mar 2017 11:25:20 -0800
Message-ID: <CAKHsmFo8=8bYHZC8hesXK5ZcX_DrArsNEUs6bFoD=h3xg7wChQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] hog: Optionally destroy uHID device when disconnected
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Juha Kuikka <juha.kuikka@gmail.com>,
        Petri Gynther <pgynther@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Mar 1, 2017 at 2:58 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Juha,
>
> On Wed, Mar 1, 2017 at 3:06 AM, Juha Kuikka <juha.kuikka@synapse.com> wrote:
>> Unlink bluetooth classic HID, HoG persists the uHID device after across
>> connections. This is fine for stateless devices that require fast reconnections
>> but some device utilize hidraw to configure them upon connection and with the
>> persisting uHID device, reconnections are hidden from them.
>>
>> Similarly, applications such as game emulators may be using the presence of the
>> HID or the accompanying input event devices to indicate that it is available,
>> thus changing behavior.
>>
>> This patch introduces a configuration option that, when set, destroys the uHID
>> device upon disconnection, it gets re-created upon reconnection, just like on
>> initial connection.
>> ---
>>  profiles/input/hog-lib.c | 29 +++++++++++++++++++++++++++++
>>  profiles/input/hog-lib.h |  1 +
>>  2 files changed, 30 insertions(+)
>>
>> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
>> index dab385f..b2a371e 100644
>> --- a/profiles/input/hog-lib.c
>> +++ b/profiles/input/hog-lib.c
>> @@ -129,6 +129,13 @@ struct gatt_request {
>>         void *user_data;
>>  };
>>
>> +static bool uhid_destroy = false;
>> +
>> +void bt_hog_set_uhid_destroy(bool state)
>> +{
>> +       uhid_destroy = state;
>> +}
>> +
>>  static struct gatt_request *create_request(struct bt_hog *hog,
>>                                                         void *user_data)
>>  {
>> @@ -1565,6 +1572,25 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
>>         }
>>  }
>>
>> +static void destroy_uhid(struct bt_hog *hog)
>> +{
>> +       struct uhid_event ev = {
>> +               .type = UHID_DESTROY
>> +       };
>> +       int err;
>> +
>> +       if (hog->uhid_created) {
>> +               err = bt_uhid_send(hog->uhid, &ev);
>> +               if (err < 0) {
>> +                       error("bt_uhid_send: %s", strerror(-err));
>> +                       return;
>> +               }
>> +               hog->uhid_created = false;
>> +
>> +               DBG("HoG destroyed uHID device");
>> +       }
>> +}
>> +
>>  bool bt_hog_attach(struct bt_hog *hog, void *gatt)
>>  {
>>         GSList *l;
>> @@ -1651,6 +1677,9 @@ void bt_hog_detach(struct bt_hog *hog)
>>         queue_foreach(hog->gatt_op, (void *) cancel_gatt_req, NULL);
>>         g_attrib_unref(hog->attrib);
>>         hog->attrib = NULL;
>> +
>> +       if (uhid_destroy)
>> +               destroy_uhid(hog);
>
> It probably make sense to check if hog->uhid_created.

That is checked within destroy_uhid() but I can move it here so the
checks are all in one place.

>
>>  }
>>
>>  int bt_hog_set_control_point(struct bt_hog *hog, bool suspend)
>> diff --git a/profiles/input/hog-lib.h b/profiles/input/hog-lib.h
>> index 415dc63..de8c42f 100644
>> --- a/profiles/input/hog-lib.h
>> +++ b/profiles/input/hog-lib.h
>> @@ -39,3 +39,4 @@ void bt_hog_detach(struct bt_hog *hog);
>>
>>  int bt_hog_set_control_point(struct bt_hog *hog, bool suspend);
>>  int bt_hog_send_report(struct bt_hog *hog, void *data, size_t size, int type);
>> +void bt_hog_set_uhid_destroy(bool state);
>
> Ive made this per instance.
>
>> --
>> 2.7.4
>
> I would consider doing this in the bt_uhid instance

Can you elaborate? Moving the uhid_destroy flag into struct bt_uhid?
Or just into the src/shared/uhid.c? Since the configuration file
option is global and read before anything else, no instances of bt_hog
or bt_uhid are present. Are you thinking of adding a runtime
configuration mechanism?

The user of bt_uhid is responsible for creating the uhid device so I
made the destruction mirror that.

 - Juha
