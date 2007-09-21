Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <351694.66042.qm@web58007.mail.re3.yahoo.com>
References: <351694.66042.qm@web58007.mail.re3.yahoo.com>
Date: Fri, 21 Sep 2007 10:47:06 +0200
Message-Id: <1190364426.5133.24.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bootstrap for blueZ
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

Hi Henry,

> I need a bootstrap to send commands to CSR bluetooth
> chip for blueZ. Does anyone has it or sample code for
> that?
> 
> Bluetooth chip can talk with eeprom or bootstrap for
> pskey on the beginning.
> 
> I have an embedded board with CSR bluetooth chip
> BlueCore 4. It works using CSR bluetooth stack. But I
> want to install BlueZ and use BlueZ utilities for
> bluetooth keyboard and mice.

you can use the bccmd utility from bluez-utils to bootstrap the BlueCore
chip. It supports H4, BCSP, USB and HCI as transports and can read PSR
files directly and program them. Check the manual page of bccmd.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
