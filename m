Return-Path: <foo00@h08.hostsharing.net>
Date: Fri, 17 Nov 2017 00:59:55 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Rob Herring <rob.herring@linaro.org>,
	Johan Hovold <johan@kernel.org>
Cc: Ronald Tschalaer <ronald@innovation.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH] Bluetooth: hci_serdev: Init hci_uart proto_lock to avoid
 oops
Message-ID: <20171116235955.GA27601@wunner.de>
References: <CALAqxLVTff-XX7bbQ8a1Pihqe=QW1HDMKST3F3okCV8jY+wGqw@mail.gmail.com>
 <CALAqxLW9gzcBrwy3TWB5x_OpKtcLTe7P8PX4KeUgvibbAaMX_A@mail.gmail.com>
 <20171116213045.GA17506@wunner.de>
 <20171116214504.GB17506@wunner.de>
 <CALAqxLX-qp=rc8P7ynGrUwWHgP2EBAwoEES-aOOuehtnJSDR+A@mail.gmail.com>
 <f181189de5fd4c75da4708425df99e70abc6a127.1510875912.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f181189de5fd4c75da4708425df99e70abc6a127.1510875912.git.lukas@wunner.de>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Nov 17, 2017 at 12:54:53AM +0100, Lukas Wunner wrote:
> John Stultz reports a boot time crash with the HiKey board (which uses
> hci_serdev) occurring in hci_uart_tx_wakeup().  That function is
> contained in hci_ldisc.c, but also called from the newer hci_serdev.c.
> It acquires the proto_lock in struct hci_uart and it turns out that we
> forgot to init the lock in the serdev code path, thus causing the crash.
> 
> John bisected the crash to commit 67d2f8781b9f ("Bluetooth: hci_ldisc:
> Allow sleeping while proto locks are held"), but the issue was present
> before and the commit merely exposed it.  (Perhaps by luck, the crash
> did not occur with rwlocks.)
> 
> Init the proto_lock in the serdev code path to avoid the oops.

Apologies, I botched Gustavo Padovan's and Johan Hedberg's e-mail
address in the To: header, please fix up when replying.

Lukas
