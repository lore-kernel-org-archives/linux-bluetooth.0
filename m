Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] apple wireless keyboard
From: Marcel Holtmann <marcel@holtmann.org>
To: "Collin R. Mulliner" <collin@betaversion.net>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040614143144.6a5ecfc8@coredump>
References: <40C9FD7B.6000004@gmx.net>  <20040614143144.6a5ecfc8@coredump>
Content-Type: text/plain
Message-Id: <1087255783.13792.54.camel@pegasus>
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
Date: Tue, 15 Jun 2004 01:29:44 +0200

Hi Collin,

> quick answer is: the apple wireless keyboard works 100% with bluez-hidd.
> 
> I had to active authentication (on the laptop side), then just wait
> until you get the bluepin popup asking for a pin, type in the pin on the
> laptop side and on the apple wireless keyboard (press enter after
> entering the pin!).

I only had to set auth once for the initial connection to the keyboard.
After that I never needed it again. It will request authentication and
set the encryption by itself on reconnect.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
