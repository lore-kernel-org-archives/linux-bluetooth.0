Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89090C4361B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 18:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 533E923B6B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 18:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbgLHSGj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Dec 2020 13:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgLHSGi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Dec 2020 13:06:38 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727B4C061749
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Dec 2020 10:05:58 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id q5so16758001qkc.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Dec 2020 10:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=j7g+mf2bjPK5a+G3dRiDt+tnmC7lnlKaPnet8fInDAY=;
        b=vSsLRsmeonWFNgw4A0MkCdbcgLVxNqLxcyr84BuEFYswbjME+5jjlCEhf4YvDcLL3j
         XyU6fL5tKV4QdcOoVxDuhr5tBQyF6ZxlDfcA/afUyCioRFFOxXMSFedaV9/yM0rfmje8
         y0X1m5F1HsTTGt57uJNH2VUkNpvdJYR3sBfNK9iHQQK1SdvkozvcmQHLCy+wJPBFf/4O
         dv8hS6Sx9pHZ5cjaeTaEmBykuRia9Vm0LSzt8cQ34BTLbVO1ROtRDD7rcjYFelwzDBUM
         paCGykQOQmZQ3BXGj+NcI25W46RWsYm+/+5X/reiTxgt1nPU/tLenOlUGeFT2+PR4UJ9
         q0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=j7g+mf2bjPK5a+G3dRiDt+tnmC7lnlKaPnet8fInDAY=;
        b=BUGIlidh5SVsRjfouNa4velV1VrxtpcVu2DseD0RfUPEryDNiXa1jSKejBAfCgfOq+
         pGkYD/Y1tw/EYowtFm17VLUICc4FePydKxRVfQyfOEysRXtBsW4oqVmoi22wutzhtrmw
         t+7S0d7rxwaNsNKBlBvkc52MQrXfZ6aGkqgeWfBQJ4SXewoL6MKZy68MfSokIPk0OFMV
         zIUVORHNIRWq50v18gGF9J7oK2VeJ/9bV/vLpfXbadyGsi1Pu9TrbfVlWMtSJlT8qN1J
         AMlJW3wRbNp4IISdcLdAzF2UPKfrTJAWfI2C+KkubWc//FC/+h5xu2LdMh/5o4fYgbmG
         qtVA==
X-Gm-Message-State: AOAM530EkQQD29yz2XPyZDnwmEG9g91Esnice5AtmDmU6BN8RD7WrCR5
        5qFFBFMelQEEVhWULxZre7C6d9C0v34=
X-Google-Smtp-Source: ABdhPJyM7YnM75mftaEba0akQ460BywkAAUKmFfvQLtnX8tR/ikeYyaamKtdlZge5GWajAr37n+r/w==
X-Received: by 2002:a37:a312:: with SMTP id m18mr32237591qke.268.1607450757404;
        Tue, 08 Dec 2020 10:05:57 -0800 (PST)
Received: from [172.17.0.2] ([40.65.201.4])
        by smtp.gmail.com with ESMTPSA id 131sm13735245qkg.69.2020.12.08.10.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 10:05:56 -0800 (PST)
Message-ID: <5fcfc084.1c69fb81.3da21.1be6@mx.google.com>
Date:   Tue, 08 Dec 2020 10:05:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1805796006777264066=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: Bluetooth: L2CAP: Try harder to accept device not knowing options
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201208172912.4352-1-hadess@hadess.net>
References: <20201208172912.4352-1-hadess@hadess.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1805796006777264066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=398401

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
Bluetooth: L2CAP: Try harder to accept device not knowing options
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#8: 
the negotiation when a device responds with L2CAP_CONF_UNACCEPT ("unaccepted

WARNING: Co-developed-by: must be immediately followed by Signed-off-by:
#120: 
Co-developed-by: Florian Dollinger <dollinger.florian@gmx.de>

ERROR: Missing Signed-off-by: line by nominal patch author 'Bastien Nocera <hadess@hadess.net>'

total: 1 errors, 2 warnings, 0 checks, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] Bluetooth: L2CAP: Try harder to accept device not knowing" has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - FAIL
Output:
Bluetooth: L2CAP: Try harder to accept device not knowing options
13: B1 Line exceeds max length (92>80): "> ACL Data RX: Handle 256 flags 0x02 dlen 16                            #64 [hci0] 59.182702"
19: B1 Line exceeds max length (92>80): "< ACL Data TX: Handle 256 flags 0x00 dlen 23                            #65 [hci0] 59.182744"
30: B1 Line exceeds max length (92>80): "> ACL Data RX: Handle 256 flags 0x02 dlen 16                            #66 [hci0] 59.183948"
36: B1 Line exceeds max length (92>80): "< ACL Data TX: Handle 256 flags 0x00 dlen 18                            #67 [hci0] 59.183994"
43: B1 Line exceeds max length (92>80): "> ACL Data RX: Handle 256 flags 0x02 dlen 15                            #69 [hci0] 59.187676"
49: B1 Line exceeds max length (92>80): "< ACL Data TX: Handle 256 flags 0x00 dlen 12                            #70 [hci0] 59.187722"
53: B1 Line exceeds max length (92>80): "> ACL Data RX: Handle 256 flags 0x02 dlen 12                            #73 [hci0] 59.192714"
59: B1 Line exceeds max length (92>80): "> ACL Data RX: Handle 256 flags 0x02 dlen 16                          #248 [hci0] 103.502970"
65: B1 Line exceeds max length (92>80): "> ACL Data RX: Handle 256 flags 0x02 dlen 16                          #249 [hci0] 103.504184"
71: B1 Line exceeds max length (92>80): "< ACL Data TX: Handle 256 flags 0x00 dlen 23                          #250 [hci0] 103.504398"
82: B1 Line exceeds max length (92>80): "> ACL Data RX: Handle 256 flags 0x02 dlen 16                          #251 [hci0] 103.505472"
88: B1 Line exceeds max length (92>80): "< ACL Data TX: Handle 256 flags 0x00 dlen 18                          #252 [hci0] 103.505689"
95: B1 Line exceeds max length (92>80): "> ACL Data RX: Handle 256 flags 0x02 dlen 15                          #254 [hci0] 103.509165"
101: B1 Line exceeds max length (92>80): "< ACL Data TX: Handle 256 flags 0x00 dlen 12                          #255 [hci0] 103.509426"
105: B1 Line exceeds max length (92>80): "< ACL Data TX: Handle 256 flags 0x00 dlen 12                          #257 [hci0] 103.511870"
109: B1 Line exceeds max length (92>80): "> ACL Data RX: Handle 256 flags 0x02 dlen 14                          #259 [hci0] 103.514121"


##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============1805796006777264066==--
