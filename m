Return-Path: <SRS0=EW2K=B4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BA2C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 16:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD24D20786
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 16:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dptechnics.com header.i=daan@dptechnics.com header.b="ZAzOzV+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgHRQvf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:51:35 -0400
Received: from sender4-op-o11.zoho.com ([136.143.188.11]:17155 "EHLO
        sender4-op-o11.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgHRQvc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 12:51:32 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597768585; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=CON19CHeR1Xgocqgddwew1x9zb8XNEnAnl9AxuWX5rPucmdYiQczRYVTu16WYDXR2BhZK9GoDpEtbsPYWYj0t5YINYxt3AjNjF4JbjqsqYmuVjcHUuNvuvqND+BZyKY88Pw6OsiCLG5A3YOGSXrq1P0uNfB3gBl3aYrcdEqfTl8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1597768585; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=hxsuXnoF+ernwmZV6yS/o5gUrMIRlNZG3bcfp4HIIhQ=; 
        b=M/wWy+c7pLDY02KvkYwh6PlXIx1Zii6NwXf46XPSfY+H1BR0EnBhCGvmqaXmas/8VO6bQPTJM+y1fQu7GYTwwKvAYTSdobv/whcMbAnZBxehscmWG6/BviBbCdh90hvtFR5MhA77jC3nyzHlwOsZ6dXlNNqeOA+bRwJva5uqens=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=dptechnics.com;
        spf=pass  smtp.mailfrom=daan@dptechnics.com;
        dmarc=pass header.from=<daan@dptechnics.com> header.from=<daan@dptechnics.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1597768585;
        s=zoho; d=dptechnics.com; i=daan@dptechnics.com;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=hxsuXnoF+ernwmZV6yS/o5gUrMIRlNZG3bcfp4HIIhQ=;
        b=ZAzOzV+9bK4tA4+mH28ZVTDclkfeNHDKUy1RAmocW3QwOmdhzPdpbtmFErekbs2a
        Wz1CchP36EIHGssp6IFPaDircdsvMhPyIQOXmB19o98u1ia+Gv+DJnpPB4tUqtlpWH5
        DyKihsR32KrbkoN8PuDrz6JdkCBnbfN8WnLsFBJE=
Received: from daan-devbox.dptechnics.local (178-116-74-88.access.telenet.be [178.116.74.88]) by mx.zohomail.com
        with SMTPS id 1597768581616726.7700689087546; Tue, 18 Aug 2020 09:36:21 -0700 (PDT)
From:   Daan Pape <daan@dptechnics.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Daan Pape <daan@dptechnics.com>
Message-ID: <20200818163611.57656-1-daan@dptechnics.com>
Subject: [PATCH BlueZ 0/1] Fixed issue in bluetooth-meshd which causes HCI
Date:   Tue, 18 Aug 2020 18:36:10 +0200
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I had compiled bluez for OpenWRT and was running the bluetooth-meshd
daemon with a Fanstel BT680T module which implement the Bluetooth 5.0
core specification.

The daemon did not properly start and failed with error:

LE Scan enable failed (0x12)

This error is described on page 2496 of the Bluetooth Core Specification
Version 5.2 and is caused by the fact that no random address was
initialized. The issue is resolved by falling back to using the default
HCI advertisement settings which use the public device address in it's
advertisements.

This is the first time that I contribute to Bluez so please forgive me
if I made any styling mistake in the patch format. I also did not include
my details in the 'AUTHORS' file just yet as I first wanted to wait
for your reaction. In case the patch is accepted my name can be added
to the 'AUTHORS' file as:

Daan Pape <daan@dptechnics.com>

Please do not hesitate to ask any further questions if neccesary.

Kind regards,
Daan Pape

Daan Pape (1):
  Fixed issue in bluetooth-meshd which causes HCI error 0x12 when LE
    scanning is enabled because no random address was set. This is fixed
    by using the default HCI own device address option.

 mesh/mesh-io-generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--=20
2.20.1


