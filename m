Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B938C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Dec 2022 02:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiLPCDP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Dec 2022 21:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiLPCDN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Dec 2022 21:03:13 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2FC389E1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Dec 2022 18:03:13 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-40b40ff39f1so15015497b3.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Dec 2022 18:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a082GuBdpX2T81nsVOFd36R+wdK4faX5cT9AgifS/Pc=;
        b=MlCSFtZmkarHIWavSGnTp/G1fUQTclqlIlabgrqPls870Cdz5yZl7CUT7B8kXsrKEh
         yWjIyk5WhRjbrUfRwpQb4SynTzcsQ4GB3W9tqU8X7neeOmithbkIxPGbfVBV8eGnYIDg
         T5yS8VIu+iARpffCU8L5uV3Jr0r+eVrB8f6EBypUr+z0akhw2un731PCDk8EyPdKtrC2
         UnUoZl1aqLOgg1zCxb+QuGfbWvUK7zicuekA4GTrIHq3a862xTRd3ETUk9WhqtI10yok
         4U0kJsWSmXEyrlSnuYBuvzpZjwquICH0ag2+hCoPBPnjxBrZcbpuXoTizuO7pXUMllSe
         49Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a082GuBdpX2T81nsVOFd36R+wdK4faX5cT9AgifS/Pc=;
        b=Opkp+Y2gcABxbwVlCGRIlAR5bN9te/AmoQ5eZoTtz50ra9I0gO+jrNRcRRJE61vF06
         Jj+nh/4w3AgK9pWIIliZMfmHrxdrhh0ZnUkOIzDyt+1efOl6epq5CiXs75GgbhW3toXt
         iQJzH5VGsq7OUbIQcRAOLN70SOjFG0a+zzZTRinAWbZdHS9bpvFNQD0iAw3+EhXPD/eZ
         hq1FdhJb/TlpqUWWrI4Lmn7HlhTFzuxopnd5ghFvwFnBZEuOJSdGImCkL27OaNHQuJmB
         Y/+uDAjSOlLrV6EA53QMqT02SPqkCunsBXxVhvhjca4JvayYjpy2tR6M43nqIpcJUTuq
         ZLLA==
X-Gm-Message-State: ANoB5pl+Nw+kK42W9v1m0uqg0KjJieecv/OH08FQ0W03mdQ0tyy++lsE
        /X9PXXiNyOcPawF3XIn5WFfqfp23HwWu5A==
X-Google-Smtp-Source: AA0mqf67VSCLfrToIOsh4111jQUYVUi9bA2kOh7VHqwchyuft0dd+d4UHT9bR+4EYOHwh4SS5qjlZw==
X-Received: by 2002:a05:7500:1595:b0:ea:8a14:9597 with SMTP id r21-20020a057500159500b000ea8a149597mr4087133gac.69.1671156191963;
        Thu, 15 Dec 2022 18:03:11 -0800 (PST)
Received: from [172.17.0.2] ([40.76.43.203])
        by smtp.gmail.com with ESMTPSA id bq7-20020a05620a468700b006ff8dfded9csm504540qkb.38.2022.12.15.18.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 18:03:11 -0800 (PST)
Message-ID: <639bd1df.050a0220.d23d.1469@mx.google.com>
Date:   Thu, 15 Dec 2022 18:03:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1206223296230155483=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] shared/gatt-client: Fix not marking service as active
In-Reply-To: <20221215234404.2735181-1-luiz.dentz@gmail.com>
References: <20221215234404.2735181-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1206223296230155483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=704956

---Test result---

Test Summary:
CheckPatch                    PASS      0.96 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      27.88 seconds
BluezMake                     PASS      1028.74 seconds
MakeCheck                     PASS      12.10 seconds
MakeDistcheck                 PASS      148.82 seconds
CheckValgrind                 PASS      244.36 seconds
bluezmakeextell               PASS      96.25 seconds
IncrementalBuild              PASS      843.96 seconds
ScanBuild                     WARNING   1042.66 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/gatt-client.c:387:21: warning: Use of memory after it is freed
        gatt_db_unregister(op->client->db, op->db_id);
                           ^~~~~~~~~~
src/shared/gatt-client.c:600:2: warning: Use of memory after it is freed
        discovery_op_complete(op, false, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:903:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1012:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1204:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1269:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1540:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1545:2: warning: Use of memory after it is freed
        discover_all(op);
        ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2047:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2055:8: warning: Use of memory after it is freed
                                                        discovery_op_ref(op),
                                                        ^~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3138:2: warning: Use of memory after it is freed
        complete_write_long_op(req, success, 0, false);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3160:2: warning: Use of memory after it is freed
        request_unref(req);
        ^~~~~~~~~~~~~~~~~~
12 warnings generated.



---
Regards,
Linux Bluetooth


--===============1206223296230155483==--
