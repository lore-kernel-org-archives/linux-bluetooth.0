Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <544bb7070612301232m41910874h59249bd0b0e88774@mail.gmail.com>
Date: Sat, 30 Dec 2006 12:32:15 -0800
From: "Ian Rickard" <inioinio@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0612301747480.20515@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
References: <544bb7070612272338m3f130e00p22ee2f1b7f67d3cb@mail.gmail.com>
	<56233.80.165.155.106.1167300847.squirrel@webmail10.pair.com>
	<Pine.LNX.4.63.0612281212140.12381@redbean.intranet.gw-instruments.de>
	<544bb7070612280942n6907d4e2u107654fd71310df4@mail.gmail.com>
	<Pine.LNX.4.63.0612301747480.20515@redbean.intranet.gw-instruments.de>
Subject: Re: [Bluez-devel] bdaddr for CSR chipset - porting dificulties
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

On 12/30/06, Peter Wippich <pewi@gw-instruments.de> wrote:
>
> Hi Ian,
>
> On Thu, 28 Dec 2006, Ian Rickard wrote:
>
> > But only UART, not USB?  I tried again with transient = true (word 7 =
> > 0x0008) and I still get a response with status 0x0009.
> The bccmd tool should also work over USB (have not tried it, but the code
> is in place).

Yeah, I'm think the problem is that Security_enable is set, preventing
the bt_addr from being changed, even temporarily.  Reading pskey 509
(decimal) returns 0x0001.

> > And yeah, I understand changing your BT address is generally a bad
> > idea.  This is just for research purposes.  I'm trying to get a Wii to
> > connect to a MacBook as if it were a Wii Remote and so far just
> > matching the device name/class has proved insufficient.  Current
> > theory is it will only connect to devices in Nintendo's OUI ranges.
>
> Have you checked the SDP service records required ??

>>From what I can tell, and I could be entirely wrong here, if the Wii
was performing an SDP query, that would result in HCI activity.  In my
tests I'm not seeing HCI activity beyond me putting the device into
discoverable mode.

My current plan of attack is to look for a USB dongle that uses the
CSR chipset (since I already have working code for it) that either 1.
ships without security_enable set or 2. I can get info on where the
SPI interface is on the board.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
