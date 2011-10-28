Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Oct 2011 14:47:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2] Fix incorrect use of atoi in maemo6
Message-ID: <20111028114722.GA20980@fusion.localdomain>
References: <1319802110-29936-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319802110-29936-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Fri, Oct 28, 2011, Dmitriy Paliy wrote:
> Use of atoi is incorrect and unsafe in maemo6 telephony and replaced
> by g_ascii_digit_value.
> ---
>  audio/telephony-maemo6.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
