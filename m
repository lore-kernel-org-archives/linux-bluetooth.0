Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Howto create SCO Connections?
From: Marcel Holtmann <marcel@holtmann.org>
To: axs203dd@excite.com
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040603094556.12D993DED@xprdmailfe8.nwk.excite.com>
References: <20040603094556.12D993DED@xprdmailfe8.nwk.excite.com>
Content-Type: text/plain
Message-Id: <1086258410.7542.69.camel@pegasus>
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
Date: Thu, 03 Jun 2004 12:26:50 +0200

Hi,

> I have built a piconet over l2cal and bnep using a desktop and a laptop. Now I need to create a SCO link between them in order to transfer real time audio from laptop to desktop. What do I need to do? Are there any utilities/tools for this particular purpose?

at the moment you can only use the SCO seqpacket socket interface. See
source code of scotest.c or hstest.c for more details.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
