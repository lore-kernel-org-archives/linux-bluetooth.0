Return-Path: <cyrus@holtmann.org>
To: bluez-users@lists.sourceforge.net
From: Johan Brannlund <johan_brn@yahoo.com>
Date: Tue, 22 Jan 2008 05:16:26 +0000 (UTC)
Message-ID: <pan.2008.01.22.05.15.43@yahoo.com>
References: <47928635.2030400@gmx.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] audio bluetooth connectivity in gutsy
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

On Sun, 20 Jan 2008 00:22:29 +0100, Gunnar Thielebein wrote:

> Hi group,
> 
> I am trying to connect my headset in gutsy with default kernel
> 2.6.22-14-generic. I tried all four(?) possible solutions: old sco way,
> plugz, bluetooth-alsa (at least the package in gutsy) and bluez-audio
> which all ends finally with a hardlock of my system when the connection
> was established with headset.

Hi. Try adding "options hci_usb force_scofix=1" to /etc/modprobe.d/bluez .

Regards,

Johan



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
