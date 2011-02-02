Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Feb 2011 12:10:58 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Fix possible crash on AVDTP Suspend req timeout
Message-ID: <20110202101058.GA15303@jh-x301>
References: <1296632538-2784-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296632538-2784-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Wed, Feb 02, 2011, Dmitriy Paliy wrote:
> This fixes possible bluetoothd crash on AVDTP Suspend request timeout
> if A2DP client was destroyed after the request was sent but before its
> timeout handled.
> 
> If Suspend request times out due to any reason, then references to A2DP
> session and stream are cleared in unix_client. Therefore, callback cannot
> be removed when unix_client is destroyed (e.g. on incomming call).
> 
> After that, consequent Abort request is sent. If the request times out
> as well, than stream_state_changed callback is invoked to change AVDTP
> state to Idle, which causes crash due to NULL dereferencing.
> 
> Therefore, it is important to keep references to AVDTP session and stream
> in unix_client until it is destroyed.
> ---
>  audio/unix.c |   15 ++++-----------
>  1 files changed, 4 insertions(+), 11 deletions(-)

Thanks. Both patches have been pushed upstream.

Johan
