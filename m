Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Feb 2011 15:35:26 -0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: Re: [PATCH v2] Fix no SEP if corresponding interface is disabled
Message-ID: <20110217183526.GA16290@jh-x301>
References: <1297935077-25540-1-git-send-email-dmitriy.paliy@nokia.com>
 <1297935077-25540-2-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297935077-25540-2-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Thu, Feb 17, 2011, Dmitriy Paliy wrote:
> A2DP sink endpoint shall not be created if A2DP sink interface is disabled.
> Same holds for A2DP source endpoint and A2DP source interface.
> 
> Such fixes bluetoothd crash when SDP record is registered and remote
> device tries to connect and stream to A2DP sink which is not initialized.
> Dereferencing of NULL happens in source_new_stream since device->source
> was not created.
> ---
>  audio/a2dp.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)

Pushed upstream. Thanks.

Johan
