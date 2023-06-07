Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62640C7EE25
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jun 2023 13:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbjFGNhM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jun 2023 09:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbjFGNhK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jun 2023 09:37:10 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C951BD7
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 06:37:09 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-75ec7e8e826so220151085a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jun 2023 06:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686145028; x=1688737028;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o+YgofBQrGNvSRd2Y6G8osTiI2ZfX1A+HStA7UKv83U=;
        b=fTu6luP/A3FrirqHqk3z3MwkB3fuWGt6zHKNH8XUyPOMoKTyPk/wsenpA5vDe0lrdN
         MW7K92w7D7Cy8W2ZzAerx+5q+0gx/XfPdhEBNLDlfskD5h/G82cyQpBeoTPWVMPgnp9c
         nu++9Q0WeBkCa8JM0+iF+Rmvaqia8HlqfSP5nI8XKTwkzNuNhVuknopleYJcGcHVc3tx
         voGGtY5qKtZvRIeXvJpiTBAghNoAL666QTRStJ3JxGuc2UiDVXyxVL/POAZUeGVamWPK
         vH8mu8W4ZKaUCkVxIksEEzZfaON905LF7SkfnyU6SMgEXaAeKlG+2GOKpfS0CLS+05Lw
         H67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686145028; x=1688737028;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+YgofBQrGNvSRd2Y6G8osTiI2ZfX1A+HStA7UKv83U=;
        b=CihdFv7OLgbtBD9qp+R5SlKU5oPSe74SfZ6efKl/6qblhtfTAT5dQkPpDpbNHOhPea
         KNvn64mb+Y47fuA9nYojxLYOq42B0wxlaCMnHe1E7qUjy3fep0f4accFWd4NzKzVfX1f
         hFAcZtL/3qsF6CRXLA/UOxkYAB+INnRoNwjngfJhvzNT3swYEvM3cdfnBaPz9Y3D6/kC
         tLG/BdWqmbLI+PSUA+h6Vu3M04awR/cD6Kj/6kQOWaozj6N4Ztmee3TJkiBUopAoROZe
         kTf5qdzq0Dy3xp2Owj5FER6Tv1rJQhB+Cp/ymNSv/kyoLjsafJ0slRr81oQ/A0K0S9E4
         7pBg==
X-Gm-Message-State: AC+VfDzMsR4hYzA0fVz9O5QPvfgcprw2FRcvrkHpg8MUFlLiuBkrK/Q3
        w1S/Im9IbL2HDrxrOppOHP8d1O2BOg4=
X-Google-Smtp-Source: ACHHUZ6cJog34Zq9RFvNaW7xo0syeo1aQWaJmS4gTjRXouPM+hCgO7Qa7AN9mxzEmyr8xIe+1LIUhA==
X-Received: by 2002:a37:301:0:b0:75d:50af:1c79 with SMTP id 1-20020a370301000000b0075d50af1c79mr1707060qkd.39.1686145028472;
        Wed, 07 Jun 2023 06:37:08 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.204.66])
        by smtp.gmail.com with ESMTPSA id ou47-20020a05620a622f00b0074d60b697a6sm5653210qkn.12.2023.06.07.06.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 06:37:07 -0700 (PDT)
Message-ID: <64808803.050a0220.7ca89.088c@mx.google.com>
Date:   Wed, 07 Jun 2023 06:37:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6459675143465960233=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, nitin.jadhav@nxp.com
Subject: RE: Code handling for VOCS service
In-Reply-To: <20230607121342.6136-2-nitin.jadhav@nxp.com>
References: <20230607121342.6136-2-nitin.jadhav@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6459675143465960233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=754867

---Test result---

Test Summary:
CheckPatch                    FAIL      1.74 seconds
GitLint                       PASS      0.72 seconds
BuildEll                      PASS      27.11 seconds
BluezMake                     PASS      863.57 seconds
MakeCheck                     PASS      12.34 seconds
MakeDistcheck                 PASS      154.02 seconds
CheckValgrind                 PASS      255.60 seconds
CheckSmatch                   PASS      340.33 seconds
bluezmakeextell               PASS      102.67 seconds
IncrementalBuild              PASS      1417.56 seconds
ScanBuild                     WARNING   1055.29 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,1/2] Added initial code for handling VOCS
WARNING:LONG_LINE: line length of 93 exceeds 80 columns
#596: FILE: src/shared/vcp.c:1268:
+				uint16_t value_handle, const uint8_t *value, uint16_t length,

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#614: FILE: src/shared/vcp.c:1340:
+				uint8_t att_ecode, const uint8_t *value, uint16_t length,

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#624: FILE: src/shared/vcp.c:1350:
+		DBG(vcp, "Unable to read Vol Offset State: error 0x%02x", att_ecode);

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#639: FILE: src/shared/vcp.c:1365:
+				uint8_t att_ecode, const uint8_t *value, uint16_t length,

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#649: FILE: src/shared/vcp.c:1375:
+		DBG(vcp, "Unable to read VOCS Audio Location: error 0x%02x", att_ecode);

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#664: FILE: src/shared/vcp.c:1390:
+				uint8_t att_ecode, const uint8_t *value, uint16_t length,

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#724: FILE: src/shared/vcp.c:1599:
+						     vcp_voffset_state_notify, NULL);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#739: FILE: src/shared/vcp.c:1614:
+		vcp_read_value(vcp, value_handle, read_vocs_audio_location, vcp);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#742: FILE: src/shared/vcp.c:1617:
+						     vcp_audio_loc_notify, NULL);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#769: FILE: src/shared/vcp.c:1644:
+		vcp_read_value(vcp, value_handle, read_vocs_audio_descriptor, vcp);

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#771: FILE: src/shared/vcp.c:1646:
+						    vcp_audio_descriptor_notify, NULL);

/github/workspace/src/src/13270609.patch total: 0 errors, 11 warnings, 676 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13270609.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/vcp.c:1272:2: warning: Null pointer passed to 1st parameter expecting 'nonnull'
        memcpy(vocs_audio_loc_n, value, sizeof(uint32_t));
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============6459675143465960233==--
