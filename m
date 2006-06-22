Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d23110170606220734t5765d71aiae468fc768d6fc31@mail.gmail.com>
Date: Thu, 22 Jun 2006 11:34:58 -0300
From: "Ulisses Furquim" <ulissesf@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1150959999.13991.9.camel@localhost>
MIME-Version: 1.0
References: <44867199.2000409@mail.utexas.edu>
	<1149714318.22472.59.camel@localhost>
	<4487B00F.7070204@mail.utexas.edu>
	<1149803817.4219.61.camel@localhost>
	<448A4385.4020809@mail.utexas.edu>
	<1149986039.5358.25.camel@aeonflux.holtmann.net>
	<4490C0F1.1090704@mail.utexas.edu>
	<1150874298.3950.15.camel@localhost>
	<449A297B.7010009@mail.utexas.edu>
	<1150959999.13991.9.camel@localhost>
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
> this seems that you have to wait for the link supervision timeout on the
> host side. Play a little bit with it. If you turn off the Bluetooth chip

Which reminds me of one thing I read in the specification: the
sniff_max_interval must be less than the link supervision timeout
parameter. I can't say for sure we are taking care of this. Marcel?

Best,

-- Ulisses

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
