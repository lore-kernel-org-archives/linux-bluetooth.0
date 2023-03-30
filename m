Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50902C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Mar 2023 22:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjC3Wmb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Mar 2023 18:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjC3Wma (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Mar 2023 18:42:30 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70A0CA28
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 15:42:29 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id bm2so15432205oib.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 15:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680216149;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uuQKJRBEcBWbBvJGwvGHzkfFLMDWQ4aQ1L4Zufp+1ss=;
        b=GOXanJyNZCAx5BX7YXeOZpDMMCXjSVcTawbXDm78tMv9br8Yz896Vo/iMEn6gyqOTS
         QtJaCCqWFBdgmufpeRnJKgsBECP/b2plxFg+3PfxE6o0ih/7dA3TZFwIk9uRm9EO4MOK
         hQtGoPg9vl/qPB+CcIWX7+aDbRyeE1IJya4Ak70rPeTLhPVF5J+NBQwgEdl2Af1tjro6
         MaZEVfcsqzxDNVYhJdWojhDFmBSYgVVbfYcQL5ep4OF5W88AHJzggOwv8SSl2BsWCWZX
         Fv8EkHyigGx7+oF5D2e1ZG2K9zh1vYgh9yiqHbDozMqBUsCDCKLXO0dKQHboJziOBfbO
         GzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680216149;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuQKJRBEcBWbBvJGwvGHzkfFLMDWQ4aQ1L4Zufp+1ss=;
        b=kMzEjF3kNC/2S9VDIhhbqcXlTBNszubRyxB5AapbTxDuKS5urtsdiAIzVXWyrJWSbQ
         FQdYG4muKHRajHZuq8Q2eKO2VIxOGr5wD+iG9uiJRP74UndQhjiNixOKA/OJ68qJKS4K
         R/tXY5RaZWiHZsOiyFK5LAio48jxUvJhjDzwgg87mXRF9HGHvs3YowNhW56fdy099rLM
         TImFt+9i6r1jjI529Q6vrzO9ZET6eXkQgb9DZ16wjD2EJ17mohUyxt3LHCfPgF5FX+Nq
         USrqIXZuohDLPBCrDXiIFgGJWjME2JteDdJC81XjBbO4tvAzelUcmZEcdcatAj7rRJ6f
         HhCg==
X-Gm-Message-State: AO0yUKVbUFqe0XtPOkaLheZd64PbYemgm2erfD1ypUi6/ESZQ5mmEVKR
        5OFb32c93mR/pK8ycT843ezwr1x7vSo=
X-Google-Smtp-Source: AK7set9cvid+RohayB0PezfcdjYtCYuWLfssnxx1EHbELmfERpuijTPQn5mhHp+Ab0oNOVq8Ag9Ckg==
X-Received: by 2002:a05:6808:1b1e:b0:386:9d6b:9995 with SMTP id bx30-20020a0568081b1e00b003869d6b9995mr13070226oib.21.1680216148977;
        Thu, 30 Mar 2023 15:42:28 -0700 (PDT)
Received: from [172.17.0.2] ([23.98.136.32])
        by smtp.gmail.com with ESMTPSA id q204-20020a4a33d5000000b0053853156b5csm206439ooq.8.2023.03.30.15.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 15:42:28 -0700 (PDT)
Message-ID: <64261054.4a0a0220.17cc1.1c92@mx.google.com>
Date:   Thu, 30 Mar 2023 15:42:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4619093110579211676=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hdegoede@redhat.com
Subject: RE: adapter: Use regular discovery for filters which only have discoverable set
In-Reply-To: <20230330211233.102136-1-hdegoede@redhat.com>
References: <20230330211233.102136-1-hdegoede@redhat.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4619093110579211676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=735584

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       FAIL      0.71 seconds
BuildEll                      PASS      27.34 seconds
BluezMake                     PASS      1011.80 seconds
MakeCheck                     PASS      11.69 seconds
MakeDistcheck                 PASS      154.67 seconds
CheckValgrind                 PASS      253.40 seconds
CheckSmatch                   PASS      338.70 seconds
bluezmakeextell               PASS      101.75 seconds
IncrementalBuild              PASS      900.61 seconds
ScanBuild                     PASS      1076.02 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
adapter: Use regular discovery for filters which only have discoverable set

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
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


--===============4619093110579211676==--
