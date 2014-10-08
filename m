Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1412759368.21709.15.camel@linux-0dmf.site>
References: <CAG0bkvK4-gfeYXXsdNg4BKdjxmo1e5d8rKuABohtYNNBHKJwDA@mail.gmail.com>
	<1412598268.1132.15.camel@linux-0dmf.site>
	<CAG0bkv+nKt-TgONDLENNUncz9NScdJGcYR+J2Z6b=wg2grvqhg@mail.gmail.com>
	<1412600108.28177.0.camel@linux-0dmf.site>
	<CAG0bkvK=fumhJNzuSgx=HFHiVP08V+QH2wLajdffx+f5ugoQPQ@mail.gmail.com>
	<1412602169.28177.2.camel@linux-0dmf.site>
	<CAG0bkv+d9SxToWpk49s=C-w_aA4zbP_RvV_8kcgV254rsvHR0A@mail.gmail.com>
	<1412607050.1743.1.camel@linux-0dmf.site>
	<CAG0bkvKJZMhurNNpc_2wgaACRzhyEikb0G0YSY7QnxqBe1rnjw@mail.gmail.com>
	<CAG0bkv+_t8CqM9w5N1hKJtT=_mQmtWWCPe-9jSHuOkNZCL3B9A@mail.gmail.com>
	<1412676071.1926.1.camel@linux-0dmf.site>
	<CAG0bkvKYT5+ZBZwdvG71g98CqZR03er6rN4y5RRfq6UUL5KnCw@mail.gmail.com>
	<CAG0bkv+YK6_wP+cnZEmfRZnLXa=7N1CMyYqVAbao22gf74dhbw@mail.gmail.com>
	<1412759368.21709.15.camel@linux-0dmf.site>
Date: Wed, 8 Oct 2014 15:51:14 +0530
Message-ID: <CAG0bkvKugdQSDm+GKRbLGLzrURth5ty9KU-8d3ED-a9sgdDkMg@mail.gmail.com>
Subject: Re: btusb_intr_complete returns -EPIPE
From: Naveen Kumar Parna <pnaveenkos@gmail.com>
To: Oliver Neukum <oneukum@suse.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	linux-usb@vger.kernel.org, acho@suse.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hcidump does not show anything when the stalls happen.



Here is the hcidump log:

[root@banunxcas29 np03]# hcidump -x -t

HCI sniffer - Bluetooth packet analyzer ver 2.1

device: hci0 snap_len: 1028 filter: 0xffffffffffffffff



Corresponding usbmon log

ffff8801265343c0 2826295762 C Ii:1:021:1 -32:1 0

ffff880126418840 2826297275 S Ii:1:021:1 -115:1 16 <

ffff880126534240 2826298730 C Ii:1:020:1 -32:1 0

ffff880126418840 2826298856 C Ii:1:021:1 -32:1 0

ffff880126418840 2826299789 S Ii:1:020:1 -115:1 16 <

ffff880126418900 2826300154 S Ii:1:021:1 -115:1 16 <

ffff8801266329c0 2837941755 C Ii:1:018:1 -32:1 0

ffff880126632c00 2837941884 C Ii:1:016:1 -32:1 0

ffff880126418b40 2837942862 S Ii:1:016:1 -115:1 16 <

ffff880126418300 2837943184 S Ii:1:018:1 -115:1 16 <

ffff880126418300 2897160790 C Ii:1:018:1 -32:1 0

ffff880126418300 2897162701 S Ii:1:018:1 -115:1 16 <

ffff880126632cc0 2897332778 C Ii:1:019:1 -32:1 0

ffff880126418840 2897332909 C Ii:1:020:1 -32:1 0

ffff880126418900 2897332959 C Ii:1:021:1 -32:1 0

ffff880126418b40 2897333002 C Ii:1:016:1 -32:1 0

ffff880126418300 2897333035 C Ii:1:018:1 -32:1 0

ffff880126418900 2897334155 S Ii:1:021:1 -115:1 16 <

ffff880126418b40 2897334405 S Ii:1:020:1 -115:1 16 <

ffff880126418300 2897334635 S Ii:1:019:1 -115:1 16 <

ffff880126418f00 2897335015 S Ii:1:018:1 -115:1 16 <

ffff880126418840 2897335367 S Ii:1:016:1 -115:1 16 <





Corresponding kernel log:

Oct  8 15:29:38 banunxcas29 kernel: [ 3244.604776] hci7 urb
ffff8801265343c0 status -32 count 0

Oct  8 15:29:38 banunxcas29 kernel: [ 3244.606273] hci7

Oct  8 15:29:38 banunxcas29 kernel: [ 3244.607741] hci6 urb
ffff880126534240 status -32 count 0

Oct  8 15:29:38 banunxcas29 kernel: [ 3244.607862] hci7 urb
ffff880126418840 status -32 count 0

Oct  8 15:29:38 banunxcas29 kernel: [ 3244.608787] hci6

Oct  8 15:29:38 banunxcas29 kernel: [ 3244.609155] hci7

Oct  8 15:29:49 banunxcas29 kernel: [ 3256.251736] hci4 urb
ffff8801266329c0 status -32 count 0

Oct  8 15:29:49 banunxcas29 kernel: [ 3256.251857] hci2 urb
ffff880126632c00 status -32 count 0

Oct  8 15:29:49 banunxcas29 kernel: [ 3256.252828] hci2

Oct  8 15:29:49 banunxcas29 kernel: [ 3256.253153] hci4

Oct  8 15:30:49 banunxcas29 kernel: [ 3315.476287] hci4 urb
ffff880126418300 status -32 count 0

Oct  8 15:30:49 banunxcas29 kernel: [ 3315.478179] hci4

Oct  8 15:30:49 banunxcas29 kernel: [ 3315.648289] hci5 urb
ffff880126632cc0 status -32 count 0

Oct  8 15:30:49 banunxcas29 kernel: [ 3315.648411] hci6 urb
ffff880126418840 status -32 count 0

Oct  8 15:30:49 banunxcas29 kernel: [ 3315.648461] hci7 urb
ffff880126418900 status -32 count 0

Oct  8 15:30:49 banunxcas29 kernel: [ 3315.648504] hci2 urb
ffff880126418b40 status -32 count 0

Oct  8 15:30:49 banunxcas29 kernel: [ 3315.648537] hci4 urb
ffff880126418300 status -32 count 0

Oct  8 15:30:49 banunxcas29 kernel: [ 3315.649651] hci7

Oct  8 15:30:49 banunxcas29 kernel: [ 3315.649905] hci6

Oct  8 15:30:49 banunxcas29 kernel: [ 3315.650134] hci5

Oct  8 15:30:49 banunxcas29 kernel: [ 3315.650514] hci4

Oct  8 15:30:49 banunxcas29 kernel: [ 3315.650866] hci2



Thanks,
Naveen


On Wed, Oct 8, 2014 at 2:39 PM, Oliver Neukum <oneukum@suse.de> wrote:
> On Tue, 2014-10-07 at 20:01 +0530, Naveen Kumar Parna wrote:
>> > The new patch clears the halt condition.
>>
>> I mean usb_clear_halt( ) returned zero.
>
> That probably means that the device doesn't just
> produce spurious stalls. Does hcidump show anything
> when the stalls happen?
>
>         Regards
>                 Oliver
>
>
