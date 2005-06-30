Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Key exchange before pairing
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <537e39c905062916247959acdf@mail.gmail.com>
References: <537e39c905062907433980aa7f@mail.gmail.com>
	 <1120067870.15397.134.camel@pegasus>
	 <537e39c905062916247959acdf@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1120108243.15397.138.camel@pegasus>
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
Date: Thu, 30 Jun 2005 07:10:43 +0200

Hi Jordi,

> I=B4d like to generate the PIN based on the shared key derived from a
> Diffie Hellman exchange between the bluetooth peers.

if you wanna use Diffie Hellman, for what reason do you want to use the
pairing and encryption of Bluetooth then.

> Is it possible to trigger this exchange at pairing time using my own
> 'pin_helper' program ?

To exchange data you need a connection first. This means you can only do
this in security mode 1 and 2. The PIN helper can't be used for any of
these task except entering a PIN.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
