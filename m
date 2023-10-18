Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A9ACDB47E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Oct 2023 16:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjJRQRW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Oct 2023 12:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjJRQRV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Oct 2023 12:17:21 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B00898
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 09:17:19 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-774141bb415so428324585a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 09:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697645838; x=1698250638; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xb1fystfuKYmk3pxBII0IcmxUS5eVGec3v8holcYxvk=;
        b=R7pW65C1n0XYUQHkD+ADAZ0gFRP19DMV2BKz6lfu9VSPlE2rbITe1gFfU/CtDTAHBj
         lAlBRy+37Ti0cqQwvYYFOt5JKo0L10ULyYYylzLTZBYXve5LbB93wLP/dcV+0QasPoJi
         T0FuxITlX6TOV6JQjCXCtOJM8TMIazUIVbqoeA8hFKAipX8NRbDhKljgyKoNwlR71ryg
         nIG45PUsFl9dxKudFyBS8tCEM7byK+cQVWAPWC+9CBcm7XlzUIRyt/A2mzYVTU664MnP
         qU6vrA3Qze963QAYjBPg6GFMoolWxSsSWSYA6yBeRRqM3k5f3txvleYQXzJ9dsS+flNP
         /Y3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697645838; x=1698250638;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xb1fystfuKYmk3pxBII0IcmxUS5eVGec3v8holcYxvk=;
        b=PLMTWR1SdM3y4DJKNzhvmi2QhTfvD9lGDxM7qNjpehMZ+Y8BZxy868tQCGgfmEVL/1
         CctrAl7NysLqaDFoNG6q5snohI8WLrZIGQouAGqpl2ypZRCycJqpQg1ggSuQGPboRAJf
         AR0tnz8+TFwBu4k5yiKLwCpjp4GahOqmHpqGddbDdfVOXgzs6aK16IHUJzQM9ay+9LnY
         eyol1xskSz9EejNUWeWPo8xxr+c5PFiP0Hv2NhLfeTeLN8DaDXNlKSjWLEEP9dYRhlwm
         oqtWPp6wnq4XnHEV2qtHlCS5h+gn8gGkypSgA/p4CYVBMw6VhyVgCZFjB2zlDQWDOp92
         91kA==
X-Gm-Message-State: AOJu0Yx7C/ref8f/RsisrJ2XfImPT5tXcBel2bBupC/5BmFDehquhwTk
        BWjHHmQGHW48UdtMW8MOfPKu/yCI3x4=
X-Google-Smtp-Source: AGHT+IHQD5HTfJPwg0oKIuXmVFaeMjNcwesqZEAcGnFzMQlAsKWO6zsu11aD4z3DEgAklTihc4mpUA==
X-Received: by 2002:a05:620a:2705:b0:778:8ce0:221a with SMTP id b5-20020a05620a270500b007788ce0221amr4068783qkp.63.1697645838263;
        Wed, 18 Oct 2023 09:17:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.43.11])
        by smtp.gmail.com with ESMTPSA id e25-20020a05620a209900b007742ad3047asm67031qka.54.2023.10.18.09.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 09:17:17 -0700 (PDT)
Message-ID: <6530050d.050a0220.53449.0930@mx.google.com>
Date:   Wed, 18 Oct 2023 09:17:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5966533498742833015=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: iso-tester: Add test for bcast receiver PA bind
In-Reply-To: <20231018143604.3484-2-iulia.tanasescu@nxp.com>
References: <20231018143604.3484-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5966533498742833015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=794362

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      28.51 seconds
BluezMake                     PASS      901.15 seconds
MakeCheck                     PASS      12.44 seconds
MakeDistcheck                 PASS      178.47 seconds
CheckValgrind                 PASS      275.42 seconds
CheckSmatch                   PASS      364.87 seconds
bluezmakeextell               PASS      118.69 seconds
IncrementalBuild              PASS      749.85 seconds
ScanBuild                     PASS      1114.30 seconds



---
Regards,
Linux Bluetooth


--===============5966533498742833015==--
