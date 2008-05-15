Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20080514002659.23ad9039@vivalunalitshi.luna.local>
References: <20080514002659.23ad9039@vivalunalitshi.luna.local>
Date: Thu, 15 May 2008 11:51:14 +0200
Message-Id: <1210845074.7025.46.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Connecting to a bluetooth device as a serial port
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

Hi Micha,

> I have a legos mindstorms nxt brick that I want to control from matlab. As far
> as I can tell matlab doesn't know bluetooth but it can work with serial ports.
> How do I setup the bluetooth connection as a serial port so that I can connect
> to it using matlab to send/receive data?

look into the RFCOMM support of BlueZ.

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
