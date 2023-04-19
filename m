Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CE5C6FD18
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Apr 2023 04:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjDSEgy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Apr 2023 00:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjDSEgx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Apr 2023 00:36:53 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4627297
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Apr 2023 21:36:48 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b5fca48bcso2402956b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Apr 2023 21:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681879008; x=1684471008;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ItBDwvQf9UPpub5N1DdRK0SORyOwk3XizUYBdmynHJc=;
        b=FlNQ0BX15sb7U8v6Ev2ERGj6skviZU25UQ5bWtAbx2nszV+3LdwnCyyktBKXy7LEAQ
         i5GF3pS6KW2esp9w72qVoJQNDP7sfVJJYn9z1dLE0/LmsEzuevBUp6aFHVaY7pKP5QLD
         dzakGJNuJCZhtC+hmfTCQtFmjcjOT8ifNDJfAPTRQA7on3It001iYXckArdpBpwwkDUw
         s6UIBJ2PyingGeIO4fp4pQJLbt27mu3SYpGhOYFdAqhWY+/T9BO6lNrqUmw3K2tjvhKj
         8AgnRwmpToZt/5vUD8WwKKNXhIv5XPHF3FhqtR9qtoLl0ppdnC0m4VHVV2Nu/hJXiIfg
         9Ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681879008; x=1684471008;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ItBDwvQf9UPpub5N1DdRK0SORyOwk3XizUYBdmynHJc=;
        b=Uc8CDKQbdx+YFomhsjIiBT0/pEW0OczskDTMH5U/GyPdU9fE78EBK+dFGSzWk92epG
         MVGGh+M9nbqKF9g1bKfXcleBYA9Wt7n50z+qphYaGLHXC8sJ/w2p/vEm6E2uQeahZTRp
         Nmv5FMMAnaFPnaCVr1wVbmGh3U6P4gx2bahxCQ0XAv/JmZbDOFNzi+DHlrG+4DAj3u3I
         40gV01+ep1FGao1CwCgNj6o8Dy42WuTId9R+bYF0z6uDRnU3Go1vpIHlFXxiZFLRuXXT
         vGXRVgEfTNyIVSR2UmPiorFiSqB28/SvnX8D3sVmJi9qQSfA2X38bhG8+gaNgn6550YA
         Znxw==
X-Gm-Message-State: AAQBX9ecPOdCbbLi5evh8IOqtsQXk2ghm0je4spMuTNLv7Jxz+vKTMTZ
        Wf7AebLrFj7gb/g3FaMmbwLxIOqtIFY=
X-Google-Smtp-Source: AKy350Y/LIqBeXw5C3a+AAfHqONhnghBrd7RCNf0pzZ5XB/5fPPuOz4R4ECPqjz3iYXISGczeOsXDw==
X-Received: by 2002:a17:903:20d4:b0:1a6:eba7:5840 with SMTP id i20-20020a17090320d400b001a6eba75840mr3412289plb.68.1681879008166;
        Tue, 18 Apr 2023 21:36:48 -0700 (PDT)
Received: from [172.17.0.2] ([137.135.38.227])
        by smtp.gmail.com with ESMTPSA id m7-20020a1709026bc700b001a183ade911sm10391175plt.56.2023.04.18.21.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 21:36:47 -0700 (PDT)
Message-ID: <643f6fdf.170a0220.30a59.7acb@mx.google.com>
Date:   Tue, 18 Apr 2023 21:36:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8756655104465415869=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, aarongt.shen@gmail.com
Subject: RE: [BlueZ,v2] obexd: support to reply folder name to store file
In-Reply-To: <20230419030742.6123-1-aarongt.shen@gmail.com>
References: <20230419030742.6123-1-aarongt.shen@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8756655104465415869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=741164

---Test result---

Test Summary:
CheckPatch                    PASS      0.40 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      35.88 seconds
BluezMake                     PASS      1255.38 seconds
MakeCheck                     PASS      13.43 seconds
MakeDistcheck                 PASS      198.60 seconds
CheckValgrind                 PASS      321.01 seconds
CheckSmatch                   PASS      445.69 seconds
bluezmakeextell               PASS      132.88 seconds
IncrementalBuild              PASS      1027.23 seconds
ScanBuild                     PASS      1453.87 seconds



---
Regards,
Linux Bluetooth


--===============8756655104465415869==--
