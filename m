Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Aug 2011 11:01:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Syam Sidhardhan <syamsidhardh@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Fix crash when disconnecting the a2dp
Message-ID: <20110812080104.GB19448@dell>
References: <1313001887-29644-1-git-send-email-syamsidhardh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313001887-29644-1-git-send-email-syamsidhardh@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Thu, Aug 11, 2011, Syam Sidhardhan wrote:
> When we disconnect the a2dp Headset by immediate power off and soon if we
> initiate a disconnection from our side, a crash is occurring. This is
> happening because of the disconnect_timeout coming after freeing the session.
> ---
>  audio/avdtp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied (after reformatting the commit message to max 74 characters;
please do this yourself in the future). Again, I left the second patch
out since I'm doubtful it helps more than it hurts readability.

Johan
