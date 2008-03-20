Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <987924.86360.qm@web8403.mail.in.yahoo.com>
References: <987924.86360.qm@web8403.mail.in.yahoo.com>
Date: Thu, 20 Mar 2008 14:52:07 +0100
Message-Id: <1206021127.7678.10.camel@californication>
Mime-Version: 1.0
Cc: bluez-users@brisammon.fastmail.fm
Subject: Re: [Bluez-devel] assertion failed for passkey-agent
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

Hi Parmod,

> When I run 
> # passkey-agent --default 0000 &
> [1] 4016
> 4016: assertion failed "(*(const char*)_DBUS_FUNCTION_NAME) != '_'"
> file "dbus-connection.c" line 2877 function
> _dbus_connection_read_write_dispatch
> 
> [1]+  Aborted                 passkey-agent --default 0000
> 
> I tried going into passkey source code but....could get nothing...

I really don't know. The last time I tested it, it works fine. However
passkey-agent.c is really only an example.

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
