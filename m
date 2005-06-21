Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050621085908.17812.qmail@web50702.mail.yahoo.com>
From: "John H." <mistamaila@yahoo.com>
Subject: Re: [Bluez-users] error on bluez-utils compile(fc4)
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1119217947.8954.8.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 21 Jun 2005 01:59:08 -0700 (PDT)

so libs2 and utils2 is not related to 2.17 of both on
site?

--- Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi John,
> 
> > apparently not, or something.
> > 
> > I tried utils, and it gave me this error...
> > 
> > hciconfig.o(.text+0x1bd4): In function
> `cmd_inq_type':
> > hciconfig.c: undefined reference to
> > `hci_write_inquiry_scan_type'
> > hciconfig.o(.text+0x1bf8):hciconfig.c: undefined
> > reference to `hci_read_inquiry_scan_type'
> > collect2: ld returned 1 exit status
> > make[2]: *** [hciconfig] Error 1
> > make[2]: Leaving directory
> > `/tmp/bluez-utils-cvs/tools'
> > make[1]: *** [all-recursive] Error 1
> > make[1]: Leaving directory `/tmp/bluez-utils-cvs'
> > make: *** [all] Error 2
> 
> you need the libs from CVS, too.
> 
> > utils2 gave me this error on configure, although I
> > have luez-libs 2.17 installed ...
> > 
> > checking for bt_inquiry in -lbluetooth... no
> > configure: error: Bluetooth library not found
> 
> Don't mix libs2 or utils2 with current libs and
> utils.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
>
-------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux
> Migration Strategies
> from IBM. Find simple to follow Roadmaps,
> straightforward articles,
> informative Webcasts and more! Get everything you
> need to get up to
> speed, fast.
>
http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
