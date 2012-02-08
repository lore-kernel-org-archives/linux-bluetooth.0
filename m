Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Feb 2012 12:51:54 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: ilia.kolominsky@gmail.com
Cc: linux-bluetooth@vger.kernel.org, Ilia Kolomisnky <iliak@ti.com>
Subject: Re: [PATCH Bluez v2] Add retries for BNEP connection setup.
Message-ID: <20120208105154.GA32509@x220.ger.corp.intel.com>
References: <1328453938-18458-1-git-send-email-iliak@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328453938-18458-1-git-send-email-iliak@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilia,

On Sun, Feb 05, 2012, ilia.kolominsky@gmail.com wrote:
> According to BNEP spec. v1.0, section 2.6.3, the
> BNEP_SETUP_CONNECTION_REQUEST_MSG should be retransmited if the
> response is not recieved for a period between 1 to 30 sec.
> Current implementation uses SO_RCVTIMEO socket option to sense
> reply time-out, which is incorrect because it does not have effect
> on g_io_add_watch monitored descriptors. This patch allows
> passing of TP/BNEP/CTRL/BV-02-C certification test.
> ---
>  network/connection.c |   59 ++++++++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 50 insertions(+), 9 deletions(-)

After a couple more minor coding style fixes the patch has now been
pushed upstream. Thanks.

Johan
