Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Aug 2011 12:42:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Add stop playing ringtone to maemo6 telephony driver
Message-ID: <20110805094201.GA29768@dell>
References: <1312528777-4152-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312528777-4152-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Fri, Aug 05, 2011, Dmitriy Paliy wrote:
> If ringtone is loud enough, it may leak to microphone when call is
> answered via Bluetooth headset. As result, it can be heard on remote
> end. Therefore, playing ringtone shall be stopped as fast as possible
> before answering a call.
> ---
>  audio/telephony-maemo6.c |   34 +++++++++++++++++++++++++++++++++-
>  1 files changed, 33 insertions(+), 1 deletions(-)

Both patches have been applied. Thanks. I also pushed a patch which
moves around the static functions so that forward-declarations of them
are not needed.

Johan
