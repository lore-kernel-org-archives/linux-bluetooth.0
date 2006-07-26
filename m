Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <22B6B486891D6241B8E3D800F393CE0F7E13AC@BGEEXC07.asiapacific.cpqcorp.net>
References: <22B6B486891D6241B8E3D800F393CE0F7E13AC@BGEEXC07.asiapacific.cpqcorp.net>
Date: Wed, 26 Jul 2006 09:00:04 +0200
Message-Id: <1153897204.746.2.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] RfCOMM connection problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Julien,

> I just want to connect my ipac to a RFcomm Bluez linux server through
> bluetooth. 
> I only want to send some "char arrays" through a socket to the linux
> machine. (i.e. use Write() of widcomm stack for ipac) I would like to
> know if it should be possible to create such a connection at the Rfcomm
> layer without using a higher level protocol (FTP,OBEX,...)?
> 
> i.e. for the moment I use the following command:
> 
> obj2.OpenClient(1,addr) ; 
> 
> Can we assign the channel 1 like this or must I use the function
> "obj2.AssignScnValue (p_service_guid,1)" ?
> I do not want to use this function since I don't want to use any
> service...

you are not seriously asking Widcomm related questions on a Linux
mailing list. How should we know? The Widcomm SDK is not available for
free.

> It is trying to connect to the Bluez server and gives me the following
> response using hcidump:

Do you mind sending this with an email client that doesn't screw up
pre-formatted text.

> It seems that the server does even not receive the tentative of
> connection of my client. The Disconnection packet DISC is sent by the
> client, like a timeout.

Your client sends the DISC. Fix your client and try again.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
