Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Apr 2011 11:35:41 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Mika Linnanoja <mika.linnanoja@nokia.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	Ville Tervo <ville.tervo@nokia.com>
Subject: Re: latest bluetooth-next doesn't compile
Message-ID: <20110428143541.GC11016@joana>
References: <4DB94EB2.5060204@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4DB94EB2.5060204@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mika,

* Mika Linnanoja <mika.linnanoja@nokia.com> [2011-04-28 14:25:38 +0300]:

> Hi!
> 
> I cloned today 
> git://git.kernel.org/pub/scm/linux/kernel/git/padovan/bluetooth-next-2.6.git 
> and seems it does not want to fully compile.
> 
> Steps were like this:
> $ git clone <url>
> $ cd <git_dir>
> $ cp /boot/old_config_file .config
> $ make oldconfig (default answers)
> $ make
>    CHK     include/linux/version.h
>    CHK     include/generated/utsrelease.h
>    CALL    scripts/checksyscalls.sh
>    CHK     include/generated/compile.h
>    UPD     include/generated/compile.h
>    CC      init/version.o
>    LD      init/built-in.o
>    VDSOSYM arch/x86/vdso/vdso32-int80-syms.lds
>    VDSOSYM arch/x86/vdso/vdso32-sysenter-syms.lds
>    VDSOSYM arch/x86/vdso/vdso32-syms.lds
>    LD      arch/x86/vdso/built-in.o
>    LD      arch/x86/built-in.o
>    CC [M]  net/bluetooth/cmtp/core.o
> net/bluetooth/cmtp/core.c: In function ‘cmtp_add_connection’:
> net/bluetooth/cmtp/core.c:349: error: ‘struct l2cap_pinfo’ has no member named 
> ‘omtu’
> net/bluetooth/cmtp/core.c:349: error: ‘struct l2cap_pinfo’ has no member named 
> ‘imtu’
> make[3]: *** [net/bluetooth/cmtp/core.o] Error 1
> make[2]: *** [net/bluetooth/cmtp] Error 2
> make[1]: *** [net/bluetooth] Error 2
> make: *** [net] Error 2
> $
> 
> Is this a known issue? I have not tried to build this exact tree before.

linux-next spotted this to me yesterday. I fixed it already. I didn't have
CONFIG_HID and CONFIG_ISDN_CAPI enabled so I was unable to see this. Sorry.

-- 
Gustavo F. Padovan
http://profusion.mobi
