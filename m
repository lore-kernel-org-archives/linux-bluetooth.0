Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Richard Cox <conardcox@earthlink.net>
Reply-To: rcox27@triad.rr.com
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Connection dropped or cannot connect
References: <000801c41e98$9e75d080$0100a8c0@terre>
In-Reply-To: <000801c41e98$9e75d080$0100a8c0@terre>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404101642.14384.conardcox@earthlink.net>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 10 Apr 2004 16:42:14 -0400

On Friday 09 April 2004 09:10 pm, Jean-Pierre Lord wrote:
> My Linux box has a Anycom usb-220 bluetooth adapter connected to it which
> is used to serve my iPAQ1940.  Works "superbly great" except those times it
> won't work at all ;-).  Either a long connection (like a download) will be
> cut or i will not be able to open a new connection.  When it happens, i
> have 2 choices: unplung the bluetooth adapter for a few seconds (which
> requires no other intervention on the software side) and replug it or reset
> the device using hciconfig.  Except that doing this reset will sometimes
> crash the hole Linux box.  I then get a stack dump and once i got a message
> that looked like this: "...killing interrupt handler...".  Sorry i wasn't
> fast enough to write down the message.
>
> I'm running "Kernel 2.4.24-mh2 on an i586" with bluez-libs-2.5,
> bluez-sdp-1.5, bluez-utils-2.5.  I normally run hcid, sdpd, "dund --listen
> --msdun call dun".  It seems to me that enabling authentification and
> encryption has made the whole thing less reliable.
>
> What can i do to improve reliability?
>
> Thank you
>
> An lsmod shows the following:
> Module                  Size  Used by
> bnep                    8912   0  (autoclean)
> ppdev                   6960   0  (autoclean)
> ppp_deflate             3120   0  (autoclean)
> zlib_inflate           19648   0  (autoclean) [ppp_deflate]
> zlib_deflate           18688   0  (autoclean) [ppp_deflate]
> bsd_comp                4416   0  (autoclean)
> ppp_async               6544   0  (autoclean)
> ppp_generic            16960   0  (autoclean) [ppp_deflate bsd_comp
> ppp_async] slhc                    4736   0  (autoclean) [ppp_generic]
> crc32                   2848   0  [bnep]
> sco                     7936   0  (unused)
> hci_usb                 6336   1
> usb-ohci               16816   0  (unused)
> rfcomm                 29040   1  (autoclean)
> l2cap                  15632   2  (autoclean) [bnep rfcomm]
> bluez                  28224   3  (autoclean) [bnep sco hci_usb rfcomm
> l2cap] ipt_MASQUERADE          1344   1  (autoclean)
> ipt_state                576   2  (autoclean)
> ip_nat_ftp              2912   0  (unused)
> iptable_nat            16592   2  [ipt_MASQUERADE ip_nat_ftp]
> ip_conntrack_ftp        3760   1
> ip_conntrack           18752   3  [ipt_MASQUERADE ipt_state ip_nat_ftp
> iptable_nat ip_conntrack_ftp] iptable_filter          1680   1
> ip_tables              12000   6  [ipt_MASQUERADE ipt_state iptable_nat
> iptable_filter] 3c509                   8304   2
> rtc                     6112   0  (autoclean)

Good news and bad news,
	Good news is that i've got my iPAQ pan connection working very well, but am 
having a very similar problem to the once described here.  Here's what 
happens in the log:

Apr 10 16:31:45 furrball kernel: hci_acl_tx_to: hci0 ACL tx timeout
Apr 10 16:31:45 furrball kernel: hci_acl_tx_to: hci0 killing stalled ACL 
connection B6:CB:5A:16:05:00
Apr 10 16:31:45 furrball kernel: pan0: port 1(bnep0) entering disabled state
Apr 10 16:31:45 furrball kernel: pan0: port 1(bnep0) entering disabled state
Apr 10 16:31:45 furrball kernel: device bnep0 left promiscuous mode

After that happens, the only thing that will fix it is to unplug and re-insert 
the USB dongle.  hciconfig just returns this when I try a reset:

[furrball:~]# hciconfig hci0 reset
Can't init device hci0. Connection timed out(110)

I read this response and turned off encrypt and authentication in hci.conf, 
but it has made no noticable difference.  This always happens after a little 
over 1 or 2 Mb of data xfer.

Any ideas on what we might try next.  If you need any more info, I'll be happy 
to provide it.

PS:  I'm using the latest bluez download from the download section, i'm 
running a vanilla 2.4.25 kernel on gentoo linux.  I've got a Belkin F8T003 
USB adapter too.

Regards,

Richard


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
