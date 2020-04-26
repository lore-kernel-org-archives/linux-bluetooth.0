Return-Path: <SRS0=2aAe=6K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAB8C55185
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Apr 2020 02:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30ED02071E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Apr 2020 02:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSENPcAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgDZCGe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 25 Apr 2020 22:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726119AbgDZCGd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 25 Apr 2020 22:06:33 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CD2C061A0C
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2020 19:06:33 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id z90so11394290qtd.10
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2020 19:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:in-reply-to:references;
        bh=15wEOqTW+vvS20m3cQG+EdYKFpDAKJlek8uRhULqtIw=;
        b=JSENPcAVgo9Aj63spzP2dAQ3YawplsHfnYrBKle4Sd1ccbC9FDWF+XifIGykcTCiNP
         MjULHwt6Rx86odP9BjmML6jcmMbsUDAupKuotMrbb6hVihv8EUdLNSyQXvxBeNoKxBmU
         UftL4GMn/ILGWsDvhHoTGEf8j0lIiB7mZ1Fu0xzc5nqKwuEh0wY7U68qEnguTsOpC/G+
         rcNa5xV5sISO+qqvEOVpTK5litqu5JACebbjFNu5SqgLunhs1bAbtVJgJmy8M43xXGaS
         rkSk/ziaAVbt/edv7i3esKEY3wklvPtiZeHcmxiOjR9Ta0EjfR+V7jJBmvU/RHON1f15
         xQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :in-reply-to:references;
        bh=15wEOqTW+vvS20m3cQG+EdYKFpDAKJlek8uRhULqtIw=;
        b=pPy97zVhSxydhhW4g7H3OYzdgzfNwGxdUa7vMF8L45RDCHk+5PYEqiW1YzxXpwxZVH
         M5kkwgHb0hcB5gtNz2HweFJc27+awKBIB6LqYWT8GHUlZ546FwY6xesrr2PA8YkzijHu
         S+21jyKqoGOjx2cCO2GWKS/0Mq5tbI4oXrbeOeyHDlGHCV9cRW7owT9dj0PkJ5XXJDod
         cMFUrzeYB30FbQd58YCvkyyBs5jxI26QLFAN7Go/0Z3g1lC5cZEVs6NZmaVwr4/tL4zS
         lecwG/ZAmcle/e3pxGTGJYCZnk69ezNPYou2Y3juEW8cXGfrHlLkEXCrE/KT8a5wmqJa
         oOPw==
X-Gm-Message-State: AGi0PuZZAT+WmRb+G6v9Tnz+XvTiN9bZNhYxzIbcld1o2WOReo8JDct8
        1MCxC7rq5kS9Cmk+fn4GK4xCX+RlWKQ=
X-Google-Smtp-Source: APiQypKr5QQAy1to+0tAqlPRbAkqWzYQIS7E53sud/pLDkrGOucrvNB8b++Sxk+5apW2tmdQfSZ9Tg==
X-Received: by 2002:ac8:70c9:: with SMTP id g9mr16973836qtp.375.1587866792246;
        Sat, 25 Apr 2020 19:06:32 -0700 (PDT)
Received: from [172.17.0.2] ([52.232.253.73])
        by smtp.gmail.com with ESMTPSA id 39sm6940857qtg.94.2020.04.25.19.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 19:06:31 -0700 (PDT)
Message-ID: <5ea4eca7.1c69fb81.3835.c3a1@mx.google.com>
Date:   Sat, 25 Apr 2020 19:06:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4873628359534257262=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, david@lechnology.com
Subject: RE: [BlueZ] src/gatt-client: always check properties in WriteValue
In-Reply-To: <20200426011935.32742-1-david@lechnology.com>
References: <20200426011935.32742-1-david@lechnology.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4873628359534257262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not replay to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.


Test Result:
Checkpatch Failed

Patch Title:
[BlueZ] src/gatt-client: always check properties in WriteValue

Output:
WARNING:LONG_LINE: line over 80 characters
#32: FILE: src/gatt-client.c:1020:
+			chrc->ext_props & BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE) {

- total: 0 errors, 1 warnings, 20 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



For more details about BlueZ coding style guide, please find it
in doc/coding-style.txt

---
Regards,
Linux Bluetooth

--===============4873628359534257262==--
