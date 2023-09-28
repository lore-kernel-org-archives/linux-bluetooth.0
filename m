Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056C9E743C9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Sep 2023 22:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjI1Wwj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Sep 2023 18:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjI1Wwi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Sep 2023 18:52:38 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739EF1A1
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 15:52:35 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-65afac36b2cso53969676d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 15:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695941554; x=1696546354; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GiE7HTZ0rvI3ujxamApUFPNcL7p3bjhAW1IZw5AMlMs=;
        b=QcVjAs/x0s2uhNtaCHKZYALxHWBVOA2WtSaJCDWp884ZBPzB8TI2u5KNwFNw8cIqCt
         /ZflvBNvLfLKDaGnjaf+Vr7dvC3oJh75+VIl2m/pkeTttE+JzttijWRlsd3hZzpaaVej
         AaHliuKRK2Z9Rbgm3XWk0zWgW5bEvdFa/+YCk3ARCWwFPHfZ0RAvyw/aJWO1bnRv2pjb
         qGSo7D7Kx3Ddby+Qmq1eMpSi2Uj871oX/8KuTfTbqozi+ka/1dqu0Euv2cdREysdbecT
         LuXWdlxtAm/+1oudHJincn+kNb7iEqcHRoPH12qLLU2Mp8s+m37GGp1UaxuS0dPWMYB1
         xzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695941554; x=1696546354;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GiE7HTZ0rvI3ujxamApUFPNcL7p3bjhAW1IZw5AMlMs=;
        b=a5GXkUDmLta2vlbcM91rjgiaQLFktxEsUuCOEGne8GBxzERnWAmjGs91+F1pn1W6Or
         DXsQEKDjW4bgF49/u+Qz8wzQZhOq6bESVkFlEprPfS62WpHJVernlfU9ALU9WuUvID00
         RO+8FrHYSPBajHRfEGRzolfhsGkT26l/P1fr7xaDTEJT9lb6yh6LEXXmbq6cBqz99+g3
         bBPeoBJ33qwjxY8Cs5ctpYzzQOgptF0feo6cWGrHl5sX51RiL2ytJKpFxtUf/qXd9h2j
         DcNf6wb0PMK5ATb47/LeThupk5EU7O/srZyAkHLuzpsPTWe8J2gUmhiJgnoo6+oSpKoT
         TTuA==
X-Gm-Message-State: AOJu0YyzgcM/MJCOOD2rDOXHNIPTFFpuMjhtUOOaiKDNzmt0ruJ8Relt
        2RIpRj65m+FiKgm9GuDgEyp7BGTL6GfoGA==
X-Google-Smtp-Source: AGHT+IFTXheMiNAHN1Nuyv2dnZQYJKW99wMiMS+1ry+2tvpjSYu0JdjrHRdnKVq1vyBMU7TntyYMHw==
X-Received: by 2002:a0c:b384:0:b0:655:f784:9d25 with SMTP id t4-20020a0cb384000000b00655f7849d25mr2357950qve.59.1695941554392;
        Thu, 28 Sep 2023 15:52:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.185.154.9])
        by smtp.gmail.com with ESMTPSA id n17-20020a0ce491000000b0065af657de01sm5115615qvl.115.2023.09.28.15.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 15:52:34 -0700 (PDT)
Message-ID: <651603b2.0c0a0220.3fa2a.3d10@mx.google.com>
Date:   Thu, 28 Sep 2023 15:52:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7680628445243381074=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] csip: Fix not registering CSIS service
In-Reply-To: <20230928203856.2100456-1-luiz.dentz@gmail.com>
References: <20230928203856.2100456-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7680628445243381074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=788643

---Test result---

Test Summary:
CheckPatch                    PASS      1.28 seconds
GitLint                       PASS      0.79 seconds
BuildEll                      PASS      36.85 seconds
BluezMake                     PASS      1218.47 seconds
MakeCheck                     PASS      14.16 seconds
MakeDistcheck                 PASS      208.80 seconds
CheckValgrind                 PASS      334.77 seconds
CheckSmatch                   PASS      464.27 seconds
bluezmakeextell               PASS      138.68 seconds
IncrementalBuild              PASS      2071.50 seconds
ScanBuild                     PASS      1395.03 seconds



---
Regards,
Linux Bluetooth


--===============7680628445243381074==--
