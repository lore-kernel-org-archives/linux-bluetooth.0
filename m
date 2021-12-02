Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33598C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Dec 2021 23:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377610AbhLBX4b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Dec 2021 18:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbhLBX4a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Dec 2021 18:56:30 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDD8C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Dec 2021 15:53:07 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id w23so2231556uao.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Dec 2021 15:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mtRx3PIzjiPwgOuQBaETxQi2m59jWnj5RX5ZAuuRth0=;
        b=OqLLhmG/ViBp5r25PrMOrhorIOu6LgIyULiS6OXMqXbNXshzLkXuKPIwpH9rfIhQtf
         pR98NaNIhtFVLv/mfP4eK3toj+r2X32s/ysnh8BpRt/IWy0Wpl/Cxu9UUIBDPhnp0ZZ6
         KeAQYFyMHqDcSWBxCop0FsxqitfqGHYh9C43mGQ/E7U4OZ3O0v5gkmB2Lt3PkU+a8w7T
         K1jjF6AP8ZqRY5I+JCTy5U94SdyX0GgtNL7rqwkoZYKaNds/XI8YX/5LdIvBLXgv0mMs
         7OOBBr87BvfYB2o2WiZm0FUrVWsxBRmEsOqW3zQzX3HysImO1uc7RpN/KgD0MdNf8Fxf
         l2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mtRx3PIzjiPwgOuQBaETxQi2m59jWnj5RX5ZAuuRth0=;
        b=e+Bu7iUETe7pXxXid1dLSIT26Ur3jZLVp6i4aAhRyPZ3HkRuhQv2ALZt3Sj9pCMepm
         rogU2puB6mKcD7Oh0P2sx26BsRfUwsib5FFGH7rcFoZjhsCudae4+oQVWVSMnNq1x8yi
         LKzMnONRzBYrB1FpRBaJPBJxrJApBISxys416Dq3b+7eSK68vLQAwETyLjaStG5McEpH
         qtAe2BBgkQyyLdDzd0TAtgav0oQep+Hyqp/BL7oW5bcuC4UzRvzQTt4AAZhUtnMZkSDV
         b/OfK9GpvqT8OFQoBrk3V/kOcJA0RKYHJpZCJj6k0XPS72n5/+VZUXpuxF6rVB419MyB
         sijg==
X-Gm-Message-State: AOAM533dIalvZ8Mk1DaAEg0bAnRqqi7K0g7jDSKLKWOXcdB293n3Ub/n
        nkYe92zpVCDw1adQUANwIpa7MXi/3cHyVR650Fk=
X-Google-Smtp-Source: ABdhPJxkzd5I/olc0Emi7lOAvDEZGmzyX0A8lukeEedo2TaCq3YKGtX6DqxQ9TJr0AZ77XCc8NYSeKGxvUlc4ZSXhmM=
X-Received: by 2002:ab0:356a:: with SMTP id e10mr19113440uaa.129.1638489186769;
 Thu, 02 Dec 2021 15:53:06 -0800 (PST)
MIME-Version: 1.0
References: <20211109164113.65981-1-benjamin@sipsolutions.net> <20211109164113.65981-2-benjamin@sipsolutions.net>
In-Reply-To: <20211109164113.65981-2-benjamin@sipsolutions.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 2 Dec 2021 15:52:56 -0800
Message-ID: <CABBYNZLj_ZVjNpscAGVvKxHuPQqmTG=4QrdSUgcSEyttd4sK2Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] Bluetooth: Reset more state when cancelling a sync command
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
> Resetting the timers and cmd_cnt means that we assume the device will be
> in a good state after the sync command finishes. Without this a chain of
> synchronous commands might get stuck if one of them is cancelled.
>
> Signed-off-by: Benjamin Berg <bberg@redhat.com>
> ---
>  net/bluetooth/hci_request.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 92611bfc0b9e..c948ee28bede 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -122,6 +122,11 @@ void hci_req_sync_cancel(struct hci_dev *hdev, int err)
>         if (hdev->req_status == HCI_REQ_PEND) {
>                 hdev->req_result = err;
>                 hdev->req_status = HCI_REQ_CANCELED;
> +
> +               cancel_delayed_work_sync(&hdev->cmd_timer);
> +               cancel_delayed_work_sync(&hdev->ncmd_timer);
> +               atomic_set(&hdev->cmd_cnt, 1);
> +
>                 wake_up_interruptible(&hdev->req_wait_q);
>         }
>  }
> --
> 2.31.1

Are you going to provide updates on this set? Or you are waiting for
more feedback on how to proceed?

-- 
Luiz Augusto von Dentz
