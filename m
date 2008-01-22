Return-Path: <cyrus@holtmann.org>
Message-ID: <4795E3D5.50703@aircable.net>
Date: Tue, 22 Jan 2008 10:38:45 -0200
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <YKHOViWG.1201003691.1597540.fma@alezan.org>
In-Reply-To: <YKHOViWG.1201003691.1597540.fma@alezan.org>
Subject: Re: [Bluez-users] Newbie needs help to start
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


> Nobody to help me? I still can't access corretly to my Serial3 device
> under debian. I'm trying to use the passkey-agent, and obexftp client,
> but I always get some:
>
>     Connecting...failed: connect
>     Still trying to connect
>
> errors.
>
> What am I doing wrong? What is the correct way to use a BT device? What
> different phases are need?
>   
Fredric we can't know if you don't send us the full hcidump -X -V log.

Pairing should only be done once, after that you don't need to pair again.

You should also report which versions of bluez (libs and utils) you
have, which version from openobex (not related to this forum) and which
version of obexftp.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
