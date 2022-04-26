Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C08C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Apr 2022 19:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354000AbiDZTmv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Apr 2022 15:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345512AbiDZTmu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Apr 2022 15:42:50 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530D61102A3
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Apr 2022 12:39:41 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id bz24so13556087qtb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Apr 2022 12:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=jpXvVB1Sw3L3mJ9RCaMGeO+SHPqraLUQMT+a+bRvNg0=;
        b=gc2W47C7KqdDcM53eyQsHrHq+t8bCS/iWmIpURofxmbHoeMh/a8nn5JXWpsIqjLq9Q
         lsE6lN3//mXDMx7vyjK31d5TZHoZf1vfGne3RsvncvPik42yx7VjzhC/l0QqIE8aRjQw
         Lt51o+WUNwh7+lAl4qAD3sVxdqoMRYDQVaAQRd8eg65ujuKX7OKsDnn25QnrjX3ssq10
         U+ypnVoWS3niCZg4EX/1GSqq+MVTam9TofVGIr/HjXtJhpVSoGbVYm+lohK7ZO/ji5BD
         tn62ft+JVsziMRFUKfHan2lim3mKhsO+mwBTEyFhsjIeL0yQtuM76MmlYbxCO3uI/AOA
         uDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=jpXvVB1Sw3L3mJ9RCaMGeO+SHPqraLUQMT+a+bRvNg0=;
        b=6bgpwJhd38bchLnT5pp0OFaDWozaLEIFrwbAWxjLur+7KJjSxTc82wRDhGjPtL9myH
         g6UPAufKKPv9yDA8+pL3lEv+Q5MSFvhLLoLiYgUu6Ja3RZByHI+LxkZ53lWdMt8rrb/g
         NvZg5nSqyY93NKfVVMoeYFi6vd8gyuyeIEZyYFLAh4DJr37SmopsvJxNUSOxZN0WdOaB
         eBuaeC7Xr1Bh5RXANNGNZ79OLny/k8jT3FDwvs2Lwx0DqTCZS0LnALFd2Syai7sUHfBd
         7oSyvnncTNSox7WFLPaEWMg41GmlwEOttcatu3PbWCBb5h5Pq+yHdTG0aRYKTEJRky5g
         edsw==
X-Gm-Message-State: AOAM532/7LEmojtBzyLV8UKzX0mP52/2EQCmdBYLYwVcVWIhf52jpius
        TNwvBq4TbPsPQimfezhqqDtzUjimtxM=
X-Google-Smtp-Source: ABdhPJzG2lvfIrg/oYtEmBxB1W9edKOnE7RFhecQvC1MvWiVftLbdFGkfEu5fuXxa0o6ZiyOqscQhQ==
X-Received: by 2002:ac8:5e54:0:b0:2f1:f60d:2b3c with SMTP id i20-20020ac85e54000000b002f1f60d2b3cmr16534308qtx.667.1651001980024;
        Tue, 26 Apr 2022 12:39:40 -0700 (PDT)
Received: from [172.17.0.2] ([40.112.49.152])
        by smtp.gmail.com with ESMTPSA id l13-20020a05622a050d00b002f205ba53efsm8576058qtx.25.2022.04.26.12.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 12:39:39 -0700 (PDT)
Message-ID: <62684a7b.1c69fb81.8dccf.209f@mx.google.com>
Date:   Tue, 26 Apr 2022 12:39:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2438250801493236288=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,BlueZ] client/player: Add transport.receive command
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220426180401.794718-1-luiz.dentz@gmail.com>
References: <20220426180401.794718-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2438250801493236288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=635861

---Test result---

Test Summary:
CheckPatch                    PASS      1.50 seconds
GitLint                       FAIL      1.01 seconds
Prep - Setup ELL              PASS      42.35 seconds
Build - Prep                  PASS      0.70 seconds
Build - Configure             PASS      8.43 seconds
Build - Make                  PASS      1357.65 seconds
Make Check                    PASS      11.97 seconds
Make Check w/Valgrind         PASS      441.40 seconds
Make Distcheck                PASS      226.99 seconds
Build w/ext ELL - Configure   PASS      8.58 seconds
Build w/ext ELL - Make        PASS      1358.19 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[v2,BlueZ] client/player: Add transport.receive command
9: B3 Line contains hard tab characters (\t): "	 receive [filename]"




---
Regards,
Linux Bluetooth


--===============2438250801493236288==--
