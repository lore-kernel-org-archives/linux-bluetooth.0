Return-Path: <SRS0=4/QO=6J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182A7C54FCB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Apr 2020 12:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E72EE20714
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Apr 2020 12:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qk0W3yHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgDYMEI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 25 Apr 2020 08:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgDYMEI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 25 Apr 2020 08:04:08 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A19C09B04B
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2020 05:04:07 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id g13so14665666wrb.8
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2020 05:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=fSauoZcALwfeTaeC6VG+uGNIgG+Zcdx8fX15Nm5SZws=;
        b=Qk0W3yHDzbx8mpMQv9Qnc3+uYDoe3LFPfxGyOY37RjgraCKr02pwCzgwLvRyg2Lf4H
         m+z2xPZfhF08GAG1uhtru9g/w4nskNqox+dRRlkK/q4UltEU5ZVsp0O3ETgByAydwk8G
         0/QYGAFbeZtqEWCRcVX69f7CgW+na/HdEX64suVJzvR7byX4JOwiS0P+eDO2AUl+ZBQj
         cnJf4Fu0J6mXldZsYbQjZPaSIw5AZyUzqMf/mCptZDBR57R4SsNkR1P7B/hVc5QW2Bfy
         rf9gPqsJKvLvE3WFImrkN9s3nSMpxYxgdPP9QGSjnsiLiYDNIisqcAEn6Mmi+IcC8J1M
         zL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=fSauoZcALwfeTaeC6VG+uGNIgG+Zcdx8fX15Nm5SZws=;
        b=SYpVUS0EsHnLR5BBlDU9ybVhphYJiqE/ZDTIwaP5Qs4Pz08xQRe94n8hENKGHYWeKv
         4U3yzhnXCvYgiqK76Vc3jb40iF/LBmNHjgQq/XXyr8zyeAFpkuNmOBWfbjYlWeK3fKPe
         6S/kq9ujmGB3qHM4kp+9VfyhClXH7avNX0FeSYHNhh0IfAR0E4yWx4Gjn3oLcbUHgkKF
         se3xAw4xUrsmT21FLZJIf3qmm9SMvWcCxQszK2IsZQwy3LgbMSKg5gFrU9PRgahduMDr
         MenlXxIBaD5yBlDEICQiftj0xViRlCrsOOGSiCVibuqdxhd6BPqEDyxsn7OkyueEH24B
         fCyg==
X-Gm-Message-State: AGi0PubOLNM+NUGEVrlkQCH+PSLlS6hbBkdUPwy0rgfRqP1V9wkSl0Ic
        AS3dKWS/Bi7nA96WmsPrwCaTVYkFKa4=
X-Google-Smtp-Source: APiQypIfr1peIx0pZJ1yQ3O7X1HwshnPtfBuXyYK3mqAzseRWRvw8b1hhRuKa4UvzxRMLjSeQ60b4A==
X-Received: by 2002:a5d:4404:: with SMTP id z4mr16449488wrq.316.1587816246123;
        Sat, 25 Apr 2020 05:04:06 -0700 (PDT)
Received: from black-betty (lfbn-idf1-1-1445-133.w90-90.abo.wanadoo.fr. [90.90.130.133])
        by smtp.gmail.com with ESMTPSA id k6sm7410694wma.19.2020.04.25.05.04.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 05:04:05 -0700 (PDT)
Message-ID: <c56e5983093556f4fecf3a788c082639287bd332.camel@gmail.com>
Subject: 0b05:1825 - HSP/HFP - command to route SCO to HCI
From:   Nicolas Fabbro <nicolas.fabbro@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Date:   Sat, 25 Apr 2020 14:03:40 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello, 

I'm trying to get my bluetooth headset working under HSP/HFP.
Currently, I can connect my headset to the bluetooth adapter, listen to
audio without issues using A2DP profile. However, when switching to
HSP/HFP, audio and mic do not work. For instance, when trying to
troubleshoot using the parecord command, the stream seems to get stuck
at a very early stage (after 0.028 sec). When opening the resulting
test file, it's empty.

After investigating, my current conclusion is that I need to use a
hardware specific hcitool command in order to route SCO traffic to the
HCI interface. Nevertheless, I could not find the command to use for my
bluetooth chipset. I am therefore contacting the mailing list to find
out if anyone would know it by any chance.

Hardware information:
- Motherboard : Asus Strix Z270E Gaming
- Bluetooth chipset : ID 0b05:1825 ASUSTek Computer, Inc. Qualcomm
Bluetooth 4.1

Software information : 
- Void Linux
- BlueZ v5.54
- Pulseaudio v13.0

Thank you very much in advance for your help, I'll happily provide
additional information if needed.

Best Regards,
Nicolas


