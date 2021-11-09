Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B427C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 23:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42A7260E73
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 23:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhKIXJJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Nov 2021 18:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhKIXJI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Nov 2021 18:09:08 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F42FC061764
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Nov 2021 15:06:21 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id p2so886031uad.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Nov 2021 15:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=evvnNIXIXqMxBwj2wmg0jO7ZdU7NdxXmiu/zqKM7Vi8=;
        b=hwiRBF91JwpEXimV8QyJJ3xh6jaLDgbYZ7bESdD/rT4ABufO3Vb8blv9NaqH8Gpqd0
         +r2w1bPpWGUYq0sUZF9fg5FK1Dj7c+AYHmzgZ+gByZpHx4RqmvgCZ9pqbPKzgZcA6ylx
         WSdPzXQVoJ4coddHU6InrWBmQt73AgbrPwk+x0u/a8jh6utSESCMJkhQF9lgUpy7qTfV
         z2MPQNcDFyFHp7YZR/UO9SptNXWyk57UcmnMSxYOI8IqY6qOE7IcAVj2V9mW2gN23vwG
         GoWDsyh4eaSrUYLlAgGvtGZGrcr/8Gs86BtCX8bPU0wbJFn+U3s8KINtZnnLChLdiSik
         8Crg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=evvnNIXIXqMxBwj2wmg0jO7ZdU7NdxXmiu/zqKM7Vi8=;
        b=jpFILt3BlwEdI9ZNUgDqqhISiqwfo45wfY/IiKS/8T38N5tzOyGe7X2ZwJCADxsPsb
         T7M8ncmne5zp8bXVMdvi5PVoOK53927wLj74RjUSIStPL+jVv8uAvrA/zE67kjQz4s6J
         4E015TTdhxxgWmcwj2CdgBVsZIbHfAdfe/FN/1inFZS7P13+CpjOUnWgKW+qythnAAJI
         whayWKxMgfO0wbHmdgmOiMgUO525/Kg3VhYX9RCgCY8B4Y2qaEXqBeRtMotEsgnH8ODU
         njP+6DhP2ZJEqvjmYuqdWGojiILBXvIG28VShxd+B3FYYAG4eL4bdBvnl9uvlJe66tUF
         w5YA==
X-Gm-Message-State: AOAM533zfWxmGZD7gEfjSDGsL7hqi49RcOXCH6kO52mqDtlDMMLbKlcv
        ydOVETVxrVakWyYO19SsY59TDlevpp9y6yIW1vzVq/Zh
X-Google-Smtp-Source: ABdhPJwXtKEsZsSTekUlKxJEUEQPn8tIxzKCOZmxReJmzABNUtgJiReMpQIzERI7YnHz0pUr2u/fsS8k4TDzDBwU/Lo=
X-Received: by 2002:a67:fd90:: with SMTP id k16mr17532471vsq.39.1636499180490;
 Tue, 09 Nov 2021 15:06:20 -0800 (PST)
MIME-Version: 1.0
References: <20211109164113.65981-1-benjamin@sipsolutions.net> <20211109164113.65981-3-benjamin@sipsolutions.net>
In-Reply-To: <20211109164113.65981-3-benjamin@sipsolutions.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 9 Nov 2021 15:06:09 -0800
Message-ID: <CABBYNZKajx0FhVwDqHDWN1WfkM83NN41RR7OzkbgbKYqqn3F6g@mail.gmail.com>
Subject: Re: [PATCH 2/4] Bluetooth: Add new hci_tx_error function
To:     Benjamin Berg <benjamin@sipsolutions.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Benjamin Berg <bberg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Benjamin,

On Tue, Nov 9, 2021 at 2:35 PM Benjamin Berg <benjamin@sipsolutions.net> wrote:
>
> From: Benjamin Berg <bberg@redhat.com>
>
> Currently this function only cancels any synchronous operation that
> might be ongoing. Adding this function allows aborting synchronous
> commands in case of low level TX/RX issues. A common example for this is
> that the device has been removed.
>
> Signed-off-by: Benjamin Berg <bberg@redhat.com>
> ---
>  include/net/bluetooth/hci_core.h | 1 +
>  net/bluetooth/hci_core.c         | 7 +++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index dd8840e70e25..542f5a37b9d0 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1267,6 +1267,7 @@ void hci_release_dev(struct hci_dev *hdev);
>  int hci_suspend_dev(struct hci_dev *hdev);
>  int hci_resume_dev(struct hci_dev *hdev);
>  int hci_reset_dev(struct hci_dev *hdev);
> +void hci_tx_error(struct hci_dev *hdev, int err);
>  int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb);
>  int hci_recv_diag(struct hci_dev *hdev, struct sk_buff *skb);
>  __printf(2, 3) void hci_set_hw_info(struct hci_dev *hdev, const char *fmt, ...);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 8d33aa64846b..bbb35188e41f 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -4069,6 +4069,13 @@ int hci_reset_dev(struct hci_dev *hdev)
>  }
>  EXPORT_SYMBOL(hci_reset_dev);
>
> +/* Reset HCI device */
> +void hci_tx_error(struct hci_dev *hdev, int err)
> +{
> +       hci_req_sync_cancel(hdev, err);
> +}
> +EXPORT_SYMBOL(hci_tx_error);

I think we might be better off having such functionality exposed by
hci_sync.h since that should be accessible by driver nowadays, at
least that seems cleaner than having to introduce yet another public
function in hci_core.h just to interface with the likes of
hci_req_sync_cancel, that said we are also deprecating hci_request.h
in favor of hci_sync.h so we might as well move the likes of
hci_req_sync_cancel to hci_sync.h renaming it to hci_cmd_sync_cancel
so it is inline with naming we are using in hci_sync.h.

>  /* Receive frame from HCI drivers */
>  int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
>  {
> --
> 2.31.1
>


-- 
Luiz Augusto von Dentz
