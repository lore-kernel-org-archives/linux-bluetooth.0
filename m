Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d23110170606260725w39add24bxc33a489ad137a3a1@mail.gmail.com>
Date: Mon, 26 Jun 2006 11:25:39 -0300
From: "Ulisses Furquim" <ulissesf@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1150999928.13991.60.camel@localhost>
MIME-Version: 1.0
References: <44867199.2000409@mail.utexas.edu>
	<1149803817.4219.61.camel@localhost>
	<448A4385.4020809@mail.utexas.edu>
	<1149986039.5358.25.camel@aeonflux.holtmann.net>
	<4490C0F1.1090704@mail.utexas.edu>
	<1150874298.3950.15.camel@localhost>
	<449A297B.7010009@mail.utexas.edu>
	<1150959999.13991.9.camel@localhost>
	<d23110170606220734t5765d71aiae468fc768d6fc31@mail.gmail.com>
	<1150999928.13991.60.camel@localhost>
Subject: Re: [Bluez-devel] Latest 2.6.16-mh1 patch.
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On 6/22/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> the upcoming Lisbon specification will take care of the missing
> possibility to see a changed link supervision timeout. However we might
> need to track the actual link supervision timeout for our connections.
> Can you try to come up with a patch for it?

We can get the link supervision timeout when the connection is
established (as we now do for the remote features), but I don't know
how we are suppose to track it if we don't receive a notification when
its value changes. It seems we don't have a _clean way_ of doing this
and we'll always have the possibility of using the wrong link
supervision timeout.

What do you think we should do? I'm wondering how often the link
supervision timeout changes and if we should assume that it won't
change after the connection is established (at least for now).

-- Ulisses

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
