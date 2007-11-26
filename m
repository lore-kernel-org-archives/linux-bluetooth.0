Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: bgsmith@bendcable.com, BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1196009038.14897.6.camel@pico>
References: <1196009038.14897.6.camel@pico>
Date: Mon, 26 Nov 2007 06:49:47 +0100
Message-Id: <1196056187.4217.54.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Lost connections - mouse and keyboard
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

Hi Brad,

> I have a Logitech mouse and keyboard that use bluetooth (dinovo).  I
> have enabled bluetooth on this Fedora 8 system and both work well with
> two problems.
> 
> (1) When I lock the system and return later the mouse no longer works.
> I have to open a terminal window and issue an hidd --connect command.
> 
> (2) When I log out, both the mouse and keyboard stop working.  I have to
> connect a USB mouse and USB keyboard to enter the authentication
> information.  Once logged in the bluetooth devices usually work,
> although I sometimes have to issue an hidd --connect command to enable
> the keyboard.
> 
> Any suggestions on resolving these issues would be appreciated.

not using hidd and using bluetoothd-input-service instead is one thing.
For input devices to re-connect you have to have a daemon running that
handles this. The input service is the best way to achieve this. Check
the BlueZ wiki for details.

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
