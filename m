Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] USB/Bluetooth dongle doesn't work in hub
References: <qszekj3j47n.fsf@timepilot.gpcc.itd.umich.edu>
	<1099959115.29330.40.camel@pegasus>
	<qszzn1rhnmh.fsf@timepilot.gpcc.itd.umich.edu>
From: Scott W Gifford <gifford@umich.edu>
In-Reply-To: <qszzn1rhnmh.fsf@timepilot.gpcc.itd.umich.edu> (Scott W.
 Gifford's message of "Mon, 08 Nov 2004 19:28:22 -0500")
Message-ID: <qszr7n3lgkp.fsf@timepilot.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 09 Nov 2004 00:47:02 -0500

Scott W Gifford <gifford@umich.edu> writes:

> Marcel Holtmann <marcel@holtmann.org> writes:
>
>> Hi Scott,
>>
>>> I'm trying to connect a USB/Bluetooth dongle to my laptop running
>>> Fedora Core 2 with a Linux 2.6.8-1.521 kernel, and these bluez RPMs
>>> installed:
>>> 
>>>     bluez-bluefw-1.0-2, bluez-libs-2.5-2.1, bluez-libs-devel-2.5-2.1,
>>>     bluez-pin-0.23-1, bluez-utils-2.4-3, bluez-sdp-devel-1.5-2.1,
>>>     bluez-hcidump-1.5-4, bluez-sdp-1.5-2.1, bluez-pan-1.1-4
>>
>> these packages are a way out of data.
>
> Ah, OK; they're the ones supplied by Fedora.  I'll try newer ones from
> the Bluez Web site.

I removed all of Fedora's bluez stuff, and installed:

    bluez-firmware-1.0.tar.gz, bluez-hcidump-1.12.tar.gz,
    bluez-libs-2.10.tar.gz, bluez-utils-2.10.tar.gz

> [...]
>
>>>     Nov  8 18:29:24 localhost kernel: hci_usb_intr_rx_submit: hci0 intr rx submit failed urb 1f48cf94 err -28
>>>     Nov  8 18:29:24 localhost hcid[23855]: Can't init device hci0. Input/output error(5)
>>> 
>>> I get the same effect plugging in to the hub on my base station, my
>>> keyboard, or a Belkin hub I just purchased.
>>
>> This looks like an USB problem to me. Update your kernel to the latest
>> Bitkeeper snapshot and try again.

I downloaded a new kernel with:

    bk clone http://linux-mh.bkbits.net/bluetooth-2.6

, compiled and booted, and I still am getting roughly the same error:

    Nov  9 00:36:06 localhost usb.agent[4258]: Setup hci_usb for USB product 50d/81/828
    Nov  9 00:36:06 localhost hcid[3688]: HCI dev 1 registered
    Nov  9 00:36:06 localhost kernel: hci_usb_intr_rx_submit: hci1 intr rx submit failed urb d0d01e94 err -28
    Nov  9 00:36:06 localhost hcid[4281]: Can't init device hci1. Input/output error(5)
    Nov  9 00:36:06 localhost usb.agent[4195]: Setup 0x00 0x00 for USB product 50d/81/828
    Nov  9 00:36:07 localhost usb.agent[4231]: Setup 0x00 0x00 for USB product 50d/81/828
    Nov  9 00:36:07 localhost usb.agent[4258]: Setup 0x00 0x00 for USB product 50d/81/828

As before, they work fine when plugged directly into the laptop.

Thanks!

----ScottG.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
