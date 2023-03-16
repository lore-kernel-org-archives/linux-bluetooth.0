Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18D7C6FD19
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 10:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjCPKdK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 06:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjCPKdH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 06:33:07 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1B8BD4DE
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 03:32:53 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id s41so951005oiw.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 03:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678962772;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RUEqs+YT3PiNnQEt8BEx2ydTtKMTPZaUNQgBrn0py4A=;
        b=Y7mmpROU8CXmLji+Xwut5XN2kX3rQkE7oyuEr6QO4fDRw1SjHzqemnr2LMO2+A/jI9
         WV/v59LqkqdBc90T0ZDYIBIEWhh4Bqs7woTkN0QAGcUd7SMg7+uLUwFHfhZcXWp4Owor
         tlHIrl9vmWxrw8Kz9e9N6AjhXm9jgHOMR85V1xhtCixwkBAR4ck8xdBLZ2Y+a00xNpGn
         GMj12sSteNsWMzw9Np0pJfBkcsonwQno8zS02r6m0kdq7swoJulyiUOeA1Z8X3yR1jPu
         y5dchKxyirTvq5g0bO2UhHnnyxWkICP0wSW1L1UJS3iNp8aeD+Udpqh7X3A42Tg5/XQi
         xhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678962772;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUEqs+YT3PiNnQEt8BEx2ydTtKMTPZaUNQgBrn0py4A=;
        b=N2n6NdE/a8xTmMarJEjASC9QvsI/ri3nXfJ/hauvB10XvI7nsUDV4EEC2awDlp5DpQ
         qIRz3AhQsmmSi71wLfA3MV10gsW07VVT7uLwopfihOSeR8KJqB4O1X/AT1FHJGec6ZOi
         lZaY+Yy+XOo0Wc86aiRfjFQ7lPw+YhCHrnUg/9Z1Nigpd6lVSyKqRa537AV8s+QHHuKf
         LMk/Ki6xzLWdhd3KuczI9WjMzs2tswbLTGxL8zL+3Pp0+ipzKAo6SjW+DnKIVrr9H2fg
         3TFyDQq3HGDMbhLOMB5B8LkZPolaje+yK5az4HocTQK/yVKeJtI7JwPmqvAYzFUbYSTI
         kfZA==
X-Gm-Message-State: AO0yUKWUfNsxEeXTm5Fl5GWzbDzOoeClTaGa/11eYO/u1vNbDLhDlGlv
        KAHTt+tuPUm0Z2BUHMzGA9BdQZrRzes=
X-Google-Smtp-Source: AK7set+4nTA0pbnZKKW73zd+ng8UZ5rS/oM8qWwLCCsm5jE8hy7FHj1Dtcz9ukhBoztvWOxeJ5mKSw==
X-Received: by 2002:a05:6808:2a8c:b0:384:8bba:940f with SMTP id fc12-20020a0568082a8c00b003848bba940fmr2510346oib.45.1678962771130;
        Thu, 16 Mar 2023 03:32:51 -0700 (PDT)
Received: from [172.17.0.2] ([13.66.79.182])
        by smtp.gmail.com with ESMTPSA id z13-20020a056808064d00b0037832f60518sm3142240oih.14.2023.03.16.03.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 03:32:50 -0700 (PDT)
Message-ID: <6412f052.050a0220.1326c.fa19@mx.google.com>
Date:   Thu, 16 Mar 2023 03:32:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6352189713899330377=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, aarongt.shen@gmail.com
Subject: RE: [BlueZ] obexd: support to reply folder or error to store/reject file
In-Reply-To: <20230316084752.12071-1-aarongt.shen@gmail.com>
References: <20230316084752.12071-1-aarongt.shen@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6352189713899330377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=730675

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      33.46 seconds
BluezMake                     PASS      1170.79 seconds
MakeCheck                     PASS      12.33 seconds
MakeDistcheck                 PASS      186.45 seconds
CheckValgrind                 PASS      312.97 seconds
CheckSmatch                   PASS      427.50 seconds
bluezmakeextell               PASS      125.19 seconds
IncrementalBuild              PASS      954.37 seconds
ScanBuild                     PASS      1366.63 seconds



---
Regards,
Linux Bluetooth


--===============6352189713899330377==--
