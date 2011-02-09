Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Feb 2011 14:01:41 -0800
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Fix blutoothd exit on badly formated AT+VTS
Message-ID: <20110209220141.GD11911@jh-x301>
References: <1297263346-29728-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297263346-29728-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Wed, Feb 09, 2011, Dmitriy Paliy wrote:
> This fixes bluetoothd exit when AT+VTS command is badly formatted,
> e.g. as AT+VTS\xfe\xfe[...]=1
> 
> Verification it done for the numeric value to be larger than 0x23,
> that corresponds to the hash '#', and to be lower than 0x44, that
> corresponds to 'D', such that the tone is in {0-9, *, #, A, B, C, D}.
> ---
>  audio/headset.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)

Pushed upstream (after the obvious typo fix in the subject). Thanks.

Johan
