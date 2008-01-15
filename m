Return-Path: <cyrus@holtmann.org>
Message-ID: <478CB508.50904@aircable.net>
Date: Tue, 15 Jan 2008 11:28:40 -0200
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <fe53c8c00801150523j4eebbf02p584cf92bdcf9f777@mail.gmail.com>
In-Reply-To: <fe53c8c00801150523j4eebbf02p584cf92bdcf9f777@mail.gmail.com>
Subject: Re: [Bluez-users] how many BT devices can be connected at the same
 time?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Joel,
You have 2 maximuns one is because of bluetooth specs the other is
because of BlueZ constraints.

BlueZ can handle up to 15 (someone correct me if I'm wrong) bluetooth
dongles (hci devices).

Then you can get up to 7 connections per bluetooth dongles (bluetooth
constraint)

Cheers,
Manuel

> hy all,
>
> I am doing a project, which requires 'n' simultanious connection,
> depending on the users loggin into the facility. I was thinking about
> implementing an application level "scheduling" to take care of
> multiplexing the request. But is there a limit in bluez?? I have heard
> bluethooth has a 6slave+1master rule?? I read the FAQ for bluez..but
> it confused me with saying .. "multiple devices can be connected".
>
> thanks for your time,
> joel.
>   


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
