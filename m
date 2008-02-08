Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <5976F853A3B35845B6375F0C1FE13EB303115489@hasmsx415.ger.corp.intel.com>
References: <5976F853A3B35845B6375F0C1FE13EB303115489@hasmsx415.ger.corp.intel.com>
Date: Fri, 08 Feb 2008 17:23:45 +0100
Message-Id: <1202487825.15090.308.camel@violet>
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

> Are there any developments in progress concerning BlueZ support for
> Bluetooth devices over SD/SDIO protocol?

BlueZ and SDIO works perfectly together. You only need a kernel with the
SDIO support and the generic Bluetooth SDIO driver (btsdio). Both have
been merged upstream and can be found in 2.6.24. The Bluetooth SDIO
device has to comply with the Type-A or Type-B standard.

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
