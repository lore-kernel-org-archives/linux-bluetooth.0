Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589C9C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 20:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350392AbiFJUIH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jun 2022 16:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350393AbiFJUIG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jun 2022 16:08:06 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D3C23D9A5
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 13:08:04 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id q1-20020a056830018100b0060c2bfb668eso10425ota.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 13:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=dv8FiFkSDUoyOsPyX1/hjV8YlB9NXwVWBi3o0hryJhA=;
        b=Ccx52uK3Uaq+rqHg7fhIV1Yjeqo7q/KKaBAQu5z4gx3d3vgTi0XXaH1EEa/ZtesHzF
         MrD2MxuGnKfBfFXOh7o9nVXD2ID1LkxjZXzoEQVDXHz6WIjguzSaVrPoeQd6gthTL4GA
         L01eLQGau33RdOdMD3XRTX2aoZXpoX+TjgC167zW6z5o564BKDxnf+3b7f9mcWDD7fkQ
         YlpuCoNLzfwD8wlQGbu+r0Q023P/xKSKOSQAGelzJAbvr7X39oZFAvhRHxho0eJZ3yb8
         HjnJMYbtaiIAuCONq1Elqs/roKk12a0AsLhvUDR06uNT1vXgf6IKjHqkNrydmupT/y95
         sQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=dv8FiFkSDUoyOsPyX1/hjV8YlB9NXwVWBi3o0hryJhA=;
        b=xDhKNobObTaTk9uhsWxdk8UqutACTxlWs8dx+lzqcH1TbK2NFCu1INA8yqEVbTDyYQ
         kdVx/TYVr5wDTJ/WsO7isQrGEsRTBK97EDG9iOeZXV3uPENOOE+ieQIG3xwtDTopzX83
         ePcKMVlknmfn/cisLBn6dYt4co5t4jd51bOzQMraoW3JNKAyn+CzdHNbpz3l7tsTJxYo
         WLjBHOzVgzoJvuzH96eSv3ONFMW5BvOEPQG167DNOzjMQ6UgG0y82DFjA78eZSCRB36j
         LHW0D9iceMZEj4D8kgq7sMvFTcwyK81Z22oNTTYuMHIK+edFp2lMFc/w6UQBC+/3f0tB
         h2LQ==
X-Gm-Message-State: AOAM5338sCsUzKZhkdAnjZ9O+5kb8a9ccj6Rzm+Pdm8WJeQwIdtiNh9P
        O9o/tHO+Cu9VlRGbDUsr5ldN5LgS9s4=
X-Google-Smtp-Source: ABdhPJzJer2IZJJr/h7QC8LoJATKBAzaUheo4ytgdf52HcW68rmz/GaFr0XCc79TNqirIDUDc5JC/w==
X-Received: by 2002:a9d:5f0c:0:b0:60b:f69a:cd75 with SMTP id f12-20020a9d5f0c000000b0060bf69acd75mr12665967oti.5.1654891684473;
        Fri, 10 Jun 2022 13:08:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.7.198])
        by smtp.gmail.com with ESMTPSA id d11-20020a4a918b000000b0041b87a7a654sm86584ooh.37.2022.06.10.13.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 13:08:04 -0700 (PDT)
Message-ID: <62a3a4a4.1c69fb81.74b3e.0576@mx.google.com>
Date:   Fri, 10 Jun 2022 13:08:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4747017862524629041=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: test-runner: Add support for audio daemons
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220610163820.79105-2-frederic.danis@collabora.com>
References: <20220610163820.79105-2-frederic.danis@collabora.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4747017862524629041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=649349

---Test result---

Test Summary:
CheckPatch                    PASS      4.57 seconds
GitLint                       PASS      2.95 seconds
Prep - Setup ELL              PASS      54.51 seconds
Build - Prep                  PASS      0.75 seconds
Build - Configure             PASS      10.73 seconds
Build - Make                  PASS      1894.15 seconds
Make Check                    PASS      13.11 seconds
Make Check w/Valgrind         PASS      570.37 seconds
Make Distcheck                PASS      301.02 seconds
Build w/ext ELL - Configure   PASS      10.96 seconds
Build w/ext ELL - Make        PASS      1856.12 seconds
Incremental Build with patchesPASS      7611.82 seconds



---
Regards,
Linux Bluetooth


--===============4747017862524629041==--
