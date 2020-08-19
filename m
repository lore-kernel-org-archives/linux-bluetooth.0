Return-Path: <SRS0=ZhIC=B5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5401C433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 13:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F819204FD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 13:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vc5Q4d1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgHSNum (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbgHSNu2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Aug 2020 09:50:28 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F988C061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 06:50:27 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id dd12so11276678qvb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 06:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=5Kq+eO5N+yscRltuzqc1xrjMAGWlhYWTm3daje9xGJk=;
        b=Vc5Q4d1IUR6s9zJjNj85e++d8iVFv13+P42Bqk7ogPL9OwR5G5TXpPll71t2mC75xj
         U632lbv/ZpFDtWiMm18wb2wn533dN/uQ3PcC19ZoLduitBiG8HqNLzSI4NtTYz5JKkYQ
         W8F2S/Z2VEiY3SUqiF3t7H+zv3EJty34zlNw3MJoZ/nXNXy+Nkvlj1NN30/7tn0uMNTj
         BTPtbHLi5XUTPIr5XSZ1h+5i25+O82q0Ct0dh3kPF9QDtNK8ct1XfvohG2CnHqmlhRIX
         rlis52MQAatXJv3GNIPOLLRb3d5ZsOVYhqtU9FAnYHGPrhUzdKcsDhGW7cUCLIX9yu4V
         aw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=5Kq+eO5N+yscRltuzqc1xrjMAGWlhYWTm3daje9xGJk=;
        b=gzEFtd4BtnStAPyPjUwpejPwM5Hqz82/4qydzUID2GES9of7nuemNzDRsDGtDTxMsn
         nwlPyvpi7J/BkE3cxTclBp/V8w/TfysakTLFMyKB3l0EsvsX3p1eUMbE1b3O3dTiC8ue
         nVpPJfYhxKqzZjnlkNX85G6A6y97c15J7o3aKIOu3LSu6tQcaun5FicvZJ0WmztQOH+P
         4mLawoXhgN2wMvefKNryd4a3PGuirrxtjmKsaxvEGQvZgdDcfI7UEyxAMf6FgBkp2FGm
         2im3BTYt2U8A4MhjIVLkuYL4+/2GijYGbDZRJFx9IvLasM/NwmnwnsBO35p4a+0beVz0
         ALXQ==
X-Gm-Message-State: AOAM530boI0qLA6HV8Ajthja1M8MLHEmlC+SVqyDwhEbxsCxmXFaosbP
        ge6iVgPO52Fp0wkrvTDRTJ0jwJocyH4fTw==
X-Google-Smtp-Source: ABdhPJyAHRb3PU4Xt5Z/2OsCo+zG+PHNDNsA2hMwFBXM58ddDJCH2oer337Lqd6eT34fjhfgqTgckQ==
X-Received: by 2002:a05:6214:290:: with SMTP id l16mr24139170qvv.187.1597845026600;
        Wed, 19 Aug 2020 06:50:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.111.146])
        by smtp.gmail.com with ESMTPSA id u39sm29590481qtc.54.2020.08.19.06.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 06:50:26 -0700 (PDT)
Message-ID: <5f3d2e22.1c69fb81.c1d36.72a4@mx.google.com>
Date:   Wed, 19 Aug 2020 06:50:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5463537467180307820=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mark.marshall@omicronenergy.com
Subject: RE: [BlueZ,1/2] btiotest: Correct setting of addr_type for big-endian platforms
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <418845b9-28e1-4356-9ce2-b422720bf948@EXC04-ATKLA.omicron.at>
References: <418845b9-28e1-4356-9ce2-b422720bf948@EXC04-ATKLA.omicron.at>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5463537467180307820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkpatch Failed

Outputs:
ERROR:INITIALISED_STATIC: do not initialise statics to 0
#21: FILE: tools/btiotest.c:559:
+static int opt_addr_type = 0;

WARNING:LONG_LINE: line over 80 characters
#31: FILE: tools/btiotest.c:619:
+		" prio=%d voice=0x%04x addr_type=%u\n", opt_accept, opt_reject, opt_disconn,

- total: 1 errors, 1 warnings, 19 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============5463537467180307820==--
