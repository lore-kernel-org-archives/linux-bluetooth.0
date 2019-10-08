Return-Path: <SRS0=DWZO=YB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BE9C10F14
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Oct 2019 10:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F262206BB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Oct 2019 10:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Drg1fMA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbfJHKYn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:24:43 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:38166 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729958AbfJHKYn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Oct 2019 06:24:43 -0400
Received: by mail-oi1-f177.google.com with SMTP id m16so14335366oic.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Oct 2019 03:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rl7INHwJCNyXE6b5ZEtYM1IZtskUcQIC/BTDcxQDTCQ=;
        b=Drg1fMA+bME2orN2rQpx+7OMYhQa8InXLIIgUXxOjJHeoD28kYmjPCF5acZfex51dj
         /acSIP1EtS6j3bfH4a1oQSLCj/sG5QjywMPrubmJ4VRMJ4EyqkR9mCJK2F5bMhrSvWbT
         upjwlMS0P+jk3Vq0B5WtDd9Xh1PF5UdnSsQKsGrbDR+F4oYOAx0xkRg2BWx4tiCXeKyA
         g5eNadBvA3LAbk0I9Rdg6E8WTTu2rFnIOlkBImxYOngDNrG+NPfDK41N/mFFWLELy5Fm
         ZyOcHtL38Htf9ugpBfFcdxxrkDvy9q6c9UGXHHN6u2pLjL0GRHy+YBjJzZwc9A8c8PCV
         2+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rl7INHwJCNyXE6b5ZEtYM1IZtskUcQIC/BTDcxQDTCQ=;
        b=kkXR+LRCSMx/jYSa2SxOVZjo9Hq8GFnpn8+hjPNwOtUMKUgD4njQ37rXaslqKpE/Jr
         mv6ahDzqfr+aVgIu3kiVE24XjkUICxbxfKNU2HN2la6iM1zFFLjYXhdQMJSDj5GcEejA
         JjcMm4NEfog4kZ4mmoIrRpH5Yku9IYjyP0vHCM11JSlPNnnh7eHUQoG0I/oUKxyh2s61
         zehznEnA/omf6iJaaT/mNYDr8p76A8yGQd22hsXICp8RexUtAjCms4iSORgwmjpHkUl5
         XdkdhvOgaku2UwKyHhHgn6QioQcpI2RBYZQl361Xbylx6MSt+OzeOXvl3JGbla40JmwC
         J4Ww==
X-Gm-Message-State: APjAAAX8JKc+NjaPZaRrPvVVuZJjPj+D/ZUo3WqC7F1AOYH3dK7Sdsra
        ya9S0tXn5FefQMMazfjJGfB4GO+HCDet32Q4+VkX/F1e
X-Google-Smtp-Source: APXvYqzruSHi9KJAgnwYSWogWmh+ZYzwZzclrgL053CCpaCUuBvDQATxvBa3eXmmoTwinhk3i1k7nid14chBaWMjFFY=
X-Received: by 2002:aca:1c03:: with SMTP id c3mr3081067oic.8.1570530281454;
 Tue, 08 Oct 2019 03:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ0=ZJ2rjxM0WmA72J5VCcUZ01q7dH+jxJi7btGzayZWHe7S1Q@mail.gmail.com>
In-Reply-To: <CAJ0=ZJ2rjxM0WmA72J5VCcUZ01q7dH+jxJi7btGzayZWHe7S1Q@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 8 Oct 2019 13:24:29 +0300
Message-ID: <CABBYNZ+DYrzhx3Riqt2SFV4ZoL5VHfOnVPH0ScHMRz=+XoBg6Q@mail.gmail.com>
Subject: Re: Bluez stopped connecting A2DP sink
To:     yayfortrees <yayfortrees@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Oct 7, 2019 at 10:34 PM yayfortrees <yayfortrees@gmail.com> wrote:
>
> Hello,
>
> I recently upgraded bluez to 5.51 from 5.50 and my headphones stopped
> using the A2DP sink during autoconnect. The headphones instead go to
> HSP/HFP mode and the A2DP sink is disabled in pavucontrol/pactl. The
> A2DP sink will only work when the device is initially paired.
>
> This had worked flawlessly for years. I was able to track down the
> regression to this patch:
> https://www.spinics.net/lists/linux-bluetooth/msg76180.html ([PATCH
> BlueZ] policy: Add logic to connect a Sink). If I apply the patch to
> 5.50, my headphones no longer connect to the A2DP sink, if I remove it
> the problem goes away.
>
> Not sure what else I should include to help track this down. The
> headphones I'm using are Beats Wireless (Solo Bluetooth).
>
> The only relevant log entry I see with the patch applied is:
> a2dp-sink profile connect failed for 34:DF:2A:0D:F8:C2: Device or resource busy

Can you collect the HCI traces of the problem using btmon? I didn't
expect that to cause any problems, it should in theory solve them but
lets see.

> Let me know if any other information is needed.
> Thanks.



-- 
Luiz Augusto von Dentz
