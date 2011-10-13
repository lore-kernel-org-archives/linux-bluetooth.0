Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Oct 2011 13:34:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix crash on power off in maemo6 after sending DTMF
Message-ID: <20111013103409.GA19481@fusion.localdomain>
References: <1318500158-9529-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318500158-9529-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Thu, Oct 13, 2011, Dmitriy Paliy wrote:
> This fixes regression introduced in
> b48e610314fb466035b198f594c5b6a68126fcf1. Crash happens when powering
> off adapter after sending DTMF tone.
> ---
>  audio/telephony-maemo6.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
