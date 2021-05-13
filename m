Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AA6C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 12:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE8E2613F1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 12:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbhEMMYk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 May 2021 08:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhEMMYj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 May 2021 08:24:39 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E036C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 May 2021 05:23:29 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j10so38224422lfb.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 May 2021 05:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2LKJxl/HvET1wbQ6GbRvgDn71bn2IGDlKd0DuJYEYvc=;
        b=Vsk3+WbfPrIZJhxbwS0kdZxx7Ssup8j1BszpDOWosyB+4zkxkR3RMQ9vjvUdAVRkrc
         SUmBRs37/DL77/XxdlYpwu47LTNNxa3CqzuwzH4fjSnuQ7aO0X9PvT6o00yQV7Cth5oT
         eDt/2K3g+KceQSM+30NR+jfSIesNT8DrwktlHRhKc1czYIPFZ7mCkvpFAJwN4K7tCfmC
         QcHrySnQTmqVgTCKPmmKwRkXqIyGbLrB5MP00vNutVvfUjqqyTeHkv/bThyV4y0ITPnK
         i7uBXx3OjAqKXSsd4nB2qWi6yVYVy54yUKhSvlPbKeSbOwfSsBHG9wLAwxszZyx5NdX0
         RUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2LKJxl/HvET1wbQ6GbRvgDn71bn2IGDlKd0DuJYEYvc=;
        b=T1iUbYwen/W/yalNY9yiO0GdMCZxQUE47CWZS3NEOjGKnw/lw+2sxsCaQvEEQrInGH
         ggOdjsgzz5O9rlJWhPoHLKM8zijog0qit91F7OiOW9u4xiTVWOs6jgQH7fp30rUQceSF
         fh1Hhnwd//y+V9qWdMGEN2cNH0txKUzLI7348VTxrc+VIodTqbL7KeIqj6680kW1d1EZ
         uMqjOeCKPNEF2k6VBoinW8sn6088PrBGma0w3emuih6ulOoQE7aQoFEBwc1Ztj0AA+rE
         9+2jGLdpYnXetwZhd04AgBZCJbTHb/hhFIdS8Es93bIXOy9lZVJaHte54Q5F7bWNWLCc
         w/XQ==
X-Gm-Message-State: AOAM533ZV3mft8aGyq0I4EHJx0D0gKQUL3klMGzeqxamWOrE1ncs/bVD
        c1g4jVOM+zIMP/H5LkOxyzl1nRg8GdU0aQ==
X-Google-Smtp-Source: ABdhPJwzpJOhk6nDq6arEWej/OA4zpw4xzHHBvt2R6LDJLOjDt5tp6FSJgu69qIrcl7KD32eXo+3Vw==
X-Received: by 2002:a05:6512:3e7:: with SMTP id n7mr27999954lfq.150.1620908607577;
        Thu, 13 May 2021 05:23:27 -0700 (PDT)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id v10sm275392lfg.257.2021.05.13.05.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:23:27 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kai Krakow <kai@kaishome.de>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove spurious error message
Date:   Thu, 13 May 2021 14:23:26 +0200
Message-ID: <4628749.GXAFRqVoOG@ix>
Organization: CODECOUP
In-Reply-To: <YJz8hJ+9N24wrIsq@kroah.com>
References: <20210512133407.52330-1-szymon.janc@codecoup.pl> <4321662.LvFx2qVVIh@ix> <YJz8hJ+9N24wrIsq@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thursday, 13 May 2021 12:16:36 CEST Greg KH wrote:
> On Thu, May 13, 2021 at 10:09:49AM +0200, Szymon Janc wrote:
> > Hi,
> > 
> > On Wednesday, 12 May 2021 20:13:19 CEST Luiz Augusto von Dentz wrote:
> > > Hi Kai,
> > > 
> > > On Wed, May 12, 2021 at 11:06 AM Kai Krakow <kai@kaishome.de> wrote:
> > > > Hi Szymon!
> > > > 
> > > > Am Mi., 12. Mai 2021 um 15:34 Uhr schrieb Szymon Janc
> > 
> > <szymon.janc@codecoup.pl>:
> > > > > Even with rate limited reporting this is very spammy and since
> > > > > it is remote device that is providing bogus data there is no
> > > > > need to report this as error.
> > > > 
> > > > [...]
> > > > 
> > > > > [72464.546319] Bluetooth: hci0: advertising data len corrected
> > > > > [72464.857318] Bluetooth: hci0: advertising data len corrected
> > > > > [72465.163332] Bluetooth: hci0: advertising data len corrected
> > > > > [72465.278331] Bluetooth: hci0: advertising data len corrected
> > > > > [72465.432323] Bluetooth: hci0: advertising data len corrected
> > > > > [72465.891334] Bluetooth: hci0: advertising data len corrected
> > > > > [72466.045334] Bluetooth: hci0: advertising data len corrected
> > > > > [72466.197321] Bluetooth: hci0: advertising data len corrected
> > > > > [72466.340318] Bluetooth: hci0: advertising data len corrected
> > > > > [72466.498335] Bluetooth: hci0: advertising data len corrected
> > > > > [72469.803299] bt_err_ratelimited: 10 callbacks suppressed
> > > > > 
> > > > > Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
> > > > > Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=203753
> > > > > Cc: stable@vger.kernel.org
> > > > > ---
> > > > > 
> > > > >  net/bluetooth/hci_event.c | 2 --
> > > > >  1 file changed, 2 deletions(-)
> > > > > 
> > > > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > > > index 5e99968939ce..abdc44dc0b2f 100644
> > > > > --- a/net/bluetooth/hci_event.c
> > > > > +++ b/net/bluetooth/hci_event.c
> > > > > @@ -5476,8 +5476,6 @@ static void process_adv_report(struct hci_dev
> > > > > *hdev, u8 type, bdaddr_t *bdaddr,> >
> > > > > 
> > > > >         /* Adjust for actual length */
> > > > >         if (len != real_len) {
> > > > > 
> > > > > -               bt_dev_err_ratelimited(hdev, "advertising data len
> > > > > corrected %u -> %u", -                                      len,
> > > > > real_len);
> > > > > 
> > > > >                 len = real_len;
> > > > >         
> > > > >         }
> > > > 
> > > > This renders the "if" quite useless since it now always ensures len =
> > > > real_len and nothing else. At this point, the "if" can be removed, and
> > > > len can be set unconditionally. Depending on the further context of
> > > > the patch, destinction between real_len and len may not be needed at
> > > > all and real_len could be renamed to len, ditching the unused original
> > > > which is potentially bogus data anyways according to your commit
> > > > description.
> > > 
> > > That was introduced to truncate the len, the patch just removes the
> > > logging but it does keep this logic, if you want to understand the
> > > reason for it just use git blame and look at the history.
> > 
> > Actually, with no log there is no need for this "if" and real_len could be
> > indeed avoided.
> > 
> > But I'd change this is subsequent patch which would not be tagged as
> > stable
> > candidate. Thoughts?
> 
> Fix it properly, and worry about stable trees later, they can also
> always take the correct change as well.

Fair enough, V2 sent.

-- 
pozdrawiam
Szymon Janc


