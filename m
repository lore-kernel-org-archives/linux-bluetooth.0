Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 27 Sep 2007 08:56:58 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Pierre-Yves Paulus <py@idlum.be>
Message-ID: <20070927085658.1c66f1c8@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <46FA5E2E.3010300@idlum.be>
References: <46F92364.3080603@idlum.be> <46F952BD.4010009@redhat.com>
	<46FA5E2E.3010300@idlum.be>
Mime-Version: 1.0
Cc: BlueZ@sc8-sf-spam2.sourceforge.net,
        development <bluez-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [Bluez-devel] Warnings and Oops on 2.6.23-rc6 while activily
 using rfcomm links (mm/slab.c)
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

On Wed, 26 Sep 2007 15:27:10 +0200,
Pierre-Yves Paulus <py@idlum.be> wrote:

> > Please use CONFIG_SLUB and turn on SLUB debugging. Something is very wrong
> > somewhere...
> 
> I did so, on 2.6.23-rc8. I also did include CONFIG_DEBUG_DRIVER and 
> CONFIG_DEBUG_KOBJECT, following Cornelia Huck's advice.

Did you see any messages (from the driver core) surrounding
kobject_move() usage or the kref badness messages? I'm asking because
refcounting/lifetime issues may be the reason for your problems...

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
