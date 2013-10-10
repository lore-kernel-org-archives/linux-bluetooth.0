Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Oct 2013 22:38:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Don't register Device ID record on sdp server start
Message-ID: <20131010203842.GB24245@x220.p-661hnu-f1>
References: <1381397344-7389-1-git-send-email-szymon.janc@tieto.com>
 <1381397929-7817-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381397929-7817-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Oct 10, 2013, Szymon Janc wrote:
> This makes SDP code no longer depends on main_opts. DID record is now
> registered from main() after sdp server was started. This is OK since
> mainloop is not yet running and record will be present when first
> request comes.
> ---
> 
> v2 - commit message improved
> 
>  src/main.c        | 4 ++++
>  src/sdpd-server.c | 5 -----
>  2 files changed, 4 insertions(+), 5 deletions(-)

Applied. Thanks.

Johan
