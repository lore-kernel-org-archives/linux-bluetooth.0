Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pete Stevens <pete@ex-parrot.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] sdptool -i
In-Reply-To: <1126801396.15633.0.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0509151732320.23886@sphinx.mythic-beasts.com>
References: <Pine.LNX.4.58.0509151651420.23886@sphinx.mythic-beasts.com>
 <1126801396.15633.0.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Thu, 15 Sep 2005 17:33:26 +0100 (BST)

On Thu, 15 Sep 2005, Marcel Holtmann wrote:

> Hi Pete,
>
> > [root@pstevens root]# sdptool -i hci0 search OPUSH
> > sdptool: invalid option -- i
> > sdptool - SDP Tool v1.5
> > Usage:
> >         sdptool [options] <command> [command parameters]
> >
> >
> > As far as I can tell, sdptool 1.5 is the latest version. Scanning the mailing
> > list suggests that the -i option has been mentioned but I can't confirm if
> > it's been implemented or not.
>
> my sdptool tells me it is version 2.21. I think you should update,
> because this was fixed long time ago.

Apologies - I've just built the latest version from source and it's working
fine now.

I'll go and hide under a rock.

Yours,

Pete Stevens

--
Pete Stevens
pete@ex-parrot.com
http://www.ex-parrot.com/~pete/

                                               What's got four legs and an arm?
                                                            A happy Rottweiler.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
