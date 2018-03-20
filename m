Return-Path: <vicencb@gmail.com>
MIME-Version: 1.0
In-Reply-To: <B4CFAEE8-F54B-4130-B3F3-412754EDB170@holtmann.org>
References: <CA64719F-6732-4683-ACC6-AF82733384C3@holtmann.org>
 <20180320184110.3888-1-vicencb@gmail.com> <B4CFAEE8-F54B-4130-B3F3-412754EDB170@holtmann.org>
From: Vicente Bergas <vicencb@gmail.com>
Date: Tue, 20 Mar 2018 20:13:08 +0100
Message-ID: <CAAMcf8DB0FKjDUbRYCXLA+xqACSyd-3mKQ2E=QVtAiLwKJFO2g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add USB ID 7392:a611 for Edimax EW-7611ULB
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Mar 20, 2018 at 7:53 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Vicente,
>
>> This WiFi/Bluetooth USB dongle uses a Realtek chipset, so, use btrtl for it.
>>
>> Product information:
>> https://wikidevi.com/wiki/Edimax_EW-7611ULB
>>
>> From /sys/kernel/debug/usb/devices
>> T:  Bus=02 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=480  MxCh= 0
>> ...
>>
>> Tested-by: Vicente Bergas <vicencb@gmail.com>
>> Signed-off-by: Vicente Bergas <vicencb@gmail.com>
>> ---
>> drivers/bluetooth/btusb.c | 3 +++
>> 1 file changed, 3 insertions(+)
>
> patch has been applied to bluetooth-next tree.
>
> Regards
>
> Marcel
>

Thank you!

Regards,
  Vicente.
