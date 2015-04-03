Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Prabhu Chawandi <foss.chaws@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] andorid/handsfree.c setting sizeof struct properly for sco_handlers[]
Date: Fri, 03 Apr 2015 12:59:27 +0200
Message-ID: <1602721.z7bkgJokoX@leonov>
In-Reply-To: <CAKafyqr3qcejbQWYQcMDCiOnjTnUC9Di8J0aKzBosm7Ft32vOw@mail.gmail.com>
References: <CAKafyqr3qcejbQWYQcMDCiOnjTnUC9Di8J0aKzBosm7Ft32vOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Prabhu,

On Thursday 02 of April 2015 09:15:14 Prabhu Chawandi wrote:

There is typo in commit subject andorid->android

Also please use 'fix' term in commit subject eg
"android/handsfree: Fix invalid size of SCO_OP_GET_FD parameters"


And this patch doesn't apply on top of master branch so you will have to 
rebase it before resend.

> diff --git a/android/handsfree.c b/android/handsfree.c
> index 7cdc8b4..e6c4b1b 100644
> --- a/android/handsfree.c
> +++ b/android/handsfree.c
> @@ -2891,7 +2891,7 @@ failed:
> 
>  static const struct ipc_handler sco_handlers[] = {
>         /* SCO_OP_GET_FD */
> -       { bt_sco_get_fd, false, 0 }
> +       { bt_sco_get_fd, false, sizeof(struct sco_cmd_get_fd) }
>  };
> 
>  static void bt_sco_unregister(void)

-- 
BR
Szymon Janc
