Return-Path: <SRS0=2FZ9=CU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288CEC433E2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 12:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C902B20758
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 12:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mgs8WOra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgIKMv3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Sep 2020 08:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgIKMug (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Sep 2020 08:50:36 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90824C061795
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 05:50:35 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so11400584wrm.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 05:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9zpvoIknYzOcak/srr5UyAFlRBj0Vd0whcdZwIrzcFc=;
        b=Mgs8WOrammTSYbbtT4z5MyWKNphx+gqBJfNtCzwQEs8SKVKRxzk4AauhBD+sMuuD7X
         Fz26Pq8/7WahNMa8mO7G4N3qN+y7B0pquw+JWo7Brm9fFwGZDZAojkHLLd/nnyjYpECJ
         X1HBDg5xeoiwfApJY8YXsFDAOTO3bSZoMvJ8Sue41cGGOtsshiu24AdJ2FJwZ2gTQdzU
         1LX0m5R684S+MWj+McKRFpW3vQm/6U8vcudTJ+1gxAo9snd0ogbAowU3A1ibXRI9y+IR
         qWn+R6tcWlbwWgVMUXDXjXdD/VhxNIaQXass1Fqwt+32kwLsi9rg+RY8cumsdoBfDD37
         2n4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9zpvoIknYzOcak/srr5UyAFlRBj0Vd0whcdZwIrzcFc=;
        b=Sy7LnW+NnmAaaMoGFRCaeWHi4ms7eV6Ydr0lkzzPlOUm0tawNarFXrXGKbNBUsZjEk
         rx9tC8RvnSaDgCKrKNx5M4Wjb8NKJOGTBYQr69iXnlHOGEtlNrbHvLOlPvUByede5xiR
         gvWYbzog87ODFjU2Q0c49YHb1UY/B27v7D+TH6s/LbEG0AwzUjm5Uvoxaig7EULJ0c1C
         7anrh2KO0Pqo1O8saRsEyzpwxvBW2oi5pLiU81QRAXs03b5Qga5JzrtOoIztmhm/aI98
         pgTZwo/RvZbBdkwGpichHOrc+eAchjSeupu/1+wQOMuvdBtsTwrTWw1R67s1A+Y0ZPxT
         PUig==
X-Gm-Message-State: AOAM530FWw/FN+E+CwTSvalgZg/Oz9ecF0IKDn2hP7EYhSAFtgeP8Gf0
        lN/i3i2gAodO+mBEufSrXirCz3/9PVZNomGRrwKG8TWRjJ/WoA==
X-Google-Smtp-Source: ABdhPJw94WKu3PC0Ny+QNdJTsv1zKbw7tOaXQB1Y+KyCWa4OHaeGwGISe7g8foAhM4Th9911C/fRvwlh88AFXI8Y4Qk=
X-Received: by 2002:adf:8544:: with SMTP id 62mr1928192wrh.262.1599828633777;
 Fri, 11 Sep 2020 05:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200902125726.Bluez.v1.1.I732df55cd70d552fc48e87686fb53c3f8ccbefa5@changeid>
In-Reply-To: <20200902125726.Bluez.v1.1.I732df55cd70d552fc48e87686fb53c3f8ccbefa5@changeid>
From:   Archie Pusaka <apusaka@google.com>
Date:   Fri, 11 Sep 2020 20:50:22 +0800
Message-ID: <CAJQfnxEHOx9mipC=y6NbTpXmmsowqXVCFbVUA4RVN4ncuwWD8Q@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] avrcp: Add handler for GET_TOTAL_NUMBER_OF_ITEMS
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Yun-Hao Chung <howardchung@google.com>,
        Michael Sun <michaelfsun@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bluez maintainers,

Could you take another look at this patch?

Thanks,
Archie

On Wed, 2 Sep 2020 at 12:57, Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> According to the AVRCP spec, section 4.5, GetTotalNumberOfItems PDU
> is mandatory for TG supporting category 1 or 3.
>
> Reviewed-by: Yun-Hao Chung <howardchung@google.com>
> Reviewed-by: Michael Sun <michaelfsun@google.com>
> ---
>
>  profiles/audio/avrcp.c | 58 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 5d0256c52..6da73394f 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -79,6 +79,7 @@
>  #define AVRCP_STATUS_SUCCESS                   0x04
>  #define AVRCP_STATUS_UID_CHANGED               0x05
>  #define AVRCP_STATUS_DOES_NOT_EXIST            0x09
> +#define AVRCP_STATUS_INVALID_SCOPE             0x0a
>  #define AVRCP_STATUS_OUT_OF_BOUNDS             0x0b
>  #define AVRCP_STATUS_INVALID_PLAYER_ID         0x11
>  #define AVRCP_STATUS_PLAYER_NOT_BROWSABLE      0x12
> @@ -211,6 +212,12 @@ struct player_item {
>         char name[0];
>  } __attribute__ ((packed));
>
> +struct get_total_number_of_items_rsp {
> +       uint8_t status;
> +       uint16_t uid_counter;
> +       uint32_t num_items;
> +} __attribute__ ((packed));
> +
>  struct avrcp_server {
>         struct btd_adapter *adapter;
>         uint32_t tg_record_id;
> @@ -566,6 +573,9 @@ static void populate_default_features(void)
>
>         /* supports at least AVRCP 1.4 */
>         default_features[7] |= (1 << 2);
> +
> +       /* supports GetTotalNumberOfItems browsing command */
> +       default_features[8] |= (1 << 3);
>  }
>
>  static unsigned int attr_get_max_val(uint8_t attr)
> @@ -2048,10 +2058,56 @@ static void avrcp_handle_get_folder_items(struct avrcp *session,
>         case AVRCP_SCOPE_SEARCH:
>         case AVRCP_SCOPE_NOW_PLAYING:
>         default:
> +               status = AVRCP_STATUS_INVALID_SCOPE;
> +               goto failed;
> +       }
> +
> +       return;
> +
> +failed:
> +       pdu->params[0] = status;
> +       pdu->param_len = htons(1);
> +}
> +
> +static void avrcp_handle_media_player_list_num_items(struct avrcp *session,
> +                               struct avrcp_browsing_header *pdu)
> +{
> +       struct avrcp_player *player = target_get_player(session);
> +       struct get_total_number_of_items_rsp *rsp;
> +
> +       rsp = (void *)pdu->params;
> +       rsp->status = AVRCP_STATUS_SUCCESS;
> +       rsp->uid_counter = htons(player_get_uid_counter(player));
> +       rsp->num_items = htonl(g_slist_length(session->server->players));
> +       pdu->param_len = htons(sizeof(*rsp));
> +}
> +
> +static void avrcp_handle_get_total_number_of_items(struct avrcp *session,
> +                               struct avrcp_browsing_header *pdu,
> +                               uint8_t transaction)
> +{
> +       uint8_t scope;
> +       uint8_t status = AVRCP_STATUS_SUCCESS;
> +
> +       if (ntohs(pdu->param_len) != 1) {
>                 status = AVRCP_STATUS_INVALID_PARAM;
>                 goto failed;
>         }
>
> +       scope = pdu->params[0];
> +
> +       switch (scope) {
> +       case AVRCP_SCOPE_MEDIA_PLAYER_LIST:
> +               avrcp_handle_media_player_list_num_items(session, pdu);
> +               break;
> +       case AVRCP_SCOPE_MEDIA_PLAYER_VFS:
> +       case AVRCP_SCOPE_SEARCH:
> +       case AVRCP_SCOPE_NOW_PLAYING:
> +       default:
> +               status = AVRCP_STATUS_INVALID_SCOPE;
> +               goto failed;
> +       }
> +
>         return;
>
>  failed:
> @@ -2065,6 +2121,8 @@ static struct browsing_pdu_handler {
>                                                         uint8_t transaction);
>  } browsing_handlers[] = {
>                 { AVRCP_GET_FOLDER_ITEMS, avrcp_handle_get_folder_items },
> +               { AVRCP_GET_TOTAL_NUMBER_OF_ITEMS,
> +                               avrcp_handle_get_total_number_of_items },
>                 { },
>  };
>
> --
> 2.28.0.402.g5ffc5be6b7-goog
>
