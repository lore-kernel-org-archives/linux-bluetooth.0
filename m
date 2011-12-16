Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Dec 2011 15:58:27 -0800 (PST)
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
cc: padovan@profusion.mobi, pkrystad@codeaurora.org
Subject: Re: [PATCH 0/2] Bug fixes for RFCOMM and L2CAP
In-Reply-To: <1323217407-2490-1-git-send-email-mathewm@codeaurora.org>
Message-ID: <alpine.DEB.2.02.1112161557170.24351@mathewm-linux>
References: <1323217407-2490-1-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Gustavo -

On Tue, 6 Dec 2011, Mat Martineau wrote:

> Here are two bug fixes for
> git://git.kernel.org/pub/scm/linux/kernel/git/padovan/bluetooth.git
>
> The first is a pretty obvious fix where an RFCOMM disconnect timer
> needs to be cancelled when the disconnect happens earlier.  It's not
> clear why the reference counting logic breaks down if this timer is
> not cancelled, but it's definitely more correct to cancel the timer.
>
> The L2CAP fix came up due to a buggy PTS test, which was not sending
> the L2CAP RFC option in an ERTM config response.  This was causing
> access to uninitialized data.
>
> Mat Martineau (2):
>  Bluetooth: Clear RFCOMM session timer when disconnecting last channel
>  Bluetooth: Prevent uninitialized data access in L2CAP configuration
>
> net/bluetooth/l2cap_core.c  |   16 +++++++++++++++-
> net/bluetooth/rfcomm/core.c |    1 +
> 2 files changed, 16 insertions(+), 1 deletions(-)
>
> -- 
> 1.7.8

Did you get a chance to look at these patches?  Note that there is a 
v2 patch for the L2CAP fix.  They fix uninitialized data access and an 
RFCOMM panic.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

