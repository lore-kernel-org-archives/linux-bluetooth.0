Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] automatic change of link role?
From: Marcel Holtmann <marcel@holtmann.org>
To: "Collin R. Mulliner" <collin@betaversion.net>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040623145218.2dcf9a2a@coredump>
References: <20040623145218.2dcf9a2a@coredump>
Content-Type: text/plain
Message-Id: <1087997029.4209.95.camel@pegasus>
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
Date: Wed, 23 Jun 2004 15:23:49 +0200

Hi Collin,

> just a simple/stupid question. Do I have to change the link role
> (master/slave) manually (by calling hci_switch_role) or does this happen
> automatically if needed (the hci device is set to RSWITCH). I have a
> program which will connect/disconnect to many different devices.

the link policy only allows role switch, it doesn't change the role. The
best way is to do it manually or set the link mode. The link mode can be
set for a device or also for a L2CAP listen socket.

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
