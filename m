Return-Path: <cyrus@holtmann.org>
Message-ID: <1334263136.16897.145.camel@aeonflux>
Subject: Re: [PATCHv6 0/2] ERTM state machine changes, part 1
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	pkrystad@codeaurora.org
Date: Thu, 12 Apr 2012 22:38:56 +0200
In-Reply-To: <1334166523-11060-1-git-send-email-mathewm@codeaurora.org>
References: <1334166523-11060-1-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> PATCHv1: Four patches, two patches updating header files were merged
> PATCHv2: Reworked utility functions for seq_lists and control headers.
> PATCHv3: Removed extra debug output, added error handling for
>   allocation failure, used some long lines at Marcel's request, removed
>   an unnecessary variable, and added a __set_control function.
> PATCHv4: Use roundup_pow_of_two macro and kmalloc
> PATCHv5: No warnings
> PATCHv6: Fix indentation issue introduced in v5
> 
> Mat Martineau (2):
>   Bluetooth: Add the l2cap_seq_list structure for tracking frames
>   Bluetooth: Functions for handling ERTM control fields
> 
>  include/net/bluetooth/l2cap.h |   12 ++
>  net/bluetooth/l2cap_core.c    |  263 +++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 267 insertions(+), 8 deletions(-)

I have no idea why neither Gustavo nor Johan applied these patches. So I
just went ahead and pushed them into bluetooth-next tree.

Regards

Marcel


