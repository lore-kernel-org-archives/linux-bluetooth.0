Return-Path: <SRS0=otBP=MV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E087C64EB8
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Oct 2018 11:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F71221479
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Oct 2018 11:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQp68Llg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F71221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeJITLQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Oct 2018 15:11:16 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:47007 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeJITLQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Oct 2018 15:11:16 -0400
Received: by mail-oi1-f174.google.com with SMTP id k64-v6so947450oia.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Oct 2018 04:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XX7mwqxmKnq3zJzATZlyUbERJrrlCKv/W5+YMhkxZN0=;
        b=XQp68Llg6sCvcVNmEsFrXVBv1Syuub6EuSarsD53CJ3mUQzRHaBaNcV9xPdTFb4REq
         xkfSZJGeeKo6FqlMDp9Rniwd3JNHhvdiZh1IMMTQ+icp/KVfBnaZan4gMrFtLfef0+g3
         iIEA5p8eME7l2Ft00iAi5tyimID4czVFGh9RJvPSMGPzrQ6bctA4IjCE7QbbfyKLzgeN
         BJ6hywv7M4bq1dCOm9l4ij6lVulop7VGbscGWiPVKjAMk5Urm4l7lG+SbGEF07RubDj+
         xShpF0aysZAjw3/x3L8H0DGJQyj+cs4HOcfsfglull6YokaVDAWHgpxvxv2nr5sFr5y1
         FVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XX7mwqxmKnq3zJzATZlyUbERJrrlCKv/W5+YMhkxZN0=;
        b=CUWvkR6tNE76ryBrmfCYpyLDteo8o3SzuKcP1JMUI+4rBKyxsEHoP8XpcA/OwuMqi3
         al9rHqDhTDCd7O/NM5ZzcrvxS1B9hMDEk4cHwa9SbpI460bEK41ny9xcssTqP1wKDqMB
         +aIOnMyeJycbxwdYxEbl6e6rnSngTAOqaoMik/ZSTdAk4Lnf7By7PnPBmLoKvu1fkVrw
         /sfchZF97qgfhBj/Hl/7mNQiPuhpuuaXFc/MjvukaVfHuGLxbIUip/Dfn1yrAMwMgfja
         nH0Bk0rFd3d0QSRinBJdHI7/Gbh9NEHl1Gk21b8K35VJ6kqHZ2WEKJj7izs+3Qh8jead
         j7RQ==
X-Gm-Message-State: ABuFfohtwPIfOHlWkRK3wUmnW8x+1rTQTFVvF2kceyN2kqFWraT86cmM
        5dZ3XswQnNnbTHlvBOUvuOS3moH5rMS7/Dp2veqQzg==
X-Google-Smtp-Source: ACcGV60UJw3iix1Vq1hOGng6xn5wU3VAK0W0gXB8cp1iiOkiJxiulMT6fEsLHNCN+//tl3nryai2CVNZ9MeM2m/U1oc=
X-Received: by 2002:aca:4786:: with SMTP id u128-v6mr6680143oia.250.1539086079078;
 Tue, 09 Oct 2018 04:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAANRJtyETNy2GMYfRtFDFm6TJs94W+oXGmY_zdR9RRx_1tFpNA@mail.gmail.com>
In-Reply-To: <CAANRJtyETNy2GMYfRtFDFm6TJs94W+oXGmY_zdR9RRx_1tFpNA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 9 Oct 2018 14:54:27 +0300
Message-ID: <CABBYNZ+g+oDtbQ+FjQcTKGzAfJcD8OkVr83YOT-cr5D9TmoBHw@mail.gmail.com>
Subject: Re: scan stopped after log hours of stress test
To:     amit.k.bag@intel.corp-partner.google.com
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Amit,

On Mon, Oct 8, 2018 at 1:36 PM Amit K Bag
<amit.k.bag@intel.corp-partner.google.com> wrote:
>
>  Scan_Stop.7z
> Hello all,
>
> I am running some stress test on chromebook with 5.44 bluez version
> and 4.4 kernel version.
> In this test it will scan for device connect to device do some data
> transfer enable disable advertisement and repeat this in a loop. But
> after hours of test scan request never sent to controller. From the
> log I can see last time kernel sent the scan stop request to
> controller and the scan stooped from controller side.
>
> In this log  mgmt discovering stop callback event  at some point is
> not received at Bluez adapter .So that
> Kernel and bluez host lost the sync on the discovery state .And
> further Discovery_start() request has been ignored .
>
> In previous success case I can see the below 2 logs
> Line 79243: 2018-09-11T11:50:41.724644+05:30 DEBUG kernel: [
> 105.371680] mgmt.c:mgmt_discovering() hci0 discovering 0
> Line 79284: 2018-09-11T11:50:41.725959+05:30 DEBUG bluetoothd[2265]:
> src/adapter.c:discovering_callback() hci0 type 6 discovering 0 method
> 0
>
> But in issue case only kernel debug message is seen in messag log as
> below but bluez log is not seen.
> Line 4048575: 2018-09-11T12:03:59.350884+05:30 DEBUG kernel: [
> 634.306257] mgmt.c:mgmt_discovering() hci0 discovering 0

Somewhere the message is dropped then, do you have btmon logs? That
should be able to decoce mgmt event nowadays so we can least know if
the message reached userspace and was dropped by bluetoothd or not.

> Further when bluez try to start scanning in kernel its always called
> stop_discovery().
>
> please suggest how to fix this issue.
>
> Thanks & Regards,
> Amit Bag



-- 
Luiz Augusto von Dentz
