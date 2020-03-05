Return-Path: <SRS0=x0qO=4W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E034AC3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 16:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBB4208CD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 16:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mfcWKgIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgCEQR7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:17:59 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38411 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgCEQR7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Mar 2020 11:17:59 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so6732852ljh.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Mar 2020 08:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fmc7zAGcguSlPllQsm/411ZOO6F+v76tbVZlcSZP8Wc=;
        b=mfcWKgIlEVXdtDrEwHuTwMt4CKbupwX2XFKNZD5q4qiYwP9/7nNgh4JbL6LsUHVaZC
         9A2ZYXiEwK3VFgCtSbv/3d65KuxOSVGXyuPibHurUiDZkYQVS5ac66n193sUMzIAb6r2
         kWpLg349llcQ3mlsv36lg8TBd8fVvFBcD6+Dnaq1jS37lbKf846WjfXEizklqpP7eMXD
         wktyHfWmRQqMpSAolRrwyzApZ/waU3aU0hQdoID1+ksZg2Rwm5SGzqvTrFbOdNDxiwLy
         JQUmhVomiNCbEvE7TcT8c4BbZHgf67SaUYGhqNDBf7HmWVbtHNFtTcZvKidLeVmCvkrO
         E0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fmc7zAGcguSlPllQsm/411ZOO6F+v76tbVZlcSZP8Wc=;
        b=XGHHzx77It1jOw0QRM+yeFXxnEqrnADixSmdeFcnRH8EB5mKlXKqqnaTrwdXtR9jB9
         fm9sASJpAhhkC8bAZgsL6WovVJ1QFfwp+Xi238wQCmcvp4p7tWZLzSPfZTVCxao5imiA
         VQr0ojEjlVCZNB6FqOiVbAncnCISBvgZ0SIs6oKOlzkeuyM4XRZd/LX7UJi9rnm/N+n2
         sY3+Hy5s4OYcP7Vj3z3avTRBHeGT4Si6aRRmA1Ghqb1RkyAs0ye8g0U6f97lOW236TYs
         uPGWZYdNUiN9keB7rXF2j/BO6ifss+2sMnrFI5euke5x/lQeKZh+apnaspHCxI+k7NAQ
         MryQ==
X-Gm-Message-State: ANhLgQ2PRvUxbxJuDbFzrLaFQYW+555pV++rZMkPh2kHe5R1q25zSWyJ
        lyXWLPxwefrcpKYdvLExEUDgkRBzGn9DlBnBCPNGdg==
X-Google-Smtp-Source: ADFU+vt4gMld2SNi0eDzSmMkCrzfI92vSyuNZ+08CZFzwSjO7sTM3Bz9bUlVb2lChY/1Gc/19nO0M0r5GtWuIeHFRM8=
X-Received: by 2002:a2e:890b:: with SMTP id d11mr6119779lji.79.1583425076738;
 Thu, 05 Mar 2020 08:17:56 -0800 (PST)
MIME-Version: 1.0
References: <20200305152839.92437-1-marcel@holtmann.org>
In-Reply-To: <20200305152839.92437-1-marcel@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Thu, 5 Mar 2020 11:17:45 -0500
Message-ID: <CALWDO_VPZ_E4KnuWoVMEw6=+X4gOsC5Pq+r46i1f6OSdquSbBQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix calculation of SCO handle for packet processing
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, Mar 5, 2020 at 10:28 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> When processing SCO packets, the handle is wrongly assumed as 16-bit
> value. The actual size is 12-bits and the other 4-bits are used for
> packet flags.
>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 4e6d61a95b20..6a88954e67c0 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -4387,13 +4387,16 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>         struct hci_sco_hdr *hdr = (void *) skb->data;
>         struct hci_conn *conn;
> -       __u16 handle;
> +       __u16 handle, flags;
>
>         skb_pull(skb, HCI_SCO_HDR_SIZE);
>
>         handle = __le16_to_cpu(hdr->handle);
> +       flags  = hci_flags(handle);
> +       handle = hci_handle(handle);
>
> -       BT_DBG("%s len %d handle 0x%4.4x", hdev->name, skb->len, handle);
> +       BT_DBG("%s len %d handle 0x%4.4x flags 0x%4.4x", hdev->name, skb->len,
> +              handle, flags);
>
>         hdev->stat.sco_rx++;
>
> --
> 2.24.1
>

LGTM.
