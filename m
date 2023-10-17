Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC5ECDB474
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Oct 2023 02:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjJQCWR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 22:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjJQCWQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 22:22:16 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5304E6
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 19:22:14 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77575233636so367624485a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 19:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697509334; x=1698114134; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=du8WvivYRb/QNbkJ7Brgg1wJnGuxZ5dB8zG8UFFPER0=;
        b=h3WoHgXtYo+0f37uC1I/WraHQSEkbejGxjwRDfkftGmUKssCKugK+p+a9HFOW9jKtJ
         +av+mgC0KDi2R5hv4IiNi28F3IHRPGUIYzx0J8PQ5WG77j8d8coDVLsTM5zeTzFz+zBG
         MFz3Bxw5VU2ETcwtczb1agHsHRNwY9e0xSFX0T3djFbXoFhG1Scwe5R/91V3JPgwsT9q
         pREJ7IHxXHD8vC29EmgblU9Kgrvl6lzNdn3/bR96lvZiTieIIuD+lESa90ifBO2T4hlO
         Vvp1W2pi1u7RnFnQURQblH9t0Q6tOpTOS1xmcnmpwmKfOm8oFYHHlv+eLkWrFpw4ZCp6
         XvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697509334; x=1698114134;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=du8WvivYRb/QNbkJ7Brgg1wJnGuxZ5dB8zG8UFFPER0=;
        b=OUekKTe5/IgH0XRcwpVEyt5asHj2kNvxhJQ6GB9+s7Mv/K2e+LgignVuiwh6qvARQx
         7oUqez85Fc47nl2G/mU50v0EaihOltUwUgbgUAtzg9WVgHCFmUuCpmAXQufT6koSHfq5
         PZ+TIOqGNhfDoeZVU9aVuqeR/Byo22TGo8PVyPuag+/Ms8Ljyk/CP6kSTXoiKYFNyD3I
         p0ypf8u/0SfRnkteZRed8O3dBIn/KF/KF8Dx4//OlKZycPBKyH6HoDMdZ0qEYhnB11E8
         YO0hg+MoiGEJN/aI4qh8Svd7oILCKtD9DwS5zvXwkHL+S8s/0g8eB94HcQKAWxmJNgte
         cxEQ==
X-Gm-Message-State: AOJu0Yy/GOTQ1HumXlIU3XvVsWwdxx2IEFzavLpLdr42Q7HJ/98Dh3eh
        Xp9aRSLqai5hfumlOiA/rqCgE4xkyeo=
X-Google-Smtp-Source: AGHT+IH+2iIkYHM0/CgLJw2UQoMyD9Yb7VsCCk3RxlLyIST2TK9bci1AF3NwQAH8pvvpsbu4XTw4Bw==
X-Received: by 2002:a05:620a:171e:b0:774:2c12:1363 with SMTP id az30-20020a05620a171e00b007742c121363mr1158270qkb.58.1697509333735;
        Mon, 16 Oct 2023 19:22:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.39.61.81])
        by smtp.gmail.com with ESMTPSA id dt33-20020a05620a47a100b0076f35d17d06sm258216qkb.69.2023.10.16.19.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 19:22:13 -0700 (PDT)
Message-ID: <652defd5.050a0220.cc5ae.0ebe@mx.google.com>
Date:   Mon, 16 Oct 2023 19:22:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4916367223106461141=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@gmail.com
Subject: RE: [BlueZ,v2] mesh: Fix check for active scan when using generic IO
In-Reply-To: <20231017002123.43533-1-inga.stotland@gmail.com>
References: <20231017002123.43533-1-inga.stotland@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4916367223106461141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=793761

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      1.14 seconds
BuildEll                      PASS      36.74 seconds
BluezMake                     PASS      1225.66 seconds
MakeCheck                     PASS      14.24 seconds
MakeDistcheck                 PASS      230.61 seconds
CheckValgrind                 PASS      350.93 seconds
CheckSmatch                   PASS      483.93 seconds
bluezmakeextell               PASS      155.13 seconds
IncrementalBuild              PASS      1108.57 seconds
ScanBuild                     PASS      1486.37 seconds



---
Regards,
Linux Bluetooth


--===============4916367223106461141==--
