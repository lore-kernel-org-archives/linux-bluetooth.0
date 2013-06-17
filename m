Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Jun 2013 13:51:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] emulator: Fix uninitialised memory usage on inquiry
Message-ID: <20130617105132.GA22357@x220.ger.corp.intel.com>
References: <1370464516-5706-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370464516-5706-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Jun 05, 2013, Anderson Lizardo wrote:
> This happens when using "btvirt -l2" and running "discoverable on" on
> hci1 and "scan on" on hci0 using bluetoothctl:
> 
> ==1870== Syscall param write(buf) points to uninitialised byte(s)
> ==1870==    at 0x4114443: __write_nocancel (syscall-template.S:82)
> ==1870==    by 0x804B503: send_packet (btdev.c:478)
> ==1870==    by 0x804B599: send_event (btdev.c:503)
> ==1870==    by 0x804B8C0: inquiry_complete (btdev.c:589)
> ==1870==    by 0x804C538: default_cmd (btdev.c:881)
> ==1870==    by 0x804E5DE: process_cmd (btdev.c:1559)
> ==1870==    by 0x804E646: btdev_receive_h4 (btdev.c:1577)
> ==1870==    by 0x804A487: vhci_read_callback (vhci.c:82)
> ==1870==    by 0x804923E: mainloop_run (mainloop.c:142)
> ==1870==    by 0x8048FD4: main (main.c:145)
> ==1870==  Address 0x41e4d0f is 15 bytes inside a block of size 258
> alloc'd
> ==1870==    at 0x402B56C: malloc (vg_replace_malloc.c:270)
> ==1870==    by 0x804B531: send_event (btdev.c:490)
> ==1870==    by 0x804B8C0: inquiry_complete (btdev.c:589)
> ==1870==    by 0x804C538: default_cmd (btdev.c:881)
> ==1870==    by 0x804E5DE: process_cmd (btdev.c:1559)
> ==1870==    by 0x804E646: btdev_receive_h4 (btdev.c:1577)
> ==1870==    by 0x804A487: vhci_read_callback (vhci.c:82)
> ==1870==    by 0x804923E: mainloop_run (mainloop.c:142)
> ==1870==    by 0x8048FD4: main (main.c:145)
> ==1870==
> ---
>  emulator/btdev.c |    3 +++
>  1 file changed, 3 insertions(+)

Applied. Thanks.

Johan
