Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5486CC77B7A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 May 2023 03:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbjEaDGX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 23:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjEaDGU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 23:06:20 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B4211F
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 20:06:12 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-39a3f165ac5so957356b6e.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 20:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685502372; x=1688094372;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rDEmopEyfHVQTJLSnROXoGt8U6tB//nK63vpRqWiJh0=;
        b=i+by0zK8s8ZheynTBD0L9kyNDKDj7XMMur9NxDZN9OAoIhf0KpN1spn/azfNPI7M4Y
         f/FzBxsqOpmN0YGzFMI2TT2AY7q3WL7tMEMhxBZF60l7SPF0TjWHstg9vNuClifQtv6/
         mQ/rf137LnK3YkLBojazfX83XaLWoKTjoL43T0se/j7Gj4pcAWIyErzqgRdg1Yd38r4w
         uxEtr5q80g++AuPWuIZOEsn522Ex2ZviZ9+P9+nlYMBFrKqxikr1YmLFso2f/fe9EdQD
         7eIQxPAbZwg5z8ljB0hOShtUgsEOjXFZphvL9gH6C0K4hLrRBU/zRNPY73PxF4zdLj/b
         /K8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685502372; x=1688094372;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rDEmopEyfHVQTJLSnROXoGt8U6tB//nK63vpRqWiJh0=;
        b=Tz6k/14dZ+it4pghO7KFfo0VWplUq9n4d20EPvMU/Jhzpp0ac5fa+bi6q8tIq1St9U
         EjjL2a5kp3FNQ3iQMT3YLyVbaa8drQhuDpNKSQAdRf36dZirleNeM6xq+VjbSqWq6PRt
         6O6bpOuzszNCxm3VDs+UyywM5pmdWeYDjBIEsM7xLXmwyVWxDrjMdXkwN4Kq1g5wFHlE
         F0dMM3X1kN40n9X4VhMZuQV0VwwqaaA9DkHATha2puSsP+CDmyRNWM1DlqwgiPo/NXpg
         2emAZypJ/6ukvqeTEaPFtqGgOTPBxcwqSIfkJHAGPcRVTNNvD2yYd1Qk4W3EK/lz1oo4
         VRbg==
X-Gm-Message-State: AC+VfDw5cS1pnDOq4FKITGBaUcmh+xFCM22RdBNu8XWK5E0+gcsA6Vh0
        sdyxX++XFmjMFEm7wcYygZfrCnqO18Y=
X-Google-Smtp-Source: ACHHUZ7DnCzq/ELl29y+y9gdtQDUdD+nnMCrj2BGhSV0N6+UjmihVgyRka5+II+K7FRhqDS8Khr3Ow==
X-Received: by 2002:a05:6808:424c:b0:398:2d08:1143 with SMTP id dp12-20020a056808424c00b003982d081143mr2190736oib.35.1685502371760;
        Tue, 30 May 2023 20:06:11 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.219.146])
        by smtp.gmail.com with ESMTPSA id r127-20020acada85000000b0039a52401ef3sm10422oig.56.2023.05.30.20.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 20:06:11 -0700 (PDT)
Message-ID: <6476b9a3.ca0a0220.600d8.00a1@mx.google.com>
Date:   Tue, 30 May 2023 20:06:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6572675588528593752=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yinghsu@chromium.org
Subject: RE: [v4] Bluetooth: Fix l2cap_disconnect_req deadlock
In-Reply-To: <20230531023821.349759-1-yinghsu@chromium.org>
References: <20230531023821.349759-1-yinghsu@chromium.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6572675588528593752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/l2cap_core.c:4663
error: net/bluetooth/l2cap_core.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6572675588528593752==--
