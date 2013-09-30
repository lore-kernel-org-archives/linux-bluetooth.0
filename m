Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Sep 2013 21:19:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] lib: Fix use of uninitialized variable in
 sdp_set_profile_descs
Message-ID: <20130930181923.GC26405@x220.p-661hnu-f1>
References: <1380546363-10722-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380546363-10722-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Sep 30, 2013, Szymon Janc wrote:
> Error path on default case was not breaking loop. To keep error
> handling similar all error path were converted to use goto.
> 
> This fix following:
> target  C: libbluetooth <= external/bluetooth/bluez/android/../lib/sdp.c
> lib/sdp.c: In function 'sdp_set_profile_descs':
> lib/sdp.c:487:10: warning: 'values[0]' may be used uninitialized in
>     this function [-Wmaybe-uninitialized]
> lib/sdp.c:2562:19: note: 'values[0]' was declared here
> lib/sdp.c:545:11: warning: 'dtds[0]' may be used uninitialized in this
>     function [-Wmaybe-uninitialized]
> lib/sdp.c:2562:9: note: 'dtds[0]' was declared here
> ---
>  lib/sdp.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Applied. Thanks.

Johan
