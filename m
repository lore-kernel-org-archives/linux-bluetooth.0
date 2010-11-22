Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Nov 2010 22:51:07 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "Arun K. Singh" <arunkat@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Automate remote name requests
Message-ID: <20101122215107.GA15444@jh-x301>
References: <1290111749-8968-1-git-send-email-johan.hedberg@gmail.com>
 <1290111749-8968-2-git-send-email-johan.hedberg@gmail.com>
 <AANLkTinMq-3K09y-bCWM1Z254FsWoRuZ=QEuZM11WPMb@mail.gmail.com>
 <20101122071243.GA23443@jh-x301>
 <AANLkTikHPWyjS+m2NMrxcL0FP6WhX+APExNELRuw4=Pe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTikHPWyjS+m2NMrxcL0FP6WhX+APExNELRuw4=Pe@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Nov 22, 2010, Luiz Augusto von Dentz wrote:
> >> Could you be bit more explicit about such user space versions that you
> >> recommend? Would latest bluez versions such as 4.80 qualify for your
> >> recommendation?
> >
> > The automated name requests upon "connect complete" events were removed
> > in 4.78 so any version from there onwards would qualify.
> 
> Maybe there is some way to detect that the kernel is not doing it, or
> at least force bluetoothd to resolve once to make sure it can be used
> with older kernel versions so it doesn't have to always update as it
> was used to be but if we are to authenticate or authorize a device it
> should have a name so the ui can display it to the user.

Regarding the kernel version detection, this was certainly considered
but there doesn't seem to be any simple way to do it. However, now that
you mention it, this can certainly be an inconvenient issue with
incoming connections for devices which we've never seen during a device
discovery. Therefore, some kind of a userspace workaround for this would
imho be desirable and I'd certainly be willing to accept a patch for it
as long as it doesn't get too complicated. I suppose it's sufficient if
the patch would be for hciops only since any system running mgmtops
would also have a kernel that does the name request.

Johan
