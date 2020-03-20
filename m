Return-Path: <SRS0=7F+K=5F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AACAC4332B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 13:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADE120739
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 13:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qBiQFmIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgCTNmI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:42:08 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35427 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgCTNmI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Mar 2020 09:42:08 -0400
Received: by mail-lf1-f65.google.com with SMTP id m15so4585940lfp.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2020 06:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eueK1RelaTKtQTskeoZt6YVdGRqiAzaN29k7LII+LmU=;
        b=qBiQFmIzx4dIZ9z3un/4jzFSKPL3QvS+rj9LCmBhm3JwobYI5BEEObAOUwVbpQiURl
         Iv0FdchSpwwl3GNwfTgCTialyUIpnQCCcZEMKeqQGXGGCvWKOo+e5AstvXV/lvKPpqBM
         4zjVT+PojPWpztxyRsAP9NuNGuWyovhTSJrv4jQXvrwQT8RbZyowOz1o/4FNddlDn5PL
         j+YHpHqx5DF2WqLwNhbmWwFVsgJ6byO+WNHs8gQSranMP1kkykX3UV6IHRF/POMM1TFZ
         p5ODFgEB467Ycb4au5lHLmqa/kJQQYXXjU+fVnLvvRARgrd39uM2qSJ4gBAq517hrPQN
         54NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eueK1RelaTKtQTskeoZt6YVdGRqiAzaN29k7LII+LmU=;
        b=UKhW9GguI7+psfrnpkmEh9Np8OSF0gToAeK21M7TvxXGPePPz7THGof9/EkoYhXCjr
         fsILmZABB9JIETQ69AolN2+58yqsXJyde/VhuPvVssJlzg8oPhlbF/237r3mgN3/a2d1
         mtQWjbaVrEIm+4FHNhcXcuerI3KaljQcG8N5JCFXUzKCJgc0UQTW5ipJsmSRm07vt94+
         0vQMHvdH7ol70QyywWsy66LoFZYa/wkKcGUFUEO3CwTT1OYoXdsCTq++G0nEoSwWd9R9
         uPzeLStCXXDBUG6/bhd0caB4rruUP7/Y4uhHQtej2yDBUtjprFYMuxWyFbvXZ9/bTVd7
         SJkQ==
X-Gm-Message-State: ANhLgQ0cU+DPmG8Bk2A0idTvsFHsrQo7YQu9/7r4KQPb7LUTj3Txfayi
        L3+OM3XAB4rBL0cibqKR23hUP19peyE1CaFU/ADMnw==
X-Google-Smtp-Source: ADFU+vubwJtJKm9IrNBGH/GTmLVxyPFceqoJe5UwQE5v3NFWqDbbZD6xpyAY97w+KHni9wWuSWUtY/5/mIC9r736CEQ=
X-Received: by 2002:a05:6512:49e:: with SMTP id v30mr5351792lfq.158.1584711725360;
 Fri, 20 Mar 2020 06:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200320133748.154926-1-alainm@chromium.org>
In-Reply-To: <20200320133748.154926-1-alainm@chromium.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Fri, 20 Mar 2020 09:41:53 -0400
Message-ID: <CALWDO_WSHiNw+uwcZzufJ7rjHr=zpMs6f3ry=rdLMGLz2gJZ=w@mail.gmail.com>
Subject: Re: [PATCH v2] bluetooth: Enforce classic key size verification.
To:     Alain Michaud <alainm@chromium.org>,
        "Holtmann, Marcel" <marcel.holtmann@intel.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,


On Fri, Mar 20, 2020 at 9:37 AM Alain Michaud <alainm@chromium.org> wrote:
>
> This change introduces a new configuration to strictly enforce key size
> checks.  This ensures that systems are in a secured configuration by
> default while allowing for a compatible posture via a Kconfig option to
> support controllers who may not support the read encryption key size
> command.
>
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> ---
>
>  net/bluetooth/Kconfig     | 20 ++++++++++++++++++++
>  net/bluetooth/hci_core.c  | 10 ++++++++++
>  net/bluetooth/hci_event.c |  4 ++++
>  3 files changed, 34 insertions(+)
>
> diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
> index 165148c7c4ce..8e177d4f3f02 100644
> --- a/net/bluetooth/Kconfig
> +++ b/net/bluetooth/Kconfig
> @@ -128,4 +128,24 @@ config BT_DEBUGFS
>           Provide extensive information about internal Bluetooth states
>           in debugfs.
>
> +config BT_EXPERT
> +       bool "Expert Bluetooth options"
> +       depends on BT
> +       default n
> +       help
> +         Provides a set of expert options and configurations that should
> +         only be used deliberately by BT experts.  This is considered a
> +         global switch to ensure these advanced features or options that
> +         depends on BT_EXPERT are only used in expert mode.
> +
> +config BT_ENFORCE_CLASSIC_KEY_SIZES
> +       bool "Enforces security requirements for Bluetooth classic"
> +       depends on BT && BT_EXPERT
> +       default y
> +       help
> +         Enforces Bluetooth classic security requirements by disallowing
> +         use of insecure Bluetooth controllers, i.e. that doesn't support
> +         Read Encryption Key Size command to prevent BT classic connection
> +         with very short encryption key.
> +
>  source "drivers/bluetooth/Kconfig"
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 4e6d61a95b20..142130d4b66b 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1540,6 +1540,16 @@ static int hci_dev_do_open(struct hci_dev *hdev)
>
>         clear_bit(HCI_INIT, &hdev->flags);
>
> +#ifdef BT_ENFORCE_CLASSIC_KEY_SIZES
> +       /* Don't allow usage of Bluetooth if the chip doesn't support */
> +       /* Read Encryption Key Size command */
> +       if (!ret && !(hdev->commands[20] & 0x10)) {
> +               bt_dev_err(hdev,
> +                          "Disabling BT, Read Encryption Key Size !supported");
> +               ret = -EIO;
> +       }
> +#endif
Just FYI, I haven't changed this bit yet.  I'll wait for your guidance
on where best to put this to leave the controller in the right state.
> +
>         if (!ret) {
>                 hci_dev_hold(hdev);
>                 hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index a40ed31f6eb8..54f90799a088 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2902,7 +2902,11 @@ static void read_enc_key_size_complete(struct hci_dev *hdev, u8 status,
>         if (rp->status) {
>                 bt_dev_err(hdev, "failed to read key size for handle %u",
>                            handle);
> +#ifdef BT_ENFORCE_CLASSIC_KEY_SIZES
> +               conn->enc_key_size = 0;
> +#else
>                 conn->enc_key_size = HCI_LINK_KEY_SIZE;
> +#endif
>         } else {
>                 conn->enc_key_size = rp->key_size;
>         }
> --
> 2.25.1.696.g5e7596f4ac-goog
>
