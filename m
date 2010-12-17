Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 0/1] Add enc_read_blob_req() as defined in BT Core v4.0
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1292612933-31095-1-git-send-email-bgix@codeaurora.org>
References: <1292612933-31095-1-git-send-email-bgix@codeaurora.org>
Content-Type: text/plain
Date: Fri, 17 Dec 2010 13:01:32 -0800
Message-Id: <1292619692.17733.11.camel@sealablnx02.qualcomm.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All

On Fri, 2010-12-17 at 11:08 -0800, Brian Gix wrote:
> Trivial addition of ATT API to encode READ_BLOB_REQ pkt.
> 

I apologize for messing up what must seem to be trivial rules for what
information to put where in the patches I am trying to get incorporated.

This particular patch is in fact a trivial addition to the ATT code,
which I believe probably is identical in all respects (including WS I
hope) to how anyone else here would have implemented it.

My follow on to this will be multi-step GATT procedures, I am going to
try as an RFC first, as the concept of GATT procedures that contain more
than one ATT Request/Response will be something that undoubtedly will
cause people to want to offer input on.

I also apologize for the sporadic nature of communication this week, as
my workstation had a catastrophic failure which is taking some time to
recover from.

> --
> Brian Gix
> bgix@codeaurora.org
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

