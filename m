Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4642E716.1010905@tao-group.com>
Date: Thu, 10 May 2007 10:34:14 +0100
From: David Given <dg@tao-group.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4641DA61.8040709@tao-group.com>	<1178722356.8628.96.camel@aeonflux.holtmann.net>	<4641E662.6080303@tao-group.com>	<1178724426.8628.102.camel@aeonflux.holtmann.net>	<4641EA96.7070204@tao-group.com>	<1178726532.8628.107.camel@aeonflux.holtmann.net>	<be976db60705090927n71d22c0an5116c8a1323ed3a3@mail.gmail.com>	<46420306.8020509@tao-group.com>
	<1178780976.25565.6.camel@aeonflux.holtmann.net>
In-Reply-To: <1178780976.25565.6.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] API documentation?
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

Marcel Holtmann wrote:
[...]
> Since I haven't heard of hcilib before your post, I am not sure that
> this holds valid. The BlueZ project doesn't use hcilib and also doesn't
> support hcilib. So ask the hcilib maintainer.

Actually I got the name wrong --- I was working off the header files, which
refer to hcilib. The shared library itself is called libbluetooth, and this is
shipped as bluez-libs, and is used by hcid itself.

[...]
> Again. Ask the hcilib maintainer.

I'm afraid that you are the maintainer.

-- 
David Given
dg@tao-group.com

This message is subject to Tao's e-mail terms ( http://e.tao-group.com/1 )
Tao Group Ltd, 62/63 Suttons Business Park, Suttons Park Avenue,
Reading, Berkshire RG6 1AZ. Registered in England, number 2722079

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
