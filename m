Return-Path: <SRS0=UWae=OV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0476FC65BAF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Dec 2018 20:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B397F2086D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Dec 2018 20:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1WJ507A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B397F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbeLLUsP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:48:15 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:33919 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeLLUsO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Dec 2018 15:48:14 -0500
Received: by mail-it1-f196.google.com with SMTP id x124so14592260itd.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Dec 2018 12:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Pc1llJ1vGFWBFC2fFu0AdtVxos97Joz2K3y69+o9b2M=;
        b=C1WJ507A6r4w+V/vkr228vGuXGxQxkj8spGKaahm98gwmVP6hJDwY9FTBn5vRDg2Cb
         j182pClixNTI9ITD/VQMkKlXixsThXeC6KSFy27iquyMgwFyneKXZCH/6Cdtmbijdkd0
         eUPCyMkuAZhfjIm5BT8H57vaV5QpPkv9ThD1PpSBf1IGoXt235i9jsaSLH488XbXJ02d
         psmWMWuynaQQXiqKu6IE0W1+plmS9FhC09ZcShPxTaFIL3Ns/gZB+0MLJ4/oUUYhHmuT
         AQOjDK/tzc8dT1gdbA/hat7I7OxcO78Y/XDfqpIZ+/A/AiGtXk7rXeoM1mbSRlK87e40
         7gOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Pc1llJ1vGFWBFC2fFu0AdtVxos97Joz2K3y69+o9b2M=;
        b=Mi2X9oQ7lStA1P/xn9fduFqVYdRaKXaTofkhxn+uU0EmKwAsERd1wLzTrb767JxPvS
         1FfAxTxT2ykdk0r+1y8WIXFD1mNFS4BuKBnNcc1kpdyoyNQov/x++hs0HG2BfzyoEy9i
         8ohW+WRJtFN3VwNPHa29Cxhbt3H3YXMHvsLZpLSIJu6QeEXdX45AcsaTR3obXvEbYUJz
         nTNC6v+/CzN7z/RAyxlRkylNdFoYwnHvz8XpH9hJGEl8gGe2doWxMMB6ORymHg7i6QT4
         I1acj7BtpMRBsPFctW+0PUNNBVHICPaeltL/K4TQRNhWkNograGkHLwpk1+lLnAIiqZN
         uBGA==
X-Gm-Message-State: AA+aEWblFB9paMAPcf7y9Y9TVoOQzN0v3yKEMRRXBtf+vyAndpeII7Xw
        VAmeV0gd83Skdb2dM1IuvVTMXwA=
X-Google-Smtp-Source: AFSGD/U5HD1lD+VMSvZC+r8S4N5lJ9oRbTOttZXPAPSAlHlLfeRPL+UFndh8Rds+fXv0004brTIyww==
X-Received: by 2002:a24:e04a:: with SMTP id c71mr7243474ith.127.1544647693669;
        Wed, 12 Dec 2018 12:48:13 -0800 (PST)
Received: from r (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id k64sm211563itb.7.2018.12.12.12.48.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 12:48:12 -0800 (PST)
Date:   Wed, 12 Dec 2018 15:48:10 -0500
From:   r yang <decatf@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/1] sbc: Use extended inline assembly for armv6
 primitives
Message-ID: <20181212204810.GA30878@r>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

What happened to this[1] patch? Did it fall by the wayside?

I can reproduce the issue this patch addresses. It was also reported
here[2] with gdb traces.

I've tested this patch with Alpine Linux on the current edge release.
Alpine currently uses sbc 1.4 and gcc 8. Before this patch bluetooth
a2dp audio will segmentation fault in sbc_analyze_eight_armv6.
After this patch the armv6 assembly code does not crash and a2dp audio
streaming works.

PS: I'm not certain how to properly send this as reply to the original
patch mail so I've referenced the original this way.

[1] https://marc.info/?l=linux-bluetooth&m=152535913710490
[2] https://bugzilla.redhat.com/show_bug.cgi?format=multiple&id=1350490
