Return-Path: <SRS0=tzy8=UI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0556BC28EBD
	for <linux-bluetooth@archiver.kernel.org>; Sun,  9 Jun 2019 23:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B220E20693
	for <linux-bluetooth@archiver.kernel.org>; Sun,  9 Jun 2019 23:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies-com.20150623.gappssmtp.com header.i=@colorremedies-com.20150623.gappssmtp.com header.b="yDlhdU6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbfFIXXF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 9 Jun 2019 19:23:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45746 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfFIXXF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 9 Jun 2019 19:23:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so7273946wre.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Jun 2019 16:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=z1chLZL7JUStVxB83hQwOXpKZdx+iT98DqkKMoEcVkQ=;
        b=yDlhdU6gS0n12d+kj/bXA2cbxmXcCFgFTIG43o9j4rJ/heHGFyyfgmUQC0Hf5Cj/qy
         N48Ca3f5Sb7Bqg1PwPHQAYVQz6z8PPmSaCvlHpRtUUN+OOm7jHM7WRTBcsdxRGFekeu1
         rwG2WK7nDVAo8W1zUK+hvNWdFk0WQtbFI7tWF5DUZGKwxFQGAp8mfR4F9ejjBBi2MGME
         zO+/doBk90wweAOwbM6BcDRVOrdrvjB0i6afEwJosZi5FjUm+V1MwMyVZRPbx1enzXPp
         fXXqA2oHQ45/+xc5bb2NiWAYWAzoGaqM7AV4ZYDZ0s0my6s7lLr0YIVhZ9n6QcAbxYrX
         6Wpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=z1chLZL7JUStVxB83hQwOXpKZdx+iT98DqkKMoEcVkQ=;
        b=oDo+0i+a1xsdUSXp0HqIQGMzVoQBwJpEroW1z8nNKg0HZl+bTO9we5pLzkWtrJ9E1H
         PquPOC4mXzeLfIMEUvlvlqZmcQPLUUk2xyLg3LMsE/qGyaX0ZfmX5cWriRK8sCR9NaB4
         AotjiY0Nclf679JAoFu4N83C4hy/QrIFJ5ajaMN24KXoDAGJvT5CBDoQGg2f6jG2lPFN
         FcCNxSEAWixXER+dDTpDheLCu9JxH06qpyUVKZ6wytV9jiqrBgs1Rol9dzcYLILhspQb
         g/R1owTofRrGdFrursnzL0GMpBoSRbK4BOXztlMvxIGkrvv5R2oXTXGAPMxPeIfhmfJ6
         4sjQ==
X-Gm-Message-State: APjAAAWb9YsFYZ9pgih4DMFUBK1M7Ezzdf/TTS6psGEa0ZiUpC6taGgO
        qqSwq2b3clA0HRq7KnqILFcJXQ6CbH4+ZFC94JUzESTmEBU=
X-Google-Smtp-Source: APXvYqwVSz3wE9y1OiSE0FAW8qw2BT/DE+Swkj1/HyuJ34sTTlLUbTnxhzsYXePvTuhZB1W7XAS3ssR6YoePQphPPZw=
X-Received: by 2002:adf:afd5:: with SMTP id y21mr41700376wrd.12.1560122583895;
 Sun, 09 Jun 2019 16:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTnoLGDByW+S4Cc311KzsSReH-_uNgtV5=pe_Fou5q9Zg@mail.gmail.com>
In-Reply-To: <CAJCQCtTnoLGDByW+S4Cc311KzsSReH-_uNgtV5=pe_Fou5q9Zg@mail.gmail.com>
From:   Chris Murphy <chris@colorremedies.com>
Date:   Sun, 9 Jun 2019 17:22:52 -0600
Message-ID: <CAJCQCtRf8y4CM2Qf7VfJBd60FKwgvSSrVskW-XJJoZKOVFy4SQ@mail.gmail.com>
Subject: Re: Apple magicmouse disconnects
To:     Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is a followup for this bug
https://bugzilla.kernel.org/show_bug.cgi?id=103631

The problem still happens with kernel 5.2.0-rc4 and bluez-5.50-6.fc30.x86_64

When I unset CONFIG_HID_BATTERY_STRENGTH the problem no longer
happens. But as a consequence, there's no information at all about the
mouse's battery strength. So I'd say the original patch is suboptimal.

https://bugzilla.kernel.org/attachment.cgi?id=203881&action=diff

But still better than random disconnects all day long. Any suggestions
on how to collect more information on the device for a better fix?


Chris Murphy
