Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Jan 2011 14:26:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Any flag indicating bt/fm is ready to run "hcitool cmd"
Message-ID: <20110113122622.GA31759@jh-x301>
References: <AANLkTinFt0Rsbk6LoTk8YnYeqGqzxwTwrWgRakCaQoWo@mail.gmail.com>
 <20110112083726.GA28156@jh-x301>
 <AANLkTi=TREFQbrwpt1QacoM+ehgJK9uZjBHib6t1pk7-@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTi=TREFQbrwpt1QacoM+ehgJK9uZjBHib6t1pk7-@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jan 13, 2011, zhangfei gao wrote:
> > The HCIDEVUP ioctl is at least synchronized with the open() callback for
> > the HCI driver so in that sense if the driver is working fine it should
> > be possible to send commands when it returns. There is however an issue
> > with existing kernels that HCIDEVUP doesn't wait for all of the kernels
> > own HCI commands to finish before returning to user space. There was a
> > patch sent for this some time ago which you might be interested in
> > trying: http://marc.info/?l=linux-bluetooth&m=129296529630642&w=4
> 
> Really thanks Johan,
> The patch synchronize hci_dev_open, it solve the problem we met, and
> "hcitool cmd" could immediately send after "hciconfig hci0 up" without
> problem.

Good to hear that it's working now.

> By the way, is this patch already in the kernel?

At least it's in the bluetooth-next tree:
http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-next-2.6.git;a=commitdiff;h=23bb57633df97ede067ea26f3cdc8a7ba2cd8109

Johan
