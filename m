Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1173045518.989564.4714.nullmailer@galant.ukfsn.org>
References: <1173045518.989564.4714.nullmailer@galant.ukfsn.org>
Date: Mon, 05 Mar 2007 13:35:07 +0100
Message-Id: <1173098107.6638.12.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Link Mode
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Iain,

>    I am trying to write a compatible equivalent to the Link Mode socket
> options API for NetBSD, and I wonder if somebody can clarify some things
> for me since I can't find any documentation about this.
> 
> I assume that RFCOMM_LM and L2CAP_LM are essentially the same, the
> following bits are defined:

from a bitwise perspective they are even the same as HCI_LM. The
different prefix is only exists to make the programs more cleanly.

> _LM_MASTER
> 	means we prefer to be master of the baseband link

It actually comes down to the HCI_Create_Connection command. This one
has a flag to indicate if a role-switch is allowed or not.

> _LM_AUTH
> 	means we want the baseband link to be authenticated

It means that a HCI_Authentication_Requested must succeed.

> _LM_ENCRYPT
> 	means we want the baseband link to be encrypted

It means that a HCI_Set_Encryption must be used to enable the
encryption.

> _LM_TRUSTED
> 	this seems unused, is there an intention?

Actually I can't remember what this was supposed to do. I think it
should be indicate that the device must be marked as trusted before
allowing a connection. However there is no way at the moment to mark a
device as trusted.

> _LM_RELIABLE
> 	signal error on unreliable link (means disconnect?)

It is basically only used in L2CAP to detect wrong ACL packets. This was
needed for the Bluetooth qualification testing.

> _LM_SECURE
> 	is this somehow different than (_LM_AUTH | _LM_ENCRYPT)?

It is authentication + encryption and on a successful connect at that
protocol level, it will also issue a HCI_Change_Connection_Link_Key.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
