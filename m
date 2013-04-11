Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Apr 2013 16:44:55 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH v1] Bluetooth: Add rejecting SCO
Message-ID: <20130411194455.GG28775@joana>
References: <1365690946-28050-2-git-send-email-claudio.takahasi@openbossa.org>
 <1365699296-22260-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365699296-22260-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

* Claudio Takahasi <claudio.takahasi@openbossa.org> [2013-04-11 13:54:56 -0300]:

> This patch sends Reject Synchronous Connection Request Command when
> hci_conn_timeout is triggered, and the SCO connection is in BT_CONNECT2
> state. It prevents inconsistency if the remote host doesn't implement
> properly the timeout for the connection request, and it removes the
> connection reference left when the socket is closed for incoming SCO
> connections.
> 
> [ 2650.129080] sco_sock_release: sock ffff8801ca417400, sk ffff88020c408800
> [ 2650.129092] sco_sock_clear_timer: sock ffff88020c408800 state 6
> [ 2650.129101] __sco_sock_close: sk ffff88020c408800 state 6 socket
> 	ffff8801ca417400
> [ 2650.129108] sco_chan_del: sk ffff88020c408800, conn ffff8801c650ea20,
> 	err 104
> [ 2650.129114] hci_conn_put: hcon ffff88020c40a800 orig refcnt 1
> [ 2650.129128] sco_sock_kill: sk ffff88020c408800 state 9
> [ 2650.129135] sco_sock_destruct: sk ffff88020c408800
> [ 2650.138468] hci_conn_timeout: hcon ffff88020c40a800 state BT_CONNECT2
> 
> Signed-off-by: Claudio Takahasi <claudio.takahasi@openbossa.org>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/hci_conn.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Patch has been applied to bluetooth-next with an improved commit subject.
Thanks.

	Gustavo
