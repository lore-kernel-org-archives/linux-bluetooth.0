Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <80236d750703270544g12df0f26w2547ed8cc4a3649@mail.gmail.com>
References: <80236d750703270300y3497df0et16f6f1a1d3ce53e0@mail.gmail.com>
	<1174991523.5815.41.camel@violet>
	<80236d750703270544g12df0f26w2547ed8cc4a3649@mail.gmail.com>
Date: Sat, 31 Mar 2007 16:00:23 +0200
Message-Id: <1175349623.5815.279.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] clearing remote name cache
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

Hi Emanuele,

> Ok thanks for  answer,  I'd like  more info about this. 
>  Are  2.1 compliance dongles already available on the market for end
> users? 

no. However in most cases a firmware update for the BlueCore4 chips is
fully enough. So my guess is that Apple will update their built-in
dongles once the specification has been made public.

> And even if I'll got one of those I guess the remote devices should be
> 2.1 too to answer to an extended inquiry.

You need to have both sides support extended inquiry and the host stack
must set the new attributes to make this work. BlueZ is already doing
this if it finds a Bluetooth 2.1 dongle.

> What about the Bluez support about the new features of Bluetooth 2.1?
> (both low level HCI api and D-bus) 

The extended inquiry is fully support. For the D-Bus API you see
actually no difference since all this stuff is hidden. However it works
perfectly fine.

The support for simple pairing from Bluetooth 2.1 has not been published
and will only be published once the specification is public.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
