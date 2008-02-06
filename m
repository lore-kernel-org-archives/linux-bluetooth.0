Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <248211.83326.qm@web8403.mail.in.yahoo.com>
References: <248211.83326.qm@web8403.mail.in.yahoo.com>
Date: Wed, 06 Feb 2008 10:23:02 +0100
Message-Id: <1202289782.15090.212.camel@violet>
Mime-Version: 1.0
Cc: bluez-users@brisammon.fastmail.fm
Subject: Re: [Bluez-devel] system hangs playing audio on headset
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

Hi Pramod,

> 4) I am using linux-2.6.22 kernel, Bluez-3.25 (libs, utils), also
> installed PLUGS & SBC from svn
>     But i could not aplly SCO flow control patch to my kernel...it
> failed..
> 
> Need I give more info to know whats going wrong..
> Whats is the patch for  SCO flow control for 2..6.22 ??

try using the Bluetooth audio service (which comes with 3.25) instead of
external headsetd. See wiki.bluez.org for instructions.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
