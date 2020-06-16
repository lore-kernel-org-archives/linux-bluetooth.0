Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9A5C433E2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 00:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 811752074D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 00:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqyELywi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgFPAMd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jun 2020 20:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgFPAM3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jun 2020 20:12:29 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3719C08C5C3
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 17:12:28 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id q8so17585428qkm.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 17:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=k+VzHbkhOPjOL4gN6qNphY1NMRuZ5keNHoEp+Jfs8ag=;
        b=PqyELywi+kdpdiU6HBX4Rgujl7pQ9cNeh9ZEHEtMMT4JbUmsMObk7NObg3UN1/6Yf2
         RLZfRDCxp29dnSNAIXRDqICRl0VgQOZ6/uv4OXOTRwKUUXn+2Yj7a3423S4sRLhvsOok
         YNKvzIApkgdb3rTe3cLxn/PVmxf3YOLrL1d4PV8fKuXuv85OpVBaYiFqmjI9U/Csmgze
         lC+d0Kj4oqPO4Kh9GOMpy30tQ732/WBsdlE+SnhtPyjc7UEXQVPheL+Tv1NKQNLdd3qo
         3atuTGV0Ux5qjMhjvsMGtB4yPkB1TDI0xfvLEOJEICBCuezg02jR9uLIbbZZ7TMtCOrj
         zm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=k+VzHbkhOPjOL4gN6qNphY1NMRuZ5keNHoEp+Jfs8ag=;
        b=Gz4rg3bxy4Gf5jElkTkGfLbf7bnnmxGfOVof1X1n4UPMPRdGD0JbM0UWnm+AToX3In
         UPmGOMSpcaVLvXD4Z8x+m9WJAuFEdIHNA0fv2F6MV1sZIHgleAsvRQIG9IrW9ED2+8eL
         DuW9jyUUpHgvPRqBBhiiWxHyyTeKwh6alZdZ3oDETZDEO41p4D1KLfNb2r163qULKy6/
         hHTx8YMP9o+syKrWhaX+dWz5vPMmESR42ebzSOLn6n/XIziPgerOk8nIJ2Gv+UqH3UR+
         2OW2iU7zMKj99EmffMZEXJyulzroVP7i1tCqoSlJ9XYetgiv22Rr7+k8x4mT4Cm9q5b1
         L/5w==
X-Gm-Message-State: AOAM531v0oKNpTtz0f2hXvVVhO0BnqdvmypU3k3yYcAe0ZRdDLGwGcHW
        wDWu5AEsc/YkZHEiEka6T0qYS0ka
X-Google-Smtp-Source: ABdhPJzIdYrAImZNScrc/WZPpolfC4uKf/RfjF8tn2eFVEzHgX+PTK60aycFSH+hSoTWhZWVgVQFfQ==
X-Received: by 2002:a37:5805:: with SMTP id m5mr16003068qkb.176.1592266347851;
        Mon, 15 Jun 2020 17:12:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.36.191.240])
        by smtp.gmail.com with ESMTPSA id k34sm12256147qtf.35.2020.06.15.17.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 17:12:27 -0700 (PDT)
Message-ID: <5ee80e6b.1c69fb81.8ff3e.42c8@mx.google.com>
Date:   Mon, 15 Jun 2020 17:12:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1251069115927506470=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, michaelfsun@google.com
Subject: RE: [bluez,v1,3/3] btmgmt: Add btmgmt command advmon-add
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200616000318.42664-4-michaelfsun@google.com>
References: <20200616000318.42664-4-michaelfsun@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1251069115927506470==
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
WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'advmon_added', this function's name, in a string
#38: FILE: tools/btmgmt.c:1026:
+	print("hci%u advmon_added: handle %u", index, ev->monitor_handle);

WARNING:NAKED_SSCANF: unchecked sscanf return value
#84: FILE: tools/btmgmt.c:4710:
+		if (!sscanf(&pattern_str[i++], "%2hhx", &pattern->value[j]))
+			return false;

WARNING:NAKED_SSCANF: unchecked sscanf return value
#86: FILE: tools/btmgmt.c:4712:
+		if (i < str_len && !sscanf(&pattern_str[i], "%1hhx", &tmp))
+			return false;

ERROR:OPEN_BRACE: that open brace { should be on the previous line
#107: FILE: tools/btmgmt.c:4733:
+static struct option advmon_add_options[] =
+					{ { "help", 0, 0, 'h' },

WARNING:LONG_LINE: line over 80 characters
#145: FILE: tools/btmgmt.c:4771:
+				sizeof(struct mgmt_cp_add_adv_patterns_monitor) +

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#158: FILE: tools/btmgmt.c:4784:
+			/* fall through */

- total: 1 errors, 5 warnings, 182 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============1251069115927506470==--
