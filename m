Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Jeffrey Bridge <jeffrey+bluez@firehead.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1173206973.11247.19.camel@aeonflux.holtmann.net>
References: <1173198739.25660.0.camel@localhost>
	<1173206973.11247.19.camel@aeonflux.holtmann.net>
Date: Fri, 23 Mar 2007 09:51:26 -0600
Message-Id: <1174665086.20624.0.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bcm2045 issue
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

Hi Marcel,

On Tue, 2007-03-06 at 19:49 +0100, Marcel Holtmann wrote:
> Hi Jeffrey,
> 
> > I'm not sure if this is supposed to work yet or not, but I'm having
> > trouble getting a Dell Wireless 355 module (AKA BCM2045) working in an
> > e1705 under Gentoo. Here is the error message generated upon 'modprobe
> > hci_usb':
> 
> load the hci_usb driver with the module parameter reset=1.

It still gets the same result with reset=1:

hci_cmd_task: hci0 command tx timeout
hci_usb_intr_rx_submit: hci0 intr rx submit failed urb ffff81004d45faa8
err -28

Jeff


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
