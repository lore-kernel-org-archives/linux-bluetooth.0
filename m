Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <231dafb50612160015y4678213dw54dab0342324745d@mail.gmail.com>
Date: Sat, 16 Dec 2006 01:15:25 -0700
From: "Dark Shadow" <shadowofdarkness@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <adf2d65c0612152357m5886f77coff5a7d227dd7d4e6@mail.gmail.com>
MIME-Version: 1.0
References: <231dafb50612152211h1bc9ca42lade6687ac51c0@mail.gmail.com>
	<adf2d65c0612152357m5886f77coff5a7d227dd7d4e6@mail.gmail.com>
Subject: Re: [Bluez-users] Trouble loading firmware with bcm203x
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

On 12/16/06, Arthur <avandorp@gmail.com> wrote:
> Hi
>
> > I just bought a Bluetooth dongle that uses the Broadcom 4503 chipset
> > and I am having trouble getting stable use out of it. I have got it to
> > work twice before with the following steps
> >
> > plug it in
> > modprobe bcm203x
> > hciconfig up
> > hciconfig reset (hours of googling to find out this is required)
>
> For my Broadcom BCM2045B2 chipset dongle loading the hci_usb module
> with "reset=1" worked wonderfully. Thanks again to Marcel Holtmann
> from this list.
>
> Good luck
>
> Arthur
>

Thanks that info will really help.

I thought I should add that I get no errors when trying to upload the
firmware. It just does not work.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
