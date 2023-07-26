Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89C9C001DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 21:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjGZVZg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 17:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGZVZd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 17:25:33 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE632685
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 14:25:27 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RB6Pb6r9jz49Pyr;
        Thu, 27 Jul 2023 00:25:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1690406724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wcwZWiK2rfnuL1oJiHrTufItNtj5nRtCSp+kgMClWpM=;
        b=dyphzWA9YGzS/kWng33LGCof5BjnalPrGCJjf7P7hFQ0tj2OjqFUIWi9KEsw2qcEqgXXju
        pTbk43nwynISmESNfQvsxsX+PUzTKYZfhtn5S3qvlZR4KYFwUpU6ltoIB6ExLzuwbjgl/Z
        HISti1FZ94NT/5tU+RmV1Ps8BUlhnwu/K7O78qI/QOtN0ykXPBGdvfPFp4AFyJif1GRgdc
        +bYJIs6bzyKNM+orneQaMLv+qDJjEocrABk2OFARZWYL1jJ0r7Jby185R5Ng++4WizNNFP
        MxoW5KlddrtZK4CMK8sD2+ontQ0nXoVPF47NNLPeCnATggYpb1sElNaE7CrejQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1690406724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wcwZWiK2rfnuL1oJiHrTufItNtj5nRtCSp+kgMClWpM=;
        b=R5c2nabtB5H5AazzOnaHqO3LpY4GTvgcn03BpavM02i5ZGwZ9CxsryVcjfAA/m+e9k8z8s
        pUqozqfCAVBYwf44F4x0uYB60051wbHxPKNs2P8UjpDJmJlX0WuUzirI9fIBFrPGQf1cpR
        a7gIH0CR28WbursLJGpQHGCbuRGvwYRzni7qWXcf3xEChEDp7k5AY704hd+Sb2/Yu+6piu
        2tPo0q3xvrsptLi+YciqgiP0sVu7fmMpnraln0qPO5Ky4Krl6dguyKFW4g5xXXFuZgzFZ5
        eOfWPfnnKAdQ9cb95wY5Bm1QKxI930tp4qd2NUcX7nP3zF+LVwxLR6TizrMA1A==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1690406724; a=rsa-sha256;
        cv=none;
        b=BGfo56jO5U/5GNwGrJ17KaOj0DVpavR5dbWTmXLM+1A4NyTDc/6VfwIoaYt5T8t/Kaqa4G
        jo1uAOv2O6hy3JYZ3EPMlL5y0H/rplTsUtHZbFAG8aQ9L/ujt2zcDGtwXv/u575VbHrVCp
        okwr1rDjmrEAiZ5pvg99/ySCmoImwQgy1Qvf0mivYWdrUiMpUzgnYinJvd+CirrL/kJVu8
        tKlhlLTK1UmxAm4QmWkFpqw9DXnNLsCjiKP9Esr5HGH8L+DK434rOoe+OOXJwB4G3bZ4u1
        3GsUPZ7v2kTx4IDjMmMqSV0AU2lmRgRYgLCdU4FVj9OlpJslUjbCMeDwjNDRCA==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 0/5] Additional tests for ISO and hci_sync
Date:   Thu, 27 Jul 2023 00:25:14 +0300
Message-ID: <cover.1690405564.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a few tests checking ISO socket handling of invalid input
parameters and cleanup in some race conditions:

    ISO QoS CIG 0xF0 - Invalid
    ISO QoS CIS 0xF0 - Invalid
    ISO Connect2 CIG 0x01 - Success/Invalid
    ISO AC 6(ii) CIS 0xEF/auto - Success
    ISO AC 6(ii) CIS 0xEF/0xEF - Invalid
    ISO Defer Close - Success
    ISO Connect Close - Success
    ISO Defer Wait Close - Success
    ISO Connect Wait Close - Success

There's also one for a hci_sync race condition that triggers GPF:

    eSCO Simultaneous Disconnect - Failure

I have a patch series fixing these, but we'll revisit the
HCI_CONN_DELETED flag there, so maybe discussion needed.

These fail on current bluetooth-next/master, so it could make most sense
to wait for the fixes first.

Pauli Virtanen (5):
  btdev: check error conditions for HCI_Create_Connection_Cancel
  sco-tester: test local and remote disconnecting simultaneously
  iso-tester: test with large CIS_ID and invalid CIG_ID/CIS_ID
  iso-tester: add tests checking Remove CIG is emitted
  btdev: fix Command Status command opcodes for Setup Sync Conn

 emulator/btdev.c   |  80 ++++++++++++++++++---
 tools/iso-tester.c | 168 +++++++++++++++++++++++++++++++++++++++++++++
 tools/sco-tester.c |  59 ++++++++++++++++
 3 files changed, 297 insertions(+), 10 deletions(-)

-- 
2.41.0

