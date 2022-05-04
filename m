Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE2BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 May 2022 21:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378503AbiEDVNd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 May 2022 17:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbiEDVNc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 May 2022 17:13:32 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EB04F9CE
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 14:09:55 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id i188-20020a636dc5000000b003c143f97bc2so1250057pgc.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 May 2022 14:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=oItEKj1b8hRoSj+evTl/1i3LqgkEyIfpmXzFkcTI5XE=;
        b=lsoJakvRGlMU+NfxFavfHmfBE+mQbla+vv3HQcrlyAzi1ohUeDazGcv+1k/TNTUX68
         IJHvNVYfLdorORjM60z0yf1WfSCDGC8iu3YtFTc3Dym4d6KUEE5fbzV78hqKUh8tObkI
         hSHwzAznXbRiV0TzMiVwxhxhV6DYzJPw4VeTWsxnYlTncsecKiUs0R4rPYgszSqnmPFf
         p0OKvG6608HtUXMcTWgF5KyDBR+yhVSYfLN9Exhc54Suxpu5LC1JFgnxaJajzkKH2MXY
         EseydC+2Cl9M8KrBsbQLWSJXe94QaqZjhOurdUz8F3GwIOenuCWomZXPhWXdMvTBoTE7
         82TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=oItEKj1b8hRoSj+evTl/1i3LqgkEyIfpmXzFkcTI5XE=;
        b=DXw2hCfQqRfBoqtjonRY5Dfdmx48y7KE453p+M5n7n14LdTQeGHynjekpLuK4owv8M
         HEcmLdMdb7swQe6D1eWS8mr3ffSI1NIIw3+oISVuZzESpNT2d+VqW9LRN4ap4N3U8Tku
         V5a79xJdZX/hQ7MSIQOpDMDuajsnRarJCudjGj6szn0BRNVyD0TcViy+qJkEjzNF5Jp8
         128TIqNQ2uYKlesLbOL2Xr30UscxKI+JpmI6kEkSqHQwazAEZHSmwAt8Fjhh47A5OEAU
         ARcp28GwhSkUjYuiTMYsMSrvjnvpU9TD3BCor5gU/0mIPA6y3cTPEe/qbzb5wRaRJjx6
         cQLA==
X-Gm-Message-State: AOAM531apAyHtXMs1xc67QEorz6LVx47lGu5qKlaHO+1ZxJhQ3eUT+gg
        W85Kw+rovlTyz1wpEiK5y20bdrS7Utu/5OXMelP5XzkxcWYyRif3zHNlMRdm+oqk5zsrGftwnh0
        zgPMgAfXSoICbk86GNQCkRZq1woQ1r0eKnKReN3Vt7wnOfTulMbsiZOLeYzG6cW8RLg85tRnhtj
        sO
X-Google-Smtp-Source: ABdhPJx1JVm05U0/gWJ8kkBMVi/oyAWbQ5BPXflczzjZX9Tz+9cgQ6W5omYiCMJgYcJRs3Zc/5s57InkY2W+
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:902:c94d:b0:15e:ba3e:c4d3 with SMTP id
 i13-20020a170902c94d00b0015eba3ec4d3mr8852281pla.121.1651698595247; Wed, 04
 May 2022 14:09:55 -0700 (PDT)
Date:   Wed,  4 May 2022 14:09:45 -0700
Message-Id: <20220504210948.2968827-1-jiangzp@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [Bluez PATCH v3 0/3] Adding bonded flag to D-Bus property
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently BlueZ client can't know easily whether a device is bonded or
not. This is causing issues for a number of applications. For example,
in the Nearby Share case, the peer device is paired, but not bonded.
This series will add the "Bonded" property in org.bluez.Device1 D-Bus
interface. Changes are also made in bluetoothctl to show the status of
the bonded flag as well as a list of bonded devices.

Changes in v3:
- Move documentation update to a separate patch
- Add description to bonded and paired
- Add an optional argument to the devices command to filter device list
- Remove paired-devices command

Changes in v2:
- Move one variable declaration to the top following C90 standard

Changes in v1:
- Add "Bonded" to D-Bus interface
- Send property changed signal if the bonded flag is changed
- Show the status of the "Bonded" flag in bluetoothctl
- Add option to show list of bonded devices

Zhengping Jiang (3):
  device: Add "Bonded" flag to dbus property
  doc: add "Bonded" flag to dbus property
  client: Add filter to devices and show Bonded in info

 client/main.c      | 72 ++++++++++++++++++++++++++++++----------------
 doc/device-api.txt | 12 +++++++-
 src/device.c       | 38 ++++++++++++++++++++----
 3 files changed, 91 insertions(+), 31 deletions(-)

-- 
2.36.0.464.gb9c8b46e94-goog

