Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6924AC54EBE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Jan 2023 06:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjAMGOY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Jan 2023 01:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbjAMGNR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Jan 2023 01:13:17 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3945569B35
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jan 2023 22:08:20 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id e129so10103777iof.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jan 2023 22:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WCbGFA2GBWQtf8uhpbhaNhBDOAnHwFjhT9LxdYniqxQ=;
        b=BVvWFt3sQypO4OvMDYSoraHbMcNikw2DJutveEPv9urX/gNORTer2Z6BAzINuTk3n3
         bl39fLP9WqY9do6z+gyNUH9ybz2g6cvK3IwZ7LXFua5t7+0AJTLki/Dad85i6/jZktkS
         R4H/hU2EYKQ276GJFDoo9IgnYa9MO9QlfZajAJaxq1FYFcKgdEqMYBysVoUEAeurqTT2
         pBijr6sGOf/rjyWYfpxUs5AmITunPxgm+8ZQ8D9O2tVhMOd0RFdPv4OTl52DUnimz+mV
         Hbp8HOWCpEDPPAtU7se+jzszvvmHJamXCB72TlWjzbxSEepOPJ6CO32Z3Yyc5i5zG9Ce
         5ckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCbGFA2GBWQtf8uhpbhaNhBDOAnHwFjhT9LxdYniqxQ=;
        b=UwteRP99wRg6716ekz0pCa3xDyoG70fVsEgO+8vr9TSfmI1O6mC3E4a/YtQXi43baq
         8uizhU//fZUkDloDaBdIAjKainUFtmDWDlxuWK6EwVkeDI038k7BIY8m/Krqimf3vF68
         t09LPojvtCYbuO6hWmhdaWl/YULtEs4sCo30pIkZFpF7P/OLPa33r8/0enpEYC5CdDKq
         bU7XEKhcuz2g27zJu700MWITcQmKtonCZJ7Q7CkNg193kzKiePLNwQ+4TtdRq/Prf/p0
         3bI+Z+ymaE7EB+qiNnzOXOVghFQFo+PqFZqNG0mwTH/F6vYaAo3Ee/2NxMR9jnyYGZlM
         YRPg==
X-Gm-Message-State: AFqh2koYEjFNZH6MjS4i5Mn+EDDdgLNW/+EeEhXrITtsyT6T8Bu+iXIf
        iMv5lnuK/FfSo+LhgGLwlkhZAddfQf8=
X-Google-Smtp-Source: AMrXdXtHqOcz+1wmiAvlJHIMszS39n8C/O+4P6c3Sb9wlOJI9enEjXTysu0mI+02gOegTc7Dcnca7g==
X-Received: by 2002:a5d:928e:0:b0:6e0:7dd:59ac with SMTP id s14-20020a5d928e000000b006e007dd59acmr55442300iom.14.1673590091843;
        Thu, 12 Jan 2023 22:08:11 -0800 (PST)
Received: from [172.17.0.2] ([40.122.242.98])
        by smtp.gmail.com with ESMTPSA id i7-20020a6bb807000000b0070485d8e250sm557798iof.45.2023.01.12.22.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 22:08:11 -0800 (PST)
Message-ID: <63c0f54b.6b0a0220.b4312.111d@mx.google.com>
Date:   Thu, 12 Jan 2023 22:08:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3726718211128535316=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhay.maheshbhai.maheta@intel.com
Subject: RE: [BlueZ,v3] shared/bap: Fixing Company ID, Vendor ID and Metadata handling
In-Reply-To: <20230113050604.71398-1-abhay.maheshbhai.maheta@intel.com>
References: <20230113050604.71398-1-abhay.maheshbhai.maheta@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3726718211128535316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=711581

---Test result---

Test Summary:
CheckPatch                    PASS      0.40 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      26.41 seconds
BluezMake                     PASS      757.26 seconds
MakeCheck                     PASS      11.02 seconds
MakeDistcheck                 PASS      147.39 seconds
CheckValgrind                 PASS      240.33 seconds
CheckSmatch                   PASS      321.90 seconds
bluezmakeextell               PASS      96.27 seconds
IncrementalBuild              PASS      623.21 seconds
ScanBuild                     WARNING   980.31 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/bap.c:2268:26: warning: Access to field 'iov_len' results in a dereference of a null pointer (loaded from variable 'cont')
        return iov_append(data, cont->iov_len, cont->iov_base);
                                ^~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============3726718211128535316==--
