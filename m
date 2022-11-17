Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1BAC4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Nov 2022 21:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbiKQV0T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 16:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbiKQVZ0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 16:25:26 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5799C14001
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 13:24:57 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id f3so3238613pgc.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 13:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HDK6PTs4WHQXaAyPS0og+tfnvydmtjAPAtYNd0bfQ/4=;
        b=XxlukR0uvu/HwnbcxEnRm8KQgnIiH34gamGZvnrEc6es0LnOyLe5EG1pB1enKXSGQP
         TgmLed85uXtuA2buwFxRWaOgQyjULzGcRcxoXl7Oq9vcoE5RTkEogH06E58NezW2VIgE
         UvsIOxVnPNqGnA0W+0Zzij4t7yAJOfF2dPv1tpt+8bP7Tm7YhFYeSpSgXzBGTGAdZf4A
         hWy1IJgGJV2mHq91BRvJVpw6Zjc0VoQw4DyNPDTInZV90hFsDxxVYfyRU9XKQOPEueXS
         0iSv0Qmfw5ENp4UjamJ7QyjkZMOi20EZTosCiX1ynttMQM53t1OuGIrkBx9Nt7zagQbQ
         GFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HDK6PTs4WHQXaAyPS0og+tfnvydmtjAPAtYNd0bfQ/4=;
        b=4hcjFtC83sHvczaHiCgIMuyc3BDjY1rPi0fEpvyfDmfMgzxa5T1bOdJH5t3tkslpLI
         3CR4gSg3/4tp/d9zufdlvLUE4y//48e1LIapiuZXJBuMZR1kLrNwjQfD0TP++fIFU+Hj
         FNXCcN+BUdqu31LeE6yf3GjBnVoYn4C/+su5vJTAg8VT0+fxeemkptW4BZhNNPs4plzd
         hftRXQTIxZlKjKTDJl6qgbXPoKEHpAxYqsVnpPKBikdG6n83faT+0z9yVQPVvNsrmxKi
         9wxtKK8AN+cz3efcIE5vVMpGXl7MossmnwrkHw4qMuVCAoxqiKp0AXD8IEwUpXCKAzez
         /uLQ==
X-Gm-Message-State: ANoB5pm1vMrmSJXgielC3WEy4F1UBT7ALq2muH+yIG0pIQBhUiaMVhm/
        7LTze55VugZx6/7Rn3i2S0y1rsgzGkc=
X-Google-Smtp-Source: AA0mqf7Nvyfgyskc8fhdKeT9dNMbTUheiPWROGo/rBb9e2lj1F73IGx3JhiexISR2wAn3YZm+K1jfw==
X-Received: by 2002:aa7:947b:0:b0:56b:a3e5:d155 with SMTP id t27-20020aa7947b000000b0056ba3e5d155mr4721332pfq.23.1668720296511;
        Thu, 17 Nov 2022 13:24:56 -0800 (PST)
Received: from [172.17.0.2] ([20.245.90.94])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902650d00b00186b55e3cd6sm1851962plk.133.2022.11.17.13.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 13:24:56 -0800 (PST)
Message-ID: <6376a6a8.170a0220.c05dd.33e9@mx.google.com>
Date:   Thu, 17 Nov 2022 13:24:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0857656791062593309=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ] tools: Use portable 64 bit data formats
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221117202150.56236-1-brian.gix@intel.com>
References: <20221117202150.56236-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0857656791062593309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=696626

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       PASS      0.42 seconds
Prep - Setup ELL              PASS      31.52 seconds
Build - Prep                  PASS      0.67 seconds
Build - Configure             PASS      9.93 seconds
Build - Make                  PASS      946.17 seconds
Make Check                    PASS      12.36 seconds
Make Check w/Valgrind         PASS      342.45 seconds
Make Distcheck                PASS      280.26 seconds
Build w/ext ELL - Configure   PASS      10.14 seconds
Build w/ext ELL - Make        PASS      100.46 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      597.33 seconds



---
Regards,
Linux Bluetooth


--===============0857656791062593309==--
