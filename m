Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1248074120.4549.89.camel@violet>
References: <dd18b0c30907192045t3078451ao9af4c1751d9efe91@mail.gmail.com>
	 <1248074120.4549.89.camel@violet>
Date: Mon, 20 Jul 2009 00:46:30 -0700
Message-ID: <dd18b0c30907200046m70ac61e9wd0464c5f44e7c28@mail.gmail.com>
Subject: Re: btusb_send_frame: hci0 urb ede00a50 submission failed
From: Justin Mattock <justinmattock@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jul 20, 2009 at 12:15 AM, Marcel Holtmann<marcel@holtmann.org> wrot=
e:
> Hi Justin,
>
>> Not sure whats happening here,
>> this morning using s2ram worked like a charm,
>> now at the end of the day this thing takes a good minute to
>> wakeup. As for the blueooth finally got it working, but
>> now I'm seeing this in dmesg:
>>
>>
>> [ =A0708.630722] Restarting tasks ... done.
>> [ =A0708.910090] usb 5-1: USB disconnect, address 3
>> [ =A0708.910262] btusb_send_frame: hci0 urb ede00a50 submission failed
>> [ =A0709.330776] [drm] Loading R500 Microcode
>>
>> Maybe suspend works better when cooler, but in anycase
>> the bluetooth works perfectly recovers from s2ram, scrollball
>> works as well(all with SELinux running too).
>
> what kernel version? Is this a plain vanilla kernel.org kernel or a
> distro kernel?
>
> Regards
>
> Marcel
>
>
>

latest git
here's a cut from dmesg:

[13176.287859] PM: Syncing filesystems ... done.
[13176.291783] Freezing user space processes ... (elapsed 0.00 seconds) don=
e.
[13176.292142] Freezing remaining freezable tasks ... (elapsed 0.00
seconds) done.
[13176.292275] Suspending console(s) (use no_console_suspend to debug)
[13176.294725] btusb_bulk_complete: hci0 urb f6ac6a50 failed to resubmit (1=
)
[13176.295720] btusb_bulk_complete: hci0 urb f6ac66e0 failed to resubmit (1=
)
[13176.296719] btusb_intr_complete: hci0 urb f6ac6420 failed to resubmit (1=
)
[13176.470263] sd 2:0:1:0: [sda] Synchronizing SCSI cache
[13176.697678] sd 2:0:1:0: [sda] Stopping disk
[13177.600230] ath9k 0000:03:00.0: PCI INT A disabled

then s2ram again:

[13182.139058] wlan0: associate with AP 00:1e:2a:00:67:f0
[13182.141361] wlan0: RX ReassocResp from 00:1e:2a:00:67:f0
(capab=3D0x431 status=3D0 aid=3D2)
[13182.141364] wlan0: associated
[13182.150158] usb 5-1: USB disconnect, address 7
[13182.150332] btusb_send_frame: hci0 urb f1f2c420 submission failed
[13182.561534] [drm] Loading R500 Microcode
[13182.561598] [drm] Num pipes: 1

Not sure what this is, but from here the mouse is functioning
as it should.


--=20
Justin P. Mattock
