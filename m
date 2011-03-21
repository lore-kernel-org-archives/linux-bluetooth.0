Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1300722233-11598-4-git-send-email-szymon.janc@tieto.com>
References: <1300722233-11598-1-git-send-email-szymon.janc@tieto.com>
	<1300722233-11598-4-git-send-email-szymon.janc@tieto.com>
Date: Mon, 21 Mar 2011 15:17:47 -0400
Message-ID: <AANLkTimzA1DZi7soB_++es81ggng+24_c0=-APgb1A9o@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] Bluetooth: Add read_local_oob_data management command
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

Just a few minor tips:

On Mon, Mar 21, 2011 at 11:43 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> +       cmd = mgmt_pending_add(sk, MGMT_OP_READ_LOCAL_OOB_DATA, index, NULL, 0);
> +
> +       if (!cmd) {
> +               err = -ENOMEM;
> +               goto unlock;
> +       }

No empty line before the if() above.

> +
> +       err = hci_send_cmd(hdev, HCI_OP_READ_LOCAL_OOB_DATA, 0, NULL);
> +
> +       if (err < 0)
> +               mgmt_pending_remove(cmd);

Same above.

> +       } else {
> +               struct mgmt_rp_read_local_oob_data rp;
> +
> +               memcpy(rp.hash, hash, 16);
> +               memcpy(rp.randomizer, randomizer, 16);

What about using "sizeof(rp.hash)" and "sizeof(rp.randomizer)" ?

> +
> +               err = cmd_complete(cmd->sk, index, MGMT_OP_READ_LOCAL_OOB_DATA,
> +                                                       &rp, sizeof(rp));
> +       }
> +
> +       mgmt_pending_remove(cmd);
> +
> +       return err;
> +}
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
