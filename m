Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB72EC83F11
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Aug 2023 19:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjH1TQe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Aug 2023 15:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjH1TQY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Aug 2023 15:16:24 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB44102
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 12:16:21 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-76da0ed3b7aso211593985a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 12:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693250180; x=1693854980;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IYs2DOwC4kPQodhVExM2Fc4jot9RzErtHzlm643Rbps=;
        b=lrgTUd9c1/X54ZfHhCdUMeko9H+JGKUoDqz+Ftx0Fs64dVphdsv1VBQkUyTqKkiaz2
         L4Aa8Ff3/9Tgn1JzAZuiWUk4nX0GbH7UrccxjVDuxzAn3jR16TCPsv00kG1N69Xil7Al
         IelhHJh6xiJmrZTt+uZLak3Ldq5sT2GhWgY9D6+edFgPbqprpuZagEuMUPjHAJ5rEYMQ
         FrBJoMRlU6moWfw0caNWMwdjby+oSK2M9cQOZAkb0z3DowBatX7vUFR0BsAyTNlN7dnt
         ZXa0aM6woGpnbACmG0yES5szIbqU9usplKuwMcLwd1N1ujYmIggqLiw74KZC6nGOUtZg
         FE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693250180; x=1693854980;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYs2DOwC4kPQodhVExM2Fc4jot9RzErtHzlm643Rbps=;
        b=O84jkwChwgMG9dRqg7+2zo3aOIxIksDDqOZxo3XhPMD+QvEOkn5NNiaYzr7iiq0Bzp
         c0ySFWuFRkzCkbg0U1StPgs3eWZLbDCVhnUM96wj1oOfQ3NX+3cwPybFidVu3j20+V3c
         mpfm01g+QwRAARTWjOhA5Ux+22ITWQ9fCHWLEiOPp+clBQu49GQQJ3DQKEXZFMfPLfwA
         UEwSFUf7HmOH7MvAbB4fBALTa4UxKhEMw5SIx/f82omhd/ihmBwV5dQpOTd0gmJVhvvO
         HDSr/DDx3++g+BBI65E1+7vx7ikBzOVpVY0dNo+kpWrVds+pu20WoiZlOgbzg4cFGLIq
         7O+Q==
X-Gm-Message-State: AOJu0YxGPptfo36Bn2tgHUj+PCnSMOh9kEmVyEBKQx2ZYdPRvMkS4Hx5
        B+0u95W3cRkJaJH3KFjZPErPLHP/XTg=
X-Google-Smtp-Source: AGHT+IHrhW+YTR/xpfNAkwDhVRPlAEtdZjeI7VcjjuEH6uW9Ez9Zd70DPaEN59eLQWkWXPGSb5RFpw==
X-Received: by 2002:a05:620a:4304:b0:76d:3475:2e10 with SMTP id u4-20020a05620a430400b0076d34752e10mr30556740qko.48.1693250180268;
        Mon, 28 Aug 2023 12:16:20 -0700 (PDT)
Received: from [172.17.0.2] ([52.191.76.16])
        by smtp.gmail.com with ESMTPSA id i3-20020ae9ee03000000b0076745f352adsm2544586qkg.59.2023.08.28.12.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 12:16:19 -0700 (PDT)
Message-ID: <64ecf283.e90a0220.962fd.9139@mx.google.com>
Date:   Mon, 28 Aug 2023 12:16:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2983210067186269257=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] shared/gatt-client: Fix not sending confirmations
In-Reply-To: <20230828175553.518129-1-luiz.dentz@gmail.com>
References: <20230828175553.518129-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2983210067186269257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=780014

---Test result---

Test Summary:
CheckPatch                    FAIL      0.79 seconds
GitLint                       PASS      0.37 seconds
BuildEll                      PASS      27.87 seconds
BluezMake                     PASS      862.90 seconds
MakeCheck                     PASS      12.61 seconds
MakeDistcheck                 PASS      156.98 seconds
CheckValgrind                 PASS      257.28 seconds
CheckSmatch                   PASS      343.83 seconds
bluezmakeextell               PASS      105.81 seconds
IncrementalBuild              PASS      709.33 seconds
ScanBuild                     WARNING   1073.71 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] shared/gatt-client: Fix not sending confirmations
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id 'fde32ff9c9c0', maybe rebased or not pulled?
#81: 
Commit fde32ff9c9c0 ("shared/gatt-client: Allow registering with NULL

/github/workspace/src/src/13368176.patch total: 0 errors, 1 warnings, 21 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13368176.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/gatt-client.c:451:21: warning: Use of memory after it is freed
        gatt_db_unregister(op->client->db, op->db_id);
                           ^~~~~~~~~~
src/shared/gatt-client.c:696:2: warning: Use of memory after it is freed
        discovery_op_complete(op, false, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:993:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1099:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1291:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1356:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1631:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1636:2: warning: Use of memory after it is freed
        discover_all(op);
        ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2140:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2148:8: warning: Use of memory after it is freed
                                                        discovery_op_ref(op),
                                                        ^~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3237:2: warning: Use of memory after it is freed
        complete_write_long_op(req, success, 0, false);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3259:2: warning: Use of memory after it is freed
        request_unref(req);
        ^~~~~~~~~~~~~~~~~~
12 warnings generated.



---
Regards,
Linux Bluetooth


--===============2983210067186269257==--
