Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Robert Siemer <Robert.Siemer@backsla.sh>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20051127174209.GB15156@polar.elf12.net>
References: <20051008132533.GA954@polar.elf12.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051008132533.GA954@polar.elf12.net>
Subject: [Bluez-devel] Re: Jumpy cursor with Wacom Graphire Bluetooth
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 27 Nov 2005 18:42:09 +0100

Hello everybody!

I'm picking up this thread because it is still unresolved...

1) Finally I could update from 2.6.12-mh3 to 2.6.14-mh2.
   With that I can prove Marcel wrong without repeating myself once
   again: the tablet works as bad as before; no visible difference
   between these two patched kernels.

2) I would like to get some answers to my questions below. Marcel,
   why are you ignoring them?


On Sat, Oct 08, 2005 at 03:25:33PM +0200, Robert Siemer wrote:

> hcidump is telling me that my tablet sends packets only after six pixels
> of mouse movement or together with button events. - I suppose that some
> parameters exchanged during connection handshake are the cause.
> 
> -Who is making the connectinon? (hidp kernel module?)
> -Who can/could influence it's outcome? (hidd userspace daemon? Plays
>  hcid an important role?)
> -Has the latency thing something to do with it?
> -Which spec should I first dig into - Bluetooth or HID?
> 
> 
> I played already around with role switching (forced, voluntary from the
> tablet, none). - Has no influence.
> 
> A "hcidump -w" connection dumps are attached. Here inline some tablet
> mouse movements:
> 
> panorama:/tmp# hcidump -V -X
> HCI sniffer - Bluetooth packet analyzer ver 1.23
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > ACL data: handle 41 flags 0x02 dlen 10
>     L2CAP(d): cid 0x0041 len 6 [psm 0]
>       0000: a1 02 00 fa 02 00                                 ......
>                      ^^ ^^
> Curser moved six "entities" to the left. While already sending a packet,
> the tablet also reports some down movements ("02").
> 
> > ACL data: handle 41 flags 0x02 dlen 13
>     L2CAP(d): cid 0x0041 len 9 [psm 0]
>       0000: a1 03 00 00 00 00 00 00  20                       ........ 
> > ACL data: handle 41 flags 0x02 dlen 10
>     L2CAP(d): cid 0x0041 len 6 [psm 0]
>       0000: a1 02 00 fd 06 00                                 ......
>                      ^^ ^^
> The same, but moved 06 entities ("pixel") down. Obviously I also moved 3
> pixels left (0xfd).
> 
> > ACL data: handle 41 flags 0x02 dlen 13
>     L2CAP(d): cid 0x0041 len 9 [psm 0]
>       0000: a1 03 00 00 00 00 00 00  20                       ........ 



Thanks for hints,
			Robert


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
