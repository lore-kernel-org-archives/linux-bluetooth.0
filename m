Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876AEC77B73
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Apr 2023 22:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344189AbjD0W3y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Apr 2023 18:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344105AbjD0W3w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Apr 2023 18:29:52 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AEB35BD
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 15:29:50 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-18ef8e9ab4fso1742049fac.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 15:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682634589; x=1685226589;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6CBs6oj27lQf6cZZQJ9ysywzmE84XNUabzNPiLR7HPU=;
        b=Xije2wwx3OQnR10OIIE/bM4JEd2TXsjnpi1pOu6ebXym3g+CxsycP1K59hV5TYphRB
         00P/ciUd24BF1j4ORIdmB6F+7rlzKFQmPdGBfXQCEjIP8iqnX7k+3P4E30em8yyyvWnH
         LPLdCUA8ycvIFlh1RFyeOVXnIBarwUqo/ExLu+YOz/SRZxF3C9IFGbFXgthkJ8ktwPjV
         rR9ZqPASERw/PnXnPUiYZ/lY67xJaZe5/ISE5Bmnqom53qnjXoDztsiArS5wTn6gf9Pm
         OVRBVdW1fs6xfg3Ntn+5IbdVbA4pkrrmrYTVNBQuYC778pl+vLnMHJ8vprSuT275HoDW
         68xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682634589; x=1685226589;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CBs6oj27lQf6cZZQJ9ysywzmE84XNUabzNPiLR7HPU=;
        b=W55TrGcqoKYSVvBE+m53YFAheWrh/IFWrkoIPZ587fIXhqKqiRdJEBwN7owOpaETgp
         Ro3LDh29LjAil0pdQYV/N662NOpbMh4jJPqrNAmiquycYrhwSyOejI9H6H1Q+UpGuleb
         omhjk1/JnSFh9VzGQCWyyn56fQnHu56bj1XdYFGQoAxue9UtOYKWOmd7QJvTuV8+SJyV
         BLYIve/IcSYBD1np1q74IGIDoFEYmPlmytyKsEa9hvK2oCLt/TqqLyeDBl7TF3qB+k20
         5VUBN17ibXsmogcdyLpalkf8D3MgB7SXM3yeVO9WAIa3IGEp/eDRpnaqYOXjwIz2fuen
         CVfA==
X-Gm-Message-State: AC+VfDzXoDKexTafuZr7ZqQuNEOSHHKlwCVF6+CwRjGbXE63SAclTnlG
        EjWt7rxGQxdALxQ5EDuTXCb4U3Aed6E=
X-Google-Smtp-Source: ACHHUZ7poez3eKQ03yI7K8MaxfKDMK0xWwnBVpkY/Y4urCEtObpbesf0qR65aH23yWxA+ewS2IBGbg==
X-Received: by 2002:a05:6870:93d3:b0:17a:cf55:242 with SMTP id c19-20020a05687093d300b0017acf550242mr1549042oal.53.1682634589423;
        Thu, 27 Apr 2023 15:29:49 -0700 (PDT)
Received: from [172.17.0.2] ([157.55.189.43])
        by smtp.gmail.com with ESMTPSA id u2-20020a05687036c200b00177c314a358sm8175544oak.22.2023.04.27.15.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 15:29:48 -0700 (PDT)
Message-ID: <644af75c.050a0220.f569b.9612@mx.google.com>
Date:   Thu, 27 Apr 2023 15:29:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8640806771906293698=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/9] media: Fix not storing Preferred Delay properly
In-Reply-To: <20230427193245.323502-1-luiz.dentz@gmail.com>
References: <20230427193245.323502-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8640806771906293698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=743661

---Test result---

Test Summary:
CheckPatch                    FAIL      5.34 seconds
GitLint                       PASS      2.84 seconds
BuildEll                      PASS      32.15 seconds
BluezMake                     PASS      972.29 seconds
MakeCheck                     FAIL      12.70 seconds
MakeDistcheck                 PASS      179.52 seconds
CheckValgrind                 PASS      291.74 seconds
CheckSmatch                   PASS      388.44 seconds
bluezmakeextell               PASS      119.48 seconds
IncrementalBuild              PASS      7133.45 seconds
ScanBuild                     PASS      1199.34 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,6/9] shared/lc3: Update configuration to use iovec
ERROR:SPACING: need consistent spacing around '>>' (ctx:WxV)
#124: FILE: src/shared/lc3.h:56:
+	LC3_IOV(0x02, LC3_FREQ, _freq, _freq >>8, \
 	                                     ^

/github/workspace/src/src/13225716.patch total: 1 errors, 0 warnings, 125 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13225716.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: MakeCheck - FAIL
Desc: Run Bluez Make Check
Output:

make[3]: *** [Makefile:11261: test-suite.log] Error 1
make[2]: *** [Makefile:11369: check-TESTS] Error 2
make[1]: *** [Makefile:11777: check-am] Error 2
make: *** [Makefile:11779: check] Error 2


---
Regards,
Linux Bluetooth


--===============8640806771906293698==--
