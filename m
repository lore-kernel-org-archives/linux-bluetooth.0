Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: multi rfcomm/sco connection
From: Marcel Holtmann <marcel@holtmann.org>
To: Radha Thiagarajan <rthiaga1@urbana.css.mot.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <411166F7.2020500@urbana.css.mot.com>
References: <20040618175410.28510.qmail@webmail.aruba.it>
	 <1087582530.4309.121.camel@pegasus>
	 <20040618183339.20830.qmail@webmail.aruba.it>
	 <1087583875.25061.2.camel@pegasus>
	 <20040618184232.25439.qmail@webmail.aruba.it>
	 <1087584576.25061.6.camel@pegasus>
	 <20040716140215.564.qmail@webmail2.aruba.it>
	 <1089991775.5119.18.camel@pegasus>  <411166F7.2020500@urbana.css.mot.com>
Content-Type: text/plain
Message-Id: <1091662532.16182.86.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 05 Aug 2004 01:35:32 +0200

Hi Radha,

> 1) We noticed that the SCO module has different behavior when dealing 
> with BDADDR_ANY as opposed to a specific bluetooth address. If a device 
> is told to listen for a SCO connection with BDADDR_ANY, and then creates 
> an outgoing SCO connection to a device using BDADDR_ANY, the connection 
> succeeds. Later, if an incoming SCO connection is received, the listen 
> socket will accept the connection (thus producing two SCO connections 
> over 2 ACL connections to 2 different devices).
> 
> This is all fine, but if instead, we bind the listen socket with a 
> specific device address (instead of BDADDR_ANY) and then try to make the 
> outgoing SCO connection using the specific address, it will fail 
> claiming that the address is already in use. This looks like 
> inconsistent behavior, given that even if we specify BDADDR_ANY and we 
> only have one interface, both connections will be using the same interface.
> 
> So, in short, if BlueZ is asked to use a specific interface for both 
> incoming and outgoing SCO connections, it will refuse to carry out the 
> bind calls, but if BDADDR_ANY is used, it will allow both connections. 
> Therefore, it appears to be a bug - either BlueZ really can't handle 
> more than one SCO at a time and it is being tricked into doing it, or it 
> should allow the user to specify the address and not complain.

there is a simply answer to that question. It is a bug :(

> 2) Consider two devices A and B. A uses BlueZ while B does not. Let us 
> also assume that B can handle more than one SCO per ACL connection.  Let 
> us say that there is a SCO connection between A and B already. Then B 
> initiates a second SCO connection on the same ACL to A. Looking at the 
> source for this situation, it appears that  the device A will overwrite 
> the SCO socket values with the new one that was just established (since 
> it allows only one SCO per ACL). Is this the intended behavior?

I read the source that the new SCO connection will be overwritten with
the value of the first one. However this still doesn't looks very nice
in any case.

Are you planning to use SCO over HCI or PCM?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
