Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Jun 2011 11:14:27 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com, ulrik.lauren@stericsson.com
Subject: Re: [PATCH] Fix AVCTP reply for message with invalid PID
Message-ID: <20110614081427.GA30193@dell.ger.corp.intel.com>
References: <1307627750-5346-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307627750-5346-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Jun 09, 2011, Szymon Janc wrote:
> Reply for control message with invalid (not registered for reception
> of messages) PID should not have message information field present.
> 
> This was affecting AVCTP 1.3 qualification test case TP/NFR/BI-01-C.
> ---
>  audio/control.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
