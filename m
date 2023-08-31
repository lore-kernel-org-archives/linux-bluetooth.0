Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFB5CA0FE1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Aug 2023 23:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241061AbjHaXRY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Aug 2023 19:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjHaXRX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Aug 2023 19:17:23 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE8FE8
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Aug 2023 16:17:21 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-64b8e1c739aso7780356d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Aug 2023 16:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693523840; x=1694128640; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hNcKnC/c30dRtjRVay40yApJqOA0fLNJAZkx9ByIjdo=;
        b=QNcN8bsHXd/CS9dvVCwf5XwjEoxux5O/aqwHtDVKOP+OEsHoixQMs25Dnzafx1TUR/
         N1uSkoEm4wWks0CfqJFbL5CoZ8XI9Idr/Bzkyh1sBE39VtTKK5RnJVNZtGM4yVgndsj6
         JxTJiSBeiKdQtoI09ZgKIU/Cgll/inQZKVuTPhRswB+vzfT1AsJhORcLnOUJCEwBRjUd
         zbMo0CfcWH9ijJHmfHxVebXVzx8Yj9Pki17ZkZHtfiwPxCildLqThnMtdGp2JmgUJa0X
         fXmjGFdROXxtdglDJAchhnnZAzaJHeFeUncx1drZIa2UW2JZ1FRwv9Kmz2xhOIqmiUYw
         ufxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693523840; x=1694128640;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNcKnC/c30dRtjRVay40yApJqOA0fLNJAZkx9ByIjdo=;
        b=G2HPQSkwdGrSsHzEOuWGa07ppQAJvUgNbfO/JWMuUc1KqNgi2tvRj2sd7FkQm9m4P/
         d4eXrHublQImspMhcTnXNinTDhjqA64Cp31Ljr5OULsn5R87/sMd9KrdBq3ZVmDhuCJM
         RvuBLwnwM0bAFkj8kEeTd1ryD2zx8qG+hLaXVibCI2MH4y1gR4PbJ3xQ0Pc7uffz2g0J
         sSwhpEMhH5qr5zPr5Nx++osasb5B8WuWKPHA384Ifn0EJbGw4ri1/Vhxl2CyH3bPPOvg
         YpEAwGQSOC+4q3d+jFLdMUYwqh4yMTjN/HGUaikdAjOG8zPRGb40ni18OT56Gq9JSMHr
         3jIg==
X-Gm-Message-State: AOJu0Yz/D4nCRQezxpKRxyceU4AQ6iMjwB7m916m0AQb0SW6ciiyYtQ1
        xWkOthlmQwmFogEbvaNNk+5147B/qFw=
X-Google-Smtp-Source: AGHT+IGZDZKSEdfe0YJ8Ay5dCUJS/0BHlRRcndWFXdR0PoSjhZh0zic65QTh/4RqYwXNJb32HHDJ+A==
X-Received: by 2002:a0c:da0d:0:b0:651:7fa7:b85c with SMTP id x13-20020a0cda0d000000b006517fa7b85cmr768568qvj.42.1693523840221;
        Thu, 31 Aug 2023 16:17:20 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.65.70])
        by smtp.gmail.com with ESMTPSA id t10-20020a0cde0a000000b0062de51d8a12sm976215qvk.26.2023.08.31.16.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 16:17:19 -0700 (PDT)
Message-ID: <64f11f7f.0c0a0220.bac98.335a@mx.google.com>
Date:   Thu, 31 Aug 2023 16:17:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2848214048872593722=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] bap: Fix not always calling bap_io_close on disconnect
In-Reply-To: <20230831220137.1164891-1-luiz.dentz@gmail.com>
References: <20230831220137.1164891-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2848214048872593722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=780965

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      27.49 seconds
BluezMake                     PASS      1016.78 seconds
MakeCheck                     PASS      12.13 seconds
MakeDistcheck                 PASS      161.16 seconds
CheckValgrind                 PASS      261.19 seconds
CheckSmatch                   PASS      347.49 seconds
bluezmakeextell               PASS      105.31 seconds
IncrementalBuild              PASS      849.83 seconds
ScanBuild                     PASS      1090.50 seconds



---
Regards,
Linux Bluetooth


--===============2848214048872593722==--
