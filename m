Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: WANG Cong <xiyou.wangcong@gmail.com>
In-Reply-To: <20070924113035.GE2442@hacking>
References: <20070924021716.9bfe7dfb.akpm@linux-foundation.org>
	<20070924113035.GE2442@hacking>
Date: Tue, 25 Sep 2007 00:18:07 +0200
Message-Id: <1190672287.5133.138.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: maxk@qualcomm.com, Andrew Morton <akpm@linux-foundation.org>,
        roel <12o3l@tiscali.nl>, linux-kernel@vger.kernel.org,
        bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] [-mm Patch] net/bluetooth/hidp/core.c: Make
	hidp_setup_input()	return int
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

Hi Wang,

> This patch:
> - makes hidp_setup_input() return int to indicate errors;
> - checks its return value to handle errors.
> 
> And this time it is against -rc7-mm1 tree.
> 
> Thanks to roel and Marcel Holtmann for comments.
> 
> Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

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
