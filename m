Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Trouble pairing with new phone... (FIXED!)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <4210E7C1.6010706@cc.gatech.edu>
References: <4210E7C1.6010706@cc.gatech.edu>
Content-Type: text/plain
Message-Id: <1108409220.7780.15.camel@notepaq>
Mime-Version: 1.0
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
Date: Mon, 14 Feb 2005 20:27:00 +0100

Hi Jay,

> I figured out how to pair with my T610 phone.
> 
> Point 1: The computer must initiate the connection. (If you attempt to scan for 
> new devices on your phone and add it there, apparently bluez will not accept 
> incoming pairing requests. Something to do with roleswitch and bluez wanting to 
> be the master? Perhaps...)
> 
> Point 2: My version of blueZ ignores the /etc/bluetooth/pin file (even when in 
> "auto" mode) and I HAD to replace the pin_helper with a link to a script which 
> simply printed "PIN:1234" (replace number with your pin).
> 
> So, once I replace "pin_helper /usr/bin/bluepin" with "pin_helper /sbin/pintest" 
> (where the pintest file contained "echo "PIN:1234") and initiated an rfcomm 
> connection to the phone with my pppd chat script, I was able to type the pin 
> into my phone and pair.
> 
> [(going the other way, from the phone to the computer, didn't work...possibly a 
> problem with the phone, possibly a problem with bluez (as it works under 
> windows...)]
> 
> My hcid.conf options are as follows:
> Options:
> autoinit yes;
> security auto;
> pairing multi;
> pin_helper /sbin/pintest
> 
> Device:
> name "BlueZ (%d)";
> class 0x100;
> iscan enable;
> pscan enable;
> lp rswitch,hold,sniff,park;
> lm accept,master;
> # Authentication and Encryption
>          auth enable;
>          encrypt enable;

if you still wanna use security mode 3 then go with it. If you set
yourself to master then go with it. These are not defaults settings and
there is a reason why.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
