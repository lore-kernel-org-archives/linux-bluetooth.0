Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Wed, 8 Sep 2010 16:47:09 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	gustavo@padovan.org, rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/4] Bluetooth: Use common SOCK_STREAM receive code in
 RFCOMM
Message-ID: <20100908194709.GK16973@vigoh>
References: <1283965529-17068-1-git-send-email-mathewm@codeaurora.org>
 <1283965529-17068-4-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283965529-17068-4-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

* Mat Martineau <mathewm@codeaurora.org> [2010-09-08 10:05:28 -0700]:

> To reduce code duplication, have rfcomm_sock_recvmsg() call
> bt_sock_stream_recvmsg().  The common bt_sock_stream_recvmsg()
> code is nearly identical, with the RFCOMM-specific functionality
> for deferred setup and connection unthrottling left in
> rfcomm_sock_recvmsg().
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/rfcomm/sock.c |  104 +++----------------------------------------
>  1 files changed, 6 insertions(+), 98 deletions(-)

Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
