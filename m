Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 12:21:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix freeing watches list in maemo6 telephony
Message-ID: <20110927092119.GV3952@dell>
References: <1316609392-28914-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316609392-28914-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Wed, Sep 21, 2011, Dmitriy Paliy wrote:
> This fixes regression introduced in 83064481481d23523e5cdd04.
> List watches has to be freed instead of list pending.
> ---
>  audio/telephony-maemo6.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
