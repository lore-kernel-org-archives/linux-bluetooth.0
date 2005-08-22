Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluetoothd D-Bus interface proposals(draft 00.05)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <5256d0b050822053737c9cd8f@mail.gmail.com>
References: <e1effdeb05081614151ee4f4bd@mail.gmail.com>
	 <9307f5f2050816154545b6f046@mail.gmail.com>
	 <e1effdeb05081805054a0be4aa@mail.gmail.com>
	 <9307f5f2050818135877575293@mail.gmail.com>
	 <8c9e090508191027e4646f1@mail.gmail.com>
	 <1124709468.23599.27.camel@pegasus>
	 <8c9e090508220504100c127e@mail.gmail.com>
	 <e1effdeb0508220527500878ab@mail.gmail.com>
	 <5256d0b050822053737c9cd8f@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1124720966.23599.50.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 22 Aug 2005 16:29:26 +0200

Hi Peter,

> What happens if you want to use your second adapter as the default? EG
> if I have a BT2.0 and a BT1.2 adapter but the BT1.2 adapter is
> detected first but you want to use the BT2.0 adapter as the default as
> its faster.

this is somekind of a policy decision and must not be the correct one in
any circumstances. And as I said before, the kernel must know about it.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
