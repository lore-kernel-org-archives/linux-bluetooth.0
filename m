Return-Path: <cyrus@holtmann.org>
Message-Id: <F5766422-47CD-4AD6-8C71-AD7D21BDB4BD@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <fb2ac3c90803041411k3ea1426cib1e729b19053adce@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Tue, 4 Mar 2008 23:25:44 +0100
References: <fb2ac3c90803041411k3ea1426cib1e729b19053adce@mail.gmail.com>
Subject: Re: [Bluez-devel] CreateSecureDevice
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

Hi Andrew,

> I was wondering why there is a CreateDevice in org.bluez.input.Manager
> if CreateSecureDevice will fall back to the same behavior if the
> device in question does not support secure pairing.
>
> bluez-gnome switched to CreateSecureDevice after that method was added
> which broke users who still had older bluez-utils (no changes to
> require a newer bluez-utils were made).  Would it not have been better
> to just add the security routines to the existing CreateDevice?  Is it
> too late to change this now?

yes, it is too later and it would have broken the API. If  
CreateSecureDevice returns with no such method error, you can always  
fallback to CreateDevice.

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
