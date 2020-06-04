Return-Path: <SRS0=9nD+=7R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA121C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jun 2020 21:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3F42206E6
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jun 2020 21:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mG3BFqlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgFDV2l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jun 2020 17:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgFDV2k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jun 2020 17:28:40 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6545C08C5C0
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2020 14:28:40 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id o7so5950208oti.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2020 14:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=40z5tW1tj8hkDY/B0YuXmKTehDdhEBSqTBO+4DBw/f0=;
        b=mG3BFqlwafNSIfYTQ3gWVO5MiFE5CHmdXG0P2HytuCXMGfdrgS66Tfz40JevY6rxrq
         rI2NLKsdBFNi86QYeGgkqo9hddJqoaKtS4+T3PSHRb6JBqRct/GztdtDZOjLD7+FoSIp
         BL/4p84ahV/9aAy6cBpGfaxceSUSJLoRgPvQYa91c10Ej7pNePMWXQCZk3xHXB4huO75
         c6ocaKfWwz4F0XRts5/7QHYcpZq+Dfd5s3cSxgsQRVj0Z79GMSrklKvmqD/SqvcLbTLu
         s7Zf4gmxkKoMENd4vWjPctzrFPNZLrbHwAFwV5nLz3PmLhJLVRotZdICX4l6Sg1O129+
         m2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=40z5tW1tj8hkDY/B0YuXmKTehDdhEBSqTBO+4DBw/f0=;
        b=rZRMT5Wc4x/+OwPIzIYtCtAvc7+ZtL+qyGgZeqf7ZhMci5uLSB0UxYiMSmOOc1QxIA
         PgXLat1psba/BRwOe8Bc7zmmACI2rHOhnW/IP3arcqc54eXK56hU45tPFilsLuly8fgS
         nukc0t2479yWYKFs5Vwm7M3jBq1rQ0mYRQtempDBw0xIQEMPO/jcGQhoGihsDw/h69+r
         Ib3+yJ+Jy6/JxgPc0Q5B+x84JT358RuxMcP67OJ+sx3UXsok2kyzjH7V8kkkbm4jn6Dp
         wvaP4s6RD2rLExD8QKQgEaI0227+S3cpbSufHmknpBZgs2syflhngaOu5NrFttgnuYgm
         HQuQ==
X-Gm-Message-State: AOAM532oj7quROd76wwSth8baZEhpLCEm7HWVQyklPsDahcxGxER3zaH
        B9BO/CuPW/MKPJ5KPlYejjmZLZcyiIFai4MrC+4=
X-Google-Smtp-Source: ABdhPJzg1tayxPt/8M5HCKJhVO1gMyci5gI+44K8w5S6A3bcJ2WNCj6u3xdjpoC7gkUi9mocMIycbaF3jBGDtVHkgns=
X-Received: by 2002:a05:6830:310c:: with SMTP id b12mr5383868ots.11.1591306120062;
 Thu, 04 Jun 2020 14:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200505121918.Bluez.v2.1.I86c1e0e8933d92d8d76dcd95036bf325cfaeced0@changeid>
In-Reply-To: <20200505121918.Bluez.v2.1.I86c1e0e8933d92d8d76dcd95036bf325cfaeced0@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 4 Jun 2020 14:28:28 -0700
Message-ID: <CABBYNZLRDzBv_ES3HvuBEc1Jse8oxfbFe+5j8exgZ1NbKsnpRg@mail.gmail.com>
Subject: Re: [Bluez PATCH v2] tools/l2cap-tester: Add test for waiting
 disconnection response
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Mon, May 4, 2020 at 9:29 PM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> This is to test the behaviour of L2CAP channel when closed with
> shut_down(sock, SHUT_WR). In this case, we should wait until we
> receive a disconnection response before raising G_IO_HUP.
> ---
>
> Changes in v2:
> - Fix compile error in android/tester-main.c
>
>  android/tester-main.c |  2 +-
>  emulator/bthost.c     | 17 ++++++++++-
>  emulator/bthost.h     |  5 +++-
>  tools/l2cap-tester.c  | 65 ++++++++++++++++++++++++++++++++++++++-----
>  tools/rfcomm-tester.c |  2 +-
>  5 files changed, 80 insertions(+), 11 deletions(-)
>
> diff --git a/android/tester-main.c b/android/tester-main.c
> index 3c5af299f..9a14b2899 100644
> --- a/android/tester-main.c
> +++ b/android/tester-main.c
> @@ -2867,7 +2867,7 @@ void emu_add_l2cap_server_action(void)
>         bthost = hciemu_client_get_host(data->hciemu);
>
>         bthost_add_l2cap_server(bthost, l2cap_data->psm, l2cap_data->func,
> -                                                       l2cap_data->user_data);
> +                                               NULL, l2cap_data->user_data);
>
>         step->action_status = BT_STATUS_SUCCESS;
>
> diff --git a/emulator/bthost.c b/emulator/bthost.c
> index 0fa283464..71d5f97bb 100644
> --- a/emulator/bthost.c
> +++ b/emulator/bthost.c
> @@ -180,6 +180,7 @@ struct l2cap_pending_req {
>  struct l2cap_conn_cb_data {
>         uint16_t psm;
>         bthost_l2cap_connect_cb func;
> +       bthost_l2cap_disconnect_cb disconn_func;
>         void *user_data;
>         struct l2cap_conn_cb_data *next;
>  };
> @@ -1510,7 +1511,9 @@ static bool l2cap_disconn_req(struct bthost *bthost, struct btconn *conn,
>                                 uint8_t ident, const void *data, uint16_t len)
>  {
>         const struct bt_l2cap_pdu_disconn_req *req = data;
> +       struct l2cap_conn_cb_data *cb_data;
>         struct bt_l2cap_pdu_disconn_rsp rsp;
> +       struct l2conn *l2conn;
>
>         if (len < sizeof(*req))
>                 return false;
> @@ -1522,6 +1525,15 @@ static bool l2cap_disconn_req(struct bthost *bthost, struct btconn *conn,
>         l2cap_sig_send(bthost, conn, BT_L2CAP_PDU_DISCONN_RSP, ident, &rsp,
>                                                                 sizeof(rsp));
>
> +       l2conn = btconn_find_l2cap_conn_by_scid(conn, rsp.scid);
> +       if (!l2conn)
> +               return true;
> +
> +       cb_data = bthost_find_l2cap_cb_by_psm(bthost, l2conn->psm);
> +
> +       if (cb_data && cb_data->disconn_func)
> +               cb_data->disconn_func(cb_data->user_data);
> +
>         return true;
>  }
>
> @@ -2553,7 +2565,9 @@ uint64_t bthost_conn_get_fixed_chan(struct bthost *bthost, uint16_t handle)
>  }
>
>  void bthost_add_l2cap_server(struct bthost *bthost, uint16_t psm,
> -                               bthost_l2cap_connect_cb func, void *user_data)
> +                               bthost_l2cap_connect_cb func,
> +                               bthost_l2cap_disconnect_cb disconn_func,
> +                               void *user_data)
>  {
>         struct l2cap_conn_cb_data *data;
>
> @@ -2564,6 +2578,7 @@ void bthost_add_l2cap_server(struct bthost *bthost, uint16_t psm,
>         data->psm = psm;
>         data->user_data = user_data;
>         data->func = func;
> +       data->disconn_func = disconn_func;
>         data->next = bthost->new_l2cap_conn_data;
>
>         bthost->new_l2cap_conn_data = data;
> diff --git a/emulator/bthost.h b/emulator/bthost.h
> index b5f36964d..2b347136f 100644
> --- a/emulator/bthost.h
> +++ b/emulator/bthost.h
> @@ -100,9 +100,12 @@ void bthost_le_start_encrypt(struct bthost *bthost, uint16_t handle,
>                                                         const uint8_t ltk[16]);
>  typedef void (*bthost_l2cap_connect_cb) (uint16_t handle, uint16_t cid,
>                                                         void *user_data);
> +typedef void (*bthost_l2cap_disconnect_cb) (void *user_data);
>
>  void bthost_add_l2cap_server(struct bthost *bthost, uint16_t psm,
> -                               bthost_l2cap_connect_cb func, void *user_data);
> +                               bthost_l2cap_connect_cb func,
> +                               bthost_l2cap_disconnect_cb disconn_func,
> +                               void *user_data);
>
>  void bthost_set_sc_support(struct bthost *bthost, bool enable);
>
> diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
> index 844ff2b46..1ef4e9213 100644
> --- a/tools/l2cap-tester.c
> +++ b/tools/l2cap-tester.c
> @@ -55,6 +55,7 @@ struct test_data {
>         uint16_t dcid;
>         int sk;
>         int sk2;
> +       bool host_disconnected;
>  };
>
>  struct l2cap_data {
> @@ -93,6 +94,8 @@ struct l2cap_data {
>         bool server_not_advertising;
>         bool direct_advertising;
>         bool close_1;
> +
> +       bool shut_sock_wr;
>  };
>
>  static void mgmt_debug(const char *str, void *user_data)
> @@ -316,6 +319,12 @@ static const struct l2cap_data client_connect_write_success_test = {
>         .data_len = sizeof(l2_data),
>  };
>
> +static const struct l2cap_data client_connect_shut_wr_success_test = {
> +       .client_psm = 0x1001,
> +       .server_psm = 0x1001,
> +       .shut_sock_wr = true,
> +};
> +
>  static const struct l2cap_data client_connect_nval_psm_test_1 = {
>         .client_psm = 0x1001,
>         .expect_err = ECONNREFUSED,
> @@ -967,6 +976,27 @@ static void server_bthost_received_data(const void *buf, uint16_t len,
>                 tester_test_passed();
>  }
>
> +static gboolean socket_closed_cb(GIOChannel *io, GIOCondition cond,
> +                                                       gpointer user_data)
> +{
> +       struct test_data *data = tester_get_data();
> +       const struct l2cap_data *l2data = data->test_data;
> +
> +       if (l2data->shut_sock_wr) {
> +               /* if socket is closed using SHUT_WR, L2CAP disconnection
> +                * response must be received first before G_IO_HUP event.
> +                */
> +               if (data->host_disconnected)
> +                       tester_test_passed();
> +               else {
> +                       tester_warn("G_IO_HUP received before receiving L2CAP disconnection");
> +                       tester_test_failed();
> +               }
> +       }
> +
> +       return FALSE;
> +}
> +
>  static bool check_mtu(struct test_data *data, int sk)
>  {
>         const struct l2cap_data *l2data = data->test_data;
> @@ -1062,6 +1092,11 @@ static gboolean l2cap_connect_cb(GIOChannel *io, GIOCondition cond,
>                         tester_test_failed();
>                 }
>
> +               return FALSE;
> +       } else if (l2data->shut_sock_wr) {
> +               g_io_add_watch(io, G_IO_HUP, socket_closed_cb, NULL);
> +               shutdown(sk, SHUT_WR);
> +
>                 return FALSE;
>         }
>
> @@ -1214,6 +1249,13 @@ static void client_l2cap_connect_cb(uint16_t handle, uint16_t cid,
>         data->handle = handle;
>  }
>
> +static void client_l2cap_disconnect_cb(void *user_data)
> +{
> +       struct test_data *data = user_data;
> +
> +       data->host_disconnected = true;
> +}
> +
>  static void direct_adv_cmd_complete(uint16_t opcode, const void *param,
>                                                 uint8_t len, void *user_data)
>  {
> @@ -1254,13 +1296,18 @@ static void test_connect(const void *test_data)
>
>         if (l2data->server_psm) {
>                 struct bthost *bthost = hciemu_client_get_host(data->hciemu);
> +               bthost_l2cap_connect_cb host_connect_cb = NULL;
> +               bthost_l2cap_disconnect_cb host_disconnect_cb = NULL;
>
> -               if (!l2data->data_len)
> -                       bthost_add_l2cap_server(bthost, l2data->server_psm,
> -                                               NULL, NULL);
> -               else
> -                       bthost_add_l2cap_server(bthost, l2data->server_psm,
> -                                               client_l2cap_connect_cb, data);
> +               if (l2data->data_len)
> +                       host_connect_cb = client_l2cap_connect_cb;
> +
> +               if (l2data->shut_sock_wr)
> +                       host_disconnect_cb = client_l2cap_disconnect_cb;
> +
> +               bthost_add_l2cap_server(bthost, l2data->server_psm,
> +                                       host_connect_cb, host_disconnect_cb,
> +                                       data);
>         }
>
>         if (l2data->direct_advertising)
> @@ -1639,7 +1686,7 @@ static void test_connect_2(const void *test_data)
>
>                 if (!l2data->data_len)
>                         bthost_add_l2cap_server(bthost, l2data->server_psm,
> -                                               NULL, NULL);
> +                                               NULL, NULL, NULL);
>         }
>
>         defer = (l2data->mode == BT_MODE_EXT_FLOWCTL);
> @@ -1927,6 +1974,10 @@ int main(int argc, char *argv[])
>                                         &client_connect_nval_psm_test_3,
>                                         setup_powered_client, test_connect);
>
> +       test_l2cap_bredr("L2CAP BR/EDR Client - Socket Shut WR Success",
> +                                       &client_connect_shut_wr_success_test,
> +                                       setup_powered_client, test_connect);
> +
>         test_l2cap_bredr("L2CAP BR/EDR Server - Success",
>                                         &l2cap_server_success_test,
>                                         setup_powered_server, test_server);
> diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
> index b20d70d58..2d3be27d8 100644
> --- a/tools/rfcomm-tester.c
> +++ b/tools/rfcomm-tester.c
> @@ -548,7 +548,7 @@ static void test_connect(const void *test_data)
>         GIOChannel *io;
>         int sk;
>
> -       bthost_add_l2cap_server(bthost, 0x0003, NULL, NULL);
> +       bthost_add_l2cap_server(bthost, 0x0003, NULL, NULL, NULL);
>         bthost_add_rfcomm_server(bthost, cli->server_channel,
>                                                 rfcomm_connect_cb, NULL);
>
> --
> 2.26.2.526.g744177e7f7-goog

Applied, thanks. Btw do you want me to apply the HID patch or do you
have an update to that?

-- 
Luiz Augusto von Dentz
