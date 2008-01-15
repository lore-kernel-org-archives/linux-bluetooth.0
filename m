Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <3863b6300801150529n6e37f046je923cf4c26b9ba23@mail.gmail.com>
References: <3863b6300801150529n6e37f046je923cf4c26b9ba23@mail.gmail.com>
Date: Tue, 15 Jan 2008 19:56:34 +0100
Message-Id: <1200423395.7978.32.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Small footprint Bluetooth stack for embedded?
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

Hi Pancrazio,

> I have to run Bluetooth on MIPS and ST40 CPU and I'm looking for a BT
> stack with minimal dependencies.
> I tried to compile Bluez but I got problems with Gnome dependencies.
> 
> What can I do to compile Bluez with minimal footprint? 
> Should I try an alternative BT stack? Which one?

the GNOME dependency is only for the PIN dialog. You can replace that
with your own passkey agent.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
