Return-Path: <SRS0=2FZ9=CU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0C9C43461
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 15:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8626B2075A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Sep 2020 15:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfFDLjYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgIKPsX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgIKPnj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Sep 2020 11:43:39 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D40C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 08:43:39 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id g10so8685087otq.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 08:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XzDgWNnuKrqNaQUU+av4P/MQZuzcjuXvW2alEkzqcAM=;
        b=OfFDLjYVZq93cM8+BpkOhGQw1cPxXC81jWiU+/nucVDw3SCbOdqHuD/FLIDqL58ajM
         +SApiaXhKPmTlQjjZKNU3IaEjj3UxdXrhN4mDUlYiilGfFMWlIVfePin7V6fxtnALZSr
         EEgZKNLMEmFKHI4q9UtG9hyzNGMnUHF3Kpeo41PrPV5hbXc9sXdSm8iHMFFbMxVbXgdk
         KMNWNZiqHyVMjFO8lZQGeai5LyD5qjzLeGRQQE+P1HK3CH197mG38ZBzi8CUUxs0O62o
         V3zfmKZMmpONTiZPZPDwVNjK5VSw23ghalE0KwwG2nMJp2gXFv19KZXPvsh8pj5zarHM
         /lKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XzDgWNnuKrqNaQUU+av4P/MQZuzcjuXvW2alEkzqcAM=;
        b=fJVfcgBtOXjBw2o8OVhmf/dY0wFGKXkacbU/v2n3gdtWqVhnk6I5spAhJN5um82r78
         FtcVehsxpDgKrPVvlpLpSNm0Zl0cCTzumrm5PznWDxMBt3RF+/oko8enogGofOFJJ+/8
         h4ZEaUSXvY//PLuTOg4NSXFT1HgQL1GshEBEyyo0FVfZd0FL/E6toXTpRRb9QNN8UgmJ
         WrKqGWJoJYlfsWMOz+BPLpDRv/CO5L5xKLW954et1ZjTgZ2/Rbmxnbo7Og8SXMmPNW4u
         q25EyyTdaBq/5MQ2oE2DXRj6YxLQnj8usITx0bPvTflG9TywuHmuhg/VvTVkPuQyK4II
         RiOQ==
X-Gm-Message-State: AOAM530zohdwmjvBYnG+7zQmNUPYHvnS9sU5Hqyc82x9gYSlIhflDWQv
        rOzNHdQeDV8wZwGNM28+9VVUOzls1B819wW0Bms=
X-Google-Smtp-Source: ABdhPJwh6sVu9L6n9x7JEhC/Ei8IrRlZTQuLMXw1B6/hn7VvgDURleyxoc/J0+Zac2Bt0iI/AS2Vh5oVa1MOkNmfITw=
X-Received: by 2002:a9d:4695:: with SMTP id z21mr1573352ote.91.1599839018223;
 Fri, 11 Sep 2020 08:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200902125726.Bluez.v1.1.I732df55cd70d552fc48e87686fb53c3f8ccbefa5@changeid>
In-Reply-To: <20200902125726.Bluez.v1.1.I732df55cd70d552fc48e87686fb53c3f8ccbefa5@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 11 Sep 2020 08:43:27 -0700
Message-ID: <CABBYNZKtMFwYZFwzoO=G54YQJVMyyyJF45eaPM9pM4_5d9j-dA@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] avrcp: Add handler for GET_TOTAL_NUMBER_OF_ITEMS
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Yun-Hao Chung <howardchung@google.com>,
        Michael Sun <michaelfsun@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Tue, Sep 1, 2020 at 9:57 PM Archie Pusaka <apusaka@google.com> wrote:
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

Applied, thanks.

-- 
Luiz Augusto von Dentz
