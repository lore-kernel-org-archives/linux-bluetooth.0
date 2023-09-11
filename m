Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAA9CA0EC3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 02:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239305AbjILCiG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Sep 2023 22:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239355AbjILCh6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Sep 2023 22:37:58 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D97A1708
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 16:11:53 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3ab3aceaf2aso3496767b6e.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 16:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694473766; x=1695078566; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gyvxyhIP7sixhPhRL/m/8M8UvR37bpcFUrTJdkYT224=;
        b=el+BHw2tdsnCY6AGHO3x39UG62B1NAX9JXGSHBJArob0tqNvl0fBsDcdoo3/eSU6R0
         yY8KcZwtlOhRaY09W6uUrJ9pLTRSrWsEPGy8oolFXu++vYTMec9dn2b1PK695mAGzSc5
         I0tTypSAPk3EYzccJK/dIKj9SsOOwiCFVDQmbZkWw8KXd99okOsniVz7efZrgXFUGptC
         CbFpaLMVtJNM/xHSR0oEdABgdwWiHbixXNtBdvH9XrTTN09iCNScz/+0x8Vu0TjznTFw
         Fd7YP4ynwITVcv6hF1A0szRJDiFzF0O+KZF2/VpgZ2FTRxIKD3ej4bo7EmsoeSar5KBx
         0RDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694473766; x=1695078566;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gyvxyhIP7sixhPhRL/m/8M8UvR37bpcFUrTJdkYT224=;
        b=TtLiTCOtOd4bB7SbeoY0xM61vRADWdIRjcc5Q/aD6l+QykNS9NCPBXN/65JKStVLTL
         DlWaIg2PiK2IF+o3P9gAHUOC33YI8k2M6U6PLP8Nr1OL7MhSUqj1X3I21SSUqZdOuX4F
         5dc1u8azhwhYp1FeIAdheJ3rw2UiU3i2DA6XPUc4XlccRVuJ7w0KUQIWgwPJKcnyGcWa
         fr72lRic0ArmOqN/52DTVkbuujOgFzA6EOBb9hr9xe0hJbP8He1oIp0LUpDq8VW9ZF9b
         1vrqCFeLWTHHjCCfWKUB4Tvnax+vZX6n6F/JYGN39NtiyGzJq5DrcdnTZqlY/WcXp/2A
         uhwg==
X-Gm-Message-State: AOJu0Yw2KWP16GcF+MpEyQWeIxtTkfVdDPRQgKAxmRX//7ZfU4Qqepgo
        mO9GhEiDevDRfAIQFUAJsbXR6o27S8ABJA==
X-Google-Smtp-Source: AGHT+IGhmo0auhv3PsC1Or4pOyVZNTHuCVVi92hBRJhL6HOdTaaRwuf168125hv1kvZ0+M/ATuFQCA==
X-Received: by 2002:a0c:fbcc:0:b0:651:6545:c74d with SMTP id n12-20020a0cfbcc000000b006516545c74dmr11665988qvp.52.1694473068006;
        Mon, 11 Sep 2023 15:57:48 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.207.98])
        by smtp.gmail.com with ESMTPSA id a1-20020a0cb341000000b0063d1f967268sm3264069qvf.111.2023.09.11.15.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 15:57:47 -0700 (PDT)
Message-ID: <64ff9b6b.0c0a0220.8b69d.cdee@mx.google.com>
Date:   Mon, 11 Sep 2023 15:57:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3938898782726182205=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: [BlueZ,v3,1/1] bap: Use defer setup when syncing to a BIS source
In-Reply-To: <20230911090922.68822-2-vlad.pruteanu@nxp.com>
References: <20230911090922.68822-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3938898782726182205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=783073

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
GitLint                       PASS      0.44 seconds
BuildEll                      PASS      35.26 seconds
BluezMake                     PASS      1249.04 seconds
MakeCheck                     PASS      13.31 seconds
MakeDistcheck                 PASS      189.55 seconds
CheckValgrind                 PASS      299.13 seconds
CheckSmatch                   PASS      450.89 seconds
bluezmakeextell               PASS      130.63 seconds
IncrementalBuild              PASS      1036.34 seconds
ScanBuild                     PASS      1413.36 seconds



---
Regards,
Linux Bluetooth


--===============3938898782726182205==--
