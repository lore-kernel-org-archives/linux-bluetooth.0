Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB35E8FDAF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 20:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjJCUVm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 16:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjJCUVm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 16:21:42 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CD39E
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 13:21:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c736b00639so10368555ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Oct 2023 13:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696364496; x=1696969296; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kTlD1hJ56QFIVhFmdNHO/9Yxdrvj3+hfP7pfKoUpFFQ=;
        b=iQgVo57GYBnuVg/5yCCnOgprgJfRLwFKpUIrXUk/Av7t1pNgtbUoolX66eUCzNpejb
         WTa7EctT/KWqbA5vY3P7y6LUvyoYc6MH+as6QJvFlwM68ZLk11rD6yXvZnWOh3sHpM2E
         x+7eSVewqSXSUFwGAzVmU5mqzrEU5EjM6cxox5Wrhm3cF7IHAfgZO0TtD4tuc0Bf6xBE
         m+l7qJF+tQ9f+h51q+Dzj/UM5FurIGwVME7a6wWScR97CdvT9J1Y50yA6b6R+PiiZuX/
         UiYBXVaygD7OCg5LLb6xDaCD+bo1gn8JgZ+EBXfIlcQTcdI7ughRs8+/yCWdyM64pUL7
         Ejqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696364496; x=1696969296;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTlD1hJ56QFIVhFmdNHO/9Yxdrvj3+hfP7pfKoUpFFQ=;
        b=Y9XK51IW6/ExgQoh5y4xWDPgIAmBZD+p97JHACK7TReYZJh+1X3Puysc8te2O/Ffub
         vAFKOFdLXkKdEhghb9J+dLjJ7pO1IUKbJMW4P+Y6gFNAcqlUHdSdd16dbdPp78A0vwb2
         r1ZwcOo0LipzKQqEFgkMwN5hYiwcZ/vGQSG0Wvn1FrAuIG9xeyg4m8DxNXuq/n1+VSOZ
         JghRSBKeLbWDS34cTT+iFa/f0q+0Cb8LUv18miz3JNACaW+2FQaHRJnrs0k8o2f/LwC5
         X0c8jKJ1pnlDvuPo+xKH88dzNmmdYTmf3vK1ORI/+jzxuegKUrXynAEuUEa6tJ5p4Mmn
         qhFQ==
X-Gm-Message-State: AOJu0Yzi7aDDpg1g/fxVIaIzPYSLfvrp8ijk704bUuIc8mYVCAUt5n1v
        Wom2/cJ9m0NrYR46BB7sFvAhOrw/yg0=
X-Google-Smtp-Source: AGHT+IH6V4qcuENBOcbuLwEUx90XPuK5NumdOMwEr5PX8l7qs3c5opE48HhHx+f0jdEsVjFqjs2CqQ==
X-Received: by 2002:a17:902:9a44:b0:1c3:f4fa:b1a2 with SMTP id x4-20020a1709029a4400b001c3f4fab1a2mr656470plv.8.1696364496471;
        Tue, 03 Oct 2023 13:21:36 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.3.162])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001bb0eebd90asm2010250plf.245.2023.10.03.13.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 13:21:36 -0700 (PDT)
Message-ID: <651c77d0.170a0220.2dffa.60a1@mx.google.com>
Date:   Tue, 03 Oct 2023 13:21:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5127394290188766336=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] shared/att: Don't keep retrying the same operation
In-Reply-To: <20231003184222.3273301-1-luiz.dentz@gmail.com>
References: <20231003184222.3273301-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5127394290188766336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=789685

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      33.91 seconds
BluezMake                     PASS      993.14 seconds
MakeCheck                     PASS      13.66 seconds
MakeDistcheck                 PASS      191.90 seconds
CheckValgrind                 PASS      308.54 seconds
CheckSmatch                   PASS      414.86 seconds
bluezmakeextell               PASS      127.84 seconds
IncrementalBuild              PASS      811.02 seconds
ScanBuild                     PASS      1271.64 seconds



---
Regards,
Linux Bluetooth


--===============5127394290188766336==--
