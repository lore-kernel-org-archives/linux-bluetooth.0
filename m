Return-Path: <cyrus@holtmann.org>
Message-ID: <e1effdeb0802180547k3115ca74y57a4c4adb769bab3@mail.gmail.com>
Date: Mon, 18 Feb 2008 10:47:36 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20080215234021.GF10614@pangeia.com.br>
MIME-Version: 1.0
References: <200710231950.31313.alon.barlev@gmail.com>
	<a8e1da0711051849ma591d4k6a816e2de7390347@mail.gmail.com>
	<9e0cf0bf0711052149t5c9fe50j19d13e368690efb@mail.gmail.com>
	<200802111757.56537.alon.barlev@gmail.com>
	<20080212235814.b4a2e565.akpm@linux-foundation.org>
	<a8e1da0802141928yabfd87ajfed0b009e1e79018@mail.gmail.com>
	<a8e1da0802151513p34ad118i54ddd8f00e6e136@mail.gmail.com>
	<20080215234021.GF10614@pangeia.com.br>
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

On Feb 15, 2008 8:40 PM, Nelson Murilo <nelson@pangeia.com.br> wrote:
>
>
> Hi,
>
> I tried that command:
> # sdptool add --channel=19 SP
> Serial Port service registered
> Segmentation fault
>
> Any hints to fix it?
>
> My enviromnent:
>
> Kernel 2.6.24.2
> hciconfig  hci0 revision
> hci0:   Type: USB
>      BD Address: 00:1D:60:4E:XX:XX ACL MTU: 384:8 SCO MTU: 64:8
>      HCI 19.2
>      Chip version: BlueCore4-External
>      Max key size: 56 bit
>      SCO mapping:  HCI
>
> # dmesg | grep -i blue
> Bluetooth: Core ver 2.11
> Bluetooth: HCI device and connection manager initialized
> Bluetooth: HCI socket layer initialized
> Bluetooth: HCI USB driver ver 2.9
> Bluetooth: L2CAP ver 2.9
> Bluetooth: L2CAP socket layer initialized
> Bluetooth: RFCOMM socket layer initialized
> Bluetooth: RFCOMM TTY layer initialized
> Bluetooth: RFCOMM ver 1.8
>
>
> Thanks in advance,
>
> ./nelson -murilo
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

Hi Nelson,

I was not able to reproduce this bug.  Which utils/libs package
version are you using?
Send your stack/library trace to provide more details.

Regards,
Claudio.
-- 
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
