Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <EC94610F2568494D8D9291885C48D3103CFDB3@nasanexd01a.na.qualcomm.com>
References: <1308645454-2724-1-git-send-email-luiz.dentz@gmail.com>
	<1308645454-2724-2-git-send-email-luiz.dentz@gmail.com>
	<EC94610F2568494D8D9291885C48D3103CFD96@nasanexd01a.na.qualcomm.com>
	<BANLkTinNy_eNeQ5WfvhJHwYgdwcdgzHGMw@mail.gmail.com>
	<EC94610F2568494D8D9291885C48D3103CFDB3@nasanexd01a.na.qualcomm.com>
Date: Tue, 21 Jun 2011 13:23:26 +0300
Message-ID: <BANLkTimRTnKHxL8csLDdm4HXp0+FV3_VHA@mail.gmail.com>
Subject: Re: [PATCH obexd] Fix crash introduced by f5279bfcedd669bc5d4e88cc1c59807c92226dfb
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Li, Nami" <nami@qca.qualcomm.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Liu, Haijun" <haijun@qca.qualcomm.com>,
	"Fan, Hong" <hongfan@qca.qualcomm.com>
Content-Type: text/plain; charset=GB2312
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nami,

2011/6/21 Li, Nami <nami@qca.qualcomm.com>:
> Hi, Luiz
>
> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: 2011年6月21日 17:48
> To: Li, Nami
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH obexd] Fix crash introduced by f5279bfcedd669bc5d4e88cc1c59807c92226dfb
>
> Hi Nami,
>
> 2011/6/21 Li, Nami <nami@qca.qualcomm.com>:
>> Hi,
>>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org
>> [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Luiz
>> Augusto von Dentz
>> Sent: 2011年6月21日 16:38
>> To: linux-bluetooth@vger.kernel.org
>> Subject: [PATCH obexd] Fix crash introduced by
>> f5279bfcedd669bc5d4e88cc1c59807c92226dfb
>>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> The callback function actually needs the bluetooth_service structure not obex_service_driver.
>> ---
>>  plugins/bluetooth.c |   11 +++++++++--
>>  1 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c index
>> fe508f4..1037b24 100644
>> --- a/plugins/bluetooth.c
>> +++ b/plugins/bluetooth.c
>> @@ -459,10 +459,11 @@ static int request_service_authorization(struct
>> bluetooth_service *service,
>>
>>  static void confirm_event(GIOChannel *io, void *user_data)  {
>> -       struct bluetooth_service *service = user_data;
>> +       struct bluetooth_service *service;
>>        GError *err = NULL;
>>        char address[18];
>>        uint8_t channel;
>> +       struct obex_service_driver *driver = user_data;
>>
>>        bt_io_get(io, BT_IO_RFCOMM, &err,
>>                        BT_IO_OPT_DEST, address, @@ -477,7 +478,13 @@
>> static void confirm_event(GIOChannel *io, void *user_data)
>>        info("bluetooth: New connection from: %s, channel %u", address,
>>                        channel);
>>
>> -       if (service->driver->service != OBEX_OPP) {
>> +       service = find_service(driver, 0);
>>
>> Will it be better to write as "service = find_service(driver, channel);" ?
>> Or if you choose not to use channel, I think you could omit channel
>> variable and omit bt_io_get(BT_IO_OPT_CHANNEL, &channel);
>
>>I only leave the channel there for logging, as for the find_service it is really useless to use the channel if we are going to support L2CAP in future, so in theory this should work regardless of the transport.
>
>
> Yeah, it`s better when support L2CAP.  If the channel is only use for logging, can we delete it?
> There are only two functions calling find_service, one in your commit , another in register_record function:
>        service = find_service(driver, 0);
> Seems the channel parameter is useless.
> And considering OBEX over L2CAP, should we modify find_service to
>   static struct bluetooth_service *find_service(struct obex_service_driver *driver)
> just delete uint8_t channel parameter.
> If ok, you or me can upload a patch for this issue.

Yep, I gonna send a new version that just remove it since we no longer
need it after this changes

-- 
Luiz Augusto von Dentz
