Return-Path: <cyrus@holtmann.org>
Date: Thu, 21 Feb 2008 08:40:45 -0300
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20080221114045.GA22154@pangeia.com.br>
References: <200710231950.31313.alon.barlev@gmail.com>
	<a8e1da0711051849ma591d4k6a816e2de7390347@mail.gmail.com>
	<9e0cf0bf0711052149t5c9fe50j19d13e368690efb@mail.gmail.com>
	<200802111757.56537.alon.barlev@gmail.com>
	<20080212235814.b4a2e565.akpm@linux-foundation.org>
	<a8e1da0802141928yabfd87ajfed0b009e1e79018@mail.gmail.com>
	<a8e1da0802151513p34ad118i54ddd8f00e6e136@mail.gmail.com>
	<20080215234021.GF10614@pangeia.com.br>
	<e1effdeb0802180547k3115ca74y57a4c4adb769bab3@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <e1effdeb0802180547k3115ca74y57a4c4adb769bab3@mail.gmail.com>
From: nelson@pangeia.com.br (Nelson Murilo)
Subject: Re: [Bluez-devel] sdptool segfault
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


Hi Claudio,

there are my packages:

# dpkg -l bluez*
iudio    3.24-1         Bluetooth audio support
ii  bluez-firmware 1.0-1          Firmware for Bluetooth devices
un  bluez-gnome    <none>         (no description available)
ii  bluez-hcidump  1.41-1         Analyses Bluetooth HCI packets
un  bluez-pan      <none>         (no description available)
un  bluez-sdp      <none>         (no description available)
ii  bluez-utils    3.24-1         Bluetooth tools and daemons
ii  bluez-utils    3.24-1         Bluetooth tools and daemons

If you need anymore, please let me know.

./nelson -murilo


> 
> I was not able to reproduce this bug.  Which utils/libs package
> version are you using?
> Send your stack/library trace to provide more details.
> 
> Regards,
> Claudio.
> -- 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
