Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56DEC6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Mar 2023 22:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjC3WcI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Mar 2023 18:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjC3WcH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Mar 2023 18:32:07 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA42E2108
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 15:32:05 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id h11so10607957ild.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 15:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680215525;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jN/ppVRRzt+sNUAUeuZfuhvopK5X7HhRbgEkjREG7wY=;
        b=S0FZS4LqoVZuO3YbGek3Im/+VY+xuIftPLAnYZDYbBdHDSj9H77yRABVSDnG1jmqNy
         b4Ob1EyclUzfvTK7Jizi6ywVe+BdPqFy3D8rYHIxJb5K1ojG2BeHK/TRg4jhgTlo0/8A
         56JuGJFlJNT+9pKkPgpV/W59aCxFOz9h5uGLP13pthhjS51BXKMUJYs+yJ7wE/eWR0Ka
         0Q0zh5vVu/fWCfc9CWj4+rVNwRg+aZ5PbkwPB0JvbsKhe9O+NiU7zubSnJ/fQpx4VsjS
         MHJ45Bo69E3pcfhLFbVvXWSLRL9e7F1EPToojiFa23a8/Qz0ryH5V0jCr1Zvj11nytE/
         nEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680215525;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jN/ppVRRzt+sNUAUeuZfuhvopK5X7HhRbgEkjREG7wY=;
        b=VpV/64K+1D7DhV+Z8/m+OoM9QrVTqMPUeGLnb73SJHa56+fxi3ldnWDoUkx9HdF2AL
         ZcgGVb60FgwJCumjGr9HRfkodYeNEkpn8B6YtzMKo7ZTJFSoQyBpn2vrn80dmDJs1CG8
         4wrD6a6SsBa5zR350gdbGLh0wAdAo/cDlX2RbECEOC9axKe9oc6DuL/LQyavvqlzWShp
         w/DWo4m5ipHXurPgb1YiO8BJiHgPs1Rnd/Bem+NSso8wXjQGvVZ/gNFR2vFwt0Q/p1K5
         IbWKyvg2BZVs5BMFKJwzMbWhwpFK/t7hn7jnEPRHqyWHZvxQNMYGpE6YKoNOxG5rAL+2
         OYew==
X-Gm-Message-State: AAQBX9cRGqdcxpfATGlJFw1y9aWAKg3rxB6EoDZsEW6D8d+LYrEyOUwo
        P/i6vd7QahhF0133L2EHedFmUuMtsgk=
X-Google-Smtp-Source: AKy350bmhorV7Muxnq/fcyaxXTha1GltHqVe3vi3Vc+unXyC7fSn7i8FZYystNdKNioWIJ9VjSeJRg==
X-Received: by 2002:a05:6e02:218f:b0:326:1d7e:1238 with SMTP id j15-20020a056e02218f00b003261d7e1238mr5548128ila.16.1680215525083;
        Thu, 30 Mar 2023 15:32:05 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.92.211])
        by smtp.gmail.com with ESMTPSA id ay42-20020a056638412a00b00406192f7335sm205827jab.98.2023.03.30.15.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 15:32:04 -0700 (PDT)
Message-ID: <64260de4.050a0220.1ee4.05ed@mx.google.com>
Date:   Thu, 30 Mar 2023 15:32:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4088740035254744143=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hdegoede@redhat.com
Subject: RE: [BlueZ] adapter: Use regular discovery for filters which only have discoverable set
In-Reply-To: <20230330211855.102798-1-hdegoede@redhat.com>
References: <20230330211855.102798-1-hdegoede@redhat.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4088740035254744143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=735586

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       FAIL      0.51 seconds
BuildEll                      PASS      26.36 seconds
BluezMake                     PASS      778.89 seconds
MakeCheck                     PASS      11.29 seconds
MakeDistcheck                 PASS      151.60 seconds
CheckValgrind                 PASS      243.65 seconds
CheckSmatch                   PASS      326.73 seconds
bluezmakeextell               PASS      97.95 seconds
IncrementalBuild              PASS      624.12 seconds
ScanBuild                     PASS      988.96 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] adapter: Use regular discovery for filters which only have discoverable set

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (83>80): "[BlueZ] adapter: Use regular discovery for filters which only have discoverable set"
27: B3 Line contains hard tab characters (\t): "	Name: Bluetooth 3.0 Keyboard"
28: B3 Line contains hard tab characters (\t): "	Alias: Bluetooth 3.0 Keyboard"
29: B3 Line contains hard tab characters (\t): "	Class: 0x00000540"
30: B3 Line contains hard tab characters (\t): "	Icon: input-keyboard"
31: B3 Line contains hard tab characters (\t): "	Paired: yes"
32: B3 Line contains hard tab characters (\t): "	Bonded: yes"
33: B3 Line contains hard tab characters (\t): "	Trusted: yes"
34: B3 Line contains hard tab characters (\t): "	Blocked: no"
35: B3 Line contains hard tab characters (\t): "	Connected: yes"
36: B3 Line contains hard tab characters (\t): "	WakeAllowed: yes"
37: B3 Line contains hard tab characters (\t): "	LegacyPairing: yes"
38: B3 Line contains hard tab characters (\t): "	UUID: Service Discovery Serve.. (00001000-0000-1000-8000-00805f9b34fb)"
39: B3 Line contains hard tab characters (\t): "	UUID: Human Interface Device... (00001124-0000-1000-8000-00805f9b34fb)"
40: B3 Line contains hard tab characters (\t): "	UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)"
41: B3 Line contains hard tab characters (\t): "	Modalias: bluetooth:v05ACp022Cd011B"
44: B3 Line contains hard tab characters (\t): "	Name: Bluetooth Mouse"
45: B3 Line contains hard tab characters (\t): "	Alias: Bluetooth Mouse"
46: B3 Line contains hard tab characters (\t): "	Class: 0x00002580"
47: B3 Line contains hard tab characters (\t): "	Icon: input-mouse"
48: B3 Line contains hard tab characters (\t): "	Paired: yes"
49: B3 Line contains hard tab characters (\t): "	Bonded: yes"
50: B3 Line contains hard tab characters (\t): "	Trusted: yes"
51: B3 Line contains hard tab characters (\t): "	Blocked: no"
52: B3 Line contains hard tab characters (\t): "	Connected: yes"
53: B3 Line contains hard tab characters (\t): "	WakeAllowed: yes"
54: B3 Line contains hard tab characters (\t): "	LegacyPairing: no"
55: B3 Line contains hard tab characters (\t): "	UUID: Human Interface Device... (00001124-0000-1000-8000-00805f9b34fb)"
56: B3 Line contains hard tab characters (\t): "	UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)"
57: B3 Line contains hard tab characters (\t): "	Modalias: usb:v0103p0204d001E"


---
Regards,
Linux Bluetooth


--===============4088740035254744143==--
