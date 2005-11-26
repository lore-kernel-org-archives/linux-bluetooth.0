Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth connection too slow
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1133029672.9123.34.camel@localhost.localdomain>
References: <1133028275.9123.29.camel@localhost.localdomain>
	 <1133028830.28718.19.camel@blade>
	 <1133029672.9123.34.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1133029959.15981.0.camel@blade>
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
Date: Sat, 26 Nov 2005 19:32:39 +0100

Hi Mario,

> > If you reach 32 kB/s then this is a good result. With Bluetooth prior
> > EDR you will reach max something around 80 kB/s, but this is not really
> > doable with PPP in between. The bottleneck can also be the UART inside
> > your mobile phone.
> 
> That wouldn't explain the reason why under Windows I'm getting 32kB/s...
> By the way, what I'm willing to do is just to have the same performance
> under Linux

try to tweak your PPP settings, because I don't think that RFCOMM is the
bottleneck here. I could be, but I doubt it.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
