Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93344C74A5B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 23:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjCPXYn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 19:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjCPXYO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 19:24:14 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C704686A8
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 16:24:12 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id l13so3675111qtv.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 16:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679009052;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pLha6/yHyK0nMq2MoCx/jiK6HFosbPlSbrUaSOcurbs=;
        b=VLLoaRyFGZNlYV+K+ytrFzAn0BYk+UN21aZ7BIZ/Ynmy9iE8y/oWBofRefitbd3Ahz
         tpqcz/udwYCjKj7QsrvTbpKGy2kTI/8h/OH1A0fa/OPqsWQmk47Gpi39C8wLjc+hI/0U
         TJ1tRulk0mcVyXM0N/HOmycDlURGQnj8v6TgzA8FyX6tXN1DKqSI+Vbtb36kDKT579uP
         2+Fi/DSZFL3SOptb4G3/jlGK5CD13mQ35/OMqio5uiSChgEnquIsm2Fn3mXfQUnM6BXw
         V9nEnIoh+pT33V+V5yt1Z4MSVUqRG0YiZFbaLlJhuljzy542n8+KI0PglelCmpl/7rXQ
         9FsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679009052;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLha6/yHyK0nMq2MoCx/jiK6HFosbPlSbrUaSOcurbs=;
        b=DQoSkFNjf3qgMGktKRMgAcPMU0Mdtad5zxHiAJqHUFjNjEpxyq+MzIjiZf0XHgjoOH
         jSE6Na8dTGlFqlNVi03pO2clRSLf0iZhCqasPa/InaPjDpbiYGRN2T28L5+WBo4rib9r
         +qJPuNm4KOKsAwgjOkdnJQkN8pUDxLq/qjYvY2zqzFLAx7WyUDDi7a6F7k9iXy112TAP
         EiH6lvhRA9tdlGU+XH+Q5XZMapqL81BqhQzOcVK30sd/KmR6WeVD8s1eETrRrnnsh3J1
         Tmn72eA/SgwAtZn+SVxtfA0Nt/yFTMBmiiZpfU8+gnX5L/ODHuEWoeGv+fs2G+w25nct
         XREg==
X-Gm-Message-State: AO0yUKUJ8cnVsygACb51DpMI4C30qYhzLadISnpeU3jJ6E+dehIhjiq5
        bZASPNgrczjcKVbTvjWMUYksHrMzqbs=
X-Google-Smtp-Source: AK7set+9O67vtIjmay/k7/sFbzwrEjuxsML+d4D4EiwwCw5We7UCYs3fmTK9QkBYMtXZmZu+2w2D7w==
X-Received: by 2002:a05:622a:104d:b0:3ae:189c:7455 with SMTP id f13-20020a05622a104d00b003ae189c7455mr9798624qte.47.1679009051786;
        Thu, 16 Mar 2023 16:24:11 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.202.162])
        by smtp.gmail.com with ESMTPSA id p17-20020a374211000000b007428e743508sm487171qka.70.2023.03.16.16.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 16:24:11 -0700 (PDT)
Message-ID: <6413a51b.370a0220.20a9e.267a@mx.google.com>
Date:   Thu, 16 Mar 2023 16:24:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7569005672382717825=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@gmail.com
Subject: RE: [BlueZ,v2,1/2] tools/mesh-cfgclient: Prevent storing duplicate models
In-Reply-To: <20230316213312.159370-1-inga.stotland@gmail.com>
References: <20230316213312.159370-1-inga.stotland@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7569005672382717825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=730979

---Test result---

Test Summary:
CheckPatch                    PASS      1.09 seconds
GitLint                       PASS      0.71 seconds
BuildEll                      PASS      27.08 seconds
BluezMake                     PASS      849.17 seconds
MakeCheck                     PASS      11.94 seconds
MakeDistcheck                 PASS      148.63 seconds
CheckValgrind                 PASS      245.05 seconds
CheckSmatch                   PASS      327.65 seconds
bluezmakeextell               PASS      98.21 seconds
IncrementalBuild              PASS      1415.53 seconds
ScanBuild                     PASS      1023.62 seconds



---
Regards,
Linux Bluetooth


--===============7569005672382717825==--
