Return-Path: <SRS0=vizm=TY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAAAC072B5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 May 2019 08:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F217C217D7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 May 2019 08:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCVOgfw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389564AbfEXIuq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 May 2019 04:50:46 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33856 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389404AbfEXIuq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 May 2019 04:50:46 -0400
Received: by mail-ot1-f66.google.com with SMTP id l17so8040805otq.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2019 01:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RJpR1mxo5cebU2uRMBBrX5t5Sv7Wcp7SpQPheFLmlug=;
        b=ZCVOgfw8nRwKn3/aXxVYauMgdzeowfeEQKc0RsLjV3WPrsvY/dc+1283EIovd6ZnNY
         OaKcWPWI8zAM3jtA/3jjWUroWxjR6HEGKAyZQA0XUSeD8O+cxyXExx0R6txXek2l+Lk3
         Jk3edqu9KV58miB1D9y9q/a9BJgg7PAKAyMbEoM2cx8C/LWrU/TCbmXPR3RtkmoS749q
         xGa5IsobWuxhX6kWJ5fQASgr0YAfgqg29qb/8f4MCN61wR99j1umC6GkLvdOmnenJbja
         7Lg3QatWTN0IL2yDo/60xlhrWWi6nD1Q0EEsQR2qeJJWiienzgchG9PtyFgu9gfZPAyq
         zOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJpR1mxo5cebU2uRMBBrX5t5Sv7Wcp7SpQPheFLmlug=;
        b=oBdFnc3BwOH4Y4y7mJvKDIwskFrm8ubRPRsTgauWjCCdxDbhWTKi3ool3YT2nSkRRo
         FMFUgdqZop/UCJJ+j1z52GV/VOY8W+Iouobs3SWLWoF5d4Yc3T6q3+5IYWvG/O4WaLLT
         4XJr3RVC5qXpM0ncswfop8c344WHH9MAyrCdye9REwofJOz7S5Eg9YPkr0PQOAY+eHCH
         1XcOf1VmwP5bknPzfcI2ArJHBnole43t32GoyHmklZMp/Fmx/TsiQIxSrxs7vewCEuQW
         yl0rPfubt3edwNIXWMOaO6UNPzF5Zcw8Q+u5o/tXJzweTf+dSiZPGr1UStgNKvGx91J6
         8Vkw==
X-Gm-Message-State: APjAAAXAGWZwoy6+jvj/SfAR8jr/kUufQvcq7yf+r6Lt4LKC01cnAgxf
        F2qDwrYNrk4qcO6pWc9Ro90VOj72eJSDDFex26vaClK0Zxg=
X-Google-Smtp-Source: APXvYqwnbvO4rvbtli3mVBduyyX7xfmzo3tkob9FVEPnQctNXiGzo3+otVE/Bjt3FPRSFQ669UEwO2T5Ylgi3Z7KV4k=
X-Received: by 2002:a9d:6a15:: with SMTP id g21mr71362otn.28.1558687845279;
 Fri, 24 May 2019 01:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190522092403.20927-1-szymon.janc@codecoup.pl>
In-Reply-To: <20190522092403.20927-1-szymon.janc@codecoup.pl>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 24 May 2019 11:50:32 +0300
Message-ID: <CABBYNZ+goH92rT8VOVfSXk-itP8HWbNFENuUcghiRjbyR0egGA@mail.gmail.com>
Subject: Re: [PATCH 1/3] monitor: Decode LE Periodic Advertising Sync
 Established Event
To:     Szymon Janc <szymon.janc@codecoup.pl>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Szymon,

On Wed, May 22, 2019 at 12:26 PM Szymon Janc <szymon.janc@codecoup.pl> wrote:
>
> > HCI Event: LE Meta Event (0x3e) plen 16                                                                                                                                                             #976 [hci1] 607.133703
>       LE Periodic Advertising Sync Established (0x0e)
>         Status: Success (0x00)
>         Sync handle: 0
>         Advertising SID: 0x06
>         Advertiser address type: Random (0x01)
>         Advertiser address: FF:00:00:00:00:AA (Static)
>         Advertiser PHY: LE 1M (0x01)
>         Periodic advertising invteral: 50.00 msec (0x0028)
>         Advertiser clock accuracy: 0x04
> ---
>  monitor/bt.h     | 12 ++++++++++++
>  monitor/packet.c | 21 ++++++++++++++++++++-
>  2 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/monitor/bt.h b/monitor/bt.h
> index d32d3a153..6494c928f 100644
> --- a/monitor/bt.h
> +++ b/monitor/bt.h
> @@ -3091,6 +3091,18 @@ struct bt_hci_le_ext_adv_report {
>         uint8_t  data[0];
>  } __attribute__ ((packed));
>
> +#define BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED     0x0e
> +struct bt_hci_evt_le_per_sync_established {
> +       uint8_t  status;
> +       uint16_t handle;
> +       uint8_t  sid;
> +       uint8_t  addr_type;
> +       uint8_t  addr[6];
> +       uint8_t  phy;
> +       uint16_t interval;
> +       uint8_t  clock_accuracy;
> +} __attribute__ ((packed));
> +
>  #define BT_HCI_EVT_LE_ADV_SET_TERM             0x12
>  struct bt_hci_evt_le_adv_set_term {
>         uint8_t  status;
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 30d432316..3235ad004 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -9613,6 +9613,24 @@ static void le_ext_adv_report_evt(const void *data, uint8_t size)
>         }
>  }
>
> +static void le_per_adv_sync(const void *data, uint8_t size)
> +{
> +       const struct bt_hci_evt_le_per_sync_established *evt = data;
> +
> +       print_status(evt->status);
> +       print_field("Sync handle: %d", evt->handle);
> +       if (evt->sid > 0x0f)
> +               print_field("Advertising SID: Reserved (0x%2.2x)", evt->sid);
> +       else
> +               print_field("Advertising SID: 0x%2.2x", evt->sid);
> +
> +       print_peer_addr_type("Advertiser address type", evt->addr_type);
> +       print_addr("Advertiser address", evt->addr, evt->addr_type);
> +       print_le_phy("Advertiser PHY", evt->phy);
> +       print_slot_125("Periodic advertising invteral", evt->interval);
> +       print_field("Advertiser clock accuracy: 0x%2.2x", evt->clock_accuracy);
> +}
> +
>  static void le_adv_set_term_evt(const void *data, uint8_t size)
>  {
>         const struct bt_hci_evt_le_adv_set_term *evt = data;
> @@ -9726,7 +9744,8 @@ static const struct subevent_data le_meta_event_table[] = {
>                                 le_phy_update_complete_evt, 5, true},
>         { 0x0d, "LE Extended Advertising Report",
>                                 le_ext_adv_report_evt, 1, false},
> -       { 0x0e, "LE Periodic Advertising Sync Established" },
> +       { 0x0e, "LE Periodic Advertising Sync Established",
> +                               le_per_adv_sync, 15, true },
>         { 0x0f, "LE Periodic Advertising Report" },
>         { 0x10, "LE Periodic Advertising Sync Lost" },
>         { 0x11, "LE Scan Timeout" },
> --
> 2.20.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
