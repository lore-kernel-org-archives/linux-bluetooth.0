Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1ECC77B73
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 14:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjE3Ohx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 10:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjE3Ohv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 10:37:51 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7E18F
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 07:37:49 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-33b04c8f3eeso25797965ab.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 07:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685457469; x=1688049469;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Kab/AxRQCNqtRY9Zf8WX2Jt6mazMVIudqK3inlurn2c=;
        b=MHrFZ+BEyUT8jJ0Y+vnspoKeN2WkpaubjUKFe5EuN7DrLy0dQTZiof0VIhnFsDApD6
         txgz6vv0+V0B49U3GdWxDwtWBOcMNQlUFDBWkotBcf9q+vK1zwRhJuYAlC7vQIB0cpoq
         7vr4Rz8gRkk0kQIOiB4H3ATsrHOW4Q/5Ut5iEd7pMp8F7aXD5Oqc3cU+PcBfM0v+xsXD
         i7qECiNIP08Y0sYk6kLQRvpZDKF/OY6u8K+9NHuV8TjPeYqQ4Y5G0M0N/fGbdAa88ikW
         Vf1KZWJ9KyGlDeM3JtmrzBSJsR+sx9/XSsG3ostHhIcq9lYFkS/YoEG0/70HnVShjVDD
         Hkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685457469; x=1688049469;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kab/AxRQCNqtRY9Zf8WX2Jt6mazMVIudqK3inlurn2c=;
        b=Qj2wawxnjzuj6NBZHoKs6QTUEpD7aXqkuC5/zWIjNWpGf3nIYX4noyW9URYsVfgdsu
         YMzr4NDrdCnB2QO2kBM49V9vEJhy1QVgtOSrnUtISjny9StM7l7IZfHAmrR9wn382PUb
         fgOtPDnOPT9lmtv6q+oD2YEe6xH9LhG4tgUw8gYaffXBEoIkTsoZPEyZTF0qNDRtSa1u
         644wzYEbOSvF76vOJ18pvXFQPZkQuPmKW75OchKBgtUh/O5m+7JCRsCFrrmz3Yhs0oHq
         SoLAsO+GDVfyVwpJX97bOZ0K5lm/FDK8IBo3MMsv1qqJgqAsJv0BIBQA26hjxh2aX+gT
         C/XA==
X-Gm-Message-State: AC+VfDzp1y+htSlCEDQG/cf5avC9IT7P0wk+HxqhTFCmwyEhY5N9UeLs
        veTjIVy3YlTAVTHdGyQwsGUz16PI6bE=
X-Google-Smtp-Source: ACHHUZ5cA34ecG3CtSUiZrkdAnsnB+AIrk8C03lk+gG8qEv4Q5bGFADUVlmL/2eUgWR+Ns/Hlm1X0w==
X-Received: by 2002:a92:2911:0:b0:33a:cd32:d2ce with SMTP id l17-20020a922911000000b0033acd32d2cemr1604305ilg.32.1685457468795;
        Tue, 30 May 2023 07:37:48 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.50.164])
        by smtp.gmail.com with ESMTPSA id h18-20020a92c092000000b00330a9a362c8sm1420714ile.8.2023.05.30.07.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 07:37:48 -0700 (PDT)
Message-ID: <64760a3c.920a0220.4efc8.1af7@mx.google.com>
Date:   Tue, 30 May 2023 07:37:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0661426631292108982=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dragos.panait@windriver.com
Subject: RE: [6.3,1/1] bluetooth: Add cmd validity checks at the start of hci_sock_ioctl()
In-Reply-To: <20230530141730.310580-1-dragos.panait@windriver.com>
References: <20230530141730.310580-1-dragos.panait@windriver.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0661426631292108982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sock.c:987
error: net/bluetooth/hci_sock.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0661426631292108982==--
