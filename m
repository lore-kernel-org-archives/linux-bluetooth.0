Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAD0=r8xfT=rBigX+fX3r0UgdTGwLyT8HixysEcB4Bnpe0vPOWQ@mail.gmail.com>
References: <1443763138-23207-1-git-send-email-jpawlowski@google.com>
	<CAD0=r8xfT=rBigX+fX3r0UgdTGwLyT8HixysEcB4Bnpe0vPOWQ@mail.gmail.com>
Date: Thu, 8 Oct 2015 17:53:00 +0300
Message-ID: <CABBYNZKERN9cCC2L2JsYZsW0Nyr4kApL4=u8Ha+H-D68B-RAeQ@mail.gmail.com>
Subject: Re: [PATCH] core/device: Fix disconnect for connect attempt
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, Oct 7, 2015 at 11:42 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> Ping ?
>
> On Thu, Oct 1, 2015 at 10:18 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>> Right now calling Disconnect from DBus on device that's not advertising
>> or out of sight will not stop the connect attempt in kernel. This patch
>> fixes that by making sure that att_io is properly cleaned up on
>> disconnect.
>> ---
>>  src/device.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/src/device.c b/src/device.c
>> index 5ec8780..fd177f4 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -1355,6 +1355,12 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
>>         if (device->browse)
>>                 browse_request_cancel(device->browse);
>>
>> +       if (device->att_io) {
>> +               g_io_channel_shutdown(device->att_io, FALSE, NULL);
>> +               g_io_channel_unref(device->att_io);
>> +               device->att_io = NULL;
>> +       }
>> +
>>         if (device->connect) {
>>                 DBusMessage *reply = btd_error_failed(device->connect,
>>                                                                 "Cancelled");
>> --
>> 2.5.0

Pushed, thanks.

-- 
Luiz Augusto von Dentz
