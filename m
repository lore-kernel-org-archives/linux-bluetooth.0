Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74EDC7EE2C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 12:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjE3M4G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 08:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjE3M4E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 08:56:04 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644DD100
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 05:55:31 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6af86627460so3352654a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 05:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685451318; x=1688043318;
        h=reply-to:references:in-reply-to:subject:to:reply-to:references
         :in-reply-to:subject:to:reply-to:references:in-reply-to:subject:to
         :mime-version:from:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpOb6iXabI9s4qxO/9LxJHlZYONhIFuWo8fbny/HpfQ=;
        b=n20JFbLpkZjZiNTWvKZSdQA/kJIC7Dik1N6PireDAce+RWSMLU6M/PTkdrczYJA7NB
         MaVB8O08dC4EQd8O6o+oftekamQFNmKEZAFFfsg281RypZJ3BdrR6t3y34vUOMSk6+TO
         las0/+asRpFld/1uwrijli9JN/6cIa/TcRcMgz9pp8kyPhy1k02G6XPlxxnLzhU9w6g5
         TDLt9KyNdgyZUKBReh/s9Zaq0qawG621JxusRpz1tiUNRix1PCgVS/RZDAGhahZaole8
         VHyqTXG4tiNbHzMo4kNptAqaM+Q76afRzf/ZhiMhKGye/B7TXGkNLyR2m96RRiXc2AyX
         w1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685451318; x=1688043318;
        h=reply-to:references:in-reply-to:subject:to:reply-to:references
         :in-reply-to:subject:to:reply-to:references:in-reply-to:subject:to
         :mime-version:from:date:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpOb6iXabI9s4qxO/9LxJHlZYONhIFuWo8fbny/HpfQ=;
        b=e8Kfa8wZvKG6d+sDU9BZflThnIO9TEmAkohHOtPuJmQdqQ5KXspIyKgCpCiedTwuF1
         wFFaF39NRROSFK347kJYuHA9AGUeu6hOlyYDuwsVokm15wrpbcFlk8B9UapHgA+sqlao
         qwCug5VAO39vdQJyA4r4u+Uk4/pBv498AZF8QI7rZm+l/uFWpP6jl7T6h9KmEL/gxf62
         452wqR9vVwf1kYFkVoTzYLCu2FRuxUhIYqKC+O12/bns6RcwH/hU+vuwTn3mJpbRx+dy
         srSpNcJV2Fed9icpVqlhl3t8XTacE59aobYB0Gw1ryboIkRw5T1qB+W1cyoaFbSdPMy9
         x+wQ==
X-Gm-Message-State: AC+VfDyzjRmyCknxatEHrFspZVVRbV3vRn8BFfnwwp9SnLGTMB7vJzWb
        /5jldBQYbdnGYQ8zPXQgJe7icLK89EY=
X-Google-Smtp-Source: ACHHUZ4zrKbtWEbszzAGHvDQidmp1lYAGBCCazVoVf6LzMvnt4qVOMe8/xaRRv63c8ax4drEPrEzXw==
X-Received: by 2002:aca:682:0:b0:394:4603:77f2 with SMTP id 124-20020aca0682000000b00394460377f2mr1322980oig.2.1685451318219;
        Tue, 30 May 2023 05:55:18 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.174.231])
        by smtp.gmail.com with ESMTPSA id e185-20020acab5c2000000b003924c15cf58sm5815125oif.20.2023.05.30.05.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 05:55:18 -0700 (PDT)
Message-ID: <6475f236.ca0a0220.5a7b0.9b9e@mx.google.com>
Date:   Tue, 30 May 2023 05:55:18 -0700 (PDT)
From:   bluez.test.bot@gmail.com
Content-Type: multipart/mixed; boundary="===============6988559729830396430=="
MIME-Version: 1.0
To:     linux-bluetooth@vger.kernel.org, dragos.panait@windriver.com
Subject: RE: Hardening against CVE-2023-2002
In-Reply-To: <20230530122629.231821-2-dragos.panait@windriver.com>
References: <20230530122629.231821-2-dragos.panait@windriver.com>
Reply-To: linux-bluetooth@vger.kernel.org
To:     linux-bluetooth@vger.kernel.org, dragos.panait@windriver.com
Subject: RE: Hardening against CVE-2023-2002
In-Reply-To: <20230530123944.241927-2-dragos.panait@windriver.com>
References: <20230530123944.241927-2-dragos.panait@windriver.com>
Reply-To: linux-bluetooth@vger.kernel.org
To:     linux-bluetooth@vger.kernel.org, dragos.panait@windriver.com
Subject: RE: Hardening against CVE-2023-2002
In-Reply-To: <20230530124208.242573-2-dragos.panait@windriver.com>
References: <20230530124208.242573-2-dragos.panait@windriver.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6988559729830396430==
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


--===============6988559729830396430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sock.c:980
error: net/bluetooth/hci_sock.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6988559729830396430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sock.c:980
error: net/bluetooth/hci_sock.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6988559729830396430==--
