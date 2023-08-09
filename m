Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E87C0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 19:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjHITwX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHITwW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 15:52:22 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4A2E3
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 12:52:21 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so3022401fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Aug 2023 12:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691610739; x=1692215539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NOejD0XytIBnJyLIfFs533F+V7TXaFsB11EHcwzAeY=;
        b=aOqONh5APAOXygqTANeKydN1+DSJ5ZTGZotB7hL0OXFyp810WpjdrrEoTOvssZqnKz
         fmlEgFryQ/UDwhwwP6lfCq1j5Z9yqIHuYODw6ZPz42ZM4H4EBy/0BV6zOQUMO91RFiMn
         +u9M6gliI73jLs6unctBVsK2u5SfugotauXsflz7Y0m7LngBJTlfsHVV04Xhs9wy/JpX
         0Gn4yWmt7qC64eE4JAWSjrQfB+G/3Y9prum7lPBSpOyQ3I9JcpvegoEDTbThHVYmAhbg
         7+tb708vEcKBzIv9yQQhPMxOq/nRVISFm0S7TnNpqTjIjzfOCtGIqF8g7EXyOOrVftHo
         seRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691610739; x=1692215539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NOejD0XytIBnJyLIfFs533F+V7TXaFsB11EHcwzAeY=;
        b=Ypaa81z3Ogyn7jghgXr82BW3WgY6j57k+p9YL3w9lSjhxa2DYItawu5stO1mPFRldI
         eJT6sZvKQDdwnHsqg7wYJv1+ORmHxlT2cNDWTpRBkgJ7gFAk3bBGkil1Bbeo9XXV1Eu8
         tENT+74zzc5en6PadbjpXErP5bIxwYQO+UO7kZt1jRo5gBuFA66fcObWQXJEIqpFhLNq
         v2wvYk4Zr6cMkFCIRAgoiuJQMB+PoqR+ZfDjCnXMXygekxDkEdq3HrZPjv6chMfNv+WT
         KQd/etlZ54/GyfB0IMR67QSXrG3uPb5Xe1EDCzfejCnCcIfc+MB9i6H8b3FwoCvcwZwN
         qDuA==
X-Gm-Message-State: AOJu0YxHkrNG9IXTi8m3eKmm40qoSJfzbbMWnffbO7nAjqIU0PfUnvLz
        ICN+OOcH2rPfixd+5udF1MTNgGoSZjXr0HgWHskVuheC
X-Google-Smtp-Source: AGHT+IFPpZ0uetYZNzI/7gm+ATjV/0t32NwSvBfFPwDGy7ygP6hb7s/0l9YjwsQRGcrX8xXu83fvLPYipGwR9N6UFAM=
X-Received: by 2002:a2e:80da:0:b0:2b9:e97a:c939 with SMTP id
 r26-20020a2e80da000000b002b9e97ac939mr133398ljg.42.1691610739350; Wed, 09 Aug
 2023 12:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <429cbc5a4fcdb150c62cf368c928e1174016eefb.1691606987.git.pav@iki.fi>
In-Reply-To: <429cbc5a4fcdb150c62cf368c928e1174016eefb.1691606987.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 9 Aug 2023 12:52:06 -0700
Message-ID: <CABBYNZ+_w5pk+H6pOtutfgUJZoEGrVJyh9qwDm0nEV4CE6hYEg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] adapter: wait for kernel exp features in adapter initialization
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Wed, Aug 9, 2023 at 12:14=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Things like BAP depend on ISO sockets being enabled in kernel.  It is
> possible the MGMT commands enabling experimental kernel features do not
> complete, before BAP etc. initialization and probing starts, in which
> case BAP will be mostly nonfunctional.
>
> This was observed to occur always when running BlueZ in a Fedora VM,
> requiring bluetoothd restart after every boot for BAP to work,
> log containing lines in the order:
>
> bluetoothd[981]: src/adapter.c:read_exp_features_complete() 6fbaf188-05e0=
-496a-9885-d6ddfdb4e03e flags 0 action 1
> bluetoothd[981]: src/adapter.c:read_info_complete() index 0 status 0x00
> bluetoothd[981]: profiles/audio/bap.c:bap_probe() BAP requires ISO Socket=
 which is not enabled
> bluetoothd[981]: src/adapter.c:iso_socket_complete() ISO Socket successfu=
lly set
>
> Fix by waiting in adapter initialization that all MGMT exp feature
> requests are done, before proceeding to read adapter information.
>
> Also fix canceling MGMT_OP_SET_EXP_FEATURE for ISO sockets.
> ---
>  src/adapter.c | 90 ++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 71 insertions(+), 19 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 004062e7c..608c06f9e 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -331,6 +331,8 @@ struct btd_adapter {
>
>         bool is_default;                /* true if adapter is default one=
 */
>
> +       unsigned int set_exp_iso_id;
> +       unsigned int exp_pending;

Lets use a struct queue to store these ids, since there could be more
than one pending and there could be more of these races with other
drivers.

>         struct queue *exps;
>  };
>
> @@ -5782,6 +5784,8 @@ static void adapter_free(gpointer user_data)
>         g_queue_free(adapter->auths);
>         queue_destroy(adapter->exps, NULL);
>
> +       adapter->exp_pending =3D 0;
> +
>         /*
>          * Unregister all handlers for this specific index since
>          * the adapter bound to them is no longer valid.
> @@ -5796,6 +5800,8 @@ static void adapter_free(gpointer user_data)
>          * since the adapter bound to them is no longer valid.
>          */
>         mgmt_cancel_index(adapter->mgmt, adapter->dev_id);
> +       if (adapter->set_exp_iso_id)
> +               mgmt_cancel(adapter->mgmt, adapter->set_exp_iso_id);
>
>         mgmt_unref(adapter->mgmt);
>
> @@ -6895,6 +6901,8 @@ static void adapter_remove(struct btd_adapter *adap=
ter)
>
>         g_slist_free(adapter->msd_callbacks);
>         adapter->msd_callbacks =3D NULL;
> +
> +       adapter->exp_pending =3D 0;
>  }
>
>  const char *adapter_get_path(struct btd_adapter *adapter)
> @@ -9824,6 +9832,8 @@ static bool set_blocked_keys(struct btd_adapter *ad=
apter)
>         .func =3D _func, \
>  }
>
> +static void exp_complete(void *user_data);
> +
>  static void set_exp_debug_complete(uint8_t status, uint16_t len,
>                                         const void *param, void *user_dat=
a)
>  {
> @@ -9854,8 +9864,10 @@ static void exp_debug_func(struct btd_adapter *ada=
pter, uint8_t action)
>
>         if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
>                         adapter->dev_id, sizeof(cp), &cp,
> -                       set_exp_debug_complete, adapter, NULL) > 0)
> +                       set_exp_debug_complete, adapter, exp_complete) > =
0) {
> +               ++adapter->exp_pending;
>                 return;
> +       }
>
>         btd_error(adapter->dev_id, "Failed to set exp debug");
>  }
> @@ -9904,8 +9916,11 @@ static void rpa_resolution_func(struct btd_adapter=
 *adapter, uint8_t action)
>
>         if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
>                         adapter->dev_id, sizeof(cp), &cp,
> -                       set_rpa_resolution_complete, adapter, NULL) > 0)
> +                       set_rpa_resolution_complete, adapter,
> +                       exp_complete) > 0) {
> +               ++adapter->exp_pending;
>                 return;
> +       }
>
>         btd_error(adapter->dev_id, "Failed to set RPA Resolution");
>  }
> @@ -9940,12 +9955,22 @@ static void codec_offload_func(struct btd_adapter=
 *adapter, uint8_t action)
>
>         if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
>                         adapter->dev_id, sizeof(cp), &cp,
> -                       codec_offload_complete, adapter, NULL) > 0)
> +                       codec_offload_complete, adapter, exp_complete) > =
0) {
> +               ++adapter->exp_pending;
>                 return;
> +       }
>
>         btd_error(adapter->dev_id, "Failed to set Codec Offload");
>  }
>
> +static void iso_socket_done(void *user_data)
> +{
> +       struct btd_adapter *adapter =3D user_data;
> +
> +       adapter->set_exp_iso_id =3D 0;
> +       exp_complete(adapter);
> +}
> +
>  static void iso_socket_complete(uint8_t status, uint16_t len,
>                                 const void *param, void *user_data)
>  {
> @@ -9969,15 +9994,20 @@ static void iso_socket_complete(uint8_t status, u=
int16_t len,
>  static void iso_socket_func(struct btd_adapter *adapter, uint8_t action)
>  {
>         struct mgmt_cp_set_exp_feature cp;
> +       unsigned int id;
>
>         memset(&cp, 0, sizeof(cp));
>         memcpy(cp.uuid, iso_socket_uuid.val, 16);
>         cp.action =3D action;
>
> -       if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
> -                       MGMT_INDEX_NONE, sizeof(cp), &cp,
> -                       iso_socket_complete, adapter, NULL) > 0)
> +       id =3D mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE, MGMT_IND=
EX_NONE,
> +                       sizeof(cp), &cp, iso_socket_complete, adapter,
> +                       iso_socket_done);
> +       if (id > 0) {
> +               adapter->set_exp_iso_id =3D id;
> +               ++adapter->exp_pending;
>                 return;
> +       }
>
>         btd_error(adapter->dev_id, "Failed to set ISO Socket");
>  }
> @@ -10063,8 +10093,10 @@ static void read_exp_features(struct btd_adapter=
 *adapter)
>  {
>         if (mgmt_send(adapter->mgmt, MGMT_OP_READ_EXP_FEATURES_INFO,
>                         adapter->dev_id, 0, NULL, read_exp_features_compl=
ete,
> -                       adapter, NULL) > 0)
> +                       adapter, exp_complete) > 0) {
> +               ++adapter->exp_pending;
>                 return;
> +       }
>
>         btd_error(adapter->dev_id, "Failed to read exp features info");
>  }
> @@ -10389,6 +10421,36 @@ static void reset_adv_monitors(uint16_t index)
>         error("Failed to reset Adv Monitors");
>  }
>
> +static void read_info(struct btd_adapter *adapter)
> +{
> +       DBG("sending read info command for index %u", adapter->dev_id);
> +
> +       if (mgmt_send(mgmt_primary, MGMT_OP_READ_INFO, adapter->dev_id, 0=
, NULL,
> +                                       read_info_complete, adapter, NULL=
) > 0)
> +               return;
> +
> +       btd_error(adapter->dev_id,
> +                       "Failed to read controller info for index %u",
> +                       adapter->dev_id);
> +
> +       adapter_list =3D g_list_remove(adapter_list, adapter);
> +
> +       btd_adapter_unref(adapter);
> +}
> +
> +static void exp_complete(void *user_data)
> +{
> +       struct btd_adapter *adapter =3D user_data;
> +
> +       adapter->exp_pending--;
> +
> +       DBG("index %u has %u pending MGMT EXP requests", adapter->dev_id,
> +                                                       adapter->exp_pend=
ing);
> +
> +       if (!adapter->exp_pending)
> +               read_info(adapter);
> +}
> +
>  static void index_added(uint16_t index, uint16_t length, const void *par=
am,
>                                                         void *user_data)
>  {
> @@ -10435,18 +10497,8 @@ static void index_added(uint16_t index, uint16_t=
 length, const void *param,
>          */
>         adapter_list =3D g_list_append(adapter_list, adapter);
>
> -       DBG("sending read info command for index %u", index);
> -
> -       if (mgmt_send(mgmt_primary, MGMT_OP_READ_INFO, index, 0, NULL,
> -                                       read_info_complete, adapter, NULL=
) > 0)
> -               return;
> -
> -       btd_error(adapter->dev_id,
> -                       "Failed to read controller info for index %u", in=
dex);
> -
> -       adapter_list =3D g_list_remove(adapter_list, adapter);
> -
> -       btd_adapter_unref(adapter);
> +       if (!adapter->exp_pending)
> +               read_info(adapter);
>  }
>
>  static void index_removed(uint16_t index, uint16_t length, const void *p=
aram,
> --
> 2.41.0
>


--=20
Luiz Augusto von Dentz
