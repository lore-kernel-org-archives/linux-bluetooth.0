Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1339572738-24345-1-git-send-email-doronkeren@ti.com>
References: <1339572738-24345-1-git-send-email-doronkeren@ti.com>
Date: Wed, 13 Jun 2012 11:53:55 +0200
Message-ID: <CAJ2qBzZVA-GkL+OyGHQH3D4UMkoA056hVhE15uybrm6jKkPCOg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix kernel crash on rfcomm disconnects.
From: Dean Jenkins <djenkins@mvista.com>
To: doronkeren@ti.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Doron,

On 13 June 2012 09:32,  <doronkeren@ti.com> wrote:
> From: Doron Keren <doronkeren@ti.com>
>
> When receiving rfcomm-disconnect-request, and right after receiving
> l2cap-disconnect-request. The rfcomm disconnect function calls
> rfcomm_session_close() function. The l2cap-disconnect-request closed
> the socket. The rfcomm_process_rx funcion at the end, checks
> if the socket is closed and calls again to rfcomm_session_close()
> function, that lead to kernel crash, because the rfcomm session list
> is already deleted on the first call. The bug is fixed by adding
> to the socket state check, test that the session state is
> not already closed.
>
> The bug can be reproduced by turning on the Bluetooth and push
> some file from another Bluetooth device (PC/Phone).
> The kernel crash log-
> rfcomm_process_rx: session c5d37340 state 1 qlen 1
> rfcomm_recv_disc: session c5d37340 state 1 dlci 0
> rfcomm_session_close: session c5d37340 state 9 err 104
> l2cap_disconnect_req: scid 0x0041 dcid 0x0040
> __l2cap_state_change: chan c6703000 BT_CONNECTED -> BT_CLOSED
> rfcomm_l2state_change: c675f800 state 9
> rfcomm_session_del: session c5d37340 state 9 list next=c7321a80, prev=bf05b838
> rfcomm_session_close: session c5d37340 state 9 err 104
> rfcomm_session_del: session c5d37340 state 9 list next=c5d376c0, prev=00200200
> Unable to handle kernel paging request at virtual address 00200200
> PC is at rfcomm_session_del+0x58/0x94 [rfcomm]
>
> ---
>  net/bluetooth/rfcomm/core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index c75107e..077890f 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -1861,7 +1861,7 @@ static void rfcomm_process_rx(struct rfcomm_session *s)
>                        kfree_skb(skb);
>        }
>
> -       if (sk->sk_state == BT_CLOSED) {
> +       if ((sk->sk_state == BT_CLOSED) && (s->state != BT_CLOSED)) {
>                if (!s->initiator)
>                        rfcomm_session_put(s);
>
> --
> 1.7.5.4
>

I have been working on fixing rfcomm crashes due to the refcnt. I
propose to remove the refcnt and instead use the rfcomm session state
machine to delete the session. I have posted 2 RFC patches on the
mailing list in the last few weeks. I can repost them if necessary.

My proposed patches have the following titles, they can be found using google:
[RFC 1/2] Bluetooth: remove rfcomm session refcnt
[RFC 2/2] Bluetooth: return rfcomm session pointers to avoid freed session

I have observed your crash in the ARM environment. The crash occurs
due to high processor loading. I believe the rfcomm_process_rx()
causes a double free of the rfcomm session. The session is deleted by
reception of the DISC but secondly the socket goes to BT_CLOSED.
Unfortunately the s pointer was freed after the DISC so a crash occurs
on the attempt to free the session twice.

I think your solution of using the s rfcomm session pointer maybe
unreliable if s the pointer becomes freed. This is because
rfcomm_process_rx() and other loops retain the old s pointer after the
session has been deleted. In addition, when the s pointer is deleted,
the refcnt value and the state are invalid, memory corruption and a
crash is likely due reuse of the freed pointer.

Also the use of the initiator flag is IMHO incorrect. The connection
and disconnect procedures are independent of each other so there
should be no requirement to know which peer established the rfcomm
control channel. Therefore, failure of the refcnt depends on which
peer established the rfcomm control channel and which peer disconnects
the rfcomm control channel and whether the socket going to BT_CLOSED
is detected.

Would it be possible to evaluate my proposed changes ? My changes are
already in a product for fix evaluation (rfcomm crashes have gone so
far) and I am trying to give my fixes to kernel.org.

If you or anyone else wishes to chat about this issue, I am on the IRC
freenode #bluez channel with nick DeanJenkins

I welcome any feedback on my proposed changes.

Note that I am not a maintainer.

Regards,
Dean

-- 
Dean Jenkins
Embedded Software Engineer
Professional Services UK/EMEA
MontaVista Software, LLC
