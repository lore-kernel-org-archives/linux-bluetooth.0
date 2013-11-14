Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: bluetoothd failure after a "malloc retun NULL" injection (attachment fix)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZJSdzsuuzEJctKo_UiKExX4_XXW+zzphhZcHzCuOoLBwg@mail.gmail.com>
Date: Thu, 14 Nov 2013 16:33:45 +0900
Cc: "Oprisenescu, CatalinX" <catalinx.oprisenescu@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Trandafir, IonutX" <ionutx.trandafir@intel.com>
Message-Id: <E03FE70C-ECC4-4D7D-917E-6F3E92297C1C@holtmann.org>
References: <6522C4F948C6F5419BA5943E1E79DD2A8ABBAE@IRSMSX104.ger.corp.intel.com> <CABBYNZJSdzsuuzEJctKo_UiKExX4_XXW+zzphhZcHzCuOoLBwg@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>> Following is an issue encountered and handled using bluez-5.10 on a 32bit Tizen 2.0 IVI based distribution.
>> 
>> If malloc returns a random NULL bluetoothd exits with core dumped.
>> In this case we do the following:
>>      -start bluetoothd,
>>      -at a random malloc call from any library (*lib*.so*), a random NULL will be returned by bluetoothd with a ld_preloaded library.
>> 
>> ~# LD_PRELOAD=/root/lib_wrapper.so /usr/libexec/bluetooth/bluetoothd -E
>> 
>> Analyzing the dump, it points directly to a DBUS_ERROR_NO_MEMORY which, after handling, keeps bluetoothd from dumping and allowing it to return the fatal error occurred as exit status, thus failing gracefully.
>> 
>> A fix proposal, handling the use-case is attached.
> 
> Im afraid if we start treating all the out of memory cases we wont
> have time to do anything else, and quite frankly if this happens for
> real the least concern would be bluetoothd, so I believe we should
> just treat OOM cases as unrecoverable. Since this can happen with any
> dbus_error, I would probably suggest to wrap it perhaps we a
> g_dbus_error API that does assert in OOM.

I am fine with fixing obvious ones. However long-term these tiny sized memory allocation must just abort the program if we run out of memory. Since there is no recovery from it anyway.

Regards

Marcel

