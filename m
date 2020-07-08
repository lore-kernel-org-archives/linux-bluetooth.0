Return-Path: <SRS0=eST2=AT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4F5C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jul 2020 10:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D433206F6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jul 2020 10:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqgiA+9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgGHKYp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jul 2020 06:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgGHKYo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jul 2020 06:24:44 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E74C08C5DC
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2020 03:24:44 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id k5so990482pjg.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2020 03:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=hjVFcpSUOWmjOUhAjbp9t713LG+CPl0W9t3Mxd3PJhw=;
        b=lqgiA+9P0w4AkyRmLchQwJ5uJibOVFuKS4wdleLwl1h38Ia3QsPrmYX8EmCZ7+OOOO
         xGOhTDAaKAzpLX+BwdrCwgGsAETCaoEQTmly+xmdjsA2zOLKMKZrM+4hB+4J02Egk+HU
         kxEkji//WwfQlrZlkTJffIfZZqT/VeG5lFh9xd/SurtZWXd7m1f+4CYPSPOdgXKwVzyW
         8AaYsGN0EgyNIO5EBEyNQfsPBYZpHPR/gfKrU8vwx7mi6HsGIZmKPgc1wwxyQShWoW7V
         RQmJls3WE7+ncKLIcWnxMGTnrAuay8GRlpzhG+rxEE2d0uD1Ja5SviLqUj4QyA91vEAJ
         EYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hjVFcpSUOWmjOUhAjbp9t713LG+CPl0W9t3Mxd3PJhw=;
        b=dadONMtFVJ7vBvqTPasmfzncU8CgGKGdiXcIC7JWMcG/hlpdR3C0h1flsjFWr2enTA
         Nbigx9B5TdQ/NSmTCu8OJOT/EHLi2bXji118vqx+eogPQqSr2ga279hvpaThqDf3Is5e
         EMYPycjrCIBXk3wxRaRgZ4Acqm++dXTsrukAXNoY2hGQB64hOJkNRhn9+TZI3389v3XC
         raWQlXgXYjohlNmB+b5U1o7EtCrPiuxDFa0AgRONh1gTDZ+d7xW/jeZq1MvWQP9DlY+w
         fh+eUusRSJvQk4LkUpT8OjdsD549E6McyKSOK906MalypiiAzwK/m/KTre5RGwZYOb2L
         /frw==
X-Gm-Message-State: AOAM531Xp0V7/O9jGQ2CP7thRHsKjNsJ38boa6HXWMc503lIvYfa7uKB
        ZQb6zE8AtBVCm93PUt8Q8+XyTUH+Cze+/eulP8RduQC6
X-Google-Smtp-Source: ABdhPJyPrg9MM4m+PXrcJSlLcj/0bLFVXal6J85DnEhsSTwSIX17QIH/69lDp8MalJS7aaoqzLko3imIjL1xrW2GWYs=
X-Received: by 2002:a17:90b:3683:: with SMTP id mj3mr8831412pjb.91.1594203883469;
 Wed, 08 Jul 2020 03:24:43 -0700 (PDT)
MIME-Version: 1.0
From:   Andrey Batyiev <batyiev@gmail.com>
Date:   Wed, 8 Jul 2020 13:24:32 +0300
Message-ID: <CAEQQxWxKs7ewwVyq4mnsyLbRhErQe9vZc5joNK6zfGSO3wN5bg@mail.gmail.com>
Subject: Temporary device removal during discovery
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello everyone,

I've found the following issue:
1. in bluetoothctl run "power on", "scan on"
2. discovery is now permanent
3. make one device discoverable for a moment (e.g. turn bluetooth on
on your phone)
4. bluez would detect new device
5. turn bluetooth off on your phone
6. now wait

Expected result:
7. your phone should disappear from discovered set after some time

Actual result:
7. phone would stay there until discovery is off (i.e. "scan off" in
bluetoothctl)


It seems like there is a code in src/adapter.c responsible for purge
stale entries
(remove_temp_devices), however it only triggers when discovery is off
(and after 3 mins).


My use case is to continuously monitor the bluetooth environment. Is
it bluez responsibility to
remove stale entries during discovery or should my own app repeatedly
stop discovery?

Thanks,
   Andrey
