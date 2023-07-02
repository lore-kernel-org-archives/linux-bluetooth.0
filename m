Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79363EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Jul 2023 21:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjGBVc7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 2 Jul 2023 17:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGBVc7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 2 Jul 2023 17:32:59 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D5F199
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Jul 2023 14:32:56 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b7fb02edfaso31354315ad.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Jul 2023 14:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688333576; x=1690925576;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pgGPeIcK1cWF/pgu7QN3nWuBoItsC72u0UdPoHWq4lk=;
        b=fXHWIyxVt4VOwNKutbDW3RlsJNrWxSsUkdM8mD9cYJcKpeDnHo6v8M4gUGYAXbwMn8
         HdhloU9lKmwLsgDcau35SBvZQDU0LaJ4DwPHSm+UBWn4lbWpNH/Eh7CtRWF3MfzBRjJB
         j8BuXtAzRhFwW6sKR25dya3n5RAP8HeqxaGPp7a7IqNRxG2I9mxjbTta4kbcMFzDKY5L
         JGLgaGXRQXkHLeVkLL+IqfSHYZgD8JlQvR0wM7QFjUzPpgLYSl78GccgffffUPK+5nHc
         yulJhDwHzbuv6Flp1ByOeWJmK20Qe2iVUzHKoFRk343qDhc8Ma+5nJXmsMdUKgaoCTNn
         kZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688333576; x=1690925576;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pgGPeIcK1cWF/pgu7QN3nWuBoItsC72u0UdPoHWq4lk=;
        b=i8I6pDU2BO8OHXZN+Rtq/6CH88iRjM5MzOP/xFSlHdTha1ka1i8BoDA9Z+Sc6JO4kt
         dQsDkSmaa9V9gvdijVCirzmzMLYEpS1V/ayASUNCw7sE0Px9bz1T4nTfozt0lJXAWbvf
         dDmebwMKbuFyTc/9vNptZEj8JZQPk1KEylNMHK9CmQO/15CnARz1nOXbnJDHM72DecFe
         1oG/bagor7ZfpcHX8ZNmK7sHUt4lblTe8PWPfM1709oycPrrj6Gi6oeogcrPht/ysmIF
         9yYgT7/azLPNCQD7dmv65wRMn6potEXRNkHc1CswNHHFOb5eiPrUZhBoEOXKpnsSyW0c
         ypdA==
X-Gm-Message-State: ABy/qLaycREXBX9N3VY1nqrnAYEeRp948fU1IKmY0u4ZLI/Fo7R6ijS0
        UaeVpoffrtFaHiOjgmz6N4+tLQQWv9Y=
X-Google-Smtp-Source: APBJJlHT3B8z6SdC86pj3OQzo+INUg2NYh/YqEffEGtg+9U5u5afo0TZXbg+TCiXcmldDY+DYg4KAA==
X-Received: by 2002:a17:902:8207:b0:1b8:4f93:b210 with SMTP id x7-20020a170902820700b001b84f93b210mr7952639pln.45.1688333575887;
        Sun, 02 Jul 2023 14:32:55 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.61.209])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090282ca00b001b8062c1db3sm11420602plz.82.2023.07.02.14.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 14:32:55 -0700 (PDT)
Message-ID: <64a1ed07.170a0220.1b90e.6996@mx.google.com>
Date:   Sun, 02 Jul 2023 14:32:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7300948416451177985=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/2] transport: handle BAP Enabling state correctly when resuming
In-Reply-To: <8af1dd5097cc4411ff2681ed39c49c232f817ebe.1688326228.git.pav@iki.fi>
References: <8af1dd5097cc4411ff2681ed39c49c232f817ebe.1688326228.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7300948416451177985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=761861

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       FAIL      0.79 seconds
BuildEll                      PASS      30.22 seconds
BluezMake                     PASS      927.56 seconds
MakeCheck                     PASS      12.58 seconds
MakeDistcheck                 PASS      174.49 seconds
CheckValgrind                 PASS      288.93 seconds
CheckSmatch                   PASS      382.64 seconds
bluezmakeextell               PASS      116.35 seconds
IncrementalBuild              PASS      1538.64 seconds
ScanBuild                     PASS      1187.46 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/2] transport: handle BAP Enabling state correctly when resuming

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
24: B1 Line exceeds max length (86>80): "profiles/audio/transport.c:bap_state_changed() stream 0x25c2880: qos(2) -> enabling(3)"
26: B1 Line exceeds max length (86>80): "profiles/audio/transport.c:bap_state_changed() stream 0x25cc590: qos(2) -> enabling(3)"
28: B1 Line exceeds max length (92>80): "src/shared/bap.c:bap_stream_state_changed() stream 0x25cc590 dir 0x01: enabling -> streaming"
30: B1 Line exceeds max length (92>80): "profiles/audio/transport.c:bap_state_changed() stream 0x25cc590: enabling(3) -> streaming(4)"
32: B1 Line exceeds max length (132>80): "profiles/audio/transport.c:transport_update_playing() /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/fd1 State=TRANSPORT_STATE_IDLE Playing=1"
33: B1 Line exceeds max length (153>80): "profiles/audio/transport.c:transport_set_state() State changed /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/fd1: TRANSPORT_STATE_IDLE -> TRANSPORT_STATE_PENDING"
34: B1 Line exceeds max length (153>80): "profiles/audio/transport.c:transport_set_state() State changed /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/fd0: TRANSPORT_STATE_IDLE -> TRANSPORT_STATE_PENDING"


---
Regards,
Linux Bluetooth


--===============7300948416451177985==--
