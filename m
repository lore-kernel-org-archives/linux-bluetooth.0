Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluez-utils 2.7 and bthid
From: Marcel Holtmann <marcel@holtmann.org>
To: Robert Foster <rfoster@mountainvisions.com.au>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1084180461.3145.8.camel@rover.mountainvisions.com.au>
References: <1084160685.3287.2.camel@rover.mountainvisions.com.au>
	 <1084177906.9269.129.camel@pegasus>
	 <1084180461.3145.8.camel@rover.mountainvisions.com.au>
Content-Type: text/plain
Message-Id: <1084181881.9269.149.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 10 May 2004 11:38:01 +0200

Hi Robert,

> I've attached a couple of files.  
> 
> bthid1.txt has the commands I executed to install the libs and utils v.
> 2.7; the bthid commands i executed, as well as the hcidump and system
> log entries related to the connection to the mouse.
> 
> Interesting to note that I wasn't prompted for a PIN this time, it
> simply failed.
> 
> Note also that this was working perfectly before the reboot, using the
> old 2.6 libs and utils.

as I said, don't enable auth and encrypt in hcid.conf, because this is
security mode 3. Make also sure that only one hcid is running.

> I have also set up a rather simple script - /etc/init.d/bluetooth-hid to
> automatically connect to the mouse at startup, which gets it's options
> from a config file in /etc/bluetooth/hid.conf

Why do you need that? The mouse and keyboard reconnects after you've
pressed a key. The only thing you have to start is bthid in daemon mode.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
