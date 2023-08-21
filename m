Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6CAEE4993
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 14:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbjHUOBZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 10:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjHUOBY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 10:01:24 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BECDCF
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 07:01:23 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-410921a7921so10095651cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 07:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692626482; x=1693231282;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iIs5rkwCglp1mjN8P5wPG2YZ4g5T/87PJ4BiMfdtObU=;
        b=KHWonGCetoI3MHV7C6yHG8FUJpUzsFW7Sld7Oi/IY1K06XcTDfSk/n8eV8rzuYnysw
         FHGqfxvfhRYyZhFahoZJVLf11oU+jQ+NJa6ZkOOMOreNcyZ45Sa2yAub496C5FoBuNHF
         zROWU9QFloj7axDqJqJ59rq4gqozMiYMXYczrd5Fi7hCynCTpWFGOF7vKk0v8/bLNt57
         eM6l9sD+vVrMnj+ULWfBnVDmTxNb+HeJVHQAtL15xIu74xpadGG9six522QVRcP9dcnr
         jWeSuW389GFgmnwILtiQCrQrAvjVeqCvjvakzrF6lZdtrMiP7kstEwyp6uLgVcB+iJ6h
         6Ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692626482; x=1693231282;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iIs5rkwCglp1mjN8P5wPG2YZ4g5T/87PJ4BiMfdtObU=;
        b=e9lPGBm3oqINtwUMAXZkBQxZ1V2au5XX9jQ8m8kejiEsT7QyNuNlJTE/x52qU/kAbr
         Mowz6UTk/FIQAqM6HjgzStRTGEnKptCdYUq8TE/3GWD2CfnWxKx3c5CVgvwzLmBa4kXw
         +1RJ6xZBcJ4MNZlSsv+Cqect1/KunITYYzp2irFmQ71BGtIOpwB6AFBS9LoCwYinPmrM
         ZjVbbLRSR8BdyAB2WKpiJ7T2WWT0NfIKpTs2yJUZYofwukAQuOIHj+em+0ZTHXgONdRE
         4vELOGjYOy8HKM0iV4DMVth4xtGtSknHFy6c1HvPYhrqJvIc9QQPEDg3xXepucPOqGkj
         6L0g==
X-Gm-Message-State: AOJu0YxFLNGgVaAf2voHj82Dzdy+W1AeOMN5Nzlz+PamLSVj+9AYpDAa
        iOpwyiBkhch/aJUTk6/RRzc318U0wTs=
X-Google-Smtp-Source: AGHT+IGckOcjZpfk2n83GDGtc3qLKBsbdp3KjFO/AkIYBpDue6Fdt+Or9AFK/dYdQam2ULMnNu4oXQ==
X-Received: by 2002:ac8:57d3:0:b0:410:959f:d7c4 with SMTP id w19-20020ac857d3000000b00410959fd7c4mr6291024qta.61.1692626481643;
        Mon, 21 Aug 2023 07:01:21 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.204.209])
        by smtp.gmail.com with ESMTPSA id j16-20020ac806d0000000b00405502aaf76sm1594075qth.57.2023.08.21.07.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 07:01:21 -0700 (PDT)
Message-ID: <64e36e31.c80a0220.be2f3.424c@mx.google.com>
Date:   Mon, 21 Aug 2023 07:01:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3025483318265498022=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Add mgmt event for BIGInfo report
In-Reply-To: <20230821120353.28711-2-iulia.tanasescu@nxp.com>
References: <20230821120353.28711-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3025483318265498022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=777863

---Test result---

Test Summary:
CheckPatch                    PASS      2.25 seconds
GitLint                       PASS      1.48 seconds
BuildEll                      PASS      27.72 seconds
BluezMake                     PASS      874.91 seconds
MakeCheck                     PASS      11.89 seconds
MakeDistcheck                 PASS      158.93 seconds
CheckValgrind                 PASS      261.98 seconds
CheckSmatch                   WARNING   352.57 seconds
bluezmakeextell               PASS      105.61 seconds
IncrementalBuild              PASS      2928.70 seconds
ScanBuild                     PASS      1084.68 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1856:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structuresmonitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1856:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============3025483318265498022==--
