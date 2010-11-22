Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Nov 2010 08:12:43 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Arun K. Singh" <arunkat@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Automate remote name requests
Message-ID: <20101122071243.GA23443@jh-x301>
References: <1290111749-8968-1-git-send-email-johan.hedberg@gmail.com>
 <1290111749-8968-2-git-send-email-johan.hedberg@gmail.com>
 <AANLkTinMq-3K09y-bCWM1Z254FsWoRuZ=QEuZM11WPMb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTinMq-3K09y-bCWM1Z254FsWoRuZ=QEuZM11WPMb@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arun,

On Mon, Nov 22, 2010, Arun K. Singh wrote:
> > The code will work sub-optimally with userspace versions that still
> > do the name requesting themselves (it shouldn't break anything
> > though) so it is recommended to combine this with a userspace
> > software version that doesn't have automated name requests.
> 
> Could you be bit more explicit about such user space versions that you
> recommend? Would latest bluez versions such as 4.80 qualify for your
> recommendation?

The automated name requests upon "connect complete" events were removed
in 4.78 so any version from there onwards would qualify.

Johan
