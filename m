Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20030716002326.787.qmail@web10207.mail.yahoo.com>
From: Aarti Kumar <akmr2000@yahoo.com>
Subject: Re: [Bluez-devel] Measuring throughput using l2test gives very
	high value.
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <pan.2003.07.15.21.46.10.918280@dcs.gla.ac.uk>
MIME-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 15 Jul 2003 17:23:26 -0700 (PDT)
Content-Type: text/plain; CHARSET=us-ascii


Hello,
I am trying to measure the throughtput between two
laptops with bluetooth connection.
The l2test gives a very high value : in theranhe of
34567 kB/sec 76578 kB/sec.
I am not able to understand what the problem is .
Also the Time taken to tranfer the data is printed as
0.00 sec.

Using following commands:
Server : ./l2test -r
Client : ./l2test -s baddr.

Thanks,
Aarti.

--- Jonathan Paisley <jp-www@dcs.gla.ac.uk> wrote:
> On Fri, 11 Jul 2003 18:53:31 +0100, James
> Courtier-Dutton wrote:
> 
> > I have discovered that the performance of the
> bluez stack is a problem
> > when using the hci_usb.c driver.
> > I cannot get it to send SCO packets quicker than
> one urb per 40ms. As
> > the headset needs one urb per 3ms, this is quite a
> problem. I would also
> > assume that other applications like file transfer
> over bluetooth would
> > be bad.
> 
> Have you identified what's actually causing this
> rate limit? It sounds
> more like a scheduling issue to me than a
> number-of-memory-copies problem.
> 
> Would you consider sharing the code modifications
> you have made thus far?
> 
> I have been experimenting with two USB dongles with
> the aim of making the
> PC act as a headset (I don't have one). I have been
> able to get reasonable
> (although sometimes choppy audio) on the PC. That
> is, the sound is being
> received by the PC. I haven't yet managed to test
> sending audio except for
> /dev/zero. All this testing is with 2.4.20-mh10.
> 
> The two dongles I have are the Mitsumi WIF-0402c and
> the Sitecom CN-500,
> which report as follows:
> 
> Sitecom CN-500:
> $ sudo /sbin/hciconfig hci0 revision
> hci0:   Type: USB 
>         BD Address: 00:10:60:A2:E4:C2 ACL MTU: 192:8
>  SCO MTU: 64:8
>         HCI 16.4
>         Chip version: BlueCore02
>         Max key size: 56 bit
>         SCO mapping:  HCI
> 
> Mitsumi WIF-0402c:
> $ sudo /sbin/hciconfig hci0 revision
> hci0:   Type: USB 
>         BD Address: 00:A0:96:1D:4A:AA ACL MTU: 128:8
>  SCO MTU: 64:8
>         HCI 11.2
>         Chip version: BlueCore01b
>         SCO mapping:  HCI
> 
> The Mitsumi accepts the SCO connection and then
> gives up, whereas the
> Sitecom is able to sustain the connection for as
> long as I have tested
> (<2minutes). The Mitsumi is much older, so I'm not
> surprised there are
> problems. However, both devices work okay in this
> manner under Windows.
> 
> 
> 
> 
> 
>
-------------------------------------------------------
> This SF.net email is sponsored by: VM Ware
> With VMware you can run multiple operating systems
> on a single machine.
> WITHOUT REBOOTING! Mix Linux / Windows / Novell
> virtual machines at the
> same time. Free trial click here:
> http://www.vmware.com/wl/offer/345/0
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-devel


__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
