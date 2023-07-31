Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59CDC001DE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jul 2023 10:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjGaKiW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jul 2023 06:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjGaKiT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jul 2023 06:38:19 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C806E48
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 03:38:18 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7658752ce2fso264168985a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 03:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690799897; x=1691404697;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T4FmPt3J3INJyUFDE/CQ7IqiCVRrNDPJjQu9rzjNiVA=;
        b=hoHfKjtxpDmkQcCbtw/W89k9mgh2YJSEgBypUk/lol6GpwWaI33hLl5moHvkFSaxE+
         TSN2/T8xRLRCH7ToJdQ3kuHdg17GmRWDkFrfeYEbtAjW9KgsPj/Ha7dhi8qkWaSkKxLD
         by9SH/nigXf9QntyEH2iLuN6qRYQJO6tbAElRvOcg+NLAz95ACyQrpfIRLjW2b3eTpyq
         sudEjRMN+Dlh58HAn+WaB39nsAhBDvYR4yXnG3DdSR8IQV4RnVru5iO4/THdABpwqOqU
         c+baPdI/3s5MfkO6QPMVFhrvSjO5fsro2x5gsauEGRpl26/cZA96owC+to9aGCwFa0tM
         1djA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690799897; x=1691404697;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4FmPt3J3INJyUFDE/CQ7IqiCVRrNDPJjQu9rzjNiVA=;
        b=hPhCrdcyNx/540SGhJYOhPyyKQlsTbCGEZO16FPcxonB+iKFFlJtlJKIFGowULniyj
         yVcsINMBQ2N2HyxtepPuLpHO2HRGGfcQVHKUrUPqXi/iHkOvyRidY0Hq1fNKRQ12CROQ
         lD9JtbqqvxsUr2pFlimwEzdEVVDsJxugF16ZSpiO4XGtdAfURg/8heihOw5J/lXcYP0x
         txbwT4/c59qE4XKZGMzi4tMDJ5zb85oyP8Yf0ZgrGnNHRuEbl+C7ke+vi4GOT5x9O3yq
         efJwF2qS28lb0oQss1O1IMXXib8YowWVxqIVLLvQV+v94kyS/kfAKXhUMZCRA69j+bdT
         3TFw==
X-Gm-Message-State: ABy/qLYqlIJLMuabYT4NzK20OVg51mjqPNS0jqtPPn70qfu/R4AU8KRp
        qpt6NqD53tdGpXtcrCmMSK8jQd+g5cnHVw==
X-Google-Smtp-Source: APBJJlFSH0Wnfvb4bjUC+7xJF30JLwTlmgMmx05TNuJP+ArPRo/iGFLZ79fqWUDrmaHEQc6/MzgYMg==
X-Received: by 2002:a0c:8cca:0:b0:636:2d83:cea6 with SMTP id q10-20020a0c8cca000000b006362d83cea6mr232116qvb.31.1690799897210;
        Mon, 31 Jul 2023 03:38:17 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.150.121])
        by smtp.gmail.com with ESMTPSA id i11-20020a0cf48b000000b0063cf9478fddsm3653981qvm.128.2023.07.31.03.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 03:38:16 -0700 (PDT)
Message-ID: <64c78f18.0c0a0220.1e438.bde7@mx.google.com>
Date:   Mon, 31 Jul 2023 03:38:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9010273729062898952=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Rename BAA_SERVICE to BCAA_SERVICE add BAA_SERVICE(0x1851)
In-Reply-To: <20230731091642.3712-2-silviu.barbulescu@nxp.com>
References: <20230731091642.3712-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9010273729062898952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=771097

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      28.29 seconds
BluezMake                     PASS      929.16 seconds
MakeCheck                     PASS      12.36 seconds
MakeDistcheck                 PASS      158.01 seconds
CheckValgrind                 PASS      257.23 seconds
CheckSmatch                   PASS      346.03 seconds
bluezmakeextell               PASS      104.50 seconds
IncrementalBuild              PASS      723.81 seconds
ScanBuild                     PASS      1080.14 seconds



---
Regards,
Linux Bluetooth


--===============9010273729062898952==--
