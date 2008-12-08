Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <493D6925.3070206@slackdot.org>
References: <4939BB42.1080607@slackdot.org>
	<1228598207.28839.49.camel@violet.holtmann.net>
	<493B281E.3000200@slackdot.org>
	<1228616055.28839.51.camel@violet.holtmann.net>
	<493BF4F8.4050609@slackdot.org>  <493D6925.3070206@slackdot.org>
Date: Mon, 08 Dec 2008 20:56:22 +0100
Message-Id: <1228766182.28839.99.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Continued SCO audio issues...
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Rob,

> I've done a little more looking and you are correct that my SCO routing 
> on the embedded devices I'm using (Compulab EM-X270) is incorrect 
> (hciconfig revision reports SCO routing to PCM rather than HCI). 
> Unfortunately, bccmd doesn't seem to work right on this platform (I 
> haven't dug into why yet) so I'm at a loss as to how to change it. Any 
> suggestions are really appreciated.

you confused me now totally. So what do you wanna do actually?

SCO over PCM is for Bluetooth chips that are hardwired to a codec or
DSP. These is default for mobile phones and most embedded devices.

SCO over HCI is for desktop/laptop system or for system with external
Bluetooth hardware/dongles.

Regards

Marcel



------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
