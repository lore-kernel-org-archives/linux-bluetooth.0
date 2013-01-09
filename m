Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Jan 2013 11:15:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/5] health: Fix pointer to local variable
 out-of-scope
Message-ID: <20130109091548.GA26746@x220.ger.corp.intel.com>
References: <1357645069-30841-1-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357645069-30841-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Tue, Jan 08, 2013, Syam Sidhardhan wrote:
> The address of the local variable is used outside the scope.
> ---
>  profiles/health/hdp_util.c |   12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

All patches have been applied. Thanks. Btw, I made a minor fix to the
g_test_fail patch to use g_assert_not_reached() instead of (a less
intuitive imo) g_assert(0).

Johan
