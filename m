Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] btsco and Nokia HDW-3 headset not working
From: James Fitzsimons <james.fitzsimons@gmail.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <f68b8ee1050323043862bc4c6d@mail.gmail.com>
References: <1111528750.12076.18.camel@localhost>
	 <42409B3B.1080906@xmission.com> <f68b8ee1050323043862bc4c6d@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1111619908.16128.6.camel@localhost>
Mime-Version: 1.0
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
Date: Wed, 23 Mar 2005 23:18:28 +0000

On Wed, 2005-03-23 at 12:38, James Fitzsimons wrote:
> On Tue, 22 Mar 2005 15:24:59 -0700, Brad Midgley <bmidgley@xmission.com> wrote:
> > This is not the latest cvs version. It's silent unless you specify "-v"
> > flag. Where did you get the kernel module and btsco daemon you are trying?

> That may be the case, I built this a few weeks ago. I will update
> tonight. I am using an ebuild produced by someone in the gentoo
> community, however I am pretty sure it gets the kernel modules and
> btsco daemon source from cvs. I will check this and rebuild to see if
> that helps.

Ok, I've just rebuilt using the latest cvs version. I am still having
the same issue where I can connect to the headset, volume etc works, but
no sound (eg from XMMS).

Output:
athos root # btsco -v 00:03:89:67:8F:F7
btsco v0.4
Device is 2:0
Voice setting: 0x0060
RFCOMM channel 1 connected
recieved AT+CKPD=200
speaker volume: 11 mic volume: 1
driver is in use
connected SCO channel
Done setting sco fd
recieved AT+VGS=15
Sending up speaker change 15
recieved AT+VGS=11
Sending up speaker change 11
recieved AT+VGS=15
Sending up speaker change 15

Any ideas? 

Thanks very much for your help,
James
-- 
It's 5.50 a.m.... Do you know where your stack pointer is ?



-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
