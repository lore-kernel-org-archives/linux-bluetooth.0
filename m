Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <951351190712240702x7b84c38j135735888bbd40d0@mail.gmail.com>
References: <951351190712240702x7b84c38j135735888bbd40d0@mail.gmail.com>
Date: Tue, 25 Dec 2007 05:19:01 +0100
Message-Id: <1198556341.8050.321.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] passkey-agent
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

Hi Jason,

> Currently, I am implementing a passkey-agent for my own application.
> The principle is similar with the /daemon/passkey-agent.c. However,
> when I run it, the system gives me some errors: "Can't regiter passeky
> agent, passkey agnet already exists". 

the error message is pretty clear. You can have multiple remote device
specific passkey agents, but only _ONE_ default passkey agent.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
