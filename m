Return-Path: <cyrus@holtmann.org>
Date: Sat, 22 Mar 2014 21:57:36 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] eir: Use unsigned int for flags in struct eir_data
Message-ID: <20140322195736.GA31169@t440s.P-661HNU-F1>
References: <1395422492-21425-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395422492-21425-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Mar 21, 2014, Szymon Janc wrote:
> This adds assumption that if flags field is not present in EIR all
> flags are unset:
> "The Flags data type shall be included when any of the Flag bits are
> non-zero, otherwise the Flags data type may be omitted."
> 
> This also fix reporting non-discoverable LE devices as limited
> discoverable due to no explicit check for flags == -1 as empty
> flags.
> ---
>  src/eir.c       |  2 +-
>  src/eir.h       |  2 +-
>  unit/test-eir.c | 18 +++++++++---------
>  3 files changed, 11 insertions(+), 11 deletions(-)

I applied a slightly modified version of this one, with the explicit
assignments to 0 left out.

Johan
