Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019E2C6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Mar 2023 03:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjCUDUA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 23:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCUDT7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 23:19:59 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475732BEE0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 20:19:57 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id iw3so14698238plb.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 20:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679368796;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XQQEXmCYxSTM+ulzprfeNTHGB80OLjbcFr5ujhtoJfU=;
        b=ciSZmXwFY587zWKsXsgDaUD5djfIweQELsXprNPbzMK0Bz0omXaqK+jVHzKkIwT0rU
         DBmVCs+K3tn/DQourtEF+DQa+Wds3rch4dqZ/1PSAXGkeTsMTPSu/UlviSPOAlFVN9s0
         Qt3jGZX6DhX3pPFTjV8t+G7tsrPawrILFlAyQJaO8XdKRH7d2B2wnexpaDO8TLovgY2V
         usTUPKX9L79VYo7gxUUSmbIICya7hJPppz9Tl+yMVD4l+z+zIpHKakcw3ZGTecn8qhwD
         elrC4R67UAv4g2kR7kwaqX7iCxK0Vrekjv9ms3SYu9SMGQ66eZVed4In1+lEiwXIStGQ
         mkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679368796;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQQEXmCYxSTM+ulzprfeNTHGB80OLjbcFr5ujhtoJfU=;
        b=7Th20jZq5csInsgU3pQPmBNRIvRYl4LLvgf0gO1rTpdmieaZ8yqlIIxZq/uDTxWOl9
         QAHx+JrhpLusQRI/xnNNPDbeJUjZHBfx6yattLhlGnoOJhmj2WWx+jv2KMgMCZaAfDOA
         Hni4WstKJIl/AybkaJkswhHraRpIZvXWZqeKqQlEb8hpmsjumPLdmVhGh3Ehxw6v+t30
         BAHBCxhHwA+rFdJOjugq+wsO5VRN/Xfe20lMzN/3RMjLlYlnGx1giBfaIbsvo8JsSiFs
         P/SqN38p4n0qcy6WtGZYgVRQ8qKNs5kgfA425LzkY2bPsFFJGgMAhnu7u21Zl4P4QDAX
         Womw==
X-Gm-Message-State: AO0yUKV0iWqMYNlH1SkrkLEVJjJeEFHpSpjamha/sBqE7mv5HnO7x/S5
        /bPEp/4sQK9fQ605+5k3t+v8ENmfmTI=
X-Google-Smtp-Source: AK7set9nO6EQDMFOskn9m+E/4fkDZSPowd3t6RusTlKAULtn7SIq+0zTxeIxiNVhOIOj8s97BSIKQw==
X-Received: by 2002:a17:90b:1c83:b0:23b:4f2a:8016 with SMTP id oo3-20020a17090b1c8300b0023b4f2a8016mr1184943pjb.3.1679368796540;
        Mon, 20 Mar 2023 20:19:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.4.2])
        by smtp.gmail.com with ESMTPSA id bh9-20020a17090b048900b0023fd6615283sm1128403pjb.5.2023.03.20.20.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 20:19:56 -0700 (PDT)
Message-ID: <6419225c.170a0220.b16e.2b6d@mx.google.com>
Date:   Mon, 20 Mar 2023 20:19:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4499800669139134039=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] shared/shell: Add support for -i/--init-script
In-Reply-To: <20230321010333.2361384-1-luiz.dentz@gmail.com>
References: <20230321010333.2361384-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4499800669139134039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=732131

---Test result---

Test Summary:
CheckPatch                    FAIL      1.12 seconds
GitLint                       PASS      0.50 seconds
BuildEll                      PASS      26.12 seconds
BluezMake                     PASS      749.45 seconds
MakeCheck                     PASS      11.59 seconds
MakeDistcheck                 PASS      147.36 seconds
CheckValgrind                 PASS      240.08 seconds
CheckSmatch                   WARNING   320.64 seconds
bluezmakeextell               PASS      96.42 seconds
IncrementalBuild              PASS      1215.93 seconds
ScanBuild                     WARNING   956.22 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/2] shared/shell: Add support for -i/--init-script
ERROR:SPACING: space required after that ',' (ctx:VxV)
#155: FILE: src/shared/shell.c:1105:
+	{ "init-script",required_argument, 0, 'i' },
 	               ^

/github/workspace/src/src/13182074.patch total: 1 errors, 0 warnings, 302 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13182074.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c:615:21: warning: non-ANSI function declaration of function 'bt_shell_usage'src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c:615:21: warning: non-ANSI function declaration of function 'bt_shell_usage'src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c:615:21: warning: non-ANSI function declaration of function 'bt_shell_usage'
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/shell.c:1171:19: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        data.init_fd = open(optarg, O_RDONLY);
                                       ^~~~~~~~~~~~~~~~~~~~~~
src/shared/shell.c:1201:13: warning: Access to field 'options' results in a dereference of a null pointer (loaded from variable 'opt')
                        if (c != opt->options[index - offset].val) {
                                 ^~~~~~~~~~~~
2 warnings generated.



---
Regards,
Linux Bluetooth


--===============4499800669139134039==--
