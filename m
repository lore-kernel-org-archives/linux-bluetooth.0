Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 May 2010 18:19:16 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Ron Shaffer <rshaffer@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/1] Bluetooth: Synchronize SCO/eSCO connection
 requests to ACL state
Message-ID: <20100524211916.GB5241@vigoh>
References: <4BFAEB5C.4040300@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4BFAEB5C.4040300@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ron,

* Ron Shaffer <rshaffer@codeaurora.org> [2010-05-24 16:10:52 -0500]:

> Marcel:
> 
> This patch resolves some issues with what looks to be certain CSR
> based headsets. When requesting SCO or eSCO while the connection
> is transitioning from sniff to active, i.e. unsniff has been requested
> but the headset has not responded with accepted, these headsets seem
> to enter a state where they don't positively respond the SCO/eSCO
> request. This was first noticed in and Motorola H350 Headset.
> 
> In addition, I've cleaned up some extraneous spaces and the original
> Copyright has been changed from Qualcomm to Code Aurora Forum as
> Qualcomm has reassigned these rights to Code Aurora Forum.

Could you please split this patch in 3 patches? Clearly it mixes 3 things:
your fix, the copyright change, and the cleanup.

> 
> -- 
> Ron Shaffer
> Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Gustavo F. Padovan
http://padovan.org
