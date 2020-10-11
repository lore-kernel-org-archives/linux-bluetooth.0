Return-Path: <SRS0=+Qjd=DS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4421CC433E7
	for <linux-bluetooth@archiver.kernel.org>; Sun, 11 Oct 2020 05:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCD892078B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 11 Oct 2020 05:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="2SyXl+bP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgJKFAl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 11 Oct 2020 01:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgJKFAl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 11 Oct 2020 01:00:41 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8205BC0613CE
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2020 22:00:40 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r10so10862431pgb.10
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2020 22:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=eZG5SK7sZHA0lKrpILD/eRTz7bH38IZ6QkwBvzzfKas=;
        b=2SyXl+bPWdcKTyuwrPRURxD2uUuMcwdFNXEMn2loQguHsdLwf3tzgg0zGUgdI7RrmH
         Bzlzyp2RswrhyTnUzOHI3f4XuqbbZ/rR26AedS46ebt7NWobCmh9KLYXunHrgIX2oRt6
         6S55fvbsDcQhxc+Y63Im4PYdEEhTLiVc8XsjsRlM6sORjpNErDgIEkDCwpnRryq5sj6+
         tdGVl3BUDThCObs+Ss09mkIaAMYj6up/L1HsAYyrEjeE8WblWj9tPCdiVlPDjCCk88GY
         so2c0YwE25VwEaMkG3I8GnT6D7Xf6liqVYliGwY1B08D4vEqhjnemKVywVfGoYvuLGYH
         9bYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=eZG5SK7sZHA0lKrpILD/eRTz7bH38IZ6QkwBvzzfKas=;
        b=mUGXxUxclAdWdKA6HaYKGzpBL3wuH+VoCzryHbgr8rq/JmfyyiebhgLproHmk1BxzF
         Elv1aMFNvb2RMth3/BIBG6rR9KJuKVYIfc13NL3rBBbsixsq0anJdv8B47FELZdhgXUK
         EJScSHw4Q+npP3PdrClXR6PxoH3on18rKjx06gRzL8FvnrmASM6Rai0tk4lSh4NrHT4u
         OLRqVlSawDnaBZmHJgsagWBttCub1SgUXwjFxvlOXRwD1oAlojW3H4Rmh9x+BOewBpfo
         7tjiTMJLZ15i1Um+QBvluSS1zAQHC8DR0CEisJeX37l2SBYBiLBP/OgyB5XRGLyyCoyH
         eR6Q==
X-Gm-Message-State: AOAM5316IYBwSL0P5eZyM3/MN6wkLSoWn2iUxYqq/UTswp2ZxRnbZG9m
        iGijG132Cw0zd3z79Jhx8BX5khBybkDyYvgI
X-Google-Smtp-Source: ABdhPJyHRKP+Ean5/6dkb0GMavh0BrvtwuJm36tTIitfqNt+7MDm3jPpc8HRqLId+4hMS2DITjQLmw==
X-Received: by 2002:a62:e112:0:b029:152:b36e:b05d with SMTP id q18-20020a62e1120000b0290152b36eb05dmr18416630pfh.3.1602392439630;
        Sat, 10 Oct 2020 22:00:39 -0700 (PDT)
Received: from [192.168.2.14] (216-19-182-159.dyn.novuscom.net. [216.19.182.159])
        by smtp.gmail.com with ESMTPSA id x4sm15348527pfm.86.2020.10.10.22.00.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2020 22:00:38 -0700 (PDT)
To:     linux-bluetooth@vger.kernel.org
From:   Peter Mullen <omaolaip@tcd.ie>
Subject: Bose QC 35 Battery/ANC Support
Message-ID: <333e38b3-da26-e3c6-76fb-1ee1caf90299@tcd.ie>
Date:   Sat, 10 Oct 2020 22:00:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi all,

I've been working on a plugin that adds support for battery level 
reporting and Active Noise Cancelling (ANC) control for the Bose QC 35 
headphones. The patch is nearly ready to go, but because of the 
non-standard way it's implemented I figured it might be necessary to get 
some preliminary feedback on it prior to submission (or to see if it's 
worth submitting).

As a brief overview of device control, the QC35 has a set of additional 
controls operating over rfcomm channel 8 where messages are passed back 
and forth between devices. The messages consist of a 3-byte opcode, a 
1-byte payload length, and N-bytes of payload. There's some more 
information on the specifics here: 
https://blog.davidventura.com.ar/reverse-engineering-the-bose-qc35-bluetooth-protocol.html

As this is a non-standard "profile", there's no profile UUID assigned to 
it which makes adding a profile somewhat more complicated. My solution 
here was to add a profile under the iPod Accessory Protocol (iAP) 
profile UUID which the QC35 lists, and to then filter out devices in the 
profile probe callback based on manufacturer ID, device class, and 
product ID. This isn't ideal as the probe will be called for any device 
listing the iAP UUID, so suggestions for alternative approaches (if 
necessary) are appreciated.

For session state control, I've hooked into the AVDTP state-change 
callback. Again, possibly non-standard but this seemed to be the best 
way to trigger the initiatiation/tearing down of the rfcomm connection.

For battery level integration, I've basically just wrapped the dbus 
interface from the standard GATT battery profile. This has been working 
fine with my DE; the battery level shows immediately after connection 
and updates as the level drops.

For ANC integration, I've added a new dbus interface under 
"org.bluez.Anc1". The interface contains a read-only "Range" property, 
which indicates the number of discrete values the ANC can be set to, and 
a read-write property "Level" which gets/sets the level. This interface 
layout was chosen to be device agnostic, so that ANC support could 
potentially be added for more devices in future.

Let me know if there are any thoughts on this; I can get the patch ready 
and submitted if desired.

Kind regards,
Peter

