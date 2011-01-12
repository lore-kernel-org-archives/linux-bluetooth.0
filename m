Return-Path: <cyrus@holtmann.org>
Date: Wed, 12 Jan 2011 10:37:26 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Any flag indicating bt/fm is ready to run "hcitool cmd"
Message-ID: <20110112083726.GA28156@jh-x301>
References: <AANLkTinFt0Rsbk6LoTk8YnYeqGqzxwTwrWgRakCaQoWo@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTinFt0Rsbk6LoTk8YnYeqGqzxwTwrWgRakCaQoWo@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jan 12, 2011, zhangfei gao wrote:
> Is there any flag indicating bt/fm is ready to run "hcitool cmd", ie,
> "hciconfig hci0 up" is really finished.
> 
> We met error "Send failed: File descriptor in bad state", if run
> hcitool immediately after "hciconfig hci0 up"
> For example:
> hciconfig hci0 up
> hcitool cmd 3f 66 02 26 00 00 00 30

The HCIDEVUP ioctl is at least synchronized with the open() callback for
the HCI driver so in that sense if the driver is working fine it should
be possible to send commands when it returns. There is however an issue
with existing kernels that HCIDEVUP doesn't wait for all of the kernels
own HCI commands to finish before returning to user space. There was a
patch sent for this some time ago which you might be interested in
trying: http://marc.info/?l=linux-bluetooth&m=129296529630642&w=4

Johan
