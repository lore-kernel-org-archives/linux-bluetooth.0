Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20141222133056.GD25294@aemeltch-MOBL1>
References: <1419248953-31147-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<3155639.Ajs76qMxjk@leonov>
	<20141222133056.GD25294@aemeltch-MOBL1>
Date: Mon, 22 Dec 2014 12:07:22 -0200
Message-ID: <CABBYNZJ_9ZCUGq5V8tYF3N9_rXjiuDrHZj8UrzM00iMKSGvJXw@mail.gmail.com>
Subject: Re: [PATCH] android/scpp: Fix using freed memory
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	Szymon Janc <szymon.janc@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Dec 22, 2014 at 11:30 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> Hi Szymon,
>
> On Mon, Dec 22, 2014 at 02:13:53PM +0100, Szymon Janc wrote:
>> Hi Andrei,
>>
>> On Monday 22 of December 2014 13:49:13 Andrei Emeltchenko wrote:
>> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>> >
>> > Fixes use after free memory bug.
>> > req is assigned to user_data and then freed with destroy_gatt_req(req)
>> > ---
>> >  android/scpp.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/android/scpp.c b/android/scpp.c
>> > index 77f48cd..9f60c9f 100644
>> > --- a/android/scpp.c
>> > +++ b/android/scpp.c
>> > @@ -301,8 +301,6 @@ static void refresh_discovered_cb(uint8_t status, GSList
>> > *chars, uint16_t start, end;
>> >     bt_uuid_t uuid;
>> >
>> > -   destroy_gatt_req(req);
>> > -
>> >     if (status) {
>> >             error("Scan Refresh %s", att_ecode2str(status));
>> >             return;
>> > @@ -329,6 +327,8 @@ static void refresh_discovered_cb(uint8_t status, GSList
>> > *chars,
>> >
>> >     discover_desc(scan, scan->attrib, start, end, &uuid,
>> >                                     discover_descriptor_cb, user_data);
>> > +
>> > +   destroy_gatt_req(req);
>> >  }
>> >
>> >  static void iwin_discovered_cb(uint8_t status, GSList *chars, void
>> > *user_data)
>>
>> This patch doesn't fix the bug (actually it introduces some memleaks).
>>
>> From what I see in code gatt_request is packing userdata passed to
>> discover_desc() so I think fix should be like:
>>
>> --- a/android/scpp.c
>> +++ b/android/scpp.c
>> @@ -328,7 +328,7 @@ static void refresh_discovered_cb(uint8_t status, GSList
>> *chars,
>>         bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
>>
>>         discover_desc(scan, scan->attrib, start, end, &uuid,
>> -                                       discover_descriptor_cb, user_data);
>> +                                       discover_descriptor_cb, scan);
>
> This would access wrong memory since scan = req->user_data and req is
> freed as I mentioned in the patch above.

This would necessary cause a invalid access since destroy_gatt_req
only unref so only in case that actually frees the scan pointer this
would cause any problem but would mean that there is unbalance number
of reference. Now this code can be simplified because we do actually
have a queue holding the requests, in fact we only need the ids, so
there is no need to have request in the first place.


-- 
Luiz Augusto von Dentz
