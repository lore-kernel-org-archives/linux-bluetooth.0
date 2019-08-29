Return-Path: <SRS0=q5Cw=WZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ECFC3A59F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Aug 2019 16:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED282205ED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Aug 2019 16:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=senic-com.20150623.gappssmtp.com header.i=@senic-com.20150623.gappssmtp.com header.b="gHk5lOAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfH2QhR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:37:17 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:42024 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfH2QhR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Aug 2019 12:37:17 -0400
Received: by mail-oi1-f171.google.com with SMTP id o6so3032157oic.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2019 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=senic-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=yqeeK41qJ4eyzvuEB0AU/rY4sRIAK4AWesl01/IKSWY=;
        b=gHk5lOAKyGz+icHncQwQcX+pATFdeFsj6/XwVBHprkfHUB+As4ZG+qk5EjH9+jkqAU
         5m7bAuHTpmkVLi0vzryG6ZxkdJLagg16Q6kADbmiA9SdrQkMXmQAYiEtEa2XymIo9Jzu
         GTIO6P+v/MyvZ7D30fY9ArHADXArDQ4LwXqcsMmkiHUEv6mydToC87UaKr1g8+wwWfwJ
         bBFe9BjLuuj5ryKHxEGCRSbpKXrPXWD5qInvzodws9Ha+fDJUZotk2pV0nuI5D5yh2Fa
         9vB6EaEJSKZlW+3l9/b0afIvm7Cc9IGqLIb5da7FBytIHOuRjIEA7pW1B1qcYXOSk6CJ
         ilAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=yqeeK41qJ4eyzvuEB0AU/rY4sRIAK4AWesl01/IKSWY=;
        b=FAXfaMst/WCGw7OwRJ0P8YLLUbxR+p/s005VhtI/P+1iHE58iZLfNwzYBkmAb/JNiJ
         BiKz41iyo98Y+D5sYzPkeQZvycGJPSkrz7k74CEzlcdCScdS0ZuymVhStAqeD7r4i+0n
         ZmpHRM8k7bvROoGPvCmqQlzcZUjvkS81JPTN37qJzEfpF6uhytfk8aNv6D3KOKxGZJQo
         rR8cVJxjNB7bkYq4zTtVHERNNA17sfc2sRLrzWYNmIN1QSW9kh2iI09d8ynJCmQp+pnL
         i9tmrf9dGoJTt3vQXIOC8Q7fQf5N1RfvaY2cY9SdLXwfPd6he3PpMJqiUTW/AZBRZBCx
         9+cA==
X-Gm-Message-State: APjAAAUBqVb45OxHwf9ImW11DlvqMFj4jErU8mpjrKfowDOhz78HAH+v
        YPb58ZJEx36A7tXsc78Vjctno3mRR798XS19/w+F4pY7
X-Google-Smtp-Source: APXvYqyA8L9zr9bdBo4ROP5lSjhRpPT03vxpvipAOOOc7h+66Bh26IzJ1i8QmnW4+rNq1mGoy0ZcNXt8by73L4uLS/0=
X-Received: by 2002:a54:4895:: with SMTP id r21mr6761608oic.66.1567096635938;
 Thu, 29 Aug 2019 09:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAOT_U5bDZwYLYsny9OpWs3HjQFLqYK2j3o3g2koKX_CwGUtMbw@mail.gmail.com>
 <CAOT_U5a-qBMnS0uaGx=O7Av_a0uVDWUaPxZb5HFbLijd+OQ6pA@mail.gmail.com> <CAOT_U5azR21Fu5a9OQ5grRW=ztmT273iba4+nHO03hoZyq-rew@mail.gmail.com>
In-Reply-To: <CAOT_U5azR21Fu5a9OQ5grRW=ztmT273iba4+nHO03hoZyq-rew@mail.gmail.com>
From:   Alan Martinovic <alan.martinovic@senic.com>
Date:   Thu, 29 Aug 2019 18:37:04 +0200
Message-ID: <CAOT_U5bzKdQRZJrRf7MbKMtkas6jfR2UHN0i50unoeUJXs_wWw@mail.gmail.com>
Subject: Locating /org/bluez/example/service from example-gatt-server
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
in the example-gatt-server which is provided in the
sources there is a reference to the dbus object
`/org/bluez/example/service`.

When that example gets run successfully under what
 "unique connection name" does that object end up living?

It doesn't exist under org.bluez

~$ busctl --list tree org.bluez
/
/org
/org/bluez
/org/bluez/hci0

Be Well,
Alan
