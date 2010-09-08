Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Wed, 8 Sep 2010 16:47:45 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	gustavo@padovan.org, rshaffer@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 4/4] Bluetooth: Use a stream-oriented recvmsg with
 SOCK_STREAM L2CAP sockets.
Message-ID: <20100908194745.GL16973@vigoh>
References: <1283965529-17068-1-git-send-email-mathewm@codeaurora.org>
 <1283965529-17068-5-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283965529-17068-5-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

* Mat Martineau <mathewm@codeaurora.org> [2010-09-08 10:05:29 -0700]:

> L2CAP ERTM sockets can be opened with the SOCK_STREAM socket type,
> which is a mandatory request for ERTM mode.
> 
> However, these sockets still have SOCK_SEQPACKET read semantics when
> bt_sock_recvmsg() is used to pull data from the receive queue.  If the
> application is only reading part of a frame, then the unread portion
> of the frame is discarded.  If the application requests more bytes
> than are in the current frame, only the current frame's data is
> returned.
> 
> This patch utilizes common code derived from RFCOMM's recvmsg()
> function to make L2CAP SOCK_STREAM reads behave like RFCOMM reads (and
> other SOCK_STREAM sockets in general).  The application may read one
> byte at a time from the input stream and not lose any data, and may
> also read across L2CAP frame boundaries.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
