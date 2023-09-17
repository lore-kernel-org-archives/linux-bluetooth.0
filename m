Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694A9CD37B4
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Sep 2023 18:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjIQSc4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 17 Sep 2023 14:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238066AbjIQScj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 17 Sep 2023 14:32:39 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19FB10E
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Sep 2023 11:32:30 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68fbb10dec7so3190416b3a.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Sep 2023 11:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694975550; x=1695580350; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pxv1QZN/sBp6zW23FncUnKtNygwvEY5MtPfzisFVt6U=;
        b=LLZqk+BQo/Lc1u9S6LJl9PGtTBVnJ5YHLslKoEWkHIbwUNO0bWOJlaOLuR/Elxw7b/
         dES8ED8r1ZR5Mbw9wJKOkbzDYce+v9PAturNq1g3egKUW54TYr0eNnZgEMCwfirWsJjl
         QcUfgn5d/h3FZCaTk7PPzyGA4OPdywnGcpgM6BxramT+E/5FxHpGyvrrPauND7Do6Fbj
         I5k1D9lxavIkTy2SXaImAKsS04ThgIW2h+UAfmfFBiPNaw0lVDH8BL/rASHwppIYCz+f
         bGOR3WblGFDoSiWsxIwTJUkrp9QQbcRkgK+7/OKTviJXSuKmHdT6kmS1xo1tPNoQZr/j
         3Zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694975550; x=1695580350;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pxv1QZN/sBp6zW23FncUnKtNygwvEY5MtPfzisFVt6U=;
        b=WZ+gW7DfT0m4S7kZID4kTlSt7zsT1l6MKNthUbUowj36H/ZveJkswSKbiBiFFMIUdv
         A2aadRjF/DDa1XuxGmz1UYKTafbxRYGMJWgzMn5pvgZkQSloWSHUVlcbp3uIdnh/QFS/
         SNc4YN6KqtrZ8wMoH74PCKJ79c4PI5bIColSeaTHYtbTe3qv1zhfojUOA2LmiLEEeK9J
         QWLmYEHZQnEftgtfG3ye/oGdYbg9+pbDazMea24GF679+GA8kmThmixeuS89aDfVU059
         OCEDG03CPQ+mCo0MszzrYRrUfkoNxEOzxE8BoRPIlyxNrd7XBGAoEb3Qr/Kj90nwm8Ts
         HPKQ==
X-Gm-Message-State: AOJu0YyVjj1nGCKhEsbQ6xIf6gDisfcV/eSLp4LkJuv3a0RO3rKrn70i
        sWkUpgdDIXtyhoQ2uXeIbdPwh2t9amA=
X-Google-Smtp-Source: AGHT+IEpncTQrtEgkjtu0kuhalKfK2WVn5VG9aCeF8n+DskyzQHcl5OXCgcDqdnqlXT+IlRB3BQ8AQ==
X-Received: by 2002:a05:6a20:1605:b0:15a:f4e:620e with SMTP id l5-20020a056a20160500b0015a0f4e620emr6967774pzj.59.1694975549847;
        Sun, 17 Sep 2023 11:32:29 -0700 (PDT)
Received: from [172.17.0.2] ([13.87.243.28])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902ab8400b001c0af36dd64sm6906675plr.162.2023.09.17.11.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 11:32:29 -0700 (PDT)
Message-ID: <6507463d.170a0220.d459f.8fe4@mx.google.com>
Date:   Sun, 17 Sep 2023 11:32:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7470932331480472126=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, koba.ko@canonical.com
Subject: RE: configure.ac: Add enable_btpclient and enable_mesh for internal ELL
In-Reply-To: <20230917165044.40310-1-koba.ko@canonical.com>
References: <20230917165044.40310-1-koba.ko@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7470932331480472126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=785015

---Test result---

Test Summary:
CheckPatch                    PASS      0.37 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      34.81 seconds
BluezMake                     PASS      1211.62 seconds
MakeCheck                     PASS      13.50 seconds
MakeDistcheck                 PASS      198.92 seconds
CheckValgrind                 PASS      320.07 seconds
CheckSmatch                   PASS      450.83 seconds
bluezmakeextell               PASS      135.07 seconds
IncrementalBuild              PASS      1062.32 seconds
ScanBuild                     PASS      1415.01 seconds



---
Regards,
Linux Bluetooth


--===============7470932331480472126==--
