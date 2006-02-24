Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Ville Tervo <ville.tervo@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Soft lockup
Message-ID: <20060224110357.GT19185@null.research.nokia.com>
References: <20060222091231.GM19185@null.research.nokia.com> <1140607245.4519.7.camel@localhost> <20060222125425.GQ19185@null.research.nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060222125425.GQ19185@null.research.nokia.com>
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
Date: Fri, 24 Feb 2006 13:03:58 +0200

Hi Marcel,

On Wed, Feb 22, 2006 at 02:54:25PM +0200, ext Ville Tervo wrote:
> Hi Marcel,
> 
> On Wed, Feb 22, 2006 at 12:20:45PM +0100, ext Marcel Holtmann wrote:
> > Hi Ville,
> > 
> > > I'm got attached oops while playing with Nokia 770. Attached patch
> > > helps. 
> > 
> > I am not really happy with this fix. Do you have an idea why this soft
> > lockup happens? Is this OMAP specific?
> 
> Me neither. I'll try to reproduce it with i386 and see if I can get more
> information.

Now I have more information about this problem.

I had debuggin enabled in net/bluetooth/rfcomm/core.c and I noticed that
for some reson rfcomm_dlc_clear_timer() is called for allready freed
dlc and lock_timer_base() gets stuck because it's trying to use invalid
timer pointer. I also tried to reproduce bug in i386 without success.
Also then debugging is on the bug much harder to reproduse. To me this
looks like dlc locking doens't work as it should work.

And other notice. rfcomm_dlc_clear_timeri() uses timer_pending()
together with del_timer() which allready calls timer_pending(). So
timer_pending() is useless in rfcomm_dlc_clear_timer().

-- 
Ville


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
