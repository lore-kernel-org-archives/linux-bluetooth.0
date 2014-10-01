Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1412152303-14849-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1412152303-14849-1-git-send-email-jakub.tyszkowski@tieto.com>
Date: Wed, 1 Oct 2014 16:01:06 +0300
Message-ID: <CABBYNZ+MRzqOUXsF4vVwNdCX0D5HV+96zjRr3L_py_P9SgUu-w@mail.gmail.com>
Subject: Re: [PATCH] emulator/bthost: Add missing flow_ctrl assignment
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, Oct 1, 2014 at 11:31 AM, Jakub Tyszkowski
<jakub.tyszkowski@tieto.com> wrote:
> This fixes following valgrind report:
> ==3093== Syscall param writev(vector[...]) points to uninitialised
> byte(s)
> ==3093==    at 0x5652FA0: writev (writev.c:54)
> ==3093==    by 0x408029: send_iov (bthost.c:484)
> ==3093==    by 0x402530: rfcomm_uih_send.isra.25 (bthost.c:1771)
> ==3093==    by 0x4095BE: bthost_receive_h4 (bthost.c:1872)
> ==3093==    by 0x4029E6: receive_bthost.part.1 (hciemu.c:141)
> ==3093==    by 0x5083CE4: g_main_context_dispatch (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
> ==3093==    by 0x5084047: ??? (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
> ==3093==    by 0x5084309: g_main_loop_run (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
> ==3093==    by 0x415920: tester_run (tester.c:815)
> ==3093==    by 0x40263E: main (tester-main.c:2588)
> ==3093==  Address 0xffefff0b1 is on thread 1's stack
> ==3093==
> ---
>  emulator/bthost.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/emulator/bthost.c b/emulator/bthost.c
> index 59dde1e..f859dd1 100644
> --- a/emulator/bthost.c
> +++ b/emulator/bthost.c
> @@ -1862,6 +1862,7 @@ static void rfcomm_pn_recv(struct bthost *bthost, struct btconn *conn,
>         }
>
>         pn_cmd.dlci = pn->dlci;
> +       pn_cmd.flow_ctrl = pn->flow_ctrl;
>         pn_cmd.priority = pn->priority;
>         pn_cmd.ack_timer = pn->ack_timer;
>         pn_cmd.max_retrans = pn->max_retrans;
> --
> 1.9.1

Pushed, thanks.


-- 
Luiz Augusto von Dentz
