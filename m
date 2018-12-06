Return-Path: <SRS0=vk22=OP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE38C04EB9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Dec 2018 02:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A51214C1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Dec 2018 02:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nestlabs.com header.i=@nestlabs.com header.b="mizsaczL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A51214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nestlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeLFCzG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Dec 2018 21:55:06 -0500
Received: from mail-it1-f179.google.com ([209.85.166.179]:55749 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeLFCzF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Dec 2018 21:55:05 -0500
Received: by mail-it1-f179.google.com with SMTP id o19so24898663itg.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Dec 2018 18:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nestlabs.com; s=google;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=pYmJeaALV1j5SXS1SQvjiq2rcRiEVrY0kLI4guT/2gU=;
        b=mizsaczLN8FVIZuEvgHeAgDvEUrK506Bxe0SAXAKk82+tacWQV28Hema590XHGwRHD
         zVfKGlSbdj1YeNzvYXPdlXV1PcPu6NX2hxtNs9sXo9nzjnaXXOI/sFtF8dLFT0cRwxqa
         2n2cV+yMLDTOK/ht92wccgzuo8K5o6hrAQoqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=pYmJeaALV1j5SXS1SQvjiq2rcRiEVrY0kLI4guT/2gU=;
        b=JyOxX5n3EjauU/NJqVhejDTWVUDnQBIwZo8fysWejeU753dzuFJagu08UrEAepP0PV
         EIYwONPVaQisA9B8QSPFVgmrSBBBGHpUNVQcDdnXYOjAPI+WG1omI+4MvijS64gU6Ogt
         na6WbXvO1TDs4aMMoJtVpLyvBFAhN1hFGuc28Z2qROxBAUnRcUFRt/92I+jgBsO2+pLj
         p2CRTa0jNkUfsfPoYZMIWvUJPzSDcII8JYW/S2HjfKtRQXdRoMkiXux6SnWmEmePoIOq
         8BwZysnteypG3rJ1SHiawVDD0T6/duCJkLoGqUHLjcV8t3TB7xKyHvmlQPpbqgYKZG/b
         EbGg==
X-Gm-Message-State: AA+aEWbOHu5MVy9WNISGk5ufytR18Ch008p8FOIdQyJRib9HNgoGd7OS
        G6UAjddPM0nh/lWPfG3Q7JcCo0qN5588xNmEoPyLAAJwwSG8HA==
X-Google-Smtp-Source: AFSGD/Xuhi46TKoyUXO+WsCdoHvsf3fO1UxaNmeQpikRSzStGoqudBKmUmVyl2gWstJZAFn/XaLfIBM6/y/hvzfOVsQ=
X-Received: by 2002:a24:7954:: with SMTP id z81mr16120832itc.94.1544064904854;
 Wed, 05 Dec 2018 18:55:04 -0800 (PST)
MIME-Version: 1.0
Reply-To: yunhanw@nestlabs.com
From:   Yunhan Wang <yunhanw@nestlabs.com>
Date:   Wed, 5 Dec 2018 18:54:53 -0800
Message-ID: <CALvjcs9zQ3v9pW6_Sy-VJD4hiX2FDrnqV7xYUNkNGg6mVaoHKQ@mail.gmail.com>
Subject: BLE advertisement re-enabling after ble connection goes away
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi, Luiz and Marcel

May I have a question on ble behavior on BLE re-advertisement?

According to Bluetooth spec Vol. 3 (the host volume), 9.2.4.2, "The
device shall remain in general discoverable mode until a connection is
established or the Host terminates the mode."

There is no description on re-enabling the advertising "after"
disconnection, so the responsibility for re-enabling the advertising
is bluez or kernel or application code? In other words, does kernel or
bluez or application would re-enable the ble advertisement after ble
disconnection happens?

Thanks
Best wishes
Yunhan.
