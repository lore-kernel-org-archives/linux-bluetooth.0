Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Wed, 8 Sep 2010 16:46:25 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	gustavo@padovan.org, rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/4] Bluetooth: Add common code for stream-oriented
 recvmsg()
Message-ID: <20100908194625.GJ16973@vigoh>
References: <1283965529-17068-1-git-send-email-mathewm@codeaurora.org>
 <1283965529-17068-3-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283965529-17068-3-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

* Mat Martineau <mathewm@codeaurora.org> [2010-09-08 10:05:27 -0700]:

> This commit adds a bt_sock_stream_recvmsg() function for use by any
> Bluetooth code that uses SOCK_STREAM sockets.  This code is copied
> from rfcomm_sock_recvmsg() with minimal modifications to remove
> RFCOMM-specific functionality and improve readability.
> 
> L2CAP (with the SOCK_STREAM socket type) and RFCOMM have common needs
> when it comes to reading data.  Proper stream read semantics require
> that applications can read from a stream one byte at a time and not
> lose any data.  The RFCOMM code already operated on and pulled data
> from the underlying L2CAP socket, so very few changes were required to
> make the code more generic for use with non-RFCOMM data over L2CAP.
> 
> Applications that need more awareness of L2CAP frame boundaries are
> still free to use SOCK_SEQPACKET sockets, and may verify that they
> connection did not fall back to basic mode by calling getsockopt().
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/bluetooth.h |    2 +
>  net/bluetooth/af_bluetooth.c      |  109 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 111 insertions(+), 0 deletions(-)

Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
