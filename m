Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDC2C63697
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 05:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB4720825
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 05:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JOnC/AKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbgKLFjZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Nov 2020 00:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbgKLDkq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 22:40:46 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD36C0613D6
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 19:40:46 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id cw8so5683482ejb.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 19:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=To4HRRrNmKhGAD42q3JjCijVTRpTZsZMj/gYSYhTv8o=;
        b=JOnC/AKQeiecbErbspMBd5TG4gY5qlzQbvgkFQaqwVtsBzSUgyWtA/zie2s8WC9r4X
         LTQeq4CJLWpvUm3fmBLfcweLZhpmgCOVFJDvtOW0ci3ul7mXtb2dHMAJv+Nlfch71AQ4
         C2mFphfFZ6e5+IQg80zo+5UzhtQReyUrV6MY6gf3bTBnksOovxmOsf/KAdXhVamEj2nW
         wUlhjXR9RVI5G0j+kWAvztSjDSVs0OAF0QZIJLz+8/wgwm5BesWlTuDCO6RxNq4w5QJJ
         gdTrYc3KncRdkDziH43LSMMwfLb7hgzwGf/uHrD+1bsjn6tSU/a7nobdkR2eJJqPX3nq
         3pAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=To4HRRrNmKhGAD42q3JjCijVTRpTZsZMj/gYSYhTv8o=;
        b=J8d9KVBcKLry7TaH9vQBdAqoW2BLkMIMmKenLAlZAOaZkcZEpSZOQDtGAbkEDNKPMd
         KhCGL9Om0aiUS/QAsGE6Hnlx0q9ghZsKdwWOpAO2v+WliwrXj3GVPjkR8jD3m7+FICfg
         RfWQ8cHZU02zZIK5BWKHxBSUo5u3l92oNRKhapG0i/ZMkiEdZj/HhEp+T0pkl7vo8LVb
         BzgjsZmLQD9e39Dt+Zj4PIWRYYiYiX3I09HEpY0iFrO8CCTRI5JLRW1ldI7bCuSGbnis
         r2rjp0FBt/pz5jJROFtbbDXFZkLsaTAeZY9Oorzp9SkiTQ7EMxzEwT7N59SuzKLJI/jo
         7+fg==
X-Gm-Message-State: AOAM531uqGRhpr0J7VHPIjF4HNgAYMWZ0cI2nstX3BZA6MCdo+JglZpt
        9lNPnwbY7580RYY3Tru4BldpQSgeBFrGK1/Y0sTwlA==
X-Google-Smtp-Source: ABdhPJxH578IOP98WEnA2WvJ0R9/4iiLYmyXLLUa5uv9EZPYNBJtM8ji4hq5Tlg2kUHwjL3VCysE5lECyDS3M52vZ0E=
X-Received: by 2002:a17:906:1a14:: with SMTP id i20mr29711499ejf.422.1605152444843;
 Wed, 11 Nov 2020 19:40:44 -0800 (PST)
MIME-Version: 1.0
References: <20201111150115.v9.1.I55fa38874edc240d726c1de6e82b2ce57b64f5eb@changeid>
 <20201111150115.v9.5.I9231b35b0be815c32c3a3ec48dcd1d68fa65daf4@changeid> <A5A4227D-58B7-4C08-AFC9-BC8A8D469179@holtmann.org>
In-Reply-To: <A5A4227D-58B7-4C08-AFC9-BC8A8D469179@holtmann.org>
From:   Yun-hao Chung <howardchung@google.com>
Date:   Thu, 12 Nov 2020 11:40:33 +0800
Message-ID: <CAPHZWUdoo_hh=8edYoHdFL8cn-Khz0JMi5QcF4QJjrP9c_zVnA@mail.gmail.com>
Subject: Re: [PATCH v9 5/6] Bluetooth: Refactor read default sys config for
 various types
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Nov 11, 2020 at 7:20 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Howard,
>
> > Refactor read default system configuration function so that it's capable
> > of returning different types than u16
> >
> > Signed-off-by: Howard Chung <howardchung@google.com>
> > ---
> >
> > (no changes since v8)
> >
> > Changes in v8:
> > - Update the commit title and message
> >
> > net/bluetooth/mgmt_config.c | 140 +++++++++++++++++++++---------------
> > 1 file changed, 84 insertions(+), 56 deletions(-)
> >
> > diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
> > index 2d3ad288c78ac..282fbf82f3192 100644
> > --- a/net/bluetooth/mgmt_config.c
> > +++ b/net/bluetooth/mgmt_config.c
> > @@ -11,72 +11,100 @@
> > #include "mgmt_util.h"
> > #include "mgmt_config.h"
> >
> > -#define HDEV_PARAM_U16(_param_code_, _param_name_) \
> > -{ \
> > -     { cpu_to_le16(_param_code_), sizeof(__u16) }, \
> > -     { cpu_to_le16(hdev->_param_name_) } \
> > -}
> > +#define HDEV_PARAM_U16(_param_name_) \
> > +     struct {\
> > +             struct mgmt_tlv entry; \
> > +             __le16 value; \
> > +     } __packed _param_name_
> >
> > -#define HDEV_PARAM_U16_JIFFIES_TO_MSECS(_param_code_, _param_name_) \
> > -{ \
> > -     { cpu_to_le16(_param_code_), sizeof(__u16) }, \
> > -     { cpu_to_le16(jiffies_to_msecs(hdev->_param_name_)) } \
> > -}
> > +#define TLV_SET_U16(_param_code_, _param_name_) \
> > +     { \
> > +             { cpu_to_le16(_param_code_), sizeof(__u16) }, \
> > +             cpu_to_le16(hdev->_param_name_) \
> > +     }
> > +
> > +#define TLV_SET_U16_JIFFIES_TO_MSECS(_param_code_, _param_name_) \
> > +     { \
> > +             { cpu_to_le16(_param_code_), sizeof(__u16) }, \
> > +             cpu_to_le16(jiffies_to_msecs(hdev->_param_name_)) \
> > +     }
> >
> > int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
> >                          u16 data_len)
> > {
> > -     struct {
> > -             struct mgmt_tlv entry;
> > -             union {
> > -                     /* This is a simplification for now since all values
> > -                      * are 16 bits.  In the future, this code may need
> > -                      * refactoring to account for variable length values
> > -                      * and properly calculate the required buffer size.
> > -                      */
> > -                     __le16 value;
> > -             };
> > -     } __packed params[] = {
> > +     int ret;
> > +     struct mgmt_rp_read_def_system_config {
> >               /* Please see mgmt-api.txt for documentation of these values */
> > -             HDEV_PARAM_U16(0x0000, def_page_scan_type),
> > -             HDEV_PARAM_U16(0x0001, def_page_scan_int),
> > -             HDEV_PARAM_U16(0x0002, def_page_scan_window),
> > -             HDEV_PARAM_U16(0x0003, def_inq_scan_type),
> > -             HDEV_PARAM_U16(0x0004, def_inq_scan_int),
> > -             HDEV_PARAM_U16(0x0005, def_inq_scan_window),
> > -             HDEV_PARAM_U16(0x0006, def_br_lsto),
> > -             HDEV_PARAM_U16(0x0007, def_page_timeout),
> > -             HDEV_PARAM_U16(0x0008, sniff_min_interval),
> > -             HDEV_PARAM_U16(0x0009, sniff_max_interval),
> > -             HDEV_PARAM_U16(0x000a, le_adv_min_interval),
> > -             HDEV_PARAM_U16(0x000b, le_adv_max_interval),
> > -             HDEV_PARAM_U16(0x000c, def_multi_adv_rotation_duration),
> > -             HDEV_PARAM_U16(0x000d, le_scan_interval),
> > -             HDEV_PARAM_U16(0x000e, le_scan_window),
> > -             HDEV_PARAM_U16(0x000f, le_scan_int_suspend),
> > -             HDEV_PARAM_U16(0x0010, le_scan_window_suspend),
> > -             HDEV_PARAM_U16(0x0011, le_scan_int_discovery),
> > -             HDEV_PARAM_U16(0x0012, le_scan_window_discovery),
> > -             HDEV_PARAM_U16(0x0013, le_scan_int_adv_monitor),
> > -             HDEV_PARAM_U16(0x0014, le_scan_window_adv_monitor),
> > -             HDEV_PARAM_U16(0x0015, le_scan_int_connect),
> > -             HDEV_PARAM_U16(0x0016, le_scan_window_connect),
> > -             HDEV_PARAM_U16(0x0017, le_conn_min_interval),
> > -             HDEV_PARAM_U16(0x0018, le_conn_max_interval),
> > -             HDEV_PARAM_U16(0x0019, le_conn_latency),
> > -             HDEV_PARAM_U16(0x001a, le_supv_timeout),
> > -             HDEV_PARAM_U16_JIFFIES_TO_MSECS(0x001b,
> > -                                             def_le_autoconnect_timeout),
> > -             HDEV_PARAM_U16(0x001d, advmon_allowlist_duration),
> > -             HDEV_PARAM_U16(0x001e, advmon_no_filter_duration),
> > +             HDEV_PARAM_U16(def_page_scan_type);
> > +             HDEV_PARAM_U16(def_page_scan_int);
> > +             HDEV_PARAM_U16(def_page_scan_window);
> > +             HDEV_PARAM_U16(def_inq_scan_type);
> > +             HDEV_PARAM_U16(def_inq_scan_int);
> > +             HDEV_PARAM_U16(def_inq_scan_window);
> > +             HDEV_PARAM_U16(def_br_lsto);
> > +             HDEV_PARAM_U16(def_page_timeout);
> > +             HDEV_PARAM_U16(sniff_min_interval);
> > +             HDEV_PARAM_U16(sniff_max_interval);
> > +             HDEV_PARAM_U16(le_adv_min_interval);
> > +             HDEV_PARAM_U16(le_adv_max_interval);
> > +             HDEV_PARAM_U16(def_multi_adv_rotation_duration);
> > +             HDEV_PARAM_U16(le_scan_interval);
> > +             HDEV_PARAM_U16(le_scan_window);
> > +             HDEV_PARAM_U16(le_scan_int_suspend);
> > +             HDEV_PARAM_U16(le_scan_window_suspend);
> > +             HDEV_PARAM_U16(le_scan_int_discovery);
> > +             HDEV_PARAM_U16(le_scan_window_discovery);
> > +             HDEV_PARAM_U16(le_scan_int_adv_monitor);
> > +             HDEV_PARAM_U16(le_scan_window_adv_monitor);
> > +             HDEV_PARAM_U16(le_scan_int_connect);
> > +             HDEV_PARAM_U16(le_scan_window_connect);
> > +             HDEV_PARAM_U16(le_conn_min_interval);
> > +             HDEV_PARAM_U16(le_conn_max_interval);
> > +             HDEV_PARAM_U16(le_conn_latency);
> > +             HDEV_PARAM_U16(le_supv_timeout);
> > +             HDEV_PARAM_U16(def_le_autoconnect_timeout);
> > +             HDEV_PARAM_U16(advmon_allowlist_duration);
> > +             HDEV_PARAM_U16(advmon_no_filter_duration);
> > +     } __packed rp = {
> > +             TLV_SET_U16(0x0000, def_page_scan_type),
> > +             TLV_SET_U16(0x0001, def_page_scan_int),
> > +             TLV_SET_U16(0x0002, def_page_scan_window),
> > +             TLV_SET_U16(0x0003, def_inq_scan_type),
> > +             TLV_SET_U16(0x0004, def_inq_scan_int),
> > +             TLV_SET_U16(0x0005, def_inq_scan_window),
> > +             TLV_SET_U16(0x0006, def_br_lsto),
> > +             TLV_SET_U16(0x0007, def_page_timeout),
> > +             TLV_SET_U16(0x0008, sniff_min_interval),
> > +             TLV_SET_U16(0x0009, sniff_max_interval),
> > +             TLV_SET_U16(0x000a, le_adv_min_interval),
> > +             TLV_SET_U16(0x000b, le_adv_max_interval),
> > +             TLV_SET_U16(0x000c, def_multi_adv_rotation_duration),
> > +             TLV_SET_U16(0x000d, le_scan_interval),
> > +             TLV_SET_U16(0x000e, le_scan_window),
> > +             TLV_SET_U16(0x000f, le_scan_int_suspend),
> > +             TLV_SET_U16(0x0010, le_scan_window_suspend),
> > +             TLV_SET_U16(0x0011, le_scan_int_discovery),
> > +             TLV_SET_U16(0x0012, le_scan_window_discovery),
> > +             TLV_SET_U16(0x0013, le_scan_int_adv_monitor),
> > +             TLV_SET_U16(0x0014, le_scan_window_adv_monitor),
> > +             TLV_SET_U16(0x0015, le_scan_int_connect),
> > +             TLV_SET_U16(0x0016, le_scan_window_connect),
> > +             TLV_SET_U16(0x0017, le_conn_min_interval),
> > +             TLV_SET_U16(0x0018, le_conn_max_interval),
> > +             TLV_SET_U16(0x0019, le_conn_latency),
> > +             TLV_SET_U16(0x001a, le_supv_timeout),
> > +             TLV_SET_U16_JIFFIES_TO_MSECS(0x001b,
> > +                                          def_le_autoconnect_timeout),
> > +             TLV_SET_U16(0x001d, advmon_allowlist_duration),
> > +             TLV_SET_U16(0x001e, advmon_no_filter_duration),
> >       };
> > -     struct mgmt_rp_read_def_system_config *rp = (void *)params;
> >
> >       bt_dev_dbg(hdev, "sock %p", sk);
> >
> > -     return mgmt_cmd_complete(sk, hdev->id,
> > -                              MGMT_OP_READ_DEF_SYSTEM_CONFIG,
> > -                              0, rp, sizeof(params));
> > +     ret = mgmt_cmd_complete(sk, hdev->id,
> > +                             MGMT_OP_READ_DEF_SYSTEM_CONFIG,
> > +                             0, &rp, sizeof(rp));
> > +     return ret;
> > }
> >
>
> frankly I would prefer if we do the re-factoring first and only then add new
> parameters.

Yes. This patch only does the refactor stuff and the next patch is the one that
adds the new parameter.

>
> While I am looking at this, I am also really confused about this
> JIFFIES_TO_MSEC business. We should actually not store anything in jiffies
> or use it in an API. Is there a good reason to keep storing things in
> jiffies internally?
>

I don't know about this, but it looks like it should be in a different
patch right?

> Regards
>
> Marcel
>
