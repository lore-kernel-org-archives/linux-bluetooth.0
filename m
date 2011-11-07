Return-Path: <cyrus@holtmann.org>
Message-ID: <4EB85473.7050103@codeaurora.org>
Date: Mon, 07 Nov 2011 13:58:11 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [RFC 0/1] Bluetooth: Add LE SecMgr and mgmtops support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


I have talked to various members of this list about upstreaming the 
changes that we have made in the Code Aurora Forum, to support a more 
feature-complete MGMTOPS interface between BlueZ and the Kernel, and
to support MITM protection for Low Energy SMP, using the same 
confirmation paths as Secure Simple Pairing (SMP).

I have spent much of the past week rebasing these changes onto the 
lastest revisions in bluetooth-next, and while this code has *not*
been extensively tested on this revision of the kernel (it has been 
vigerously tested on older Android base platforms) it can now at leat be 
cleaning applied to this kernel, and comments made.

I expect issues will be found, and I also expect to eventually submit 
this as at least two patches:

1. MGMTOPS additions/modifications
2. SMP rework

I have made an attempt to preserve all bug fixes from the past 5-6 
months, but may inadvertantly have undid some fixes.

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
