Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D302C6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Mar 2023 19:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjCTTVN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 15:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCTTUd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 15:20:33 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18803644D
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 12:12:49 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id bf15so5905574iob.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 12:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679339567;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4FtTPMSvL8Uwdk1Kfy/fVbE+DthTJZ7/N91mxmpLf84=;
        b=nVHx2STD+wTIEQipkUBu3sshr1U3wytMmagC4BlYt0eWeLFwE+thU1BRVH0AECmvrc
         zViGFfLtus+D6wJTINrtUac7YUVFTiHCvuhUK1HVBPIAtwgNIzJP6Oz+RqEol9EEC/An
         Ia6xsYhD5FnuHlXeer+1Xu05xz3ZLwgkyQv+ZiMAblULFVEdOBO2oaFJr6y60rzkh8Ve
         WfEaWRf7BP519VCCnnoUj64WmASWZlwtr+Boa6+qT6TpafG576Rj59u7o8ggbDe+OA4s
         lklMM0MeOms+ukqBlrV/P/yx8AmO0UgDFujiypRWRiGbTZENL1qDCg7C/0N4b0qd4t9h
         O3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679339567;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FtTPMSvL8Uwdk1Kfy/fVbE+DthTJZ7/N91mxmpLf84=;
        b=C5s8sOwDniD1qFxmxNTXx10cqReno+t1VhQZyAlekJHpmk5AvuVOrtajBpjWS2pI38
         c9dz05r+AZzVodp0rI3vjr1ZPJzqX5y2F1EH0nW9nC2uAsSv8Xj4FA2GIv2ydWi2svFo
         4YwYbKCIJm4Y2JHF8IskoQn8UNbayagai7YHCldGi3qp28c/r2NDurNRfVU/DRhsBE6+
         BIqtSZdHF0X3HhrVREPjqwhNspTGM85Y81nvNXgsrt73KuEqme5KJZXqcmBxYS5ecJSk
         QItvK6x7zUeFs292rXNvQ4s+tpide/zrEJ8vF0mPp/VyP/qXYOMmXo/7OrAJB44YEid+
         Obew==
X-Gm-Message-State: AO0yUKXTqpTk98Ip3tbzgJhDgJl7Nk36kovkv+8rV2fIQ5c9GgcTKJM/
        7DCBFkNlaYqdW5wwANVzl269nixW6vQ=
X-Google-Smtp-Source: AK7set8W5Bh03IFe+NaPSfnZKMuPEDYxb7zazZWekNgbirZJxqSbg58zQo8kVaCqv7kpBKtSixzlNw==
X-Received: by 2002:a6b:6316:0:b0:74c:bb78:25d7 with SMTP id p22-20020a6b6316000000b0074cbb7825d7mr388480iog.19.1679339567466;
        Mon, 20 Mar 2023 12:12:47 -0700 (PDT)
Received: from [172.17.0.2] ([13.89.2.172])
        by smtp.gmail.com with ESMTPSA id bv20-20020a056638449400b004065707eb2bsm2295557jab.42.2023.03.20.12.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 12:12:36 -0700 (PDT)
Message-ID: <6418b024.050a0220.66e38.39b7@mx.google.com>
Date:   Mon, 20 Mar 2023 12:12:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2487753635668708527=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@gmail.com
Subject: RE: [BlueZ] tools/mesh-cfgclient: Add local address check
In-Reply-To: <20230320175825.321702-1-inga.stotland@gmail.com>
References: <20230320175825.321702-1-inga.stotland@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2487753635668708527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=731984

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      26.24 seconds
BluezMake                     PASS      752.49 seconds
MakeCheck                     PASS      10.85 seconds
MakeDistcheck                 PASS      147.56 seconds
CheckValgrind                 PASS      241.11 seconds
CheckSmatch                   PASS      320.46 seconds
bluezmakeextell               PASS      96.56 seconds
IncrementalBuild              PASS      607.54 seconds
ScanBuild                     PASS      958.94 seconds



---
Regards,
Linux Bluetooth


--===============2487753635668708527==--
