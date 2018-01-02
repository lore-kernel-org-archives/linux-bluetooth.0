Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 3/3] Bluetooth: Avoid WARN splat due to missing GPIOLIB
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180102165829.GA6735@wunner.de>
Date: Tue, 2 Jan 2018 18:10:05 +0100
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Frederic Danis <frederic.danis.oss@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Ronald Tschalaer <ronald@innovation.ch>,
        "Peter Y. Chuang" <peteryuchuang@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <5F5AC09D-65DB-4DC2-AAF4-6BA021557C1E@holtmann.org>
References: <9ef8be4ef80c38b693e5755c738a88de9c907944.1514143015.git.lukas@wunner.de>
 <1514450477.7000.302.camel@linux.intel.com> <20171228091805.GA1559@wunner.de>
 <1514453177.7000.320.camel@linux.intel.com>
 <CACRpkdb=Wj9dEfu7YEfQCA94MdBNQmp5UwHOgRsTZX=bf5d-Hw@mail.gmail.com>
 <1514464858.7000.334.camel@linux.intel.com>
 <CACRpkdYRojbfCC_b9vO0MquvLeenru0rrYNv7WzMg3d3b=iF+g@mail.gmail.com>
 <20171229095135.GA25623@wunner.de>
 <CACRpkda1uzW2A=13tobpNrNNgTmv-ri6kb628TYS7rv3xPsx4A@mail.gmail.com>
 <0668F24B-610E-4239-8470-DEB96D533D96@holtmann.org>
 <20180102165829.GA6735@wunner.de>
To: Lukas Wunner <lukas@wunner.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukas,

>>>> By the way, what is the rationale for this rule that consumers shall
>>>> depend on rather than select GPIOLIB?
>>> 
>>> I think consumers should depend on GPIOLIB and producers
>>> should select GPIOLIB.
>> 
>> so what do we do here? Should I revert the patch or can I get an updated
>> patch that uses the agreed upon select vs depends.
> 
> I've prepared this branch which still needs to be tested & debugged,
> it contains a patch to change the "select" to a "depends on":
> 
> https://github.com/l1k/linux/commits/hci_bcm_v2/
> https://github.com/l1k/linux/commit/71aa06c610d0
> 
> If you prefer reverting 27378f4c1b92 or rebase your branch and drop it,
> I'll be happy to provide a rectified version instead (basically
> 27378f4c1b92 and 71aa06c610d0 squashed together).  I was assuming that
> bluetooth-next/master is a non-rebasing branch, hence prepared
> 71aa06c610d0 as a fix of the existing commit.

I will revert and rebase if I have to, but if we can just get a fix applied on top of it, then that works for me as well.

Regards

Marcel

