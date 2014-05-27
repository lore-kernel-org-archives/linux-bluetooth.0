Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@intel.com>
Date: Tue, 27 May 2014 10:47:08 +0300
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: HCI_AUTO_OFF ... how to do that from hcitool?
Message-ID: <20140527074708.GA5780@t440s.lan>
References: <CAAJw_ZtNeoECv+qbSwCwyMmOsOpnbhxy61isdd9LUfi5N6FEAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAAJw_ZtNeoECv+qbSwCwyMmOsOpnbhxy61isdd9LUfi5N6FEAA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jeff,

On Tue, May 27, 2014, Jeff Chua wrote:
> commit ab81cbf99c881ca2b9a83682a8722fc84b2483d2
> Author: Johan Hedberg <johan.hedberg@nokia.com>
> Date:   Wed Dec 15 13:53:18 2010 +0200
> 
>     Bluetooth: Implement automatic setup procedure for local adapters
> 
> A new HCI_AUTO_OFF flag is added that user space needs to clear to
> avoid the automatic power off

First of all please don't send private emails on topics that can be
discussed in public. I've included linux-bluetooth in CC where I hope
the thread can continue.

> Help, how do I clear the HCI_AUTO_OFF flag using "hcitool cmd" ?

The HCI_AUTO_OFF flag is a purely kernel-side feature without any user
space interface. It gets automatically cleared when the kernel completes
the initial setup/init routine of the controller.

Johan
