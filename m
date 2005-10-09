Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Microsoft Inetllimouse for Bluetooth 2.0
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <434879E2.7010902@insight.rr.com>
References: <434879E2.7010902@insight.rr.com>
Content-Type: text/plain
Message-Id: <1128874661.7798.3.camel@blade>
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
Date: Sun, 09 Oct 2005 18:17:41 +0200

Hi Daniel,

> i am somewhat new to linux Ubuntu breezy, and i have managed to get
> my Bluetooth Microsoft mouse 2.0 to connect to Ubuntu. And everything 
> works fine as if the mouse is a 2button mouse with no scroll wheel. My 
> scroll wheel isnt recognized, and my forward/back buttons do not work. I 
> have tried every HOW TO: on the net, but they are all tailored to other 
> mice, most of them are corded. And none of them are Bluetooth to my 
> knowledge.
> Here is my Setup :
> 
> Inspiron 6000 Laptop Internal Dell truemobile 350 Bluetooth Card.
> MS intellimouse for Bluetooth 2.0
> 
> When i use Xev my movements are logged, and my clicks are too , but not 
> forward/back buttons, and no scroll wheel

you need to use the 2.6.13-mh1 patch to get full report mode protocol
support.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
