Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1346416811-23484-16-git-send-email-szymon.janc@tieto.com>
References: <1346416811-23484-1-git-send-email-szymon.janc@tieto.com>
	<1346416811-23484-16-git-send-email-szymon.janc@tieto.com>
Date: Fri, 31 Aug 2012 11:19:59 -0400
Message-ID: <CAJdJm_NHUsbuWvLwquROhq83+O0vQcv-w=g=CfpCje7rmSDdBA@mail.gmail.com>
Subject: Re: [RFC v2 15/15] hciemu: Fix build errors due to unaligned memory access
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi  Szymon,

On Fri, Aug 31, 2012 at 8:40 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> --- a/test/hciemu.c
> +++ b/test/hciemu.c
> @@ -426,8 +426,10 @@ static void num_completed_pkts(struct vhci_conn *conn)
>         np = (void *) ptr; ptr += EVT_NUM_COMP_PKTS_SIZE;
>         np->num_hndl = 1;
>
> -       *((uint16_t *) ptr) = htobs(conn->handle); ptr += 2;
> -       *((uint16_t *) ptr) = htobs(vdev.acl_cnt); ptr += 2;
> +       bt_put_be16(conn->handle, ptr);
> +       ptr += 2;
> +       bt_put_be16(vdev.acl_cnt, ptr);
> +       ptr += 2;

These should be bt_put_le16().

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
