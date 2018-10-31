Return-Path: <SRS0=39h9=NL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DBDECDE44
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Oct 2018 14:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D043020664
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Oct 2018 14:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=logic8.org header.i=@logic8.org header.b="WlIqmD4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D043020664
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=logic8.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbeJaXr7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:47:59 -0400
Received: from logic8.org ([94.156.174.12]:33736 "EHLO mail.logic8.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729570AbeJaXr7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Oct 2018 19:47:59 -0400
X-Greylist: delayed 575 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Oct 2018 19:47:59 EDT
To:     linux-bluetooth@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=logic8.org; s=default;
        t=1540996805; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=PZ6x+81dcnVO4Mu4WDPlO2NLbN0g/+V4eCOrO+sbLgA=;
        b=WlIqmD4yBLn9EiyT+uFkX6ZbrbI0PE6yI1QR5P6N1hUuCIgyEGuKQJoqMIRnMcOX+CHGbN
        9YTdXe7j1JWXrUSNsw3ZexNe02UxWulfjKFT3AVZik0xOCrPez9csN1xwwqSM0aFXF4wqq
        fR0EYYPeZsIW08Zkhs4Qulfg0UFyYSk=
From:   bluez@logic8.org
Subject: Mesh network using multiple Raspberry Pis
Message-ID: <df20f73a-2a5a-bbeb-7829-867fe9fc33c2@logic8.org>
Date:   Wed, 31 Oct 2018 15:40:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=logic8.org;
        s=default; t=1540996805;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=PZ6x+81dcnVO4Mu4WDPlO2NLbN0g/+V4eCOrO+sbLgA=;
        b=XjgHqwKPlWhw3XtnSGINMnWh8EaDbB+oBnCz+m2SA1GeVgxfNWGSP40tqVmMWHT1UwfW2I
        Z5NRKm52/a0SrCGB5DTeSPmmp+iDMj0NzouHkJOZ7z+zrMlI5WGse5kxOCj69bKoRt32i1
        9RvJ5zIluUlbUG8wyetwFAZqj/W/j+I=
ARC-Seal: i=1; s=default; d=logic8.org; t=1540996805; a=rsa-sha256;
        cv=none;
        b=k3WD11nnIx/S8Qevvb57aMDnF3PJyX/6beuxh73mNLGdW+v+q0HOSN+m/uo44NKVkXeemIcVmSeAt5sZxjFqjbgWFvEsxXN9aUng4wvsCj3j5qpOC1Pe2Iddn/7C8ZEw5dDEiYSBXJCwYM5XEu6kkdOy0UsRueqMRePhOA03k4c=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=catchall@logic8.org smtp.mailfrom=bluez@logic8.org
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=catchall@logic8.org smtp.mailfrom=bluez@logic8.org
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I want to set up a Bluetooth Mesh network with multiple Raspberry Pi 3 devices, using the on-board Bluetooth and meshctl. I have bluez 5.50 installed and running without errors, however I struggle with setting up the network.

The problem that I face is that all available examples and documentation uses one Raspberry Pi with meshctl and one other device, usually some kind of development board (e.g. NRF52840). I have not found an example that uses meshctl to set up a mesh network using only Raspberry Pis.

As a first step it would be desired that one board shows up on the other once discover-unprovisioned is enabled.

Thank you for your help.

Best regards,
Laurenz
