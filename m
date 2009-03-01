Return-Path: <cyrus@holtmann.org>
Subject: Re: Bluetooth radio =?ISO-8859-1?Q?doesn=B4t?= reply to inquiry
 request
From: Marcel Holtmann <marcel@holtmann.org>
To: Carles Cufi <carles.cufi@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <aa4f458e0903010445j49d07c26j144210cb099540de@mail.gmail.com>
References: <aa4f458e0903010445j49d07c26j144210cb099540de@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 01 Mar 2009 19:21:08 +0100
Message-Id: <1235931668.6074.47.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Charles,

> I am currently developing a custom application and while debugging it
> I have stumbled upon a problem that seems to be
> related to some internal kernel problem, and hence I am sharing it
> with you to see if anyone has any advice at all about
> how to approach it.
> 
> I have a setup running:
> 
> * Ubuntu 8.10
> * Linux 2.6.27-11-generic #1 SMP
> * BlueZ 4.12 (from pkgconfig)
> * Gnome with the bluetooth daemon running
> * A High-speed USB hub with 3 Toshiba Bluetooth 2.0 dongles
> (PA3455U-1BTM) each with a CSR BlueCore-4 inside.
> 
> What the application does:
> 
> My custom application performs inquiries (using the hci2 Host
> Controller) periodically with bound raw HCI sockets (i.e.
> hci_send_cmd (dd, OGF_LINK_CTL, OCF_INQUIRY, INQUIRY_CP_SIZE, &cp);)
> and then receiving the inquiry responses by polling
> the device descriptor and parsing the events that come from the Host
> Controller (len = read(dd, hci_buffer,
> sizeof(hci_buffer)) and then headerptr = (hci_event_hdr *) (hci_buffer
> + 1);). In the meantime, Host Controllers hci0
> and hci1 send files over OBEX (using obexftp) to the devices discovered by hci2.
> 
> The problem:
> 
> The application runs fine for a while, inquiring and sending (or
> trying to send) files over OBEX. But after a few
> successful inquiries, the program stops after having sent an inquiry
> request command and never receiving any response
> for it (no command status and no inquiry result or inquiry complete events).
> After that, the btusb subsystem seems to block completely, since I am
> unable to contact
> any of the HCs until I unload it and load it again (with rmmod and modprobe).
> 
> Logs attached:
> 
> hciconfig_dump: output of hciconfig -a
> hciX_dump: output of sudo hcidump -i hciX -Vt
> dmesg_dump: output of dmesg
> 
> Please note that to help me find out what was going on inside the
> kernel I decided to recompile bluetooth.ko and
> btusb.ko with the following flags enabled:
> CONFIG_BT_HCIBTUSB_DEBUG
> CONFIG_BT_HCI_CORE_DEBUG
> CONFIG_BT_HCI_SOCK_DEBUG
> 
> What seems to be going on:
> 
> From the last few lines of dmesg:
> 
> [  324.011911] hci_send_frame: hci2 type 1 len 8
> [  324.011913] hci_send_to_sock: hdev edfe7800 len 8
> [  324.011921] btusb_send_frame: hci2
> [  324.011939] hci_sock_recvmsg: sock ec9aa900, sk eda5ee00
> [  324.256140] __set_isoc_interface: hci1 setting interface failed (110)
> 
> and the last few lines of hci2_dump:
> 
> 2009-02-27 13:23:49.377393 < HCI Command: Inquiry (0x01|0x0001) plen 5
>    lap 0x9e8b33 len 16 num 0
> 
> The last inquiry request command seems to be being sent correctly
> (btusb_send_frame: hci2) but just after that we see a
> failure when calling __set_isoc_interface on hci1.
> 
> I do not currently have enough knowledge about the btusb subsystem to
> find out what's happening, and so if someone has
> any information about this, please let me know, it would be most useful.

why don't you use periodic inquiry instead and let the controller handle
the timing.

Also should try the bluetooth-testing.git tree since it contains an
updated btusb.ko driver.

Regards

Marcel


