Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Sat, 31 Jul 2010 20:14:54 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Inga Stotland <ingas@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org,
	johan.hedberg@gmail.com, marcel@holtmann.org
Subject: Re: [PATCH 3/4] Added command argument "-J" to indicate preference
 of using AMP vs BR/EDR.
Message-ID: <20100731231454.GB29039@vigoh>
References: <1280514626-22559-1-git-send-email-ingas@codeaurora.org>
 <1280514626-22559-4-git-send-email-ingas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280514626-22559-4-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

* Inga Stotland <ingas@codeaurora.org> [2010-07-30 11:30:25 -0700]:

> Possible values: "require_br_edr", "prefer_amp", "prefer_br_edr"
> ---
>  test/l2test.c |   34 +++++++++++++++++++++++++++++++++-
>  1 files changed, 33 insertions(+), 1 deletions(-)
	
I would prefer to review and merge the kernel bits first and then go to
the userspace stuff. Doing that we'll have more sure that the socket
options won't change.

-- 
Gustavo F. Padovan
http://padovan.org
