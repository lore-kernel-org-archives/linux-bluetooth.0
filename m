Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michael Mauch <michael.mauch@gmx.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20051215211716.GB12373@elmicha.333200002251-0001.dialin.t-online.de>
References: <op.s1tgc9j9xabado@portatilegio> <1134636788.5198.42.camel@localhost> <op.s1tiptlkxabado@portatilegio> <1134638529.11856.1.camel@localhost> <op.s1tj7dd6xabado@portatilegio> <1134642179.11856.30.camel@localhost> <op.s1t0xmg8xabado@portatilegio> <op.s1t2ws0rxabado@portatilegio> <op.s1t63hh3xabado@portatilegio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <op.s1t63hh3xabado@portatilegio>
Subject: [Bluez-users] Re: A blue chamaleon to be
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
Date: Thu, 15 Dec 2005 22:17:16 +0100

zio tom wrote:

> In data Thu, 15 Dec 2005 18:29:17 +0100, zio tom <zio.tom@gmail.com> ha  
> scritto:
> 
> >Now, when I'm trying to connect via GPRS through wvdial (after having  
> >configured wvdial.conf to fit to my provider's profile) here what I get:
> >
> >giovanni@linux:~> su
> >Password:
> >linux:/home/giovanni # wvdial
> >--> WvDial: Internet dialer version 1.54.0
> >--> Cannot open /dev/rfcomm0: Cannot get information for serial port.
> >--> Cannot open /dev/rfcomm0: Input/output error
> 
> Sorry for having posted that too much in a hurry. Now, what configuration  
> file or log should I post to make helping easier?

"rfcomm" should show rfcomm0 with the device address and the channel.
If not, run "rfcomm bind 0". 

If that works, you could change the "bind no" to "bind yes" in
rfcomm.conf and restart the bluez/bluetooth init script (hopefully it
contains a "rfcomm bind all").


  Michael


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
