Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth 1.2 and 1.1 compatibility
From: Marcel Holtmann <marcel@holtmann.org>
To: Sean Loh <blaze_wk@yahoo.com>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <20041013022808.63256.qmail@web41113.mail.yahoo.com>
References: <20041013022808.63256.qmail@web41113.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1097652607.4643.10.camel@notepaq>
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
Date: Wed, 13 Oct 2004 09:30:07 +0200

Hi Sean,

> I have curretnly written a program to transmit data
> over IP over Bluetooth using the PAN profile. I was
> wondering if I actually ported the program to use it
> over another notebook using the Bluetooth usb 1.2
> adapter, will bluez then still be the same. Or will
> some bluez specifications change? My program just uses
> the basic sockets to trasmit data. 

there will be no difference when using Bluetooth 1.1 or 1.2 devices. If
you like you can even connect to a Bluetoth 1.0b device and will see no
difference.

> Other questions, 
> - does bluez support the higher data
> throughputs(around 2.1 Mbps) of Bluetooth 1.2?

We already support the EDR extension for Bluetooth 1.2.

> - are there any bluez compliant bluetooth usb
> adapters?

What I know is that BlueZ supports every USB dongle that is out on the
market at the moment. But I haven't seen so far any dongle with EDR
support.

> - if my program is indeed able to be ported to be used
> over the bluetooth 1.2 usb adapter, will my program
> immediately benefit from the increased data rate of
> the bluetooth 1.2 specification?

Yes.

> thanks for any help, bluez rocks!!

You are welcome.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
