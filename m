Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCF1EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 04:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjGLEwD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 00:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjGLEwB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 00:52:01 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E9AE49
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 21:52:00 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-ca3cc52ee62so389034276.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jul 2023 21:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=personaltelco-net.20221208.gappssmtp.com; s=20221208; t=1689137519; x=1691729519;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Eqg7Kpk0k+ogd6aNIVIKNqz1QHCLjcIuS+g/K7qBp0=;
        b=3I3FSSDwbq+BeBEUgRPE+w1Xu1+OOiqOuE6oWxroVLOXkpYi7ylgxSQaWQKJNSvnKe
         LxzsYjgXwls/BCXnsQWEFCBDX+cNqoW9wubEuVeSb/BebfgXEoFuxzZn5/3pv52Rg+mU
         o3M3Yd2U4HQZGcmDBgszWoQd1VB0IXhS7NjEjH2naKd1gnLpyNhrtrQnuLyxFhTBZcg1
         QgfOoljtSeZ9SwiV3nUZXHinAKFusXyMWU5JfH4ZL+qDMYO7iLGxr/B/x3X7klRRpESE
         dBfpe3tQaYPrkmNxO09gfq5rlHsGwxo7qf9nD66/bxS9r2HEwVes+FTud6H5fyyecF3p
         Ug2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689137519; x=1691729519;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Eqg7Kpk0k+ogd6aNIVIKNqz1QHCLjcIuS+g/K7qBp0=;
        b=VqccP7SllEmqLroXR3wuOjjHFAQaWXuoz5u2Q3qbKcRt1NHeV/wFcgyCupexoodBlb
         S4WbthWOwbQGOWvR+B5IbMaLP+NIXhZhRdQQNEM7FK/pJD2yx9TyewI3UvX2gb/NkB5a
         g2ChhnhI8DdER6tqB2Pi07rRyCbwoGzWILnZTuSrXvHWE4ib7WfAD9Cl4JVKV+M2uek+
         808QyaZMfI9epBQdhaw3jA96BIwHeHDmMWI5N0NLDN/rVTcJUNgjUEEaAGWYgHQHr81f
         F44IIQ2sCng4Gju476oD5zypmAhm7n5ssdS+NLDEZHMtwXK3hvVR2r8soxwOxc2Mmh/1
         Ncfw==
X-Gm-Message-State: ABy/qLaW6yBC+SuWHOVrx9ev5NmNbaCbcxLDWvsGB7CwuarUuoURs7sx
        qBL5xsrveJxhT94J99QCjY6Eue0BvOQ4rf3tQGqGQsk1yV0Cz4TT
X-Google-Smtp-Source: APBJJlEzh3Mlva20eTtW4Z7MoOFJzSMibovWRtrkPtDRXDJtxeasb4hrvOX/f5DJ7f0SEv0lrfpy48dptKqU3d8ibrQ=
X-Received: by 2002:a0d:f182:0:b0:56c:e70b:b741 with SMTP id
 a124-20020a0df182000000b0056ce70bb741mr17349992ywf.20.1689137519179; Tue, 11
 Jul 2023 21:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAHP3WfM2efs35fvQ+uOjy2awWgKosAfA7FbeAob8k6GhBwZvng@mail.gmail.com>
In-Reply-To: <CAHP3WfM2efs35fvQ+uOjy2awWgKosAfA7FbeAob8k6GhBwZvng@mail.gmail.com>
From:   Russell Senior <russell@personaltelco.net>
Date:   Tue, 11 Jul 2023 21:51:47 -0700
Message-ID: <CAHP3WfMz1p4MHwwDGTeU6iyuPz3OhnoB2EZ62s4voZbjhBEocw@mail.gmail.com>
Subject: ell location bug/inconsistency with README
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I mentioned this on the irc channel recently, thought I'd escalate to
the mailing list. Also, I am a total newbie with bluez, so please
pardon what appears like and actually is pathetic ignorance.

I am building bluez 5.68 on OpenWrt and found that a recent commit
1106b28be8 seems to have made the configure script look for ell
whether or not --enable-mesh or --enable-btpclient are used (I'm not
using them), in contrast to the language in the README:

"When neither --enable-mesh nor --enable-btpclient is specified, then this
part is irrelevant and Embedded Linux library is not required."

I worked around it by patching out the part of configure that errors
on not finding ell, but this seems like a bug either in the code or
the README.

Thanks,

-- 
Russell Senior
russell@personaltelco.net
