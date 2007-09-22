Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: David Woodhouse <dwmw2@infradead.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1190487435.5133.66.camel@aeonflux.holtmann.net>
References: <1190483342.7150.224.camel@pmac.infradead.org>
	<1190487435.5133.66.camel@aeonflux.holtmann.net>
Date: Sat, 22 Sep 2007 22:00:47 +0100
Message-Id: <1190494847.7150.242.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: Claudio Takahasi <cktakahasi@gmail.com>
Subject: Re: [Bluez-devel] [PATCH] Attempt bonding with keyboards.
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

On Sat, 2007-09-22 at 20:57 +0200, Marcel Holtmann wrote:
> the main questions is if we wanna make that policy of pairing a device
> first part of the input service or the the UI creating the device.
> 
> I think it should be part of the UI and it should create the pairing
> before connecting the input device.

I'm not convinced. Should the UI really have to know things like 'if
it's a keyboard, attempt pairing. If it's a mouse, don't bother'?

I would have thought that this was something we should leave to the
input service. The UI just tells the service to make it work.

-- 
dwmw2


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
