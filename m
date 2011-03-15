Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Mar 2011 19:36:37 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Move telephony_last_dialed_number_req
Message-ID: <20110315173637.GA16335@jh-x301>
References: <1300193754-5748-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300193754-5748-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Tue, Mar 15, 2011, Dmitriy Paliy wrote:
> telephony_last_dialed_number_req function moved to be after
> send_method_call. It is used in successive commit.
> ---
>  audio/telephony-maemo6.c |   24 ++++++++++++------------
>  1 files changed, 12 insertions(+), 12 deletions(-)

All three patches have been pushed upstream. Thanks.

Johan
