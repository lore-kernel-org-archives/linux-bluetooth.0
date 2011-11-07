Return-Path: <cyrus@holtmann.org>
Message-ID: <4EB857CA.1000902@codeaurora.org>
Date: Mon, 07 Nov 2011 14:12:26 -0800
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


I am also now going to commence rebasing the MGMTOPS changes that I made 
to Bluez.  The changes are much less drastic, but of course important 
for the support of the kernel side.  The existing MGMTOPS interface will 
work with the Kernel changes with fairly minor changes, that include 
usually a few extra parameters in the datagrams.

Most significantly, we thought that the LE Address type (Random vs 
Public) was important to store with the pairing information.  I know 
that some here have been of the opinion that we can just do an LE scan 
each time we want to connect to an LE device, but as we make the move 
towards supporting LE Privacy, this piece of information (Random vs 
Public) really is just an extension of the BD Addr being used.

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
