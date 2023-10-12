Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534BACDB474
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Oct 2023 21:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442911AbjJLVhR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Oct 2023 17:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344156AbjJLVhR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Oct 2023 17:37:17 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FB5B7
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Oct 2023 14:37:15 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-564af0ac494so1090074a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Oct 2023 14:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697146635; x=1697751435; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X3Qtm9w/VpOAiJu/Jjk7r4Qr7ygufm74US4MRIUyg0o=;
        b=PyrVMOHBH7G0+K+QYzrwwWEVWlSE5Gmu9OnWIdmYIFA+0axaE9K+Bs6OCGizSOi975
         FGN4t2XZ3zV3l9LTIKimLdBVqHix8GyD/IN61CdxS9a9DYriqIn+cymklJWyav3h2GIj
         PauxddjIy3m8zwEiyo0itNUtplszVtEwtYBSYIXDr4b0eHrqNNL9YTxBsTV0/4+DnLXs
         TKCKe0ojZbTJdnD9c/r0m9JlFbIikPL5TwZMcZTMuyTZ8hO2b5W46M6sAYpoVBi+iMsV
         1TZXcmsWu75045ppa3ECMRV+ikjNvIbnQTwyejQTkbK8sSQqp+G/Ue5xJnEyN9yXBr9f
         4tjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697146635; x=1697751435;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3Qtm9w/VpOAiJu/Jjk7r4Qr7ygufm74US4MRIUyg0o=;
        b=PrHir0MycKj6vxHk/ZmIgWmK2VLvf4hPsFqf5rniYDZk+LpIYA0C9CTmIOM1J8RNzD
         J+wsOROLk3zmSJmOEFtqdmxY3vC3ntFB3IhayikxVrE+9Fh0c+sQSSADXWKlbRmNUObY
         jKui2snqlsI3tArWZeKJwBFQbVZDzjpkR81sPgeVH/S3js8vBF64NSkjWxeJp3TaH+pA
         OyVgF9/joRhSxaVwIbsPlxtnunCZY6VqH5W66e8upnIMjVKGGQLb78ETaRSo36yDU8FQ
         CzJFvAC+ni/wyLcdkT/gzypuEpEO3XBBNifZ+OfibV1r+A3C4Pb2qeBS+PsHnIAKrhce
         3EAw==
X-Gm-Message-State: AOJu0YzrCumP2yt/Ytdcoh3m/9KjJmUvXZH/7k87NOdiA/QMK8Jbo4wQ
        wMzsOTxrry0d5zZzZFlcZ6hKr3aVt70=
X-Google-Smtp-Source: AGHT+IEwea4kgezhd9OWSmJUIq2A5VUviduUQIraG+uqh0haVuMRaTTeHDeFl4OvomL2GHd5T8QGHQ==
X-Received: by 2002:a05:6a20:f3a2:b0:154:9943:7320 with SMTP id qr34-20020a056a20f3a200b0015499437320mr20757003pzb.28.1697146634725;
        Thu, 12 Oct 2023 14:37:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.45.227])
        by smtp.gmail.com with ESMTPSA id ji10-20020a170903324a00b001c444f185b4sm2449494plb.237.2023.10.12.14.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 14:37:14 -0700 (PDT)
Message-ID: <6528670a.170a0220.69bab.8956@mx.google.com>
Date:   Thu, 12 Oct 2023 14:37:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8120449603753531137=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] doc/obex-*-api: Rename to org.bluez.obex.*.rst
In-Reply-To: <20231012202207.1365107-1-luiz.dentz@gmail.com>
References: <20231012202207.1365107-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8120449603753531137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=792726

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      0.24 seconds
BuildEll                      PASS      28.06 seconds
BluezMake                     PASS      814.27 seconds
MakeCheck                     PASS      11.67 seconds
MakeDistcheck                 PASS      175.89 seconds
CheckValgrind                 PASS      268.35 seconds
CheckSmatch                   PASS      360.99 seconds
bluezmakeextell               PASS      117.25 seconds
IncrementalBuild              PASS      705.34 seconds
ScanBuild                     PASS      1088.42 seconds



---
Regards,
Linux Bluetooth


--===============8120449603753531137==--
