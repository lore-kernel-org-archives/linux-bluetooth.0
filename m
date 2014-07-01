Return-Path: <cyrus@holtmann.org>
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <53B2D160.4010306@lwfinger.net>
Date: Tue, 01 Jul 2014 10:18:56 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Daniel Drake <drake@endlessm.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
 "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
 champion <champion_chen@realsil.com.cn>
Subject: Re: [PATCH v2] Bluetooth: btusb: Add Realtek 8723/8761 support
References: <1404218878-14218-1-git-send-email-drake@endlessm.com>	<16AC594D-6B3C-4CB6-B951-0763F3E4E27A@holtmann.org> <CAD8Lp45HbA03MycDVu6akTfEET_ZzxrwGpH1TbiQrw5Z178aeA@mail.gmail.com>
In-Reply-To: <CAD8Lp45HbA03MycDVu6akTfEET_ZzxrwGpH1TbiQrw5Z178aeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/01/2014 09:18 AM, Daniel Drake wrote:
> On Tue, Jul 1, 2014 at 2:41 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>>          .driver_info = BTUSB_RTK | BTUSB_RTL...
>>
>> The think with RTL vs RTK is now confusing me even more. So what are the official model numbers from Realtek anyway. Maybe we should start using them now and not bother carrying around some legacy from the Ethernet or WiFi drivers.
>
> The product codes are RTLxxxx so perhaps I will update it to use 'rtl'
> instead of 'rtk' everywhere. That 'rtk' just came from the vendor
> driver. Maybe Larry has some knowledge of the conventions here.

The Realtek drivers for wifi devices all use "rtl" as the abbreviation. As I had 
not made many changes to the vendor-supplied driver for BT, I had not worried 
about such details; however, I do think that "rtl" should be used here.

>> There is also no generic vendor command that we can run first to get the model information? Do we really need to use USB vendor and product ids to pick the right one. I personally hate using vendor and product ids.
>
> I'm no expert on this hardware, just happened to receive one instance,
> and then found the vendor driver on Larry's github. The vendor driver
> uses USB IDs for this purpose, and I don't have any extra insight (nor
> access to other devices).

All I know about this issue is that the unmodified btusb will load when one  one 
of the Realtek BT devices is present, thus there is some generic recognition. 
The driver should should be able to use that; however, it will still need to be 
able to differentiate among the various Realtek devices. My vote is to keep the 
USB ID information.

> However, I just noticed that we only have 2 of the 7 main firmware
> files available. Larry, do you have all of the ones mentioned in the
> driver? e.g. ones like rtl8761aw8192eu_fw are missing from your repo.
>
> Googling around, it looks like these other devices are really not
> common, maybe we should just reduce it to RTL8723A and RTL8723B
> support, especially if we don't have firmware for the others. There is
> only 1 type of firmware for each variant there, the code would be
> simpler, no need for VID/PID lookup. That would be enough to make me
> happy, plus all the people filing issues on Larry's github.

Looking at the firmware table,

+} rtk_fw_table[] = {
+	{ BTUSB_RTL8723A, ROM_LMP_8723a, "rtl8723a_fw", "rtl8723a_config" },
+	{ BTUSB_RTL8723B, ROM_LMP_8723b, "rtl8723b_fw", "rtl8723b_config" },
+	{ BTUSB_RTL8761AU, ROM_LMP_8761a, "rtl8761au_fw", "rtl8761a_config" },
+	{ BTUSB_RTL8761AW_8192EU, ROM_LMP_8761a, "rtl8761aw8192eu_fw", 
"rtl8761a_config" },
+	{ BTUSB_RTL8761AU_8192EE, ROM_LMP_8761a, "rtl8761au8192ee_fw", 
"rtl8761a_config" },
+	{ BTUSB_RTL8761AU_8812AE, ROM_LMP_8761a, "rtl8761au8812ae_fw", 
"rtl8761a_config" },
+	{ BTUSB_RTL8821A, ROM_LMP_8821a, "rtl8821a_fw", "rtl8821a_config" },
+};

The RTL8812AE, RTL8821AE, and RTL8192EE devices are not that rare. The wifi 
drivers for those devices have been added in the last couple of kernel cycles. I 
will be contacting Realtek to get copies of those firmware files. I do not know 
about the RTL8192EU or the RTL8761AU. I have not run across those USB devices yet.

BTW, I added my contact at Realtek to the Cc list.

> Only caveat there is that someone might push us to return to the
> RTL8761 mess (different firmware for different VID/PID) some day.

I am certain that Realtek separated these devices for a reason, which is why I 
favor keeping VID/PID.

Please do not be hasty in posting new versions. You had V2 in my mailbox before 
I had even gotten a chance to see V1. Remember that we live in different time zones.

Larry
