Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Feb 2011 16:35:04 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Justin Mattock <justinmattock@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: bluetooth disabled with current 2.6.38-rc4
Message-ID: <20110216193504.GH14085@joana>
References: <1A8743E5-65EA-4625-82FD-658C9722629F@gmail.com>
 <20110215135245.GA11561@jh-x301>
 <1ADFED1F-912D-4DF9-A3BB-795F9AB1D1F8@gmail.com>
 <20110216133411.GD14085@joana>
 <5C042A85-6D54-451D-8BAC-CE24D61907CA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5C042A85-6D54-451D-8BAC-CE24D61907CA@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Justin,

* Justin Mattock <justinmattock@gmail.com> [2011-02-16 07:34:52 -0800]:

> 
> On Feb 16, 2011, at 5:34 AM, Gustavo F. Padovan wrote:
> 
> > Hi Justin,
> >
> > * Justin Mattock <justinmattock@gmail.com> [2011-02-15 19:26:12  
> > -0800]:
> >
> >>
> >> On Feb 15, 2011, at 5:52 AM, Johan Hedberg wrote:
> >>
> >>> Hi Justin,
> >>>
> >>> On Sun, Feb 13, 2011, Justin Mattock wrote:
> >>>> maybe I missed something, but my bluetooth is just not functioning
> >>>> with
> >>>> 2.6.38-rc4(works with 2.6.37-rc4)
> >>>>
> >>>> I've done a bisect on this, but was pointed to:
> >>>> c0e45c1ca3162acb2e77b3d9e152ce6e7b6fa3f5
> >>>> but doesn't look correct to me
> >>>>
> >>>> here is what I am seeing with the bluetooth-applet etc..:
> >>>>
> >>>> working correctly:
> >>>> http://www.flickr.com/photos/44066293@N08/5443727238/
> >>>>
> >>>> not working:
> >>>> http://www.flickr.com/photos/44066293@N08/5443124859/
> >>>>
> >>>> my /var/log/daemon.log shows:
> >>>>
> >>>> Feb 13 17:12:22 Linux-2 acpid: 1 client rule loaded
> >>>> Feb 13 17:12:23 Linux-2 bluetoothd[1950]: HCI dev 0 registered
> >>>> Feb 13 17:12:23 Linux-2 bluetoothd[1950]: Listening for HCI events
> >>>> on hci0
> >>>> Feb 13 17:12:23 Linux-2 bluetoothd[1950]: HCI dev 0 up
> >>>> Feb 13 17:12:23 Linux-2 bluetoothd[1950]: Unable to find matching
> >>>> adapter
> >>>>
> >>>> I can try at another bisect, but might take some time.. let me know
> >>>> if there is something I can test
> >>>> or do.
> >>>
> >>> Are you sure this is a kernel problem? There was a similar issue  
> >>> with
> >>> BlueZ 4.86 or 4.87 which was already fixed. Could you try with 4.88?
> >>>
> >>> Johan
> >>
> >> o.k. I built 4.88 and still had the issue show up, except this time  
> >> no
> >> icon(instead of the icon, that is not lit up)..
> >>
> >>
> >> anyways I did do another bisect and had better results(hopefully)this
> >> time..:
> >>
> >> 23bb57633df97ede067ea26f3cdc8a7ba2cd8109 is the first bad commit
> >> commit 23bb57633df97ede067ea26f3cdc8a7ba2cd8109
> >> Author: Johan Hedberg <johan.hedberg@nokia.com>
> >> Date:   Tue Dec 21 23:01:27 2010 +0200
> >>
> >>    Bluetooth: Fix __hci_request synchronization for hci_open_dev
> >>
> >>    The initialization function used by hci_open_dev (hci_init_req)
> >> sends
> >>    many different HCI commands. The __hci_request function should  
> >> only
> >>    return when all of these commands have completed (or a timeout
> >> occurs).
> >>    Several of these commands cause hci_req_complete to be called  
> >> which
> >>    causes __hci_request to return prematurely.
> >>
> >>    This patch fixes the issue by adding a new hdev->req_last_cmd
> >> variable
> >>    which is set during the initialization procedure. The
> >> hci_req_complete
> >>    function will no longer mark the request as complete until the
> >> command
> >>    matching hdev->req_last_cmd completes.
> >>
> >>    Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> >>    Acked-by: Marcel Holtmann <marcel@holtmann.org>
> >>    Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> >>
> >> :040000 040000 e8d8ae5fab74b2ba73d0c52e7e09b30e5df8484e
> >> 8d1409e8dc2206492cb86e8848c8c23aff182e2a M      include
> >> :040000 040000 07fdb5f6ceadcfde12c46a3b5c82937b7dac892c
> >> 8f3b08fbbc9fcd078d0f5224b8bc818eeb072dc4 M      net
> >
> > Can you please send the hcidump output? There should be a package  
> > for it in
> > your distribution, if not get the bluez-hcidump from git.kernel.org
> >
> > -- 
> > Gustavo F. Padovan
> > http://profusion.mobi
> 
> 
> 
> o.k...keep in mind I hve never really used that tool, but here goes:
> 
> HCI sniffer - Bluetooth packet analyzer ver 2.0
> device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
>  > ACL data: handle 46 flags 0x02 dlen 12
>     L2CAP(d): cid 0x0041 len 8 [psm 0]
>       A1 02 00 11 FD 00 00 00
>  > ACL data: handle 46 flags 0x02 dlen 12
>     L2CAP(d): cid 0x0041 len 8 [psm 0]
>       A1 02 00 0A FF 00 00 00
>  > ACL data: handle 46 flags 0x02 dlen 12
>     L2CAP(d): cid 0x0041 len 8 [psm 0]
>       A1 02 00 1B FC 00 00 00
>  > ACL data: handle 46 flags 0x02 dlen 12
>     L2CAP(d): cid 0x0041 len 8 [psm 0]
>       A1 02 00 22 FE 00 00 00
>  > ACL data: handle 46 flags 0x02 dlen 12
>     L2CAP(d): cid 0x0041 len 8 [psm 0]
>       A1 02 00 27 FF 00 00 00
>  > ACL data: handle 46 flags 0x02 dlen 12
>     L2CAP(d): cid 0x0041 len 8 [psm 0]
>       A1 02 00 15 FF 00 00 00
>  > ACL data: handle 46 flags 0x02 dlen 12
>     L2CAP(d): cid 0x0041 len 8 [psm 0]
>       A1 02 00 2C 00 00 00 00
>  > ACL data: handle 46 flags 0x02 dlen 12
>     L2CAP(d): cid 0x0041 len 8 [psm 0]
>       A1 02 00 2B 00 00 00 00
>  > ACL data: handle 46 flags 0x02 dlen 12
>     L2CAP(d): cid 0x0041 len 8 [psm 0]
>       A1 02 00 14 FF 00 00 00
>  > ACL data: handle 46 flags 0x02 dlen 12
>     L2CAP(d): cid 0x0041 len 8 [psm 0]
>       A1 02 00 21 FD 00 00 00
>  > ACL data: handle 46 flags 0x02 dlen 12
>     L2CAP(d): cid 0x0041 len 8 [psm 0]
>       A1 02 00 18 FB 00 00 00
>  > ACL data: handle 46 flags 0x02 dlen 12
>     L2CAP(d): cid 0x0041 len 8 [psm 0]
>       A1 02 00 09 FD 00 00 00
>  > ACL data: handle 46 flags 0x02 dlen 12
>     L2CAP(d): cid 0x0041 len 8 [psm 0]
>       A1 02 00 0C FC 00 00 00
>  > ACL data: handle 46 flags 0x02 dlen 12
>     L2CAP(d): cid 0x0041 len 8 [psm 0]
>       A1 02 00 04 FE 00 00 00
>  > ACL data: handle 46 flags 0x02 dlen 12
>     L2CAP(d): cid 0x0041 len 8 [psm 0]
> 
> Justin P. Mattock
> 

It seems that Bluetooth is working for you. If you really have an issue,
please run "bluetooth -nd" by hand and get the full debugs logs. Also check
if you can run "hciconfig -a".


-- 
Gustavo F. Padovan
http://profusion.mobi
