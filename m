Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Mar 2012 12:29:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Subject: Re: [PATCH V2 2/7] Set DeviceID when registering adapter not when
 sdp server is starting
Message-ID: <20120328092924.GA23691@x220>
References: <1332260847-20079-1-git-send-email-szymon.janc@tieto.com>
 <1332260847-20079-2-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1332260847-20079-2-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HI Szymon,

On Tue, Mar 20, 2012, Szymon Janc wrote:
> Adapter ops are registered after sdp server is started. Thus no
> adapters were registered yet when setting DID on sdp startup and DID
> was never set.
> ---
>  src/manager.c      |   15 ++++-----------
>  src/manager.h      |    1 -
>  src/sdpd-service.c |    3 ---
>  3 files changed, 4 insertions(+), 15 deletions(-)

Compilation fails with this patch:

src/manager.c: In function ‘btd_manager_register_adapter’:
src/manager.c:416:15: error: ‘struct main_opts’ has no member named ‘did’

Please fix and resend.

Johan
