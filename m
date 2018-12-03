Return-Path: <SRS0=1Mik=OM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157C6C04EB9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Dec 2018 03:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87AE20892
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Dec 2018 03:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zinnoinc-com.20150623.gappssmtp.com header.i=@zinnoinc-com.20150623.gappssmtp.com header.b="XYqMe07b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87AE20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zinnoinc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbeLCDhz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 2 Dec 2018 22:37:55 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:33746 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeLCDhz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 2 Dec 2018 22:37:55 -0500
Received: by mail-ed1-f52.google.com with SMTP id p6so1216984eds.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Dec 2018 19:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zinnoinc-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=L+AE943PUJNpFpnEou1kw6xifwwAKxICB7PdJcWS4Sc=;
        b=XYqMe07bGmZa7NBX32v9wt8YRope4Ym2gblEGcrBOzCyWLb4VFaBY9/vJDg8OW9dr8
         axGJeEGKLHCEeXFKF6xATtXTnL5B3hlucya2OnEXWyc6cE69YAk4nR4A2eK254FkQ592
         Hi6Pa8iXroU/Pwzw8KwuhG/rCsH47msxfbx1xceYtXqjsthH5DbAHFt6DR6m1qfCHoEs
         YtHXVeZ/YZNhV/zE4Yxx//hBBkl3SB+GNcjHt9t7QTOutPavbcJ9T89/s4z4uJw169Am
         2UWydjRX9LrFBpLNpDyDI/XaE895sZ2dDHDg/wh/xMNc3UYoPk4XOHIzj8d23lVUr8Zd
         aw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=L+AE943PUJNpFpnEou1kw6xifwwAKxICB7PdJcWS4Sc=;
        b=ubL1dkAIFo7B4IuOKsHDrNzHOUl+eL9JJJE3VpOPGYeX3j0Gf8Dew0ctOyzBHd6/o8
         NvFfu53mG12pIEPJtIUdBmPJRxzWlODvONMWQMYdCSHehWYatwOOpeJk34XDpojySPe2
         iiezAp+nDF1ESSoQYZx1XcXqZB7kgYQp+ro6DKZEY0+WAXUkSSFdfN+yyRBkNcz7aPPs
         E+IpksoiNXC5SDz9EAPjixDbxBxtQcxahztb3owCKzIm/hCqBFl0b0TUXLWSKzcdA1Ud
         jf4Cl5Qmg/qpNXuEGm3/RKjVr/MAxAJ6stK/wwvMIr4dkiJwgKYyt6PixsEZ5kcIv5gJ
         j+9Q==
X-Gm-Message-State: AA+aEWYnopms1GPE9qIli6+FQ/OHFObOxWK8MvY4WKObypsR78usN6pN
        zi2eJZjzYtkG45BK5JIkiOITbIEBi/Mh0Wg6cKWavUNPtk4xIw==
X-Google-Smtp-Source: AFSGD/UAhUPGTY4mT0nizb72kQuLCxp8q3XG5AWYuJGMsESWnDFkPiNyRPt83emrHVg/3xVZigEqwnT3NCPGTZvztHE=
X-Received: by 2002:a17:906:7087:: with SMTP id b7-v6mr11360666ejk.194.1543808267936;
 Sun, 02 Dec 2018 19:37:47 -0800 (PST)
MIME-Version: 1.0
From:   Tuan Nguyen <tuan.nguyen@zinnoinc.com>
Date:   Mon, 3 Dec 2018 10:37:11 +0700
Message-ID: <CA+z3N4hm3CQezC0DZjd=BY-e6EX9bB07N4jxxqYeEgzH-QiW3Q@mail.gmail.com>
Subject: iOS auto disconnect after 30s
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi there,

I am using bluez 5.50 to write an application to communicate with iOS
app via BLE.
the python advertisement and gatt server work well but when I tried to
change gatt security method from encrypt-read/write to read/write, my
iOS app alway disconnect after 30s.

Using btmon, i found a error related to Insufficient Authentication.
Also try to test with bluez 5.47, the issue does not happen.

Thanks

Tuan Nguyen
