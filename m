Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74251C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 00:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB4D206DC
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 00:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t0Hocq5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgFEAM3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jun 2020 20:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgFEAM3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jun 2020 20:12:29 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76473C08C5C0
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2020 17:12:29 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id w3so8163434qkb.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2020 17:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=IWsACdXFFq/mralFNJ/c0UDePFg1NMTSfbcUi/v1PWU=;
        b=t0Hocq5msaTsT4rTn846ZCiyIiQ862EJOhQNaZGEgwu913XFCVQxzGUIcM+vuSa9Dq
         z0xuxorRKsNpU13Zqh4KBvzikRjTSLuwOyyWlaInz1wbeVQL4715qlEHwpmxEhCkL8Ko
         LbTC1QhqAh4uPmK/SaYDMWWL26ERBeoGYDK2xb7jp8L8WZ+iEtodFq90MjkEhIlrIprD
         EnFtdoPRCugprXhTW0JMnVug2kWRhtU7ew2hp004dTUcubIvFSXZT3Zp3bJRB6o2gbIO
         GlpD6qMVeMOlwedUKl4QDvalwLygmEk7uxcVYd5kGgZ7kSLKNuwyO3H8KUy5BKzqBzsc
         zUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=IWsACdXFFq/mralFNJ/c0UDePFg1NMTSfbcUi/v1PWU=;
        b=aAQwhWdrbQZzV6k9mMz8eTmVoeAToahD/77hI84r1Y3Azp54xVJuhjadIfSCbeaXcL
         jmHulaOBwMQ2hcXJoEys/JCo5FJZwO6flQkDg9/zj7msf8nqVHFUyUmK2cg+z7xxtNal
         l8caEFjY3MZqLBQcOLS5oc8ohrSirmsxvSgP24QgQhbK5HNSnRZ4unyRMNO8VSOA3YMs
         6L53sDPsDSsaRMX5YhUeVRg2cgKEb6EVzpMLuohhZ7JM40E2pBl0296n0jWiFZuquz9b
         ZNKSBDFkpMnQPjfcTYD4w34fukd50NdthueLNUIKiT5PA3Umw8lJS5B2hZ/Bs4KHhiiE
         w11A==
X-Gm-Message-State: AOAM5326OAnsW8CIuJAHKoQNVtx5iRqiI//WC9vOdOh9+yDvqze61upl
        XHsrPHv+L0uTFlPbhkmEkZgqAXt0X3w=
X-Google-Smtp-Source: ABdhPJwd+9uiLOg8HHXAxU0pKwDXZ+s8V4CMKV0Jxnuchv3GCwIAtLM0cfRD1NySyFkSaDM8z4wk7Q==
X-Received: by 2002:a37:ec3:: with SMTP id 186mr7513210qko.88.1591315948631;
        Thu, 04 Jun 2020 17:12:28 -0700 (PDT)
Received: from [172.17.0.2] ([52.184.167.57])
        by smtp.gmail.com with ESMTPSA id d23sm5671432qtn.38.2020.06.04.17.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 17:12:28 -0700 (PDT)
Message-ID: <5ed98dec.1c69fb81.33c77.0269@mx.google.com>
Date:   Thu, 04 Jun 2020 17:12:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3646426762868530783=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pali@kernel.org
Subject: RE: btio: Fix registering Object Push, File Transfer and other L2CAP profiles
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200604231541.4170-1-pali@kernel.org>
References: <20200604231541.4170-1-pali@kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3646426762868530783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkpatch Failed

Outputs:
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#9: 
bluetoothd[19117]: src/profile.c:ext_start_servers() L2CAP server failed for Message Notification: setsockopt(L2CAP_OPTIONS): Invalid argument (22)

ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit f2418bf97dec ("btio: Add mode to for Enhanced Credit Mode")'
#27: 
commit f2418bf97d ("btio: Add mode to for Enhanced Credit Mode") which

- total: 1 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============3646426762868530783==--
