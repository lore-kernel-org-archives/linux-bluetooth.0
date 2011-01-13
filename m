Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110112083726.GA28156@jh-x301>
References: <AANLkTinFt0Rsbk6LoTk8YnYeqGqzxwTwrWgRakCaQoWo@mail.gmail.com>
	<20110112083726.GA28156@jh-x301>
Date: Thu, 13 Jan 2011 01:53:07 -0500
Message-ID: <AANLkTi=TREFQbrwpt1QacoM+ehgJK9uZjBHib6t1pk7-@mail.gmail.com>
Subject: Re: Any flag indicating bt/fm is ready to run "hcitool cmd"
From: zhangfei gao <zhangfei.gao@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jan 12, 2011 at 3:37 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Wed, Jan 12, 2011, zhangfei gao wrote:
>> Is there any flag indicating bt/fm is ready to run "hcitool cmd", ie,
>> "hciconfig hci0 up" is really finished.
>>
>> We met error "Send failed: File descriptor in bad state", if run
>> hcitool immediately after "hciconfig hci0 up"
>> For example:
>> hciconfig hci0 up
>> hcitool cmd 3f 66 02 26 00 00 00 30
>
> The HCIDEVUP ioctl is at least synchronized with the open() callback for
> the HCI driver so in that sense if the driver is working fine it should
> be possible to send commands when it returns. There is however an issue
> with existing kernels that HCIDEVUP doesn't wait for all of the kernels
> own HCI commands to finish before returning to user space. There was a
> patch sent for this some time ago which you might be interested in
> trying: http://marc.info/?l=linux-bluetooth&m=129296529630642&w=4

Really thanks Johan,
The patch synchronize hci_dev_open, it solve the problem we met, and
"hcitool cmd" could immediately send after "hciconfig hci0 up" without
problem.
By the way, is this patch already in the kernel?

>
> Johan
>
