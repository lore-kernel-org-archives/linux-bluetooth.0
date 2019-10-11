Return-Path: <SRS0=4il6=YE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939A8ECE58C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Oct 2019 08:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A912084C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Oct 2019 08:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQWOpLHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfJKI1a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Oct 2019 04:27:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42278 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfJKI13 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Oct 2019 04:27:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id n14so10820222wrw.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2019 01:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=qVoJ4SVUyU+6feycFSsMeunDkYBWEzLCZffZvRl19i4=;
        b=TQWOpLHsGjyKDbkPNkg3p8u/aA2m8Jk4oFN757R1kEwZqwSqEXcLbv3MQOAdXEDENt
         tachmmp8fEDl6554Y4YWckTKLY3wGsbc1U3xr2CI33sqh6RmQ4nc5QQVkKFYJzo+cbu9
         wiFYcoCpOQnCGOWObWs7Gt5F4/U7HG8wkyugL/wI86V/H2VPqy8GWSCjL4FiyhK8FKiL
         vgB0s5g7ufjLxOtP7IT1IU6GQG/bYLEqyaNsBvFbta+pNqfw1UhB1+jBkLxhnHh01Der
         W9b1xsHnCAeEdQACfz6krJ3m3MyNToTCcMNKgbLrDqJwKE8pM632gilTIk219bm5f0l0
         X10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=qVoJ4SVUyU+6feycFSsMeunDkYBWEzLCZffZvRl19i4=;
        b=Vwcs2rQuj/dj57pcUq/zycZPkZIYD1VXSZAheH4+d/iH2YLVZ1ntLOKnD8pQ4OIJcj
         D66b6VfLwfJDdgOPr86F60erbrx/WaeRyIUHhaFdps3ZJmI34jb11eVsgO9s1uWHZtzd
         FKagtaBfBnBUK+9jh+YjD5YmAQpu+u/H6gASB/ZmPl/nY2BDimojYRC54NisOGGlE71N
         fQMzlI0qC+mIuhEPQxBs/r3WaPsMVImOGXSMeFrjfE2lAFp6jg3oLtmz4xfwXxJLBcUI
         cE2UDy5pmumH9W8sQugCdqbga8wJa2Uw9jpdfoHgGvONJ7U4eVknPjtHTU2nkINapCQ9
         T2ww==
X-Gm-Message-State: APjAAAVP4wDL1zP2wrnUfVYY2zr7s1PLm4/T/FgKFScVzxHCXAJfe0g6
        JVKSqtW3kau91xBD2XMVC59dTkW4
X-Google-Smtp-Source: APXvYqwGnUvMg9lWGrSkosUUcnRUbMQ4pCJQHUcOgJt7uJvq9dqNFjmj4OgLRQZrkULZaD+ly+w+6g==
X-Received: by 2002:adf:f0c8:: with SMTP id x8mr12646659wro.206.1570782446090;
        Fri, 11 Oct 2019 01:27:26 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id z9sm8646256wrp.26.2019.10.11.01.27.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Oct 2019 01:27:24 -0700 (PDT)
Date:   Fri, 11 Oct 2019 10:27:23 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: Determinate EDR speed
Message-ID: <20191011082723.t6w2jcg7v4erlnq6@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello!

I would like to ask, how can userspace application which uses bluez DBus
API determinate EDR speed of remote bluetooth device?

Particularly, I'm interested in detection if bluetooth headset supports
EDR 2 Mbps or EDR 3 Mbps speed and based on this decide which SBC
parameters would be used for encoding audio via SBC codec.

Is there any bluez API for it?

-- 
Pali Rohár
pali.rohar@gmail.com
