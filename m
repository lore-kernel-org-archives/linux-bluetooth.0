Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160810221428.23951-1-vcgomes@gmail.com>
References: <20160810221428.23951-1-vcgomes@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 12 Aug 2016 10:57:10 +0300
Message-ID: <CABBYNZKT87Hng4C6yXUA4L02Oi+OT85QE-3TNFfoYbDA+6M5Rw@mail.gmail.com>
Subject: Re: [PATCH] core: Fix wrong expectations for the return of recv()
To: Vinicius Costa Gomes <vcgomes@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Thu, Aug 11, 2016 at 1:14 AM, Vinicius Costa Gomes <vcgomes@gmail.com> wrote:
> Since commit b5f34f9420b50 "Bluetooth: Fix bt_sock_recvmsg return value"
> in the kernel, Bluetooth sockets of type SOCK_SEQPACKET, when read()
> will return the size of the packet received, which can be larger than
> the the buffer passed by user space.
>
> In this case the problem was causing a disconnection soon after
> the reception of an SDP request.
>
> Reported by: Alban Browaeys <prahal@yahoo.com>
> ---
>  src/sdpd-server.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/sdpd-server.c b/src/sdpd-server.c
> index c863508..b8190da 100644
> --- a/src/sdpd-server.c
> +++ b/src/sdpd-server.c
> @@ -164,7 +164,7 @@ static gboolean io_session_event(GIOChannel *chan, GIOCondition cond, gpointer d
>         }
>
>         len = recv(sk, &hdr, sizeof(sdp_pdu_hdr_t), MSG_PEEK);
> -       if (len != sizeof(sdp_pdu_hdr_t)) {
> +       if (len < sizeof(sdp_pdu_hdr_t)) {
>                 sdp_svcdb_collect_all(sk);
>                 return FALSE;
>         }
> --
> 2.9.2

Applied, note that I did have to include a cast since it was causing
and signess comparison error.

-- 
Luiz Augusto von Dentz
