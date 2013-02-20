Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Feb 2013 10:00:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] avctp: Fix invalid file descriptor close
Message-ID: <20130220080030.GB14731@x220>
References: <1361203483-32117-1-git-send-email-s.syam@samsung.com>
 <1361203483-32117-2-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1361203483-32117-2-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Mon, Feb 18, 2013, Syam Sidhardhan wrote:
> During avctp_confirm_cb(), if any error happens we set the session
> state to AVCTP_STATE_DISCONNECTED, which inturn try to close fd 0.
> ---
> 
> I'm not sure about this fix in the latest upstream code,
> but in the case of Bluez 4.101, I got the following
> error log(with extra fd print) and this patch fixes the same.
> 
> audio/avctp.c:avctp_confirm_cb() AVCTP: incoming connect from BC:47:60:F5:88:89
> Refusing unexpected connect from BC:47:60:F5:88:89
> audio/avctp.c:avctp_set_state() AVCTP Disconnected
>     audio/avctp.c:avctp_disconnected()
> AVCTP: closing uinput[fd=0] for BC:47:60:F5:88:89
> 
> 
>  profiles/audio/avctp.c |    1 +
>  1 file changed, 1 insertion(+)

Applied. Thanks.

Johan
