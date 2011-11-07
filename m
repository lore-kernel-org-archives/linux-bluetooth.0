Return-Path: <cyrus@holtmann.org>
Message-ID: <4EB85527.30607@codeaurora.org>
Date: Mon, 07 Nov 2011 14:01:11 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 0/1] Bluetooth: Add LE SecMgr and mgmtops support
References: <4EB85473.7050103@codeaurora.org>
In-Reply-To: <4EB85473.7050103@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 11/7/2011 1:58 PM, Brian Gix wrote:
>
> I have talked to various members of this list about upstreaming the
> changes that we have made in the Code Aurora Forum, to support a more
> feature-complete MGMTOPS interface between BlueZ and the Kernel, and
> to support MITM protection for Low Energy SMP, using the same
> confirmation paths as Secure Simple Pairing (SMP).
>
> I have spent much of the past week rebasing these changes onto the
> lastest revisions in bluetooth-next, and while this code has *not*
> been extensively tested on this revision of the kernel (it has been
> vigerously tested on older Android base platforms) it can now at leat be
> cleaning applied to this kernel, and comments made.
>
> I expect issues will be found, and I also expect to eventually submit
> this as at least two patches:
>
> 1. MGMTOPS additions/modifications
> 2. SMP rework
>
> I have made an attempt to preserve all bug fixes from the past 5-6
> months, but may inadvertantly have undid some fixes.
>

This patch was rebased off of:

commit 1e92e0b03905de28616d53c8b8c654defb16a096
Author: Szymon Janc <szymon.janc@tieto.com>
Date:   Thu Nov 3 16:05:44 2011 +0100

     Bluetooth: Add debug print to l2cap_chan_create

     Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
     Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>







-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
