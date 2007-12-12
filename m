Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <002e01c83c96$d2f37270$2a0dc70a@dlh.st.com>
References: <002e01c83c96$d2f37270$2a0dc70a@dlh.st.com>
Date: Wed, 12 Dec 2007 16:50:44 +0100
Message-Id: <1197474644.5644.15.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Simple Pairing in BlueZ
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

Hi Shankar,

> I want to use the simple pairing procedure. I digged the archives of bluez-announce mailing list and read that BlueZ now supports it. I could not find in the mailing list how to enable and use it. Has anybody here  tried it and can give me ideas on how to go about it.
> 
> I have googled "simple pairing in bluez" without much success. It just leads me to the announcement.  

we only have basic support for Simple Pairing. The Bluetooth SIG changed
the whole Simple Pairing/Security Mode 4 in the last minute before
releasing the Bluetooth 2.1 specification and so far nobody has tried to
fully implement it. With the changed specification, it is actually kinda
complex.

Regards

Marcel



-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
