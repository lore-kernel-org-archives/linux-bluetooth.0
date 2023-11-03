Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF87C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Nov 2023 20:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378202AbjKCU16 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Nov 2023 16:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376881AbjKCU15 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Nov 2023 16:27:57 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B48B18B
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Nov 2023 13:27:54 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5b9a456798eso1754390a12.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Nov 2023 13:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699043274; x=1699648074; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EXtvSG1OVovOX/Pa0SIGdrAaL+JA9mlXOqEloqi5F5o=;
        b=Oqj/DqbIIk6Hr4dtz0193YHGSl86PnVh27irFpMrnvVGti17SZNfWENk56EHXf7AYl
         LiKM7I569WXpVxdeqG+Cnf/h3a11S9iUq2G8lAgiEHWLQ5PgJLi03xglApepY0EuOE/0
         UXMGv0MPpwxieFy/jeUsjVjtD/C5oKKqH6KgO2ZBToli3DalwoYG14xhxEQVCGgc834e
         TRaCn8zV6H0ExwkpqF08CqLY77I0xrqmT9k6cWO6TITtzgvSbhl2JLfI/QwzqOXh7O6u
         iXisWkgh25GQFnM2EizS693tsGzy0O2cEENrCkU9Kau+54mwa8/p2ycbQsQYztULEjJQ
         VOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699043274; x=1699648074;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EXtvSG1OVovOX/Pa0SIGdrAaL+JA9mlXOqEloqi5F5o=;
        b=OQcwKFuwdWTdhuqp6RaU3cKry4GUq85rKbc6owh3FEE6KtB5HD9eLDiBLrIFiOV+DX
         KW//+0+9Lrs9zawQsev0GWuJWGzbS/lcpvyNVeBgiavH0fDB6yiln29Kt1gp3IUD15sx
         ykkQ4sgWTH7DG3ut9BcM25zgdZ05brWoGqRnAvAm6pmdf2kvtUPvtl2qVla4RW8oBH6D
         WE6PkPQSLaPVUDsM/R9XQRXnJT7XfXWVq0o1SvEAF23GB/qbz/N0egIobHJakG7/CDLp
         D9AhfUtlofc9LVNLDaHucAyu3lnRDQ8CJQUBmlq2daBNUFwlpdSol1MGNgjBMA+N/aHF
         mH0g==
X-Gm-Message-State: AOJu0YzhFq73isJFaHV4fX6h8Sv6GF/xETWa1OV9+eIiaUnrThJRYAsV
        uXor6o+2KjgztwyUYxvR5knHizeP/Ac=
X-Google-Smtp-Source: AGHT+IHQt1v7Pf9MITlnnI3U5fia4XyWYor/QGKOVejCDc7GW29vSXk+11sAeI2/a/Um2rX5dVzXJQ==
X-Received: by 2002:a05:6a20:12c4:b0:181:275f:3b53 with SMTP id v4-20020a056a2012c400b00181275f3b53mr10393121pzg.42.1699043273584;
        Fri, 03 Nov 2023 13:27:53 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.45.18])
        by smtp.gmail.com with ESMTPSA id g9-20020a170902c38900b001c726147a45sm1762236plg.190.2023.11.03.13.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 13:27:53 -0700 (PDT)
Message-ID: <654557c9.170a0220.5edbc.5418@mx.google.com>
Date:   Fri, 03 Nov 2023 13:27:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6046630260743502846=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, verdre@v0yd.nl
Subject: RE: Fix an allocation oversight in SDP parsing
In-Reply-To: <20231103182150.60088-2-verdre@v0yd.nl>
References: <20231103182150.60088-2-verdre@v0yd.nl>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6046630260743502846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=798710

---Test result---

Test Summary:
CheckPatch                    FAIL      1.64 seconds
GitLint                       PASS      0.91 seconds
BuildEll                      PASS      33.44 seconds
BluezMake                     PASS      953.81 seconds
MakeCheck                     PASS      12.88 seconds
MakeDistcheck                 PASS      200.22 seconds
CheckValgrind                 PASS      309.63 seconds
CheckSmatch                   PASS      413.84 seconds
bluezmakeextell               PASS      135.45 seconds
IncrementalBuild              PASS      3258.43 seconds
ScanBuild                     WARNING   1227.60 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/4] lib/sdp: Allocate strings in sdp_data_t with NULL termination
WARNING:BAD_SIGN_OFF: Co-developed-by: must be immediately followed by Signed-off-by:
#59: 
Co-developed-by: Zander Brown <zbrown@gnome.org>
---
/github/workspace/src/src/13444881.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13444881.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,2/4] lib/sdp: Don't assume uint8_t has size 1
WARNING:REPEATED_WORD: Possible repeated word: 'of'
#47: 
Assuming the size of of uint8_t is bad practice, we use

WARNING:BAD_SIGN_OFF: Co-developed-by: must be immediately followed by Signed-off-by:
#52: 
Co-developed-by: Zander Brown <zbrown@gnome.org>
---
/github/workspace/src/src/13444882.patch total: 0 errors, 2 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13444882.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,3/4] lib/sdp: Use correct string length in sdp_copy_seq()
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#52: 
only the length of the string (so `sdp_data_t->unitSize - sizeof(uint8_t)`).

WARNING:BAD_SIGN_OFF: Co-developed-by: must be immediately followed by Signed-off-by:
#61: 
Co-developed-by: Zander Brown <zbrown@gnome.org>
---
/github/workspace/src/src/13444883.patch total: 0 errors, 2 warnings, 13 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13444883.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,4/4] lib/sdp: Pass size_t to sdp_get_string_attr()
WARNING:BAD_SIGN_OFF: Co-developed-by: must be immediately followed by Signed-off-by:
#58: 
Co-developed-by: Zander Brown <zbrown@gnome.org>
---
WARNING:LONG_LINE_COMMENT: line length of 91 exceeds 80 columns
#80: FILE: lib/sdp.c:2189:
+			/* Have to copy the NULL terminator too, so check len < valuelen */

WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#94: FILE: lib/sdp_lib.h:144:
+int sdp_get_string_attr(const sdp_record_t *rec, uint16_t attr, char *value, size_t valuelen);

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#103: FILE: lib/sdp_lib.h:546:
+static inline int sdp_get_service_name(const sdp_record_t *rec, char *str, size_t len)

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#109: FILE: lib/sdp_lib.h:551:
+static inline int sdp_get_service_desc(const sdp_record_t *rec, char *str, size_t len)

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#115: FILE: lib/sdp_lib.h:556:
+static inline int sdp_get_provider_name(const sdp_record_t *rec, char *str, size_t len)

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#121: FILE: lib/sdp_lib.h:561:
+static inline int sdp_get_doc_url(const sdp_record_t *rec, char *str, size_t len)

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#127: FILE: lib/sdp_lib.h:566:
+static inline int sdp_get_clnt_exec_url(const sdp_record_t *rec, char *str, size_t len)

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#133: FILE: lib/sdp_lib.h:571:
+static inline int sdp_get_icon_url(const sdp_record_t *rec, char *str, size_t len)

/github/workspace/src/src/13444884.patch total: 0 errors, 9 warnings, 62 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13444884.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
lib/sdp.c:507:16: warning: Dereference of undefined pointer value
                int8_t dtd = *(uint8_t *) dtds[i];
                             ^~~~~~~~~~~~~~~~~~~~
lib/sdp.c:535:17: warning: Dereference of undefined pointer value
                uint8_t dtd = *(uint8_t *) dtds[i];
                              ^~~~~~~~~~~~~~~~~~~~
lib/sdp.c:580:12: warning: Access to field 'attrId' results in a dereference of a null pointer (loaded from variable 'd')
        d->attrId = attr;
        ~         ^
lib/sdp.c:1870:26: warning: Potential leak of memory pointed to by 'ap'
        for (; pdlist; pdlist = pdlist->next) {
                                ^~~~~~
lib/sdp.c:1884:6: warning: Potential leak of memory pointed to by 'pds'
                ap = sdp_list_append(ap, pds);
                ~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
lib/sdp.c:1929:10: warning: Potential leak of memory pointed to by 'u'
                        *seqp = sdp_list_append(*seqp, u);
                        ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/sdp.c:2034:4: warning: Potential leak of memory pointed to by 'lang'
                        sdp_list_free(*langSeq, free);
                        ^~~~~~~~~~~~~
lib/sdp.c:2123:9: warning: Potential leak of memory pointed to by 'profDesc'
        return 0;
               ^
lib/sdp.c:3251:8: warning: Potential leak of memory pointed to by 'pSvcRec'
                pSeq = sdp_list_append(pSeq, pSvcRec);
                ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/sdp.c:3252:9: warning: Potential leak of memory pointed to by 'pSeq'
                pdata += sizeof(uint32_t);
                ~~~~~~^~~~~~~~~~~~~~~~~~~
lib/sdp.c:4588:13: warning: Potential leak of memory pointed to by 'rec_list'
                        } while (scanned < attr_list_len && pdata_len > 0);
                                 ^~~~~~~
lib/sdp.c:4884:40: warning: Potential leak of memory pointed to by 'tseq'
        for (d = sdpdata->val.dataseq; d; d = d->next) {
                                              ^
lib/sdp.c:4920:8: warning: Potential leak of memory pointed to by 'subseq'
                tseq = sdp_list_append(tseq, subseq);
                ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
13 warnings generated.



---
Regards,
Linux Bluetooth


--===============6046630260743502846==--
