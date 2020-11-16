Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C772C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Nov 2020 19:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C48242225E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Nov 2020 19:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LH6m+bZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgKPTY2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Nov 2020 14:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbgKPTY2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Nov 2020 14:24:28 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1005C0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 11:24:27 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id u4so17934300qkk.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 11:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=se3cXLuEzOnTWoZ4jS9V9dWB4nDfwR8j7XyOw0uLrVw=;
        b=LH6m+bZ8l9oSXQPXmzvsOf7pZf8MyUsMQeDRc/kqKJCZVNRbwZhPd1wl/hUpkylOHk
         YIYoYtmQbbvVIKZPflnOPNkXqQrWxoHenw7cUOYBhH6rHdmp8BH+LA7eLv2GMmo1SY3v
         Lmby02KbfjZ3QJFAtUVaEw+4nDZnWIcyLKKv0gBQpvFXr7TaIrHIrDsf/LV07Qu8gZ77
         stCO2OxpoEjMw/cVuG3v27OB/kjapDH+sNmSKgktY13dV8rVI2aSn+hk3//jsYR7QKhG
         e48lvftwz8VVdnHJJzfyqLYdAaHOSYnV+AKQEdz9CHy54sktGTEVVsX4rWsS/Eo8bHYH
         vR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=se3cXLuEzOnTWoZ4jS9V9dWB4nDfwR8j7XyOw0uLrVw=;
        b=bzP/R0XjSqkQRwqazLte0Gv4m5ZcOu8+DYS+BANNwW6lCzsRja88eOin5n9GwsmKCD
         3QdDxPJG87Lt1osKHJsjN2OedkNoSz70TCzqtpiP5PBz1WIzra4uKzwx7RHrMeZ6lXyq
         0h0DxwxpzVgerm0KMBpMsms7UlKZl2hF3c9phZ/9tHii/0Wr0yrtnDwOkMq8sxzMQlWv
         jODIW/x7uO/oZ8FoD2MEycrKbs+JqDOZiCeTDRbohUR2ZxWRNtPBYLtr4RLD8I5V4gAK
         rLsCJNCBxOIyE1pM+e4/+Ktec1GZ08V+YWQxPUZXPp3ZZEmz/OQlaAHFDLSssS9zOc0E
         6sxQ==
X-Gm-Message-State: AOAM531qviEwtkJqZI3ASIPXcxtGkOh2jdTba6hOyk9nzzRpmACwI+k6
        Fj23dTMD50rc3a7diSoqMW4poKokuPUFJA==
X-Google-Smtp-Source: ABdhPJyUhxmOxGgMTGO7iyE5+8k1JQSbKlNVRXWZv0yz4oBBTmmAeZQhmayPs/0GJ0BXCg2r9TK2rg==
X-Received: by 2002:a37:a4c3:: with SMTP id n186mr3714160qke.495.1605554667001;
        Mon, 16 Nov 2020 11:24:27 -0800 (PST)
Received: from [172.17.0.2] ([40.75.64.54])
        by smtp.gmail.com with ESMTPSA id w1sm11244265qta.34.2020.11.16.11.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 11:24:26 -0800 (PST)
Message-ID: <5fb2d1ea.1c69fb81.86fc3.213f@mx.google.com>
Date:   Mon, 16 Nov 2020 11:24:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9002251987291296219=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [bluez,v2] adv_monitor: Fix remove monitor from the kernel
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201116104106.bluez.v2.1.If5b2e2990c2c57e237708d8cbbf038e376ad0c7a@changeid>
References: <20201116104106.bluez.v2.1.If5b2e2990c2c57e237708d8cbbf038e376ad0c7a@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9002251987291296219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=385377

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============9002251987291296219==--
