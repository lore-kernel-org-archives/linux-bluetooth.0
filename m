Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Pairing a keyboard
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20041125064110.GA2505@frostnet.net>
References: <20041125064110.GA2505@frostnet.net>
Content-Type: text/plain
Message-Id: <1101367010.7538.78.camel@pegasus>
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
Date: Thu, 25 Nov 2004 08:16:49 +0100

Hi Chris,

> When trying to pair with an apple wireless keyboard, hcitool cc errors
> "Can't create connection: Input/output error". I was hoping someone
> might have a suggestion on what to look into.

who said that pairing works by calling "hcitool cc ..."? You should use
the "hidd --connect ..." command instead.

> I'm kernel 2.6.9-mh4 and bluez 2.11 on an x86 with a D-Link DBT-120.
> After starting hcid I run "hcitool cc <addr>" and get the error above.
> I've included "hcidump -x"'s transcript at the bottom of this email.
> bluepin does not work on my installation (pygtk seems broken), so I wrote
> a script to echo "0000" to stdout. This may well be my problem? I do not know
> if this is the format hcid is expecting or if it is the initial pin apple
> sets. I did read that the mouse uses this pin, this is the only reason for
> my choice. For my hcid.conf file, security is auto, pin_helper is set to this
> script, and auth and encrypt are commented out.

The bluepin script must echo "PIN:0000".

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
