Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Some questions
From: Marcel Holtmann <marcel@holtmann.org>
To: Dirk Vornheder <DVornheder@t-online.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200406240756.18537.dvornheder@t-online.de>
References: <1BYJR5-1Xq5q40@cmpmail07.bbul.t-online.de>
	 <200406231941.04587.dvornheder@t-online.de>
	 <1088013813.4296.3.camel@pegasus>
	 <200406240756.18537.dvornheder@t-online.de>
Content-Type: text/plain
Message-Id: <1088076099.4296.41.camel@pegasus>
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
Date: Thu, 24 Jun 2004 13:21:39 +0200

Hi Dirk,

> > I need a version where you log the initial creation of the HCI link. Do
> > you made this dump as root?
> >
> 
> The hcidump is started before starting ciptool search.
> 
> In the moment i can't see no connection to the printer adapter
> 
> but hcitool scan shows it.

I can't follow you. The dump only shows a CMTP and a BNEP connection to
your access point. If you wanna print make sure that the Bluetooth CUPS
backend is in place and you configured a printer for it. The AP has
nothing to do with printing.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
