Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D85C636CA
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Jul 2021 13:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B95B613D3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Jul 2021 13:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhGQNSS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Jul 2021 09:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhGQNSR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Jul 2021 09:18:17 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAC0C06175F
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Jul 2021 06:15:21 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id p202so11637808qka.12
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Jul 2021 06:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=fzdqgMwe8IIZAKRX7nzODRaKZkvkDAwVAjnrAxiZoxc=;
        b=FzxZwrMGiSCPre4Ibq7e6gfebI2suJp/sg4FL95QypB4HV8ZDD20eHMh7Y0cv4UOej
         YfPf7s67pDD2W0itYa6b+opq1kceaOel1/Ku2D3l79G1CKQNSu4jhuBAYUEx5596ofu4
         i+4OkcV/NEUfVlGR+6HSWXEIbyLHujUB9UPmq6kq4u3NeOpQZ3Ep0PHgea353VznNiLX
         JpPl8D5nMoDdsd9SBqVnIyHPU97ARIVOa0NAIL1TZKQOs+2cwEMEMnPgNdvq5nMRPr8h
         C6FGpVMei4BpyiTMJBee/pR1EzOegjKMz0vBtNPT9JRgctVuOeODYMuVZpyYcVtjq5dK
         k2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=fzdqgMwe8IIZAKRX7nzODRaKZkvkDAwVAjnrAxiZoxc=;
        b=sHQWiIIpaXzgw78Y80ZfOBeJ7zDf5qJ2ZOduM+w+9W7YEJBuxMTdMhWCMG+X90e3sA
         3d437pbsA6KiN5hEiZVtkIFetettwi+8xfZe2DPMvqygZFGVY9VzpZap7ZBDdQIn32f1
         n3C55bcOKHgZaXi/eXmZnYuvlNXRrR60KCeFp46sC0E8uKAy0fwyQg0KXWYtwP9JGbJH
         dGmzp1B6ahhjEW5BRodwtCanekL7qCKDZAvYenrV1WrqYENdXLZ4QKiYvkxfhR965Xko
         5Y1izBsJr8cIVtwoGBQgu/r988AqViZI+zK7KvH1Jd+UC4RXFx94C8xjuzt/rihWuN/a
         K1Dw==
X-Gm-Message-State: AOAM5334mJqBSlvcL601wtjWdHOtGICaUi4VgPGZ7qCXh3vosdmtz85X
        6qjs1zFknZcQWm2LwuAQP3IFKp0AjGk9Kg==
X-Google-Smtp-Source: ABdhPJwfahGISef8ODK81Iy9n3VsINt+Vzn0AEO6oaVnF0RXPKJsvmkxTdXx1W26IGphEwKBS0UEBg==
X-Received: by 2002:ae9:e511:: with SMTP id w17mr15220271qkf.306.1626527719831;
        Sat, 17 Jul 2021 06:15:19 -0700 (PDT)
Received: from [172.17.0.2] ([13.77.70.245])
        by smtp.gmail.com with ESMTPSA id b6sm4479361qtg.1.2021.07.17.06.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 06:15:19 -0700 (PDT)
Message-ID: <60f2d7e7.1c69fb81.46b9d.d77a@mx.google.com>
Date:   Sat, 17 Jul 2021 06:15:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1744995941911079245=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, me@dylanvanassche.be
Subject: RE: [1/4] obexd: phonebook-ebook: modernize
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210717125508.29186-1-me@dylanvanassche.be>
References: <20210717125508.29186-1-me@dylanvanassche.be>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1744995941911079245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=517051

---Test result---

Test Summary:
CheckPatch                    FAIL      1.55 seconds
GitLint                       FAIL      0.49 seconds
Prep - Setup ELL              PASS      47.28 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.39 seconds
Build - Make                  PASS      204.40 seconds
Make Check                    PASS      9.50 seconds
Make Distcheck                PASS      248.76 seconds
Build w/ext ELL - Configure   PASS      9.13 seconds
Build w/ext ELL - Make        PASS      192.09 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
obexd: phonebook-ebook: modernize
WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#145: FILE: obexd/plugins/phonebook-ebook.c:138:
+			e_vcard_add_attribute(evcard2, e_vcard_attribute_copy(attrib));

WARNING:LONG_LINE_COMMENT: line length of 102 exceeds 80 columns
#252: FILE: obexd/plugins/phonebook-ebook.c:245:
+	/* Prepare pull request, return the prepared request which is passed to phonebook_pull_read */

WARNING:SPACING: space prohibited between function name and open parenthesis '('
#275: FILE: obexd/plugins/phonebook-ebook.c:268:
+static void phonebook_pull_read_ready (GObject *source_object,

WARNING:SPACING: space prohibited between function name and open parenthesis '('
#292: FILE: obexd/plugins/phonebook-ebook.c:284:
+	e_book_client_get_contacts_finish (E_BOOK_CLIENT (source_object),

WARNING:SPACING: space prohibited between function name and open parenthesis '('
#292: FILE: obexd/plugins/phonebook-ebook.c:284:
+	e_book_client_get_contacts_finish (E_BOOK_CLIENT (source_object),

WARNING:LONG_LINE_COMMENT: line length of 83 exceeds 80 columns
#321: FILE: obexd/plugins/phonebook-ebook.c:305:
+	* Convert each contact to a vCard and append the card to the buffer string.

WARNING:BLOCK_COMMENT_STYLE: Block comments should align the * on each line
#321: FILE: obexd/plugins/phonebook-ebook.c:305:
+	/*
+	* Convert each contact to a vCard and append the card to the buffer string.

WARNING:LONG_LINE: line length of 92 exceeds 80 columns
#324: FILE: obexd/plugins/phonebook-ebook.c:308:
+	for (count = 0; l && count + data->count < maxcount; l = g_slist_next(l), count++) {

WARNING:SPACING: space prohibited between function name and open parenthesis '('
#351: FILE: obexd/plugins/phonebook-ebook.c:330:
+	g_slist_free_full (contacts, (GDestroyNotify) g_object_unref);

WARNING:LONG_LINE_COMMENT: line length of 91 exceeds 80 columns
#376: FILE: obexd/plugins/phonebook-ebook.c:351:
+	/* Retrieve results from the backend, based on the request. Return 0 on success. */

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#389: FILE: obexd/plugins/phonebook-ebook.c:364:
+				   (GAsyncReadyCallback) phonebook_pull_read_ready,

WARNING:SPACING: space prohibited between function name and open parenthesis '('
#409: FILE: obexd/plugins/phonebook-ebook.c:384:
+	e_book_client_get_contact_finish(E_BOOK_CLIENT (source_object),

WARNING:LONG_LINE_COMMENT: line length of 81 exceeds 80 columns
#464: FILE: obexd/plugins/phonebook-ebook.c:431:
+	/* Get a contact from the backend, contact must be in cache to succeed */

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#478: FILE: obexd/plugins/phonebook-ebook.c:445:
+				  (GAsyncReadyCallback) phonebook_get_entry_ready,

WARNING:SPACING: space prohibited between function name and open parenthesis '('
#510: FILE: obexd/plugins/phonebook-ebook.c:499:
+	e_book_client_get_contacts_finish (E_BOOK_CLIENT (source_object),

WARNING:SPACING: space prohibited between function name and open parenthesis '('
#510: FILE: obexd/plugins/phonebook-ebook.c:499:
+	e_book_client_get_contacts_finish (E_BOOK_CLIENT (source_object),

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#802: FILE: obexd/plugins/phonebook-ebook.c:555:
+			     phonebook_cache_ready_cb ready_cb, void *user_data, int *err)

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#875: FILE: obexd/plugins/phonebook-ebook.c:621:
+				   (GAsyncReadyCallback) phonebook_create_cache_ready,

ERROR:SPACING: spaces required around that '?' (ctx:VxW)
#911: FILE: obexd/plugins/phonebook-ebook.c:657:
+		      gerr != NULL? gerr->message: "NULL");
 		                  ^

ERROR:SPACING: spaces required around that ':' (ctx:VxW)
#911: FILE: obexd/plugins/phonebook-ebook.c:657:
+		      gerr != NULL? gerr->message: "NULL");
 		                                 ^

- total: 2 errors, 18 warnings, 889 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] obexd: phonebook-ebook: modernize" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

configure.ac: specify phonebook plugin at build time
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#10: 
Cherry-picked from https://github.com/sailfishos/bluez5/commit/d39ed9e2db8d4f9ab239a859c777e5504459b9dd

WARNING:BAD_SIGN_OFF: Non-standard signature: Co-authored-by:
#12: 
Co-authored-by: Dylan Van Assche <me@dylanvanassche.be>

- total: 0 errors, 2 warnings, 20 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] configure.ac: specify phonebook plugin at build time" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

obexd: phonebook: Workaround for PTS client not sending mandatory apparams
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#12: 
Cherry-picked from https://github.com/sailfishos/bluez5/commit/e8001df26e1964ddb98d02ad27ab8f909ffe2f17

WARNING:BAD_SIGN_OFF: Non-standard signature: Co-authored-by:
#14: 
Co-authored-by: Dylan Van Assche <me@dylanvanassche.be>

- total: 0 errors, 2 warnings, 21 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] obexd: phonebook: Workaround for PTS client not sending" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
configure.ac: specify phonebook plugin at build time
7: B1 Line exceeds max length (103>80): "Cherry-picked from https://github.com/sailfishos/bluez5/commit/d39ed9e2db8d4f9ab239a859c777e5504459b9dd"

obexd: phonebook: Workaround for PTS client not sending mandatory apparams
1: T1 Title exceeds max length (74>72): "obexd: phonebook: Workaround for PTS client not sending mandatory apparams"
8: B1 Line exceeds max length (103>80): "Cherry-picked from https://github.com/sailfishos/bluez5/commit/e8001df26e1964ddb98d02ad27ab8f909ffe2f17"


##############################
Test: Prep - Setup ELL - PASS
Desc: Clone, build, and install ELL

##############################
Test: Build - Prep - PASS
Desc: Prepare environment for build

##############################
Test: Build - Configure - PASS
Desc: Configure the BlueZ source tree

##############################
Test: Build - Make - PASS
Desc: Build the BlueZ source tree

##############################
Test: Make Check - PASS
Desc: Run 'make check'

##############################
Test: Make Distcheck - PASS
Desc: Run distcheck to check the distribution

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============1744995941911079245==--
