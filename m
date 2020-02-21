Return-Path: <SRS0=Dxuj=4J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8688AC11D24
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Feb 2020 04:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584D8208E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Feb 2020 04:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=adafruit.com header.i=@adafruit.com header.b="FNWq/cUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgBUEbp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Feb 2020 23:31:45 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36650 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729547AbgBUEbp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Feb 2020 23:31:45 -0500
Received: by mail-ed1-f68.google.com with SMTP id j17so779989edp.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2020 20:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=adafruit.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=ASfhlmPH4t6ySmx+hkyIiNHeOfpOFdRzeqSR7yqCluI=;
        b=FNWq/cUxQ74RFjbMQT7AJrXA0IvXwUWuUsbzB9OIFMeWvlAVyGwCHnmOVpSmGYkvrQ
         XdWsYQhvICaziYZzxpCRmdlaEOR8FJJIVvPg9HdKI4uOPzbWR946APnMQolZxgydBboM
         76DzCJ5L+rOP2qiyyQ5I1HwYbMtbQJU5+xJ60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ASfhlmPH4t6ySmx+hkyIiNHeOfpOFdRzeqSR7yqCluI=;
        b=SUxfXJ5KvJL0shKOKL07nULxtpY3fGa/2a960dTFAcg4cEYba6BVE80WMBNymS2Qfe
         h9yi90OL48MAUuNTTs6gT9D7A1Bo6mnez4d7lXMdF+/taAABdY8xFh2ZZydo0OewSv6Z
         4m3MEjHw0tSEJaPGAQa31urpFsWx1Ifx0zQGsopAo+j/9yDQLlfmTbG49sogkPuyoafe
         Q0NArkw06l0pUV10aKu6YxFgPCwtVbSqg8wWfn8kFUox7rJjb+ZrduSvLoR7s25fsTiG
         79iogm7aOrxia1WSUzq09hcTxLPEImBjxjHOYzvK8VJaBNOcoH9Tei+Gh9LoBzw+G2BW
         sy7A==
X-Gm-Message-State: APjAAAX0LsQv+vcQkfQrsORJp8jV9FCkrYtmjr8xJjw0GBOn6DIbRbPr
        v8lbWg0lTG+XLB8Xh+fBxxJHukORs7dnMkdtmkhe3NGRdDw=
X-Google-Smtp-Source: APXvYqzFGrm4K4lqwHr7gNe9QPAXzRKHq+SmvD4U1gW4GaFTS7ksieHluxXdJtz3GT3kAIICzlOfi5BDIW39/9wLwBU=
X-Received: by 2002:a17:907:2112:: with SMTP id qn18mr34202643ejb.92.1582259503420;
 Thu, 20 Feb 2020 20:31:43 -0800 (PST)
MIME-Version: 1.0
From:   Scott Shawcroft <scott@adafruit.com>
Date:   Thu, 20 Feb 2020 20:31:32 -0800
Message-ID: <CAJ_gUqbKKxt15OhizRN_x4Dy-RvyuEUH0Bwcah_KEcMsQakQoA@mail.gmail.com>
Subject: Adding support for DuplicateData into the kernel
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi!

I'm trying to create a bridge between BLE advertisements and the web
for sensor data logging. The BLE advertisements use manufacturer data
to transmit the sensor data. I'm running on a Raspberry Pi 3b.

I've been trying to use the Bluez dbus interface with DuplicateData,
trying both true and false, and I never seem to get duplicates back. I
dug into it via hcidump and noticed that the scan enable still has
filter duplicates set to true regardless. I can only manage to get it
set to False when using hcitool.

I believe I've tracked the issue down into the kernel here:
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/hci_request.c#n858
where enabling duplicate filtering is hardcoded. It seems that hcitool
side steps this by talking directly to the hci device.

Could someone confirm I'm on the right track? I'd be willing to plumb
the DuplicateData value through to the kernel if someone could help me
find the call path down.

Thanks!
~Scott
