Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20040331134502.35044.qmail@web21006.mail.yahoo.com>
From: =?iso-8859-1?q?Gary=20Martin?= <gary_martin_au@yahoo.com.au>
Subject: Re: [Bluez-users] Desperate newbie
To: Andreas Deresch <aderesch@fs.tum.de>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.56L0.0403311318140.9869@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Wed, 31 Mar 2004 23:45:02 +1000 (EST)

Thank you for your support Andreas. Problems like this make me
want to go back to Mac OS X, but there is something about Linux
that draws me back. It has been a struggle --- I think a lot of
the problems I have encountered with Linux have been the result of
trying to run it on a PowerPC chip!!

I started using Linux because my Masters thesis will be on the use
of OSS in the public health care system --- I thought I should
practice what I will preach!

 --- Andreas Deresch <aderesch@fs.tum.de> wrote: > On Wed, 31 Mar
2004, [iso-8859-1] Gary Martin wrote:
> 
> > 4 - It seems to be a lot of work to find a class code that
> might
> > not even be the problem
> Correct. What I meant was, that *any* of the three should work.
> BTW, "Mobile
> Phone" is the class value returned by your T628 by hcitool inq
> (0x520204).
These are the different classes I have tried in hcid.conf
# Local device class
	# class 0x100;
	# class 0x10c;
	# class 0x120104;
	# class 0x100100;
	class 0x520204;

> 
> > I have spent too much time on this problem already. I'm
> beginning
> > to lose faith in Linux for "users" like me
> Don't. It can take some time to get used to, but it's worth it.
> :-)
> Anyhow, I would really be interested in solving your problem (or
> at least
> determining the cause), if you are willing to keep trying a
> little longer:
> 
> What is the output of sdptool browse?
There is a lot of output:
debian:~# sdptool browse
Inquiring ...
Browsing 00:0E:07:54:32:0B ...
Service Name: Dial-up Networking
Service RecHandle: 0x10000
Service Class ID List:
  "Dialup Networking" (0x1103)
  "Generic Networking" (0x1201)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Profile Descriptor List:
  "Dialup Networking" (0x1103)
    Version: 0x0100
 
Service Name: Voice gateway
Service RecHandle: 0x10002
Service Class ID List:
  "Headset Audio Gateway" (0x1112)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 3
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0100
 
Service Name: Serial Port 1
Service RecHandle: 0x10003
Service Class ID List:
  "Serial Port" (0x1101)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 4
 
Service Name: Serial Port 2
Service RecHandle: 0x10004
Service Class ID List:
  "Serial Port" (0x1101)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 5
 
Service Name: OBEX Object Push
Service RecHandle: 0x10005
Service Class ID List:
  "OBEX Object Push" (0x1105)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 10
  "OBEX" (0x0008)
Profile Descriptor List:
  "OBEX Object Push" (0x1105)
    Version: 0x0100
 
Service Name: IrMC Synchronization
Service RecHandle: 0x10006
Service Class ID List:
  "IrMCSync" (0x1104)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 11
  "OBEX" (0x0008)
Profile Descriptor List:
  "IrMCSync" (0x1104)
    Version: 0x0100
 
Service Name: HF Voice gateway
Service RecHandle: 0x10007
Service Class ID List:
  "" (0x111f)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 6
Profile Descriptor List:
  "" (0x111e)
    Version: 0x0100
 
Service Name: OBEX Basic Imaging
Service RecHandle: 0x1000b
Service Class ID List:
  "" (0x111b)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 15
  "OBEX" (0x0008)
Profile Descriptor List:
  "" (0x111a)
    Version: 0x0100
 
Service Name: OBEX File Transfer
Service RecHandle: 0x1000f
Service Class ID List:
  "OBEX File Transfer" (0x1106)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 7
  "OBEX" (0x0008)
Profile Descriptor List:
  "OBEX File Transfer" (0x1106)
    Version: 0x0100

> What exactly did you mean by "multisync cannot find the phone"?
> You can
> select "IrMC Mobile Device" as plugin, "Bluetooth" as connection
> type, and
> can "search for units", but do not get a response? (Phone was
> discoverable?)
Yes --- there is an option in Multisync (IRMC-Bluetooth) to
"search for units", and if found, "test connection" It just hangs
during the search
> 
> ad 

Gary

Find local movie times and trailers on Yahoo! Movies.
http://au.movies.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
