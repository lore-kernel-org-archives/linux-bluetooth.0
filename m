Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE4DCDB474
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Oct 2023 16:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjJTQcs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Oct 2023 12:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjJTQcs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Oct 2023 12:32:48 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B55D5A
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 09:32:46 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6ce31c4a653so623568a34.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 09:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697819565; x=1698424365; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a4wRkhk6kYut+Ztj6iDTzI71JsMZ2duU4cCEOPY0NLI=;
        b=FkHl+5rgxhTVfmoHwNjt0YaaI9CoQJLB0psW7q3VOeROghAP2HyHuoc3N9jiwaWzGG
         B4v+pCjjLaEk0zGVs1fCmE/X4Yk8BcDEP6XKu3RNi6DXJwqZhg5tHpBVTfozcM/BivTc
         Aj3hWHMp44H5LEsMKj2JfTHdPNz7dwCi0KckD5whoIm6FKNry+JOCdTUKyNrFKVtjP0k
         9/eaPIOVAaSJI82Qkb6UyxMz5QZyZy9C0jrFeyKmtc7Xbhv3qmbT7gOpedpiwfo8fC1e
         m5HZ3ICFWIKWtfvmS6p1KHUzBQPhLJo6DSTvA41isUJltqxZUnPIDqsq6qphFvOK5kcy
         yxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697819565; x=1698424365;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4wRkhk6kYut+Ztj6iDTzI71JsMZ2duU4cCEOPY0NLI=;
        b=Es7OJsoVRUXFm9XNAe0/cSGWPimzM/CLVrySi4Su0ulfYwfc1XFgsC/31fS63out3W
         WC8yR7o65rVDvcc46U3Qt45m+PVKlBqE2uJk5qZawM99iBPANN7okb0KaCLx63mxyJOM
         hHVCtDCKZrpa7BvxEy/SaAX9rvrV7hmfE8mQaghvtHufmWqlmPVsWa0OE97f0VmnZ2uK
         QRmrdzdzaDkDALrKtd111/Yw68Ps58geqfxVVytqCcP5NYrPAbGlwbwaapzSjxSc8XaS
         5nT1sXWgfKiwHZmQvjixEFE4s1fCBKumIqgE5oxZ9/Ik8DRVgAa9Vf2Iv+SiTymz963W
         ck8Q==
X-Gm-Message-State: AOJu0Yx10PMeuWT45qgkNePzRcj3YpUv7ADWgdDhMhhSPK0AKek8bZrI
        lvRLjjfNxo8+L6SFLXyHa3TOLWx7AX4=
X-Google-Smtp-Source: AGHT+IHQqk84T25lk7a9DK7mu1p3AELGiH6alP3EYgdjH25CyRGGNznasfKtq0ISVnD2OwP2oUDxTg==
X-Received: by 2002:a05:6830:1652:b0:6c4:c3ac:a9dc with SMTP id h18-20020a056830165200b006c4c3aca9dcmr2406824otr.21.1697819565274;
        Fri, 20 Oct 2023 09:32:45 -0700 (PDT)
Received: from [172.17.0.2] ([40.79.245.128])
        by smtp.gmail.com with ESMTPSA id dc6-20020a056214174600b006590d020260sm799653qvb.98.2023.10.20.09.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 09:32:44 -0700 (PDT)
Message-ID: <6532abac.050a0220.51fd3.3d98@mx.google.com>
Date:   Fri, 20 Oct 2023 09:32:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8153729081247836542=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/5] media: Populate location to qos structure
In-Reply-To: <20231020142554.486629-1-kiran.k@intel.com>
References: <20231020142554.486629-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8153729081247836542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=795144

---Test result---

Test Summary:
CheckPatch                    PASS      2.33 seconds
GitLint                       PASS      1.64 seconds
BuildEll                      PASS      28.35 seconds
BluezMake                     PASS      930.45 seconds
MakeCheck                     PASS      11.57 seconds
MakeDistcheck                 PASS      180.89 seconds
CheckValgrind                 PASS      278.11 seconds
CheckSmatch                   PASS      381.00 seconds
bluezmakeextell               PASS      120.14 seconds
IncrementalBuild              PASS      3824.44 seconds
ScanBuild                     PASS      1143.53 seconds



---
Regards,
Linux Bluetooth


--===============8153729081247836542==--
