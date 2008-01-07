Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Jan 2008 15:10:15 +0100
From: Gabor Gombas <gombasg@sztaki.hu>
To: Dave Young <hidave.darkstar@gmail.com>
Message-ID: <20080107141014.GA12763@boogie.lpds.sztaki.hu>
References: <20071228173203.GA20690@boogie.lpds.sztaki.hu>
	<a8e1da0712290007o168a730cw923055ad2c265d84@mail.gmail.com>
	<20080102151642.GA7273@boogie.lpds.sztaki.hu>
	<20080103131620.GA16307@boogie.lpds.sztaki.hu>
	<20080104010542.GA2860@darkstar.te-china.tietoenator.com>
MIME-Version: 1.0
In-Reply-To: <20080104010542.GA2860@darkstar.te-china.tietoenator.com>
Cc: linux-kernel@vger.kernel.org, bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] Oops involving RFCOMM and sysfs
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

Hi,

On Fri, Jan 04, 2008 at 09:05:42AM +0800, Dave Young wrote:

> Could you try the patch (on 2.6.24-rc6) following and check the debug messages? 
> 
> diff -upr linux/net/bluetooth/rfcomm/tty.c linux.new/net/bluetooth/rfcomm/tty.c
> --- linux/net/bluetooth/rfcomm/tty.c	2008-01-04 08:58:48.000000000 +0800
> +++ linux.new/net/bluetooth/rfcomm/tty.c	2008-01-04 09:01:01.000000000 +0800
> @@ -313,6 +313,7 @@ static void rfcomm_dev_del(struct rfcomm
>  {
>  	BT_DBG("dev %p", dev);
>  
> +	dump_stack();
>  	set_bit(RFCOMM_TTY_RELEASED, &dev->flags);
>  	rfcomm_dev_put(dev);
>  }

This did not trigger.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
