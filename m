Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Dec 2011 16:15:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] hdp.c: Delay ChannelConnected signal
Message-ID: <20111215141505.GA6875@x220>
References: <1323857512-5626-1-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323857512-5626-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Wed, Dec 14, 2011, Santiago Carot-Nemesio wrote:
> This signal is sent before channel is connected as soon as MCAP accepts
> the data channel creation request. At this moment, applications that
> try to get the fd before the connection finishes will fail. This problem
> can be solved delaying the ChannelConnection signal until the connection
> operation finishes.
> ---
>  health/hdp.c |   45 ++++++++++++++++++++++++++++++++++-----------
>  1 files changed, 34 insertions(+), 11 deletions(-)

Thanks. The patches have now been pushed upstream. I had to do one extra
patch myself since I found quite many things wrong with the include
statement ordering for files under the health subdirectory.

Johan
