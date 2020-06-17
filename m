Return-Path: <SRS0=B2uu=76=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683BBC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 12:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C15820FC3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 12:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZjCgzjoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgFQMwD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 08:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFQMwC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 08:52:02 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48965C06174E
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 05:52:02 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s1so2744827ljo.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 05:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ydc4Anp7yqvrtJe1VckMIJmtVzaa7m1psqY7l5LknoE=;
        b=ZjCgzjoI0hBRmEg86l18ac2TqJaeKjuYMSO9RVxaxqvOPwYrV0XCeJIS/pEoMKED9p
         8cQBdZ5Nwvzep4ZkXoGsenwU6gbdl7unGcpOD7qeiZHOqeaId377utONIZpquD7sJAjj
         nqeU/V1/STz5I7IXx84oPv+fXmm/QdpSlTzvtJ1zHZ6rGqxt9Qtngmpj9r5uAbZklkxh
         dzPsRigkywp/QNY/M/MBXxc0jmNTRlD1CP5YapSBIN/V7NOXwYkxTQwHLWLowuKnlvi7
         mTYywCHRjbRHvSudJbWTxssZQNYzXuov+Z53cbRIRUfcvvUw0dX+8LLMpN3QR9wYyLz5
         EhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ydc4Anp7yqvrtJe1VckMIJmtVzaa7m1psqY7l5LknoE=;
        b=hRa2H2H718pduW7j5uBElpeWbM+NI1Z5gHJvN0+C4T+gPLjn7Hw1L4A8ZglAe97hBM
         F9ZoR4j87oRo6PouW+b7OEMjagrmCcYLN7Aov5I/xZGWSCdaMXaV+l1ZXv8mZlpGGf98
         KFkA2M5fZ07mcBVR9IjTY/n2VdQjT7raCHeNd5aFou1E5goBzj9RzaUoIqus8gWZP9D8
         iSbcyH0/zTCWhzdXxbpyxyv+docqUjtklCDoi2Oh0YyXkWL8DpiyU/DSexgUGfALkoZV
         RddZ12rx5Y3WM4hJvB2vy1kioK8XGxF83O/9V0wb6E+dQAqDHZMaYQsaGCBu53ikA9Qd
         wn4w==
X-Gm-Message-State: AOAM532hEzk1wWwx74Y9b2qqxVE3PZxXKqn1GW34lgQOcBSu0DdCrc5A
        oivbVzhpf4m2PgQyuHGQh47OKHAnx+fhBUN+0c/2OtxjW+g=
X-Google-Smtp-Source: ABdhPJyefdY2FLhLAz0mvOvN4thuiBVrBcPST7C2kcEvt/XJjXbhDnQWqOux4rLmwJxy1rqOvH12JJcwBp+U6ELDjkk=
X-Received: by 2002:a2e:890d:: with SMTP id d13mr4049371lji.75.1592398320495;
 Wed, 17 Jun 2020 05:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1592390407.git.marcel@holtmann.org> <33f8fb3c32ce1940f2cb41adfe440ca0f77fc39c.1592390407.git.marcel@holtmann.org>
In-Reply-To: <33f8fb3c32ce1940f2cb41adfe440ca0f77fc39c.1592390407.git.marcel@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Wed, 17 Jun 2020 08:51:48 -0400
Message-ID: <CALWDO_XOhECFiQcpcMTxs_MPubcv3HVHZKXSgxbPFRLA6w1atQ@mail.gmail.com>
Subject: Re: [PATCH 01/14] Bluetooth: mgmt: Add commands for runtime configuration
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,


On Wed, Jun 17, 2020 at 6:42 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> This adds the required read/set commands for runtime configuration. Even
> while currently no parameters are specified, the commands are made
> available.
>
Reviewed-by: Alain Michaud <alainm@chromium.org>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c        |  7 +++++++
>  net/bluetooth/mgmt_config.c | 18 ++++++++++++++++++
>  net/bluetooth/mgmt_config.h |  6 ++++++
>  3 files changed, 31 insertions(+)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 99fbfd467d04..ecfdfc4df486 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -114,6 +114,8 @@ static const u16 mgmt_commands[] = {
>         MGMT_OP_SET_EXP_FEATURE,
>         MGMT_OP_READ_DEF_SYSTEM_CONFIG,
>         MGMT_OP_SET_DEF_SYSTEM_CONFIG,
> +       MGMT_OP_READ_DEF_RUNTIME_CONFIG,
> +       MGMT_OP_SET_DEF_RUNTIME_CONFIG,
>  };
>
>  static const u16 mgmt_events[] = {
> @@ -166,6 +168,7 @@ static const u16 mgmt_untrusted_commands[] = {
>         MGMT_OP_READ_SECURITY_INFO,
>         MGMT_OP_READ_EXP_FEATURES_INFO,
>         MGMT_OP_READ_DEF_SYSTEM_CONFIG,
> +       MGMT_OP_READ_DEF_RUNTIME_CONFIG,
>  };
>
>  static const u16 mgmt_untrusted_events[] = {
> @@ -7305,6 +7308,10 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
>                                                 HCI_MGMT_UNTRUSTED },
>         { set_def_system_config,   MGMT_SET_DEF_SYSTEM_CONFIG_SIZE,
>                                                 HCI_MGMT_VAR_LEN },
> +       { read_def_runtime_config, MGMT_READ_DEF_RUNTIME_CONFIG_SIZE,
> +                                               HCI_MGMT_UNTRUSTED },
> +       { set_def_runtime_config,  MGMT_SET_DEF_RUNTIME_CONFIG_SIZE,
> +                                               HCI_MGMT_VAR_LEN },
>  };
>
>  void mgmt_index_added(struct hci_dev *hdev)
> diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
> index f6dfbe93542c..8e7ad2a51dbb 100644
> --- a/net/bluetooth/mgmt_config.c
> +++ b/net/bluetooth/mgmt_config.c
> @@ -251,3 +251,21 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
>                                MGMT_OP_SET_DEF_SYSTEM_CONFIG,
>                                MGMT_STATUS_SUCCESS);
>  }
> +
> +int read_def_runtime_config(struct sock *sk, struct hci_dev *hdev, void *data,
> +                           u16 data_len)
> +{
> +       bt_dev_dbg(hdev, "sock %p", sk);
> +
> +       return mgmt_cmd_complete(sk, hdev->id,
> +                                MGMT_OP_READ_DEF_RUNTIME_CONFIG, 0, NULL, 0);
> +}
> +
> +int set_def_runtime_config(struct sock *sk, struct hci_dev *hdev, void *data,
> +                          u16 data_len)
> +{
> +       bt_dev_dbg(hdev, "sock %p", sk);
> +
> +       return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
> +                              MGMT_STATUS_INVALID_PARAMS);
> +}
> diff --git a/net/bluetooth/mgmt_config.h b/net/bluetooth/mgmt_config.h
> index 51da6e63b1a0..a4965f107891 100644
> --- a/net/bluetooth/mgmt_config.h
> +++ b/net/bluetooth/mgmt_config.h
> @@ -9,3 +9,9 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
>
>  int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
>                           u16 data_len);
> +
> +int read_def_runtime_config(struct sock *sk, struct hci_dev *hdev, void *data,
> +                           u16 data_len);
> +
> +int set_def_runtime_config(struct sock *sk, struct hci_dev *hdev, void *data,
> +                          u16 data_len);
> --
> 2.26.2
>
