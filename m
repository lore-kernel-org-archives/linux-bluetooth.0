Return-Path: <john.stultz@linaro.org>
MIME-Version: 1.0
In-Reply-To: <25BE9D66-9609-42D0-8A83-E15758FA3A1B@holtmann.org>
References: <CALAqxLVTff-XX7bbQ8a1Pihqe=QW1HDMKST3F3okCV8jY+wGqw@mail.gmail.com>
 <CALAqxLW9gzcBrwy3TWB5x_OpKtcLTe7P8PX4KeUgvibbAaMX_A@mail.gmail.com>
 <20171116213045.GA17506@wunner.de> <20171116214504.GB17506@wunner.de>
 <CALAqxLX-qp=rc8P7ynGrUwWHgP2EBAwoEES-aOOuehtnJSDR+A@mail.gmail.com>
 <f181189de5fd4c75da4708425df99e70abc6a127.1510875912.git.lukas@wunner.de> <25BE9D66-9609-42D0-8A83-E15758FA3A1B@holtmann.org>
From: John Stultz <john.stultz@linaro.org>
Date: Mon, 11 Dec 2017 13:49:11 -0800
Message-ID: <CALAqxLXeN3fF_ZUVeKLEYnDy25bd0+D7DgK3eLA3rVv3dEv6qQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_serdev: Init hci_uart proto_lock to avoid oops
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Lukas Wunner <lukas@wunner.de>, Rob Herring <rob.herring@linaro.org>,
	Johan Hovold <johan@kernel.org>, Ronald Tschalaer <ronald@innovation.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Nov 16, 2017 at 10:07 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Lukas,
>
>> John Stultz reports a boot time crash with the HiKey board (which uses
>> hci_serdev) occurring in hci_uart_tx_wakeup().  That function is
>> contained in hci_ldisc.c, but also called from the newer hci_serdev.c.
>> It acquires the proto_lock in struct hci_uart and it turns out that we
>> forgot to init the lock in the serdev code path, thus causing the crash.
>>
>> John bisected the crash to commit 67d2f8781b9f ("Bluetooth: hci_ldisc:
>> Allow sleeping while proto locks are held"), but the issue was present
>> before and the commit merely exposed it.  (Perhaps by luck, the crash
>> did not occur with rwlocks.)
>>
>> Init the proto_lock in the serdev code path to avoid the oops.
>>
[snip]
> patch has been applied to bluetooth-next tree.

Sorry to be a nuisance if its just a timing thing, but I wanted to
follow up on this just to make sure it didn't fall through the cracks,
as I noticed w/ -rc3 it hasn't landed yet.

thanks
-john
