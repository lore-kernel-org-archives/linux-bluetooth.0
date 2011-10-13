Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Oct 2011 13:46:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix +CLCC in maemo6 during CSD_CALL_STATUS_COMING
Message-ID: <20111013104635.GA19913@fusion.localdomain>
References: <1318501551-10048-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318501551-10048-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Thu, Oct 13, 2011, Dmitriy Paliy wrote:
> This fixes the same issue as in 8a6119ea1c685fc61419ee444a5967596f524c1c
> but for CSD_CALL_STATUS_COMING. Call status change sequence in csd is
> IDLE to COMING, COMING to PROCEEDING, and PROCEEDING to WAITING.
> 
> Returned 'state of the call' value after CSD_CALL_STATUS_COMING, as well
> as after CSD_CALL_STATUS_PROCEEDING, in +CLCC shall be 5 (waiting, MT
> call) instead of 4 (incoming, MT call) in maemo6 telephony driver for the
> second incoming call.
> ---
>  audio/telephony-maemo6.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

Applied. Thanks.

Johan
