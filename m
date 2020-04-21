Return-Path: <SRS0=JHfm=6F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D13EC2BA19
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 04:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD55A20882
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 04:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BE4WwCBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgDUE0N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Apr 2020 00:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725904AbgDUE0N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Apr 2020 00:26:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4F5C061A0F
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 21:26:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id rh22so9892442ejb.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 21:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1wv+mM3FaICu4qZIPsYweTEvloXG2IsKb5hRnj674ck=;
        b=BE4WwCBgISSm69rVdwWui3573xDfllLyQZZ60emXT9o7ScUCG5PQ+NVhEVQeHRjJYm
         4++ql5PVcqPsKppeyU2/DXNLL5AtAA5IyY8AOymqsk8Ry6ftSKoih79LJTNvBb7zljai
         7qmOAqqoJKeYDza2XvwhMVq4YeVOqRgERLRWvp4wu4RBsbezjywq/myKNbDf1e1Y3xlj
         Ysf1daQ1kPSUq69lCmA7hsByKbjtWd3/S3gNGeA8f4wQfw9xdzI744d8aqhvmiium3Mz
         ZN+QlYCnmkxiXwD/raLtmKnB/0omwQkzKkxZQ3t6USzbAXgoP4Y84LUpXCRzC/sNrxQ1
         fUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1wv+mM3FaICu4qZIPsYweTEvloXG2IsKb5hRnj674ck=;
        b=J9e1BwOKyplAmEuPr6CiUchG0e3UiGoBdvv3ADygq0OXtJm7UhZiLk9wQOfPsfwo/A
         +1UGYgvAc3461o27Lod2vmLwYGgyp52kBCZk8Jy/5gTTwRo+vv0KNw0ygEK+Ul7ac4x0
         GpOsKoS+sBN8toveIUxevJ+gTb3mHR7ogbQAdT43meevwShynyNXfWLaFL6Hf61YfQFB
         4K+GvljTzhQ+dCpnk7qlX4IcTwHDi7xpPf+gyCfvYD7xBr+JNO1WO17ejk50SQPY6HcB
         8GUOnsVb7s7lMBoQLBPnhLkTBGoI3AHQrjYii9DldReGk3vocHutqbiip2zPBomcHs4f
         hUMw==
X-Gm-Message-State: AGi0PuZpeKRZ61KvYP7uELGbbZFSmboZZFtlrxPWKvjELcSn4asRRK81
        DR71kIctoRmLpE6PX6ttsWxPzMSMkHE1lvC/TsHeAwCYhrA=
X-Google-Smtp-Source: APiQypLJhvlmDpEiYP4W2/IMeg9d7aaRATXvbphOArrMX9nqn9EkEclIIqgRGHtwATD+31LF08UOMaarkyiTwmK0Xj0=
X-Received: by 2002:a17:906:4bc3:: with SMTP id x3mr19697847ejv.38.1587443171222;
 Mon, 20 Apr 2020 21:26:11 -0700 (PDT)
MIME-Version: 1.0
From:   Yun-hao Chung <howardchung@google.com>
Date:   Tue, 21 Apr 2020 12:26:00 +0800
Message-ID: <CAPHZWUeGeaN5jmNHv56VzSsdmCvS1WKfSnaYE+YCfd5E8+3S-Q@mail.gmail.com>
Subject: Auto-connect after disconnection from user on trusted devices
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Cc:     Sonny Sasaka <sonnysasaka@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi linux-bluetooth,

Bluez doesn't disable auto-connect for trusted devices even in
device.Disconnect. This causes users can't disconnect from peripherals
unless they untrust the device.

The behavior seems to change into this way intentionally after this change:
https://www.spinics.net/lists/linux-bluetooth/msg72898.html

I would like to understand why this change is needed and what is the
suggestion to disconnect a trusted device.

Thanks.

Howard
