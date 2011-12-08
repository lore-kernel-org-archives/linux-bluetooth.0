Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Dec 2011 10:38:36 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Peter Krystad <pkrystad@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 hcidump 0/5] Add BT 3.0+HS parsing
Message-ID: <20111208083834.GC28028@aemeltch-MOBL1>
References: <1320281817-359-1-git-send-email-pkrystad@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320281817-359-1-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

On Wed, Nov 02, 2011 at 05:56:52PM -0700, Peter Krystad wrote:
> This patch adds parsing and display of BT 3.0+HS signaling
> 
> v2 - updates to match revised a2mp.h from bluez

What is the status with these patches? Do I understand it correctly that
the license for one patch with definitions (GPL v2 only) prevents it to be
applied?

Peter could you change license so that all user-space code have the same
license? Otherwise we could use hardcoded values of course ....

Best regards 
Andrei Emeltchenko 

> 
> Peter Krystad (5):
>   Add L2CAP Create/Move channel definitions
>   Add A2MP definitions
>   Add parsing of L2CAP Create/Move Channel signals
>   Add parsing of A2MP signals
>   Minor cleanup of indentation in output
> 
>  lib/a2mp.h      |  137 +++++++++++++++
>  lib/l2cap.h     |   44 +++++
>  parser/hci.c    |   15 +-
>  parser/l2cap.c  |  495 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  parser/parser.h |    1 +
>  src/hcidump.c   |    1 +
>  6 files changed, 688 insertions(+), 5 deletions(-)
>  create mode 100644 lib/a2mp.h
> 
> -- 
> 1.7.7
> 
> --
> Peter Krystad
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
