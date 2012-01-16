Return-Path: <cyrus@holtmann.org>
Message-ID: <1326705845.6454.274.camel@aeonflux>
Subject: Re: bluez 4.97: build failure when used in C++ apps
From: Marcel Holtmann <marcel@holtmann.org>
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: linux-bluetooth@vger.kernel.org, Milan Crha <mcrha@redhat.com>,
	ying.an.deng@intel.com, ulf.hofemeier@intel.com,
	ning.w.wang@intel.com
Date: Mon, 16 Jan 2012 10:24:05 +0100
In-Reply-To: <1326702341.3360.107.camel@pohly-mobl1.fritz.box>
References: <1326702341.3360.107.camel@pohly-mobl1.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Patrick,

> Bluez 4.97 has entered some distros recently (Fedora Core, MeeGo 1.2
> update), which broke compilation of the C++ code in SyncEvolution
> using /usr/lib/bluetooth.h.
> 
> The compiler error is:
> /usr/include/bluetooth/bluetooth.h::131:9: error: invalid conversion from 'void*' to 'bt_get_le64(void*)::<anonymous struct>*'
> ...
> 
> The reason is that C++, in contrast to C, does not allow conversion of
> void * to anything, and this code gets compiled as C++ when the app is
> written in C++. The macro with the assignment itself is older, but only
> recent Bluez starts to use it in inline functions, thus triggering the
> problem.
> 
> Attached is a proposed solution. Note that I have only verified that it
> now compiles in C and C++, I have not actually tested the resulting
> Bluez, because compilation fails for me on Debian Testing for another
> reason (libcheck.a linked into shared object, doesn't work because not
> relocatable).

please can we get inline patches from git format-patch. Also this topic
has been raised before and I need confirmation for a GCC guru to confirm
that this does exactly the same all all platforms.

Tested this on x86 hardware is useless since it does unaligned access
properly anyway. ARM, MIPS and PowerPC would be interesting.

Regards

Marcel



