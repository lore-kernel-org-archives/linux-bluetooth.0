Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14DCE7D0A6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Sep 2023 19:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjIUTyc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Sep 2023 15:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjIUTyQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Sep 2023 15:54:16 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B1C66342
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Sep 2023 12:02:10 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c5bbb205e3so12063435ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Sep 2023 12:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695322929; x=1695927729; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WU/ytcwtBCmxBKDAuChAeWFI27o1b45Ab5bfpr6voEY=;
        b=nTVb/7hcyTsJh1Pij9HuQ6CNVBGOHUX9PNP45iHSm7hkpDtOv5sHjfJGLJiKu8OQmN
         JRUtCJpYcSnbTkcwMcWfKWluiRFIz8ADNhf3pFnOg5P7gxb6+2YWrvy7/NyhTt2QCjNy
         QgEYbLuTRgtkvORIa+pqRWhkDS4DhhI6+MpguW0Z90ffbA3M6ewW9jthMeTW8n2dsTt5
         KixVASLh7E7tdsz8HWFQ7Tt6Qc1yh3eEbgrFxplcgMwUdYhXysVVaqkyUw21dXMI37Xf
         TMFn48VRxpkqz2J1WbQ50d0NV6V5bTskcxo3ka/sjPsvcNGvpKZxaC0TyRr6TGDqYAoN
         35sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322929; x=1695927729;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WU/ytcwtBCmxBKDAuChAeWFI27o1b45Ab5bfpr6voEY=;
        b=qhDrk6Ov1vuUQ838+LNcc8D94UL1IvLvMnYY/GQwPaxmHl11UtZ/pD3ghPJu7tg4l9
         Yxqlw/IVe5n2O5fuO6Ezzl6vRMIfqXskI8FQlrUUxEz14AlWgAp3qBtwNWiqx2gtBvm/
         MYdpU1PQfSqInu6DTTlHQqhV4OFB1wz9g6+1VkjL8Fs+IUljJOa+4ih2XM0Mffm4gQHb
         E2Odv6Se9g00m3JuVG3PrxXuecxj8BsnxFDBSYO3YoBSZOLHzFzP4FJF8QqTeMtYXcu0
         ZI7/mALJdXhM1AsBxPcJM12LSxR1DPBO2q4FsvZyoD4MHh1wDjQGrcFeW7y6oB1wv4as
         e3Pw==
X-Gm-Message-State: AOJu0YyzkpQP1ortAes9btk/cSmm0Gvo+0nsnIi4n8Vz+MbwtU9mG75u
        c6pdGCB6DHS+DEMn++Ov0qmXxFH1vQY=
X-Google-Smtp-Source: AGHT+IHXv0naB6saWPt90mvCYDBxsJa15JdLP8h01Nh1XAxqpY+lS/nwaPrmxUY/fWqzvFIG/NaHMA==
X-Received: by 2002:a17:902:da81:b0:1c3:323f:f531 with SMTP id j1-20020a170902da8100b001c3323ff531mr6752083plx.20.1695322929263;
        Thu, 21 Sep 2023 12:02:09 -0700 (PDT)
Received: from [172.17.0.2] ([13.64.11.215])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902f54c00b001c55e13bf2asm1868391plf.283.2023.09.21.12.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 12:02:08 -0700 (PDT)
Message-ID: <650c9330.170a0220.ad36.7b2b@mx.google.com>
Date:   Thu, 21 Sep 2023 12:02:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8852524929467329284=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: client/player: Allow the user to control BIG encryption
In-Reply-To: <20230921103945.36180-2-vlad.pruteanu@nxp.com>
References: <20230921103945.36180-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8852524929467329284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=786290

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      37.16 seconds
BluezMake                     PASS      1261.17 seconds
MakeCheck                     PASS      13.59 seconds
MakeDistcheck                 PASS      211.70 seconds
CheckValgrind                 PASS      338.49 seconds
CheckSmatch                   PASS      472.16 seconds
bluezmakeextell               PASS      142.40 seconds
IncrementalBuild              PASS      1072.57 seconds
ScanBuild                     PASS      1491.32 seconds



---
Regards,
Linux Bluetooth


--===============8852524929467329284==--
