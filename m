Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 Sep 2012 11:23:31 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 00/19] Bluetooth: Create AMP physical link
In-Reply-To: <1346933997-14369-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Message-ID: <alpine.DEB.2.02.1209111121550.3754@mathewm-linux>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1346933997-14369-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Andrei -

On Thu, 6 Sep 2012, Andrei Emeltchenko wrote:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> This set of patches enhances A2MP protocol and creates physical
> link between AMP controllers. This is further iteration towards
> Bluetooth High Speed.
>
> Changes:
> 	* p3: Use hci_conn for representing physical link(type AMP_LINK) instead of
> 	struct phy_link, refactoring.
> 	* p2: Remove HCI callbacks and use amp_mgr global list, refactor code.
> 	* p1: Fixed locking issues, added basic logical link preparation.
> 	* v3: Remove workqueue from callback processing; change callback functions
> 	names according to reviewers recommendations; create global amp_mgr_list to
> 	have lookup to amp manager, physical and logical links so for those HCI events
> 	which might be identified by __handler__ we have lookup; remove extensive
> 	hexdump from gen_amp_key.
> 	* v2: Fix typos and bugs, add functionality: now physical connection
> 	might be established.
> 	* v1: Fix typos, change debug prints, refactor code for better
> 	splitting functionality.
>

This doesn't apply to the current bluetooth-next HEAD, could you 
rebase?

Patch 18 (AMP: Send Create Chan Req) also conflicts with my signaling 
patch set, so it would help if you dropped it for now and added that 
functionality after the signaling code is in.

Thanks,

--
Mat Martineau

The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

