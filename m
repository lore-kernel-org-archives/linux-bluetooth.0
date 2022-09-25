Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8387FC54EE9
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Sep 2022 18:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiIYSy5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Sep 2022 14:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiIYSyz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Sep 2022 14:54:55 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1975E1183C
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Sep 2022 11:54:54 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id z191so3647374iof.10
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Sep 2022 11:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=jTHgN+z7HzoJ10LD1Q/KxAgXuVKTJwz3qnfXPNWPwB4=;
        b=Xjz3ZdXOwXBFdWLySCJkzVvUR0HjxbpnZ84PMtNwbF4UXH0hCh/NXylrnWGqTYojj4
         KGYJzaK/IPAN6sVOkEeDdpBoTCFHqCxv44MbDD1DJlYUS0dhtFRK6mPabi69WFo3ftSL
         SQrIs8kh1FXe8geGtV6VzKrB5Bp1nHNuZCwGinb3Ws1sEayxvwV608eWT69aFheyRqDa
         3JmX+ufKzohGOTIUN/02MeonBtPP7hWNTuK3tAUfqmgtz+ibChxy2PNIJO7N8mihS7nf
         PvVEo6XKABMq8g15g7ohxdmje97L8QG8+sPvag0M5aN7GwxYF5FC/aKd83TwVspYDpqw
         5qLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=jTHgN+z7HzoJ10LD1Q/KxAgXuVKTJwz3qnfXPNWPwB4=;
        b=WxXppOHEHpZx15wxRLBKyJxX73C1vgrR+kEXNzl1MpoZtnenLiveQ4wQITTTFuFuS5
         5R7iykSlUvhZkD7TtvgQFzMHEOB/sdHjxH9XI1Hm4cdV3SdCofCphUmnSxJ3dyw1T7+X
         oYJnyyapQDKhUzna0WhJsmaf5XzGPt2QC6Bc1dZzx//PWG4d8do+No3kzeJgzI8PMyT7
         mv1Kq5BRgyKM51i3jQ05lFS3p9bwwryd0od5ooOMh/i/ZXyKoYEzUFp9TPsJnvmTfjon
         lDdf0S2jnMSlIf2osQbp/wuNk7BbK6yyIRTHykt6/2z8c1W4jJObzXvSOsX9CjLqdIrg
         z5fQ==
X-Gm-Message-State: ACrzQf3oZ6iYpL170HdwXiOF8JOj1VWzk7PmAhJqghvLmvTeKjrS22Mo
        lZwE9y3iP7hrkdG+v5hh7DczNSPh3a0=
X-Google-Smtp-Source: AMsMyM7seueO7fjqtdjfqzkoa1ap8+H+2PtdcNkUDPHb5OcjVTCftSkK4xi5xk/o/YLQamYje0r0PA==
X-Received: by 2002:a05:6638:144f:b0:35a:6828:680d with SMTP id l15-20020a056638144f00b0035a6828680dmr10478476jad.286.1664132093162;
        Sun, 25 Sep 2022 11:54:53 -0700 (PDT)
Received: from [172.17.0.2] ([40.86.95.243])
        by smtp.gmail.com with ESMTPSA id d5-20020a026205000000b0035a242f30b6sm6114748jac.175.2022.09.25.11.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 11:54:52 -0700 (PDT)
Message-ID: <6330a3fc.020a0220.d5f6e.6ef1@mx.google.com>
Date:   Sun, 25 Sep 2022 11:54:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2231518343826692665=="
MIME-Version: 1.0
Subject: RE: [BlueZ] obexd: point DBUS service to obex.service directly
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, beppe85@gmail.com
In-Reply-To: <CAP96LmPVajLT8P_SBzJBnW1vJqDhU9-XRdVdpyReuwB=utNFLQ@mail.gmail.com>
References: <CAP96LmPVajLT8P_SBzJBnW1vJqDhU9-XRdVdpyReuwB=utNFLQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2231518343826692665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2231518343826692665==--
