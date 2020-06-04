Return-Path: <SRS0=9nD+=7R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAE7C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jun 2020 21:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B1E0206C3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jun 2020 21:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoNCW01K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgFDV0Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jun 2020 17:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgFDV0X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jun 2020 17:26:23 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDFEC08C5C0
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2020 14:26:22 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id q188so1538933ooq.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2020 14:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GwJEgzKXnIoM0ZhICPXeidYUgLgqF7aYeFNAxGWuXJY=;
        b=VoNCW01KujgQynoqWMImLWIi6sMAn/FuqZuyqANQUAeNddKAPljyQjmk+4winxket0
         NdSloR51yiyhODrCYepw7o6R7kgwV2f78TLaHDd5Jk1LU5Zevhb7durZfcgKPMaIueXC
         frMaXFhCLVGH43nxyguwWpHA7/X53GYRnSZjmWwn5vco3YCXwGJvDfKGGjSfhoLZoFl9
         CvOMWSULBqBZM8wEI8wS3igJ6WnyCqC2QP0qqa1rdSkr1mlgAjSDyio9+0+/DV1aRNdq
         7vtkJJXGuso8EIApu9kbLM4LIo1R1J6ndssA88MOOQbgAQ6Jn4e9qpqYOoBYrTpkZ2iO
         /LYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GwJEgzKXnIoM0ZhICPXeidYUgLgqF7aYeFNAxGWuXJY=;
        b=S89fpzQFeYa8YvsptL7TpYh+xE0EIWU8Qxti79L3iGQFbTX6tBYvEYmbMzsTvEcdOw
         tc01JfQTi2czHaonc9LJ7v7TyYAu3f0hZ5J7itvveElvOQAPXAv4Psdwq8+5Br9GVJ2A
         O2BRCbRKGUk8ZjpTeVzra732+HGmDPWmaYuAZIZyH/ezMRDM7DDVoohKgUpPqO7aQO1k
         pdJ/yKfKTjMpw/knoehX3hlLTR9MBjFVol+GUR11id06tHzIKNF7YnCE5/XAWbysOPS3
         yTCKX9s1pZF5fAp8aWGOotnUI7Faxdr4/DkZbW/4Uey4snsftz783cwzPxHap1ASeOMa
         EPkQ==
X-Gm-Message-State: AOAM532GcxHkPBmFyzOuID+kXPWHmx7U40ZA4rJdPbIkCsAx1hGO1R3q
        osx9yu3PwW/J5EJOHjx+fRfOzWRv83b2y3/4JoQ=
X-Google-Smtp-Source: ABdhPJzr1DP13Vq9Oxt12bVdAhE92JYgHsfoFbhuiV5zkWfPFndrkvmC+oM4MMTy0UFZgu9xG/QZ3noPmYnMWmRB6Y0=
X-Received: by 2002:a4a:3811:: with SMTP id c17mr5170710ooa.91.1591305981719;
 Thu, 04 Jun 2020 14:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200529133023.Bluez.v3.1.I804fb280949e4ce5cd9d0fce544a6f1a0592d11b@changeid>
In-Reply-To: <20200529133023.Bluez.v3.1.I804fb280949e4ce5cd9d0fce544a6f1a0592d11b@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 4 Jun 2020 14:26:10 -0700
Message-ID: <CABBYNZKemz-L+xSWygEBmqnW9LQPqMvfXXgi2HjYgZA0YONFuw@mail.gmail.com>
Subject: Re: [Bluez PATCH v3] audio/avrcp: Fix media player passthrough bitmask
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Michael Sun <michaelfsun@google.com>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Thu, May 28, 2020 at 10:31 PM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> Adjust the values of the passthrough bitmask with the declared
> keys in avctp.c:key_map, according to section 6.10.2.1 of the
> AVRCP specification.
>
> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> ---
>
> Changes in v3:
> - Use table to map the passthrough bitmask instead of hardcoding
>
> Changes in v2:
> - Fix the mix-up between the first 4 and the last 4 bits of each
> octet
>
>  profiles/audio/avctp.c | 11 +++++
>  profiles/audio/avctp.h | 11 +++++
>  profiles/audio/avrcp.c | 93 ++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 108 insertions(+), 7 deletions(-)
>
> diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
> index 058b44a8b..7307eaa9e 100644
> --- a/profiles/audio/avctp.c
> +++ b/profiles/audio/avctp.c
> @@ -2222,3 +2222,14 @@ bool avctp_is_initiator(struct avctp *session)
>  {
>         return session->initiator;
>  }
> +
> +bool avctp_supports_avc(uint8_t avc)
> +{
> +       int i;
> +
> +       for (i = 0; key_map[i].name != NULL; i++) {
> +               if (key_map[i].avc == avc)
> +                       return true;
> +       }
> +       return false;
> +}
> diff --git a/profiles/audio/avctp.h b/profiles/audio/avctp.h
> index 68a273561..c3cd49d88 100644
> --- a/profiles/audio/avctp.h
> +++ b/profiles/audio/avctp.h
> @@ -54,7 +54,12 @@
>  #define AVC_DOWN                       0x02
>  #define AVC_LEFT                       0x03
>  #define AVC_RIGHT                      0x04
> +#define AVC_RIGHT_UP                   0x05
> +#define AVC_RIGHT_DOWN                 0x06
> +#define AVC_LEFT_UP                    0x07
> +#define AVC_LEFT_DOWN                  0x08
>  #define AVC_ROOT_MENU                  0x09
> +#define AVC_SETUP_MENU                 0x0a
>  #define AVC_CONTENTS_MENU              0x0b
>  #define AVC_FAVORITE_MENU              0x0c
>  #define AVC_EXIT                       0x0d
> @@ -72,9 +77,11 @@
>  #define AVC_9                          0x29
>  #define AVC_DOT                                0x2a
>  #define AVC_ENTER                      0x2b
> +#define AVC_CLEAR                      0x2c
>  #define AVC_CHANNEL_UP                 0x30
>  #define AVC_CHANNEL_DOWN               0x31
>  #define AVC_CHANNEL_PREVIOUS           0x32
> +#define AVC_SOUND_SELECT               0x33
>  #define AVC_INPUT_SELECT               0x34
>  #define AVC_INFO                       0x35
>  #define AVC_HELP                       0x36
> @@ -95,6 +102,8 @@
>  #define AVC_FORWARD                    0x4b
>  #define AVC_BACKWARD                   0x4c
>  #define AVC_LIST                       0x4d
> +#define AVC_ANGLE                      0x50
> +#define AVC_SUBPICTURE                 0x51
>  #define AVC_F1                         0x71
>  #define AVC_F2                         0x72
>  #define AVC_F3                         0x73
> @@ -108,6 +117,7 @@
>  #define AVC_GREEN                      0x7b
>  #define AVC_BLUE                       0x7c
>  #define AVC_YELLOW                     0x7c
> +#define AVC_VENDOR_UNIQUE              0x7e
>
>  struct avctp;
>
> @@ -183,3 +193,4 @@ int avctp_send_vendordep_req(struct avctp *session, uint8_t code,
>  int avctp_send_browsing_req(struct avctp *session,
>                                 uint8_t *operands, size_t operand_count,
>                                 avctp_browsing_rsp_cb func, void *user_data);
> +bool avctp_supports_avc(uint8_t avc);
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 773ccdb60..fa97a3a89 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -293,15 +293,75 @@ struct control_pdu_handler {
>                                                         uint8_t transaction);
>  };
>
> +static struct {
> +       uint8_t feature_bit;
> +       uint8_t avc;
> +} passthrough_map[] = {
> +       { 0, AVC_SELECT },
> +       { 1, AVC_UP },
> +       { 2, AVC_DOWN },
> +       { 3, AVC_LEFT },
> +       { 4, AVC_RIGHT },
> +       { 5, AVC_RIGHT_UP },
> +       { 6, AVC_RIGHT_DOWN },
> +       { 7, AVC_LEFT_UP },
> +       { 8, AVC_LEFT_DOWN },
> +       { 9, AVC_ROOT_MENU },
> +       { 10, AVC_SETUP_MENU },
> +       { 11, AVC_CONTENTS_MENU },
> +       { 12, AVC_FAVORITE_MENU },
> +       { 13, AVC_EXIT },
> +       { 14, AVC_0 },
> +       { 15, AVC_1 },
> +       { 16, AVC_2 },
> +       { 17, AVC_3 },
> +       { 18, AVC_4 },
> +       { 19, AVC_5 },
> +       { 20, AVC_6 },
> +       { 21, AVC_7 },
> +       { 22, AVC_8 },
> +       { 23, AVC_9 },
> +       { 24, AVC_DOT },
> +       { 25, AVC_ENTER },
> +       { 26, AVC_CLEAR },
> +       { 27, AVC_CHANNEL_UP },
> +       { 28, AVC_CHANNEL_DOWN },
> +       { 29, AVC_CHANNEL_PREVIOUS },
> +       { 30, AVC_SOUND_SELECT },
> +       { 31, AVC_INPUT_SELECT },
> +       { 32, AVC_INFO },
> +       { 33, AVC_HELP },
> +       { 34, AVC_PAGE_UP },
> +       { 35, AVC_PAGE_DOWN },
> +       { 36, AVC_POWER },
> +       { 37, AVC_VOLUME_UP },
> +       { 38, AVC_VOLUME_DOWN },
> +       { 39, AVC_MUTE },
> +       { 40, AVC_PLAY },
> +       { 41, AVC_STOP },
> +       { 42, AVC_PAUSE },
> +       { 43, AVC_RECORD },
> +       { 44, AVC_REWIND },
> +       { 45, AVC_FAST_FORWARD },
> +       { 46, AVC_EJECT },
> +       { 47, AVC_FORWARD },
> +       { 48, AVC_BACKWARD },
> +       { 49, AVC_ANGLE },
> +       { 50, AVC_SUBPICTURE },
> +       { 51, AVC_F1 },
> +       { 52, AVC_F2 },
> +       { 53, AVC_F3 },
> +       { 54, AVC_F4 },
> +       { 55, AVC_F5 },
> +       { 56, AVC_VENDOR_UNIQUE },
> +       { 0xff, 0xff }
> +};
> +
>  static GSList *servers = NULL;
>  static unsigned int avctp_id = 0;
>
> -/* Default feature bit mask for media player as per avctp.c:key_map */
> -static const uint8_t features[16] = {
> -                               0xF8, 0xBF, 0xFF, 0xBF, 0x1F,
> -                               0xFB, 0x3F, 0x60, 0x00, 0x00,
> -                               0x00, 0x00, 0x00, 0x00, 0x00,
> -                               0x00 };
> +/* Default feature bit mask for media player */
> +static uint8_t default_features[16];
>
>  /* Company IDs supported by this device */
>  static uint32_t company_ids[] = {
> @@ -490,6 +550,22 @@ static sdp_record_t *avrcp_tg_record(void)
>         return record;
>  }
>
> +static void populate_default_features(void)
> +{
> +       int i;
> +
> +       for (i = 0; passthrough_map[i].feature_bit != 0xff; i++) {
> +               if (avctp_supports_avc(passthrough_map[i].avc)) {
> +                       uint8_t bit = passthrough_map[i].feature_bit;
> +
> +                       default_features[bit >> 3] |= (1 << (bit & 7));
> +               }
> +       }
> +
> +       /* supports at least AVRCP 1.4 */
> +       default_features[7] |= (1 << 2);
> +}
> +
>  static unsigned int attr_get_max_val(uint8_t attr)
>  {
>         switch (attr) {
> @@ -1913,7 +1989,8 @@ static void avrcp_handle_media_player_list(struct avrcp *session,
>                 item->subtype = htonl(0x01); /* Audio Book */
>                 item->status = player_get_status(player);
>                 /* Assign Default Feature Bit Mask */
> -               memcpy(&item->features, &features, sizeof(features));
> +               memcpy(&item->features, &default_features,
> +                                       sizeof(default_features));
>
>                 item->charset = htons(AVRCP_CHARSET_UTF8);
>
> @@ -4578,6 +4655,8 @@ static int avrcp_init(void)
>         btd_profile_register(&avrcp_controller_profile);
>         btd_profile_register(&avrcp_target_profile);
>
> +       populate_default_features();
> +
>         return 0;
>  }
>
> --
> 2.27.0.rc2.251.g90737beb825-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz
