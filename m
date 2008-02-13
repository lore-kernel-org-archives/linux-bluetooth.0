Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <5976F853A3B35845B6375F0C1FE13EB30315351E@hasmsx415.ger.corp.intel.com>
References: <5976F853A3B35845B6375F0C1FE13EB303115489@hasmsx415.ger.corp.intel.com>
	<1202487825.15090.308.camel@violet>
	<5976F853A3B35845B6375F0C1FE13EB30315351E@hasmsx415.ger.corp.intel.com>
Date: Wed, 13 Feb 2008 14:45:05 +0100
Message-Id: <1202910306.7664.413.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] SDIO support
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

Hi Claudio,

> Does anybody know about an SDIO specific device tested with BlueZ stack?
> Any modifications required to the generic driver?

I have the Socket SDIO card and that one works perfectly fine. It is a
Type-B card, but we switch it back into Type-A mode. We don't need
anything else than Type-A since we have a full Bluetooth stack running
anyway.

http://www.holtmann.org/linux/bluetooth/sdio.html

The Socket SDIO actually contains a Bluetooth chip from Toshiba.

I also have done initial tests with the BlueCore6 from CSR. The
BlueCore6 contains a native SDIO interface. My prototype is still
crashing and I never got a newer one. Hint :)

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
