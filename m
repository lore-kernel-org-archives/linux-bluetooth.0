Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <48075B6A.2060308@access-company.com>
References: <48075B6A.2060308@access-company.com>
Date: Thu, 24 Apr 2008 19:42:21 +0200
Message-Id: <1209058941.12684.37.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [patch] BNEP/PAN Qualification issues
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

Hi Frederic,

> I got my hand over a BNEP and PAN test plan and tried to pass it with 
> current PAN implementation (pand, not network service). I met several 
> issues and tried to find some solutions to them.
> 
> * Handling of 32 and 128 bits uuids,
> * Correct response to invalid uuids,
> * Respond to control messages before connection setup,
> * Handling of bnep extension together with general headers,
> * Handling of bnep extensions together with setup connection requests.
> * Forwarding of unknown BNEP extensions (not available for broadcast, 
> advice requested),
> * Give up pan connection after 30 seconds,
> 
> The result of that work is two patchs, one for the kernel (based on 
> latest git) and one for pand (a bit old that one I fear). However, it 
> should be easy to get similar patch for network service.

I need both patches in unified diff format (-u). I am not a machine and
can't read context diffs.

Please break up the kernel patch in small chunks that solve each
problem. It is easier for me to review them and then apply them.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
