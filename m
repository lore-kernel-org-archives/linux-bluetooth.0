Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9F9C64E7A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 06:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 878B1205ED
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 06:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgLCGFC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 01:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgLCGFC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 01:05:02 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFF5C061A4D
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Dec 2020 22:04:22 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id n14so888717iom.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Dec 2020 22:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=STDqOXiB6XjyZrlYqeRNeaTP5PBzbi9Er7znoXIe1dw=;
        b=h/DtrBR1wJeJGggVVWh8RjyQkL+OltanbrFefv0Gy3wst+Ma4CxFAGT+4H5X3BwNf3
         gRDZ/7FD2n4Rzm1VqM5+Bc9qAhgTcELt4J2+P1mqjDUK40g9W2F6ur3h2qfyZDpEeVXt
         Q+opzMfin1ICeZAiLfIM4KjKMQUbqRVbS8W5iEng1j/qkhKi0WWnjyWh9Ywt17y6OxI8
         dn8eNZi5mPH+EfmasVMQqGgj3YxbXzGhJYoSkzlY/FGYeZe2apGUv7QVjspTKe/a2jXe
         0NljHcwBmitT8iWqG4xQEk0l3hQQ33ztCS2QWg/wLT2qLJDdoW7j9oUguXeiPB//aivt
         8fzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=STDqOXiB6XjyZrlYqeRNeaTP5PBzbi9Er7znoXIe1dw=;
        b=ajTKd4zROIuiAWD2OnDM5lZZGx4oRVuII+T1hqGiCB/jI5t3K53XhwMQT0Qh6ADyG7
         cVPg5g/PpN+Dx8i6XJCuM+h9FEDL/T/sQR4iaJByX1pU6Q45ftvjhLnj5eqH8yzhCmUc
         0AF/95mAoUDnFy3exi6L0rIYrTXt3hNEm0uh1NbfWq3x24LP8G+pJTWst0WCjI2iBpVz
         dkgVKP4rPBIXJhHEpQJ+ZHJca9dUbDxXo4EY1rWR8g0M0K3Nj8Y19jIQdiHIihhuHUw/
         +JLU1gfer7oAXeIJ2FtOMxc2R2Ai9u3jEimlDXa2NoG27k6daQJGCxbZzW/eAkX4GRKy
         2Nnw==
X-Gm-Message-State: AOAM530A1WJHNshCN9EsywNJwtIclqWGutgO3gOKbJaFxbvx0dmy+g+O
        KRNw4nXAqNXbmwetW+YthmrKeILPL9k=
X-Google-Smtp-Source: ABdhPJzdv35fV3Fea7317dbG+IJ+hB6+zH/QSAW7VADZAzJyFTgqKl6Pg7mfPi7gb/N6xVMpxxecJQ==
X-Received: by 2002:a05:6638:50c:: with SMTP id i12mr2081147jar.74.1606975461769;
        Wed, 02 Dec 2020 22:04:21 -0800 (PST)
Received: from [172.17.0.2] ([52.252.100.121])
        by smtp.gmail.com with ESMTPSA id s1sm66458iot.0.2020.12.02.22.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 22:04:21 -0800 (PST)
Message-ID: <5fc87fe5.1c69fb81.d579b.03da@mx.google.com>
Date:   Wed, 02 Dec 2020 22:04:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5462868916117773626=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, zijuhu@codeaurora.org
Subject: RE: [v1] Bluetooth: btusb: support download nvm with different board id for wcn6855
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1606971434-23709-1-git-send-email-zijuhu@codeaurora.org>
References: <1606971434-23709-1-git-send-email-zijuhu@codeaurora.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5462868916117773626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=395155

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - FAIL
Output:
Bluetooth: btusb: support download nvm with different board id for wcn6855
1: T1 Title exceeds max length (74>72): "Bluetooth: btusb: support download nvm with different board id for wcn6855"


##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============5462868916117773626==--
