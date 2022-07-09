Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624DFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Jul 2022 16:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiGIQ1H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 9 Jul 2022 12:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGIQ1F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 9 Jul 2022 12:27:05 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325F62F3BD
        for <linux-bluetooth@vger.kernel.org>; Sat,  9 Jul 2022 09:27:03 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id g28so2096456qts.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 Jul 2022 09:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tMC4uTDwg8VeE5afl5XDitIoIinxR28DO01csdvIWIw=;
        b=ZXzHYQ0stvxTUxvYd7D6eF5zxZadaf+TwRCoDGSP7NzYXDDasE2ggvsZmWde9nHidD
         h0Jp6bZ0HVVXjb/Fe85TIlapGl7ndSeYC6O1yHx72DHXC3Fa1WqEUZRINHBTAfiJ1LUU
         dDcWzUwsrRi30pX19nWr7xDNrJT12szz4S6ROzWnqOdD2Ts4vx6JB7X5lttYHsgHIpUH
         Parrmzw0a8T2lQqUHst9tr4uGtql4px4jmb3usIVB34J7hFYnxw+tFyJ+S3zjC3g1eCC
         YqrBoJsM1qvQ9VDZ9tHXS6mugAlnfL7vE0OsuBxNtFopMfYi7671klju3xk8jWHftN4M
         UucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tMC4uTDwg8VeE5afl5XDitIoIinxR28DO01csdvIWIw=;
        b=Fs1FpnTFlRIvUqr7cB2StaaTfRm5WQm/+en95hDEku1WWWbTdTiMT9oeaFTUB6s6n8
         97YLDM9fP9mJN5kbgY3rAKRAqV+ex1aBgsIyJGdPGbMcfCFDM24OjSlf977z4CjEWHsE
         iefCXHtJTEmyOrg/KQcIK73lBcjcQwWTz3yo9KizjKwmLJJ/A9jG3Ym+Cq8x5ryAvTA0
         L8V9IJWnPHxtKdeFtOQmRptappplqpSgdI6pqjU8iH+e73teP+Y3t2scjSWk25/fnij3
         NRFeAUNdjfvzqZUyyePTXcXFsSsu35d5JuDXhp9SPgqKT7j1sGTpiXwqgiUxtv+VzebL
         fVCg==
X-Gm-Message-State: AJIora/3ghp4mhKn9hXN7/T0a+EIwQu20FInyUEf545U6S7AuG4OELoq
        Jur/w9rrjZqeGOkv2T/5w+JVpJ7bC5gD5URs
X-Google-Smtp-Source: AGRyM1uAu543yKHI4tufvsXhmBeZpVJjBv9l7L2U496zBFPb1JhEhFFwl2liMUJE9adipa6STM3uqQ==
X-Received: by 2002:a05:622a:1709:b0:31e:aef7:71f with SMTP id h9-20020a05622a170900b0031eaef7071fmr1784543qtk.27.1657384022080;
        Sat, 09 Jul 2022 09:27:02 -0700 (PDT)
Received: from robotnik.. ([209.23.56.93])
        by smtp.gmail.com with ESMTPSA id bx10-20020a05622a090a00b00304ecf35b50sm1625818qtb.97.2022.07.09.09.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 09:27:01 -0700 (PDT)
From:   shwoseph <shwoseph@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     shwoseph@gmail.com
Subject: [PATCH BlueZ 0/1] ExcludeAdapter setting for input plugin
Date:   Sat,  9 Jul 2022 12:26:57 -0400
Message-Id: <20220709162658.1953-1-shwoseph@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

As a bluez user I have run into cases where the input plugin can be problematic because it binds both HID PSMs on all bluetooth adapters. Simply disabling the plugin is not an ideal solution if you want to, for example, run an application that binds PSMs 17 and 19 on adapterA while using a bluetooth input device on adapterB. This proposed feature would allow users to determine which of their adapters can be engaged by the input plugin. Using the ExcludeAdapters key in input.conf a comma separated list of bdaddrs can be specified that the input plugin will not start a server on.

shwoseph (1):
  ExcludeAdapter configuration setting for input profile

 profiles/input/device.c   | 22 ++++++++++++++++++++++
 profiles/input/device.h   |  4 ++++
 profiles/input/input.conf |  4 ++++
 profiles/input/manager.c  | 36 +++++++++++++++++++++++++++++++++++-
 4 files changed, 65 insertions(+), 1 deletion(-)

-- 
2.32.0

