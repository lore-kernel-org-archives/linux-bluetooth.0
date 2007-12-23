Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <359782e70712230600n7077ee15hcab67216b9e7c8b4@mail.gmail.com>
References: <359782e70712230600n7077ee15hcab67216b9e7c8b4@mail.gmail.com>
Date: Sun, 23 Dec 2007 20:17:52 +0100
Message-Id: <1198437472.8050.305.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] AFH between master and slave
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
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

> I'd like to ask a question about BT radio: if there is only 1master, 1
> slave in 1 piconet's effective arange(50 feets), will the radio
> between master and slave continue hoping? I think they should only use
> 1 of 79 channels after connected. Is that right? further more, when
> another slave join in the piconet, it will use another channel other
> than the occupied one to setup the connection, right?

you should read the specification. A Bluetooth radio will always use
hoping. The AFH is only to place nice with other 2.4 GHz radios. It will
not affect the hoping in case Bluetooth radios.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
