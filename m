Return-Path: <pander@users.sourceforge.net>
Message-ID: <416E403C.4040101@users.sourceforge.net>
Date: Thu, 14 Oct 2004 11:00:44 +0200
From: Pander <pander@users.sourceforge.net>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] modprobe: FATAL: Error inserting hci_usb
References: <416D745B.7020208@users.sourceforge.net> <1097737908.4640.4.camel@notepaq>
In-Reply-To: <1097737908.4640.4.camel@notepaq>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi Pander,
> 
> 
>>I'm have build linux kernel 2.6.8.1 with Debian testing distro on a 
>>PowerPC (PowerBook G4). All went well and booted oke except for 
>>bleutooth support:
>>
...
>>modprobe: FATAL: Error inserting hci_usb 
>>(/lib/modules/2.6.8.1-pbg4/kernel/drivers/bluetooth/hci_usb.ko): Unknown 
>>symbol in module, or unknown parameter (see dmesg)
>>
>>I also patched the 2.6.8.1 kernel source with patch-2.6.8-mh2 but that 
>>resulted in the same error. dmesg says the same as above. Does anyone 
>>know how to fix this?
> 
> 
> I have seen this too, but sometimes it still works. Check with lsmod if
> the module is loaded.

Hi Marcel, it works althought the FATAL is being reported.

Thanks,

Pander
> Regards
> 
> Marcel
