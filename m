Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730C0C001DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jun 2023 13:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245230AbjFNNws (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jun 2023 09:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245165AbjFNNwp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jun 2023 09:52:45 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B85A6
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jun 2023 06:52:43 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-45739737afcso192234e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jun 2023 06:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686750761; x=1689342761;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fYyG4cepXqQnExdh3j0yosqLh1XQ/lQOHl20k69/PYI=;
        b=DBU98+iOPzqUYgo+eI3/eR+vbjDcKj0JlUCtL8GXePtsd567ulGwSylrMdpiyxRb9I
         aywT0ypxFCcpOCZmUkt3WbNMqpbJScuKujrk2KY80h1OTfg7p2LB6IAG2jZKPoZ7yNl8
         1L+Xs+/ueTs95OWO+tJWuGMGbMvzt4nO1YQUCDux4HwmDUEtoObdnv8vg3AJIVq9EbG8
         ZoXxAyj/umKJrXp/JXpCis04aBSMZcn8ZnPfB4dt30A0AdUq/faZT6ubiI2mStxhMO/P
         wDTb6hfbxgGgadP2E8zm9E0pFjRAdpEFSF3gyRufsyVPYhYfeVVqBeYdB/pR6LNyA81g
         RZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686750761; x=1689342761;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fYyG4cepXqQnExdh3j0yosqLh1XQ/lQOHl20k69/PYI=;
        b=HFADVBeJcooZB6NJln73ym+jQLBlBRNsbvb4B0bbwOXmR6Wdi6k5dDVM9SixkpB0wD
         T2D855mqvQyHwdbRodZ3wBbtPKV3F548dv5wnJY084rCpn3pTkhUK27zIaDTYvi+TdwQ
         EbB36OAlmhOTVw0T+5l/VvIRef94Y60q9NIOdwLCd2DPNPcMaxL0XtPu+RABTaAWMB2/
         u6spvN3zgoNB8yQ+O3PZx04wx5t10Y+Af9x+/ygFhNWFniXuvUzjddXMSP9ACl7zDmYl
         PqHRm7vKuUgQoZFFpzx4Qb8kh1DWS17bJbXXHIuH7iOMqJwC0GtHDXcxuKAVN0uXpX3I
         BYpQ==
X-Gm-Message-State: AC+VfDyIZgYNDQQTTQGfIykpqUOKL3j5LEmmNy8Q0hindUnBxkTO6yN7
        fFcVb7cm+QFWgNlOCLpd7KIpbItjCJ8=
X-Google-Smtp-Source: ACHHUZ5evtqQLkcY0YqJjSOJzQxUoVB+XWGD5arAZrGP+AqZoOYy6I9yE4pobleEDqvnTTcAmgmS7w==
X-Received: by 2002:a1f:c153:0:b0:46e:7a64:a4c8 with SMTP id r80-20020a1fc153000000b0046e7a64a4c8mr1516039vkf.6.1686750761184;
        Wed, 14 Jun 2023 06:52:41 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.137.179])
        by smtp.gmail.com with ESMTPSA id k2-20020a0cf582000000b0062fe9cedf37sm140778qvm.15.2023.06.14.06.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:52:40 -0700 (PDT)
Message-ID: <6489c628.0c0a0220.34218.0c96@mx.google.com>
Date:   Wed, 14 Jun 2023 06:52:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0609433538377438216=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, Joakim.Tjernlund@infinera.com
Subject: RE: bluez SEGV in current master
In-Reply-To: <6704ebbea9d1bb64e54b45b1b3d6cd321b28971b.camel@infinera.com>
References: <6704ebbea9d1bb64e54b45b1b3d6cd321b28971b.camel@infinera.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0609433538377438216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=757099

---Test result---

Test Summary:
CheckPatch                    FAIL      1.02 seconds
GitLint                       FAIL      0.74 seconds
BuildEll                      PASS      27.26 seconds
BluezMake                     PASS      861.75 seconds
MakeCheck                     PASS      12.27 seconds
MakeDistcheck                 PASS      153.25 seconds
CheckValgrind                 PASS      250.95 seconds
CheckSmatch                   PASS      338.03 seconds
bluezmakeextell               PASS      101.49 seconds
IncrementalBuild              PASS      702.53 seconds
ScanBuild                     PASS      1039.34 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
bluez SEGV in current master
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#128: 
Jun 13 13:38:15 systemd-coredump[3941]: Process 1897 (bluetoothd) of user 0 dumped core.

/github/workspace/src/src/13279998.patch total: 0 errors, 1 warnings, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13279998.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
bluez SEGV in current master

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
7: B1 Line exceeds max length (88>80): "Jun 13 13:38:15 systemd-coredump[3941]: Process 1897 (bluetoothd) of user 0 dumped core."
9: B1 Line exceeds max length (106>80): "                                        #0  0x0000556bea93277a a2dp_resume_complete (bluetoothd + 0x3e77a)"
10: B1 Line exceeds max length (101>80): "                                        #1  0x0000556bea9210a2 finalize_resume (bluetoothd + 0x2d0a2)"
11: B1 Line exceeds max length (102>80): "                                        #2  0x0000556bea92afaf avdtp_start_resp (bluetoothd + 0x36faf)"
12: B1 Line exceeds max length (98>80): "                                        #6  0x0000556bea9dcc85 mainloop_run (bluetoothd + 0xe8c85)"
13: B1 Line exceeds max length (110>80): "                                        #7  0x0000556bea9dd0dc mainloop_run_with_signal (bluetoothd + 0xe90dc)"
14: B1 Line exceeds max length (90>80): "                                        #8  0x0000556bea91a4ef main (bluetoothd + 0x264ef)"
15: B1 Line exceeds max length (92>80): "                                        #11 0x0000556bea91ace1 _start (bluetoothd + 0x26ce1)"
16: B1 Line exceeds max length (95>80): "Jun 13 13:38:15 systemd[1]: bluetooth.service: Main process exited, code=dumped, status=11/SEGV"
21: B3 Line contains hard tab characters (\t): "342	static void a2dp_resume_complete(struct avdtp *session, int err,"
22: B3 Line contains hard tab characters (\t): "343								void *user_data)"
23: B3 Line contains hard tab characters (\t): "344	{"
24: B3 Line contains hard tab characters (\t): "345		struct media_owner *owner = user_data;"
25: B3 Line contains hard tab characters (\t): "346		struct media_request *req = owner->pending;"
26: B3 Line contains hard tab characters (\t): "347		struct media_transport *transport = owner->transport;"
27: B3 Line contains hard tab characters (\t): "348		struct a2dp_sep *sep = media_endpoint_get_sep(transport->endpoint);"


---
Regards,
Linux Bluetooth


--===============0609433538377438216==--
