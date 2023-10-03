Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEA3E8FDB6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 20:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjJCUu7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 16:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjJCUu5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 16:50:57 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF00AC
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 13:50:54 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4195fddd6d7so2087191cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Oct 2023 13:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696366253; x=1696971053; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vcHEZjTFzSFGAso5sTdW/ssEwjvWW3Dn406OmlaLPiY=;
        b=noY9iqXt8nfeVG9o8YK7Xo1+Abx3EtHN1PTTQny7gQP6r2q5np0/LEB78li0QrLdPY
         ZCEbt+ldfQCh109lD5KbTp6M7JrbwqktuKkxA/P/7OglTUA/sh9VVgEPf9JW5DYg4oEN
         Lxp/0samjGlCU9CnnHad+5G1C/qOb9skkprNraHDvyzL/oQHFA3wDpL4XqeOKyrrtEL1
         antGQOsuXlzAPbACSypENdRRyslzXd4MdCAqwZPSmoUe3euC1k21zGcfrBQDVbALFqM3
         04ahWkqXOo69gSxk4iliJn1p7fTe9eWMscOwNy2a5rnhGbOtCMswK2uMU1zOQBdWLWO0
         273g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696366253; x=1696971053;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vcHEZjTFzSFGAso5sTdW/ssEwjvWW3Dn406OmlaLPiY=;
        b=El7WVZwcRITWVXlQYaqs55VMzl9Qr3ZC4O4TGQxdlr5hYPOlVG35VX5F6tCB0iAVoF
         pVl138bKj2+d9gnENsYQa23U+47+pltXi7n7ToxZ3fL4X2PLta3oZW2xTSoeeqrUbFYU
         AK5WDzxzsieaDibF/kPuki8oJwXnubeBseBW9Qa86Xnj+xhy4JVcZXuSKtCFYIBr05wu
         /pU4RUavHAr9+Kh0l4mDyTJmZH0ASbl24KNueMS/j40jGB/kHFEJmdUKHdEuVnG9EDj1
         xMj+uQXFcqj1VtD+I4pcea6fB/YgBX+2BPpQh4/UYxE8xWOFHyu3X7N2gWiWg2dOyu01
         sQGw==
X-Gm-Message-State: AOJu0YxlY8XsdWPve2GZ6j36RQ19YQCsE6448Y55Ntx6FqG8RpSiKb97
        NKFKnzbCWWiVefJF1bWPbelf1wUGMhk=
X-Google-Smtp-Source: AGHT+IHJeoysR1uWju9hzOM0/RIggFygQbjekhrbeaKfZAipuI30cT1F7B6rYzl9uY166ClWvk8p1w==
X-Received: by 2002:ac8:7c4e:0:b0:410:9668:530a with SMTP id o14-20020ac87c4e000000b004109668530amr576950qtv.21.1696366253243;
        Tue, 03 Oct 2023 13:50:53 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.76.102])
        by smtp.gmail.com with ESMTPSA id t3-20020ac87383000000b0041957506ca9sm722792qtp.15.2023.10.03.13.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 13:50:52 -0700 (PDT)
Message-ID: <651c7eac.c80a0220.601aa.3ff6@mx.google.com>
Date:   Tue, 03 Oct 2023 13:50:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8480787155770362819=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v3,1/2] bap: use MediaEndpoint related properties consistently
In-Reply-To: <530fedd2233740d401c67bc1470756c86cb578a2.1696360700.git.pav@iki.fi>
References: <530fedd2233740d401c67bc1470756c86cb578a2.1696360700.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8480787155770362819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=789693

---Test result---

Test Summary:
CheckPatch                    PASS      1.17 seconds
GitLint                       PASS      1.98 seconds
BuildEll                      PASS      28.77 seconds
BluezMake                     PASS      897.30 seconds
MakeCheck                     PASS      12.03 seconds
MakeDistcheck                 PASS      163.96 seconds
CheckValgrind                 PASS      266.65 seconds
CheckSmatch                   PASS      359.83 seconds
bluezmakeextell               PASS      109.91 seconds
IncrementalBuild              PASS      1459.07 seconds
ScanBuild                     PASS      1105.26 seconds



---
Regards,
Linux Bluetooth


--===============8480787155770362819==--
