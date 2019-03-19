Return-Path: <SRS0=3ySR=RW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84831C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Mar 2019 13:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AEC420854
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Mar 2019 13:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NY2P3+bb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfCSNWr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:22:47 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:42630 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfCSNWr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Mar 2019 09:22:47 -0400
Received: by mail-oi1-f170.google.com with SMTP id w139so7150274oie.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2019 06:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=i8TNMLeE42mrdVgVswM6ME9KIOvH/RjQWjoofLZgIrk=;
        b=NY2P3+bbPhDQa2EuIgHhbfQCHM1X4zgi/9PSESkPMoaLGt6KWoYbnViVpNyezJWduU
         DV1oIMNrSGWNKpWNkJBNHFcOeqcQsixzYHjn5aSiZQ/ha8DVzOGD8R73UmbEVKGDi+fd
         776vmA4S1dQMdZjNfQN8qOQRhW3yLbEXadGLMJCpDGsCnbfWDh/r27YfzZtbgW9sUNz2
         K6UknqDV9RcGmeeCHG6KfB9wetPo8okPpXLlfwZJe5PIGFFjZuedrBIUfArnUTlzMdEa
         FPbNp49MyemBZ8loFz+HX0uqwDC6Cedh6U5IW4SAY92xE7NJm1q55vukzqNpsbck2i4W
         7tjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=i8TNMLeE42mrdVgVswM6ME9KIOvH/RjQWjoofLZgIrk=;
        b=Gn8k99oWXY09O1TzLvGekeCT3xReNXB7tyq1sU0RsarMtn7ujpqRGiPg2Vsbxt9J6e
         eB72V/d/S2sDHHBE/CTjaOCni3Re6Bw/IZP9YekK8VDHa/CvigANj2xAjrXe1xLxHO06
         RT2zrDWPIHVSpc/rgW6sup18nA3hs0skpEm5/pJw0hFeDmJ9gLBGcl1qKJKgtoiqZ8aa
         S57UGWPIJWScL6+odrhda//fFJqZcwYGPxks7s9cnsfZfNt5P1sZNYf+QDnS0o6ks/kZ
         WlP8yHD2U0/mvzWC/BgMrrbgatbk7xawGKOLN+X4KcYjCcL7/oOr/ZIIWUxp4Y1j9nmL
         CYYA==
X-Gm-Message-State: APjAAAUV/Fh4ocktkQgsZwG3Y3kh72lHoNzrs5bFCCkK+nEndAwV0HRg
        XWm99mKL/A+V4m/1/sCTOvyvFXOY54hRLsjQ6kp4fmaNytw=
X-Google-Smtp-Source: APXvYqxE3bDnRgq9ioOnZcml9+0wNLvL5haFqqD8YBQp0K5lSpV+6BmRRiBo1o1JFYt5ifjOYJONHFkPnttAamE1bRg=
X-Received: by 2002:aca:5605:: with SMTP id k5mr1329786oib.43.1553001766945;
 Tue, 19 Mar 2019 06:22:46 -0700 (PDT)
MIME-Version: 1.0
From:   Miguel Sancho <miguel.a.sancho@gmail.com>
Date:   Tue, 19 Mar 2019 14:22:35 +0100
Message-ID: <CAGuyqoGXTArrUiWKkX9AGkUAa0qAhXGn2b5sgPiaDM968MmzQw@mail.gmail.com>
Subject: BlueZ 5.50: Avoid service discovery in every connection
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
using Bluez 5.50 to pair do a BLE device, I am seeing that there is
Service Discovery every time the peripheral is connected:
ReadRequest
ReadRequest
....
Read By Group Type Request
Read By Group Type Request
Read By Group Type Request
...
This behavior continues even if the remote device is marked as trusted.
how can this be avoided?
Thanks in advance
Miguel
