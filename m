Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Mon, 19 Jun 2006 12:13:36 -0400
Message-ID: <70DCB28C5BB04A4BBB1C8512589BAC65E69927@MAIL006.mail.lan>
In-Reply-To: <1150692231.7068.3.camel@localhost>
From: "Brand, Chris" <chris.brand@qwikker.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Multiple connections with kernel 2.4 make HCI die
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

Hi Kevin,

> no. Disable the SCO support of the hci_usb driver. With a 2.6 
> kernel you can do this with a module paramter, but I am not 
> sure if this made it ever into the 2.4 kernel.

Just to avoid you wasting your time, I'm seeing what sounds like exactly
the same thing with a UART connection rather than USB. This is with a
2.4.18 kernel and 2.25 bluez-libs. Fortunately in my system I can easily
power-cycle the dongle, which seems to be the only way to bring it back
to life.

Hopefully it goes without saying that I'm very interested to hear about
anything you find that helps :-)

Chris



_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
