Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16E9E748FE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Oct 2023 17:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjJBRmh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Oct 2023 13:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJBRmg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Oct 2023 13:42:36 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C019283
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Oct 2023 10:42:33 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-77acb04309dso604014739f.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Oct 2023 10:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696268553; x=1696873353; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5lEtGCur1daujBDfEh4DBgVIyKi405Qc9bL/q5hkJ7Y=;
        b=B6KE/qS5542AWg8oah+LeUhlB+OgRPrNFmd8ERyqRz3r3fyxGadqyckbIIp0TEGRFe
         w/6hMW2e+omCCGWFd6LznVoYtz7EgEVbsR6e8oRwOYQ0TLtTSZ5Nzs2BxM9fq+XiMawU
         Wy73b272JMWHnPAD8n/lqKGx9WwK90AtvkaAgNYF9RFTBFQ7B1Hou2/W1IOoIZE2vmv9
         7uY7EOMayGCjSP4gU17M6ZmgzAog/PqT6OTWMOgka7glaAgJ07/KdkhD9iFQRCsdRndq
         ToWmQyMxUwCus0zsfWEwooUjQpTWA/r7vAVDYENBVW8fETWUuJzEgI8OWpvQNAFGtGYW
         FoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696268553; x=1696873353;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5lEtGCur1daujBDfEh4DBgVIyKi405Qc9bL/q5hkJ7Y=;
        b=CLmcE+E6fhNgrBOXLNmu5lWv47ERTwl6ExY6qaLL4BZ+cAFkEFENiyLACuJtSX9mbs
         HiIbgk4pQaofbJJMQXlL0wg4fCz1gcqRk67RlLh1K1sihu29TCIuvJzjJJY5SEf0+WmU
         uOiNcbOqkzGMBlgWdY0raPNvauWTLqhmQ5DkSdIdVzQbV7NgisufzpxcvggqJZH7aytW
         RwL1sGCGSYK0A81U1IiW8vy7ZXrsRvUDOu9QFJhxVlmVIPtFM3xuo9C9oMMDeEZCaS/X
         7B1hMNSn06rQWpGcQkTT6j8Hb/oLKfQQz8+SozouyAqDx9g+6Hq3nX4bgoix6mcSNq7Z
         3F4Q==
X-Gm-Message-State: AOJu0YzHyuBoweNr4+NBdzY38SXQCbE2rwA4lA5yGfb4KkYd3zHs6jqN
        hpgbZ603WVDSmVJxtjnR9AUHeC/KpMw=
X-Google-Smtp-Source: AGHT+IGduvmUuxT4ANph5nC1VlZt9BXeUPqRz7kbsrWOhQbsNUMLzKzqh3DD+Bg8gjj5N/AUmqLoaQ==
X-Received: by 2002:a6b:5c01:0:b0:798:3e95:274f with SMTP id z1-20020a6b5c01000000b007983e95274fmr14138369ioh.19.1696268552599;
        Mon, 02 Oct 2023 10:42:32 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.125.162])
        by smtp.gmail.com with ESMTPSA id i12-20020a02c60c000000b00430bb70004dsm7111256jan.103.2023.10.02.10.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:42:32 -0700 (PDT)
Message-ID: <651b0108.020a0220.7da6d.9864@mx.google.com>
Date:   Mon, 02 Oct 2023 10:42:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0987954861331903791=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Update transport acquire/release flow BAP bcast source
In-Reply-To: <20231002153352.3163-2-iulia.tanasescu@nxp.com>
References: <20231002153352.3163-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0987954861331903791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=789347

---Test result---

Test Summary:
CheckPatch                    PASS      1.46 seconds
GitLint                       PASS      0.89 seconds
BuildEll                      PASS      28.53 seconds
BluezMake                     PASS      885.38 seconds
MakeCheck                     PASS      12.39 seconds
MakeDistcheck                 PASS      162.32 seconds
CheckValgrind                 PASS      261.73 seconds
CheckSmatch                   PASS      352.83 seconds
bluezmakeextell               PASS      108.54 seconds
IncrementalBuild              PASS      2179.90 seconds
ScanBuild                     PASS      1078.14 seconds



---
Regards,
Linux Bluetooth


--===============0987954861331903791==--
