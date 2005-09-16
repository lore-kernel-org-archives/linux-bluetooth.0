Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] PAN and RFCOMM
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <432A314C.4050701@avantwave.com>
References: <432A314C.4050701@avantwave.com>
Content-Type: text/plain
Message-Id: <1126844755.5934.9.camel@localhost.localdomain>
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
Date: Fri, 16 Sep 2005 06:25:54 +0200

Hi,

>    I am writing a file transfer program though rfcomm to my device. But
> I found that whenever my device connected with a bluetooth access point,
> the connect/transfer/disconnect actions are all very slow. Is it the
> restriction on the bluetooth protocol/baseband or i should set something
> before any connections?

this can be and depends on the chips of the other devices. However the
HCI 16.4 of your local adapter is not bad, but still quite old.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
