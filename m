Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Jan 2011 20:53:51 +0530
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/4 v2] Add proper tracking mechanism to NREC
Message-ID: <20110119152351.GH2112@jh-x301>
References: <1295352671-5533-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295352671-5533-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Jan 18, 2011, Luiz Augusto von Dentz wrote:
> NREC may change during the connections so it has to be tracked in order
> to signal changes to applications.
> ---
>  audio/headset.c   |   55 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  audio/headset.h   |    6 +++++
>  audio/transport.c |   19 ++++++++++++++++++
>  3 files changed, 79 insertions(+), 1 deletions(-)

I didn't realize there was a v2 of this and I already went ahead and
pushed v1. What was the difference? Can you send a patch to update the
upstream tree to whatever this v2 does?

Johan
