Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6522C4F948C6F5419BA5943E1E79DD2A8ABBAE@IRSMSX104.ger.corp.intel.com>
References: <6522C4F948C6F5419BA5943E1E79DD2A8ABBAE@IRSMSX104.ger.corp.intel.com>
Date: Wed, 13 Nov 2013 17:03:36 +0200
Message-ID: <CABBYNZJSdzsuuzEJctKo_UiKExX4_XXW+zzphhZcHzCuOoLBwg@mail.gmail.com>
Subject: Re: bluetoothd failure after a "malloc retun NULL" injection
 (attachment fix)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Oprisenescu, CatalinX" <catalinx.oprisenescu@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Trandafir, IonutX" <ionutx.trandafir@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Nov 13, 2013 at 4:09 PM, Oprisenescu, CatalinX
<catalinx.oprisenescu@intel.com> wrote:
> Hello,
>
> Following is an issue encountered and handled using bluez-5.10 on a 32bit Tizen 2.0 IVI based distribution.
>
> If malloc returns a random NULL bluetoothd exits with core dumped.
> In this case we do the following:
>       -start bluetoothd,
>       -at a random malloc call from any library (*lib*.so*), a random NULL will be returned by bluetoothd with a ld_preloaded library.
>
> ~# LD_PRELOAD=/root/lib_wrapper.so /usr/libexec/bluetooth/bluetoothd -E
>
> Analyzing the dump, it points directly to a DBUS_ERROR_NO_MEMORY which, after handling, keeps bluetoothd from dumping and allowing it to return the fatal error occurred as exit status, thus failing gracefully.
>
> A fix proposal, handling the use-case is attached.

Im afraid if we start treating all the out of memory cases we wont
have time to do anything else, and quite frankly if this happens for
real the least concern would be bluetoothd, so I believe we should
just treat OOM cases as unrecoverable. Since this can happen with any
dbus_error, I would probably suggest to wrap it perhaps we a
g_dbus_error API that does assert in OOM.

-- 
Luiz Augusto von Dentz
