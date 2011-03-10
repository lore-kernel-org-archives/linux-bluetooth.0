Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Mar 2011 11:06:59 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Increase AVDTP request timeout
Message-ID: <20110310090659.GB2883@jh-x301>
References: <AANLkTi=aBuDLD2qTa4p29CMdBHjBs_nos5YxC5F4T-fB@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTi=aBuDLD2qTa4p29CMdBHjBs_nos5YxC5F4T-fB@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Tue, Mar 08, 2011, Daniel ??rstadius wrote:
> At least one headset with both A2DP and PBAP sends delayed responses
> to AVDTP requests when it is doing PBAP queries (typically at the
> beginning of the connection).
> 
> Increasing the timer by two seconds to give the headset more time to
> reply, to avoid aborting the AVDTP connection.
> ---
>  audio/avdtp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Pushed upstream. Thanks.

Johan
