Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120817082830.GA31481@x220>
References: <CAKT1EBfp+iJfRSodDfoqtDB4X90BNR1wEJh_zXvw0t6JvnaWuA@mail.gmail.com>
	<1345147991-31320-1-git-send-email-claudio.takahasi@openbossa.org>
	<1345147991-31320-5-git-send-email-claudio.takahasi@openbossa.org>
	<20120817082830.GA31481@x220>
Date: Fri, 17 Aug 2012 11:00:27 -0300
Message-ID: <CAKT1EBf-qz4xzq1__OCd-7AMmJJJFAirW7Yvm_sTx2bTfHZDtQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 04/10] gatt: Add storing Appearance
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan:

On Fri, Aug 17, 2012 at 5:28 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Claudio,
>
> On Thu, Aug 16, 2012, Claudio Takahasi wrote:
>> This patch stores the Appearance characteristic value read from the
>> remote GAP service.
>> ---
>>  profiles/gatt/gas.c |    8 ++++++++
>>  1 files changed, 8 insertions(+), 0 deletions(-)
>>
>> diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
>> index 2fb12ce..bf603e8 100644
>> --- a/profiles/gatt/gas.c
>> +++ b/profiles/gatt/gas.c
>> @@ -68,8 +68,11 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
>>  static void gap_appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
>>                                                       gpointer user_data)
>>  {
>> +     struct gas *gas = user_data;
>>       struct att_data_list *list =  NULL;
>> +     bdaddr_t src, dst;
>>       uint16_t app;
>> +     uint8_t type;
>>       uint8_t *atval;
>>
>>       if (status != 0) {
>> @@ -92,6 +95,11 @@ static void gap_appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
>>
>>       DBG("GAP Appearance: 0x%04x", app);
>>
>> +     adapter_get_address(device_get_adapter(gas->device), &src);
>> +     device_get_address(gas->device, &dst, &type);
>> +
>> +     write_remote_appearance(&src, &dst, type, app);
>
> I'm not so sure it's a good idea to have plugins use the storage
> functions directly. Instead I'd put this into the device_set_appearance
> function which you add later in this patch set. If there really is a
> need to access storage functions from within plugins (which there isn't
> for this particular case) then we need to prefix all of the storage
> functions with btd_* since those are the only types of symbols that
> should be exported from the core daemon to plugins.
>
> Johan

ok. Wait for a new patch series, write_remote_appearance call will be
moved to device_set_appearance.

BR,
Claudio
