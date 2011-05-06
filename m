Return-Path: <cyrus@holtmann.org>
Message-ID: <4DC3A317.9060700@nokia.com>
Date: Fri, 06 May 2011 10:28:23 +0300
From: Mika Linnanoja <mika.linnanoja@nokia.com>
MIME-Version: 1.0
To: padovan@profusion.mobi
CC: linux-bluetooth@vger.kernel.org, ext Ville Tervo <ville.tervo@nokia.com>,
        Antti Julku <antti.julku@nokia.com>,
        ext Marcel Holtmann <marcel@holtmann.org>,
        Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
        linus.walleij@stericsson.com, par-gunnar.p.hjalmdahl@stericsson.com
Subject: Re: [PATCH] bluetooth: Fix for security block issue.
References: <1295965639-16683-1-git-send-email-lukasz.rymanowski@tieto.com> <1295971990.1520.53.camel@aeonflux> <4DB935D9.5080302@nokia.com> <20110428095139.GJ18898@null> <4DBA6D97.7050207@nokia.com> <20110505190230.GC2098@joana> <4DC390C0.1000607@nokia.com>
In-Reply-To: <4DC390C0.1000607@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 05/06/2011 09:10 AM, Mika Linnanoja wrote:
> Hi.
>
> Was not happening on ubuntu 9.04 (2.6.28.x) and ubuntu 9.10 (2.6.31.x).
>
> Since 10.04 (2.6.32.x) it has been happening to my knowledge.
>
> It's rather easy to reproduce also manually just by trying to send files in a
> loop via OPP between e.g. 2 ubuntu boxes when both have BT2.1 usb dongles
> (devices can be paired, doesn't help).

One another thing; this specific patch doesn't apply on top of your 
linux-bluetooth or bluetooth-next anymore due to the refactoring work (.39 level).

Applying it on top of 2.6.38.x kernel[1] works, but after sending OPP towards 
PC running with applied kernel I get kernel oops/crash like:

[  143.503531] Call Trace:
[  143.503531]  [<c12eaff2>] acpi_idle_enter_simple+0x105/0x13d
[  143.820013]  [<c12eb114>] acpi_idle_enter_bm+0xd5/0x25e
[  143.820017]  [<c142000d>] cpuidle_idle_call+0x7d/0x160
[  143.820020]  [<c10092ca>] cpu_idle+0x8a/0xc0
[  143.820023]  [<c104021e>] ? complete+0x4e/0x60
[  143.820026]  [<c15055cd>] rest_init+0x5d/0x70
[  143.820029]  [<c17a87ee>] start_kernel+0x35f/0x366
[  143.820032]  [<c17a82a3>] ? pass_all_bootoptions+0x0/0x149
[  143.820036]  [<c17a80f1>] i386_start_kernel+0xe0/0xe8

After that trying "hciconfig hci0 -a" results in timeout. That trace doesn't 
look like bt specific at all to my untrained eye.

Stock kernel without this patch doesn't cause such kind of issue. Of course it 
could be built somehow differently, I'm not an expert, followed some blog's 
instructions[2].

BR,
Mika

[1] git cloned git://kernel.ubuntu.com/ubuntu/ubuntu-natty.git
[2] http://parabing.com/2011/04/28/ubuntu-natty-a-custom-kernel-is-what-you-want/
