Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: BlueLogic Wingkey problems
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20041114T204627-795@post.gmane.org>
References: <loom.20041114T133356-876@post.gmane.org>
	 <1100449789.21403.47.camel@pegasus>
	 <loom.20041114T204627-795@post.gmane.org>
Content-Type: text/plain
Message-Id: <1100463226.21403.69.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 14 Nov 2004 21:13:46 +0100

Hi Andres,

> > first I need some more information about this device 
> >  
> >  hcitool inq 
> >  hcitool scan 
> >  hcitool info 00:xx:xx:xx:xx:xx 
>  
> bash-2.05b# hcitool inq 
> Inquiring ... 
>         00:02:72:40:8A:DC       clock offset: 0x582d    class: 0x002540 
> bash-2.05b# hcitool scan 
> Scanning ... 
>         00:02:72:40:8A:DC       BlueLogic Keyboard 
> bash-2.05b# hcitool info 00:02:72:40:8A:DC 
> Requesting information ... 
>         BD Address:  00:02:72:40:8A:DC 
>         Device Name: BlueLogic Keyboard 
>         LMP Version: 1.1 (0x1) LMP Subversion: 0x1a5 
>         Manufacturer: Cambridge Silicon Radio (10) 
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00 
>                 <3-slot packets> <5-slot packets> <encryption> <slot offset> 
>                 <timing accuracy> <role switch> <hold mode> <sniff mode> 
>                 <park state> <RSSI> <channel quality> <SCO link> <HV2 packets> 
>                 <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme> 
>                 <power control> <transparent SCO> 

actually the class value is wrong if it is a mouse+keyboard combination.
The current HID boot protocol can't set the correct input parameters if
this value is wrong. However you can overwrite it from userspace with a
--subclass=0xc0 parameter when starting hidd from the boot scripts.
  
> > Then compile the libs2 CVS repository and run 
> >  
> >  ./test/sdptest records 00:xx:xx:xx:xx:xx > sdp_records.txt 
> >  
> > and send me the file sdp_records.txt. 
>  
> Sorry, I only have a gmane interface for now (no attachements) -> inline. I can 
> resend with an attachement tomorrow. 

Please do so. I need that for my database.

> > > config:  
> > > - vanilla 2.6.9 kernel  
> > > - x86  
> > > - tried with planet and epox usb bt adapters  
> > > - gentoo setup, with hidd etc. installed and enabled.  
> >  
> > Use a 2.6.9-mh3 kernel and see if this helps. 
>  
> will try this as soon as I have time (hopefully tomorrow). 

The -mh3 activates the HID report mode and so the --subclass workaround
shouldn't be needed anymore.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
