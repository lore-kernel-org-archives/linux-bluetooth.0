Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] pair problem
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <9c68c0a70510292205td65b49bw@mail.gmail.com>
References: <9c68c0a70510292205td65b49bw@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1130658058.5396.61.camel@blade>
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
Date: Sun, 30 Oct 2005 08:40:58 +0100

Hi,

> I can't pair my usb adapter with my phone(nokia 6670).
> my kernel is 2.6.11
> 
> hcid.conf:
> options {
>         autoinit yes;
> 
>         security auto;
> 
>         pairing multi;
> 
>         pin_helper /etc/bluetooth/mypin;
> }

the original hcid.conf show this:

        # Security Manager mode
        #   none - Security manager disabled
        #   auto - Use local PIN for incoming connections
        #   user - Always ask user for a PIN
        #
        security auto;

So if you use "auto" then the PIN for incoming connection comes
from /etc/bluetooth/pin and by default this is "BlueZ" as your hcidump
is showing it. Set it to "user" if you always wanna ask the PIN helper
program.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
