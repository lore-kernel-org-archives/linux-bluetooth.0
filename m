Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1320243335.15441.279.camel@aeonflux>
References: <CAKzePapHJwC2VMpjgS_uK=NCUPCEAQt5+zDSEqRJNdPth-Aztw@mail.gmail.com>
	<1320243335.15441.279.camel@aeonflux>
Date: Tue, 15 Nov 2011 11:18:39 +0800
Message-ID: <CAKzePaqfsChbeJBB=R1FyicrpfCu0Lgaytzv6oQoHne1FWFAMg@mail.gmail.com>
Subject: Re: How to add firmware uploader function to Bluez?
From: Al Cho <acho@suse.com>
To: Marcel Holtmann <marcel@holtmann.org>, padovan@profusion.mobi,
	linux-bluetooth@vger.kernel.org
Cc: oneukum@suse.com, jlee@suse.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

Would anyone could give me help kindly?
I have sent the firmware uploader source code as a patch to this mailing list,
named: "How to add firmware uploader function to Bluez? (Broadcom
firmware uploader)"
There are Make file and source code "brcm_patchram_plus_usb.c" in this patch.
If you want to compiler this use "make" and need bluez-devel package
for bluetooth.h,
hci.h , and hci_lib.h..

I don't have enough knowledge about Bluez tool rules ,please correct
me if i got any mistake.

Sincerely,
              AL


On Wed, Nov 2, 2011 at 10:15 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Al,
>
>> Broadcom BT4.0 module 0a5c:21e1 and 0a5c:21e3 need firmware
>> to setup(enable) at the first time we use.
>> We got the firmware and firmware uploader (brcm_patchram_plus_usb )
>> ( user space tool ) from Broadcom ,the Licence is GPLv2,
>> would it possible that add those to bluez package?or any idea for this?
>>
>> please correct me if i got any mistake,thanks.
>
> can you post these firmware loader as a patch to this mailing list? Then
> we can discuss on how to integrate it best.
>
> Regards
>
> Marcel
>
>
>



-- 
Al Yu-Chen Cho
Software Engineer
Room B, 26/F, No. 216 Tun-Hwa S. Road, Sec. 2
Taipei, 106
+8862-2376-0010 X20031
acho@suse.com
SUSE
