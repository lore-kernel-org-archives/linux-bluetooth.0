Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1205260526.30595.91.camel@cookie.hadess.net>
References: <20080311102907.kkvnan148sgo8o8k@wmlab.csie.ncu.edu.tw>
	<1205260526.30595.91.camel@cookie.hadess.net>
Date: Wed, 12 Mar 2008 22:04:36 +0100
Message-Id: <1205355876.1363.1.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] bluez-gnome
	access	volatile	while	adapter-changed
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

Hi Bastien,

> > Thanks, I had got the patch from bugzilla and it work fine to fix this  
> > problem.
> 
> This patch makes sure we're not receiving signals when the client object
> is still alive, but the front-end device selection widget is gone.

patch has been applied. Thanks.

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
