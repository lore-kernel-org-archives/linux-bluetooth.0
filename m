Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4050323B.1030307@ei.tum.de>
From: Matthias Thomae <thomae@ei.tum.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] crash on remove
References: <20040310182158.GA9279@naginata.ccs.neu.edu> <404F84BC.4020406@xmission.com> <20040310223504.GA3398@omocha.vort.org> <404FB5D1.5030104@xmission.com> <20040311024720.GA3297@omocha.vort.org>
In-Reply-To: <20040311024720.GA3297@omocha.vort.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 11 Mar 2004 10:32:43 +0100

Hi all,

I also get a crash when unplugging my bt usb adapter (Acer BT-700, 
CSR-based) on a VIA Chipset machine with 2.6.4-rc3 kernel. 
CONFIG_BT_HCIUSB_SCO is *not* set, CONFIG_BT_SCO is.

Regards.
Matthias

Russell Neches wrote:
> Now, by SCO support, do we mean the module (CONFIG_BT_SCO) or
> CONFIG_BT_HCIUSB_SCO? I'm actually getting the crash without the sco
> module loaded, and I have my kernel built with CONFIG_BT_HCIUSB_SCO not
> set. I don't think SCO shows up anywhere else in the kernel. Sorry if
> I'm beginning to sound pedantic. 
> 
> Maybe I should figure out how to use SysReq after all...



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
