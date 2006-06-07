Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 7 Jun 2006 10:57:38 +0200
From: Thomas Arendsen Hein <thomas@intevation.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20060607085738.GA379@intevation.de>
References: <OF0B6841A9.963250D8-ONC1257171.002503E4-C1257171.00289B9D@dcx.dcx>
MIME-Version: 1.0
In-Reply-To: <OF0B6841A9.963250D8-ONC1257171.002503E4-C1257171.00289B9D@dcx.dcx>
Subject: Re: [Bluez-users] How to setup a pptp-connection via the
	dund-service ?
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

* andreas.knuth@daimlerchrysler.com <andreas.knuth@daimlerchrysler.com> [20060517 09:24]:
> Does someone has successfully tried to set up a pptp server via dund 
> communicating over Bluetooth?
> My first attempt does not work as expected...
> How does interact the dund with the pptpd and the pppd ?

I've done it indirectly with doing an unencrypted PPP connection
over dund and over this tcp/ip layer I connected to the pptp
service.

With the Palm PDA I had to do it like this anyway, because it only
supports PPTP over IP and I guess other clients have the same
behaviour.

Thomas

-- 
Email: thomas@intevation.de
http://intevation.de/~thomas/


_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
