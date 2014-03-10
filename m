Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <A6C5B873-6614-45B3-AD4C-B3E08831E6D8@warski.org>
References: <6E6C1573-4744-486B-B2E6-2D3DC45D024B@warski.org>
	<CAJdJm_PMAVyiY-=13puBHAucCzObUWOSOXZ+maOL2z11YwOh-g@mail.gmail.com>
	<A4DDF6F3-8DD4-4CF7-A5C0-205F5B4EE489@warski.org>
	<CAJdJm_PN3xGjdNOtr3o-J0SJ8N6MJXBChUCwOWOZBrdFKDBfGA@mail.gmail.com>
	<407CD6A9-AFA8-4A8A-BA2C-882D7A64EF40@warski.org>
	<0BA8DEFD-9E73-4A6A-A9E6-1957634CABF8@warski.org>
	<CAJdJm_P6gnpW5AhO9j4+LV6KX30J4sTWd_tWW=x=E+ejQq3cTQ@mail.gmail.com>
	<A2B80C7C-697D-44E5-80EA-B398E62EE608@warski.org>
	<CAJdJm_MXR08tvceb0-vHT=VD+dKY_dz2MbkO3eaUoBneeFxXMA@mail.gmail.com>
	<A6C5B873-6614-45B3-AD4C-B3E08831E6D8@warski.org>
Date: Mon, 10 Mar 2014 09:09:02 -0400
Message-ID: <CAJdJm_MrjHy-fk-OQUeepxh2C_K=ap30ekR0U91e6kK+ov42HQ@mail.gmail.com>
Subject: Re: Passive scanning of iBeacons results in a "Data Buffer Overflow"
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Adam Warski <adam@warski.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Adam,

Duplicate filtering is done inside the controller. If you disable
filtering, the controller will receive a lot more packets (the
quantity will depend on device's advertising parameters, but it is
several times more packets).

Even if your Gimbal device changes address on every packet (which is
unusual, usually address changes are time based), what you actually
see without using --duplicate is still a small fraction of what the
controller receives over the air. Try comparing  Gimbal  on using
--duplicates versus not using (instead of comparing different devices
with different firmware and adv. parameters).   Try counting number of
adv. reports on both situations.  I expect to see a lot more when
--duplicate is enabled...

Regarding the logs, it seems your dmesg.txt seems only to show the
last lines of debugging... maybe the dmesg buffer is too short. Can
you check if there is a more complete log generated in one of the
/var/log/kern.log.* files ?

Fortunately, It contains one snippet showing problems with HCI
reassembly from USB packets:

[  878.184532] btusb_intr_complete: hci0 urb d9a8d300 status 0 count 16
[  878.185499] btusb_intr_complete: hci0 urb d9a8d300 status 0 count 16
[  878.186498] btusb_intr_complete: hci0 urb d9a8d300 status 0 count 12
[  878.386548] btusb_intr_complete: hci0 urb d9a8d300 status 0 count 16
[  878.387530] btusb_intr_complete: hci0 urb d9a8d300 status 0 count 16
[  878.387664] hci_rx_work: hci0
[  878.387693] hci_send_to_monitor: hdev d9a4e000 len 64
[  878.387783] hci_send_to_sock: hdev d9a4e000 len 64
[  878.387803] hci_rx_work: hci0 Event packet
[  878.387822] hci_event_packet: hci0 event 0xbc
[  878.387847] hci_send_to_monitor: hdev d9a4e000 len 4
[  878.387896] hci_send_to_sock: hdev d9a4e000 len 4
[  878.387913] hci_rx_work: hci0 Event packet
[  878.387930] hci_req_cmd_complete: opcode 0x200c status 0x00
[  878.387945] hci_sent_cmd_data: hci0 opcode 0x200c
[  878.387959] hci_event_packet: hci0 event 0x00
[  878.388058] hci_sock_recvmsg: sock da567840, sk daa9c800

It contains 3  bogus events:

> HCI Event: Unknown (0xbc) plen 62
> HCI Event: Unknown (0x00) plen 2
> HCI Event: Physical Link Complete (0x40) plen 127

For me, it still points out to corrupted/truncated USB packets.
Unfortunately, it is just indirect evidence as the logs don't show raw
USB packets. But you can definitively confirm by using a USB sniffer
tool. I recommend using tshark (wireshark's command line interface).
It works just fine on raspberry. See this post for instructions:
http://nagaraj-embedded.blogspot.com.br/2012/03/capturing-usb-data-through-wireshark.html

Note that on raspberry there is just "usbmon1" (i.e. Bus 1), and
everything is attached to it. So the logs will get other unrelated
traffic (like ethernet packets), but wireshark GUI is powerful enough
to filter only traffic related to a specific device.

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
