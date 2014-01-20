Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Jan 2014 15:20:47 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	Szymon Janc <szymon.janc@gmail.com>
Subject: Re: [PATCH v2 1/5] lib: Add flag to force large MTU size used for
 SDP connection
Message-ID: <20140120132047.GA19106@x220.p-661hnu-f1>
References: <1390216116-23670-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1390216116-23670-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Jan 20, 2014, Szymon Janc wrote:
> This will allow to workaround Dualshock4 not respecting L2CAP MTU
> size while sending SDP response. Use same L2CAP MTU value base on
> RFCOMM.
> ---
>  lib/sdp.c     | 27 +++++++++++++++++++++++++++
>  lib/sdp_lib.h |  1 +
>  2 files changed, 28 insertions(+)

All patches in this set have been applied. Thanks.

Johan
