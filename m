Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DADBC001DE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jul 2023 21:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjGaVji (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jul 2023 17:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjGaVjh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jul 2023 17:39:37 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F317D8
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 14:39:37 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-403b3213d8aso30404661cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 14:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690839576; x=1691444376;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rYiFDZqutnQN5UfQ5iBONprN7KsHZewPRwPyGoDWKK4=;
        b=A7MvlUog2T9durfS/2SopEvewAz64NAYg59v4uFoxesg1sG5ULlEi1IQuLXsp7d0/h
         pAgEnnDdWoeM6xoRshyHxT4D4/VsstNacRb+Kjv74R9Qyuj90xnnUJaGU04RbfAk0dsE
         C0T01Z4ZBZEufP0ah1vqi0UXTLIBtMmlYtQncLQarSbHTPlqrxVbtwBByF6gC1bybKPF
         yxt4vtv2kvuNj93/0Qh+0o1RDwxbqTCOX7J+owjvctn+CSDHZavXNr5fWSyLTgOJ27H8
         dhQBoqQdPa4gLpFCGZ+JnbENYcFRtNXeR1PzIbFcOZZODdvGM/T98fYst6/iIA88BkOj
         5xkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690839576; x=1691444376;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYiFDZqutnQN5UfQ5iBONprN7KsHZewPRwPyGoDWKK4=;
        b=cn+XIkcnPaofqS1ms4uox+8cPuWQFbtlZ8fSrtc0l9xhKVmwqxV80h0fqDgMvfzdRw
         Uhez3O+waM9ZzFlnSRi0fWcb8WjLMP4VcOEOAiBW0HQZYNeMvTVp1ZVtPxC2gYe9DIv/
         SGt22c0rTFZVtmSw+CRsckULDdWmGOO1IzMMh0MKVE8CkuLDOiaoUrNobROHAW/rJnsm
         HnjwwuuUCDq7bj8+kFrELiDPy7r+UysYJtTYGvNIHheC4fyvak+HDZ6vweeZeM10aBEh
         vn5BiKdRuovHYUegMEzuRHwj/s1iPGOZEj7xX+UfjVdy7cbNWkUcHlM1NaBMf1U2z6It
         x57g==
X-Gm-Message-State: ABy/qLYDVdUtJGDMXXBgVp4+MNpZ5h1bUYL9R6ynB8lgTd3gYOs59lCs
        WN5Ma+lhpBM1horBMQdixHQ+N0TmMNQ=
X-Google-Smtp-Source: APBJJlEulrU9+4euf2YUxF1Pswd39wEyPK38AygEzNp5lgt/zsjDZPPxW2Y9na77aGPJKHt9ZgFbLA==
X-Received: by 2002:a05:622a:178c:b0:403:af80:7cc1 with SMTP id s12-20020a05622a178c00b00403af807cc1mr12895054qtk.42.1690839576107;
        Mon, 31 Jul 2023 14:39:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.75.184])
        by smtp.gmail.com with ESMTPSA id p5-20020ac84085000000b0040b3aa5f7ecsm2388240qtl.70.2023.07.31.14.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 14:39:35 -0700 (PDT)
Message-ID: <64c82a17.c80a0220.af5bb.74cd@mx.google.com>
Date:   Mon, 31 Jul 2023 14:39:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3513924777009326303=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] monitor: Add TX frame number and speed estimation
In-Reply-To: <20230731200844.384507-1-luiz.dentz@gmail.com>
References: <20230731200844.384507-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3513924777009326303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=771337

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.39 seconds
BuildEll                      PASS      36.17 seconds
BluezMake                     PASS      1283.93 seconds
MakeCheck                     PASS      13.31 seconds
MakeDistcheck                 PASS      207.42 seconds
CheckValgrind                 PASS      333.37 seconds
CheckSmatch                   WARNING   471.14 seconds
bluezmakeextell               PASS      141.83 seconds
IncrementalBuild              PASS      1085.39 seconds
ScanBuild                     PASS      1513.19 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1832:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3602:52: warning: array of flexible structuresmonitor/bt.h:3590:40: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============3513924777009326303==--
