Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Sep 2015 12:26:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Oon-Ee Ng <ngoonee.talk@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: SMP Security Request breaks previously working bluetooth mouse
Message-ID: <20150904092640.GA19882@t440s.lan>
References: <CAGQ70euRR__Vv25Z9kvj6EfXyFruU36sYC82RrN8ijg_rdpYUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGQ70euRR__Vv25Z9kvj6EfXyFruU36sYC82RrN8ijg_rdpYUA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 01, 2015, Oon-Ee Ng wrote:
> I refer (to the best of my knowledge) to the patch submitted in [1].
> 
> When upgrading from 4.1.5 to 4.1.6 (Arch Linux), my Lenovo N700
> Bluetooth mouse stops working. Downgrading fixes, hence unlikely to be
> a hardware issue.
> 
> When on 4.1.6 (bugged version) dmesg spams this every 3 minutes or so:-
> Bluetooth: SMP security requested but not available
> 
> Please advise on additional details which may be required.

My guess is that your adapter is being initially powered on by the
legacy HCI_DEV_UP ioctl (e.g. "hciconfig hci0 up") which causes the SMP
context not to be initialized properly.

You would still not be able to repair with earlier 4.1.x kernels because
of this (i.e. they also have a similar issue you just haven't triggered)
but from 4.1.6 onward there's an extra check to prevent NULL pointer
dereferences (and hence the kernel crashing) if the SMP context is not
initialized.

The check for the SMP context is however done earlier than really
necessary and the patch I've just sent should move it to a better place,
i.e. still allow encrypting with existing LTKs.

The proper fix (which will make all of SMP work again) is to locate the
"hciconfig hci0 up" and not use it anymore (use either bluetoothctl,
btmgmt or some other mgmt-based method for powering on the adapter).

Johan
