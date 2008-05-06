Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300805061132h9268d54mb1efe9a66b4967b1@mail.gmail.com>
Date: Tue, 6 May 2008 12:32:46 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BAY143-W121FBB2656D29CC749BA3E4D60@phx.gbl>
MIME-Version: 1.0
References: <BAY143-W121FBB2656D29CC749BA3E4D60@phx.gbl>
Subject: Re: [Bluez-devel] --SBC codec filterbank implementation
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

binQing

>   I   am  implementing SBC  encoder.   Can  any one tell me  the SBC  codec
> filterbank  implementation details  ? I think the filter coefficients used
> in the code  are not the same with  Blue spec. I  want to  know  the
> reference doc.   Thank  you  very  much !

are you implementing your own or deploying what we have in bluez?

the tables have changed a lot from the spec--there was some math we
could precompute and that meant rebuilding the tables. We also changed
to fixed point, so it would be hard to recognize the original values.

If you don't already have the spec you'll find it at bluetooth.com

-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
