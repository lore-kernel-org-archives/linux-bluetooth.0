Return-Path: <cyrus@holtmann.org>
Date: Wed, 12 Oct 2011 10:54:00 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2] Fix call status in +CLCC for maemo6 telephony
Message-ID: <20111012075359.GA13957@fusion.localdomain>
References: <1318332898-21272-1-git-send-email-dmitriy.paliy@nokia.com>
 <1318332898-21272-2-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318332898-21272-2-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Tue, Oct 11, 2011, Dmitriy Paliy wrote:
> If list current calls is requested when there is second incoming call
> and csd call status is CSD_CALL_STATUS_PROCEEDING, then returned 'state
> of the call' value in +CLCC is 4 (incoming, MT call), which is incorrect.
> Indication than proceeds from incoming to waiting state.
> 
> This patch sets the corresponding value to 5 (waiting, MT call) in
> maemo6 telephony driver for the second call.
> ---
>  audio/telephony-maemo6.c |   12 ++++++++++--
>  1 files changed, 10 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
