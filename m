Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1PrkAXb"
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABD6BD
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 04:05:16 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77f8e4702a6so158671385a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 04:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702555515; x=1703160315; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+QZ9bsyzaH1t7IAGHqDvZ2S56Vy9/MiSQcb5s4/zZZs=;
        b=S1PrkAXbf68eefqXfOpg9GQEu2eHjPVpi26KtOnsYjBUGrYwU936EoubWM1IZdXeqY
         0Z/JbvxV9LZmp7/LLtiJWp3ZK+rD3HmPZl11fRGO8PU1HiH8Nj5IayUuVoQDhhVT0q18
         ELK9/wK+vWJ8x+iczBfAQsW5p0FXl9svW0SEiu5YJiIOjlHfVDuFK3bWJcSusmaSDh2n
         K+hPJW+DUHEtuKtOE4FMRFMKaCUdlgMP7TX+7fwlSsbxAXkXCAtdvmgMlMGyZZc8Ll0c
         ABtlT677XJmBc5S+6edVuBQCp0Z6q3J2gO/1B4C3FAISTWqYijLqkSFeGBgISXchlq4+
         wDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702555515; x=1703160315;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QZ9bsyzaH1t7IAGHqDvZ2S56Vy9/MiSQcb5s4/zZZs=;
        b=NwinfcbVXrVdYsGOz9aydyEwAoFV9vKDRYrb5spwiOEwiTxhJb6QVdFi7tfI+b28AU
         xDRPbI1QObrCF+DA8qyZVmlvdixq0HaBeSpjKuvoz7MMOk8pWYJwqfev5uhNNEgwcTgS
         W6GzAPapMPZ5g9rnp6BAKwCOUZJj5wgD9LtK3slg2LeqcH3FrGg19OZzeVDRHS69qCwU
         uP+O/9GzYDOUG2dA9cPKRcibvGKLTm7CPB6yByNnUsJpo7mBmu7qBPFB2Mb6O0a9F2HZ
         ugh2t5evO7Zp350YNPYVvd4RF64qlUg2/3BiTNgFmhAL3MtQXCT0ZJ432ZyhVUKlJNXy
         YVPQ==
X-Gm-Message-State: AOJu0Yx+42x4hZUuv/jRttM54ZpRtAI1FEn75bfYSK4/y9/4dKuiabcW
	JuPYVdcr3aRKozHsuZt3Fk47Bnav8Ms=
X-Google-Smtp-Source: AGHT+IF7V8kew8CVCrWloo7L+aKPF5JPEm5S1gmC4r4z86OgGMnNR4HemgN6vgB/+RLnEbfdTqDEGQ==
X-Received: by 2002:a05:620a:ce3:b0:76f:1817:942b with SMTP id c3-20020a05620a0ce300b0076f1817942bmr9583158qkj.28.1702555515258;
        Thu, 14 Dec 2023 04:05:15 -0800 (PST)
Received: from [172.17.0.2] ([172.183.79.4])
        by smtp.gmail.com with ESMTPSA id h4-20020a05620a21c400b0077dd520f844sm5189601qka.84.2023.12.14.04.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:05:15 -0800 (PST)
Message-ID: <657aef7b.050a0220.d6086.d239@mx.google.com>
Date: Thu, 14 Dec 2023 04:05:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4444500505010420088=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vinit.mehta@nxp.com
Subject: RE: mgmt: Fix crash after pair command
In-Reply-To: <20231214110339.1763-2-vinit.mehta@nxp.com>
References: <20231214110339.1763-2-vinit.mehta@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4444500505010420088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=810016

---Test result---

Test Summary:
CheckPatch                    FAIL      0.82 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      24.46 seconds
BluezMake                     PASS      735.10 seconds
MakeCheck                     PASS      12.45 seconds
MakeDistcheck                 PASS      154.37 seconds
CheckValgrind                 PASS      216.05 seconds
CheckSmatch                   PASS      319.72 seconds
bluezmakeextell               PASS      100.78 seconds
IncrementalBuild              PASS      667.31 seconds
ScanBuild                     WARNING   915.38 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,1/1] mgmt: Fix crash after pair command
ERROR:OPEN_BRACE: that open brace { should be on the previous line
#117: FILE: client/mgmt.c:853:
+		if(len)
+		{

ERROR:SPACING: space required before the open parenthesis '('
#117: FILE: client/mgmt.c:853:
+		if(len)

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#122: FILE: client/mgmt.c:858:
+				mgmt_confirm_neg_reply(prompt.index, &prompt.addr);

ERROR:OPEN_BRACE: that open brace { should be on the previous line
#124: FILE: client/mgmt.c:860:
 		else
+		{

WARNING:LONG_LINE_COMMENT: line length of 87 exceeds 80 columns
#126: FILE: client/mgmt.c:862:
+			/* After pair command, if the user doesn't provide any input on

WARNING:LONG_LINE_COMMENT: line length of 89 exceeds 80 columns
#127: FILE: client/mgmt.c:863:
+			 * bluetoothctl CLI interface after receiving the prompt(yes/no),

WARNING:LONG_LINE_COMMENT: line length of 82 exceeds 80 columns
#128: FILE: client/mgmt.c:864:
+			 * than subsequent CLI command will trigger a call to DBUS

WARNING:LONG_LINE_COMMENT: line length of 83 exceeds 80 columns
#129: FILE: client/mgmt.c:865:
+			 * library function (dbus_message_get_no_reply) with a NULL

WARNING:LONG_LINE_COMMENT: line length of 83 exceeds 80 columns
#130: FILE: client/mgmt.c:866:
+			 * message pointer which triggers assertion in DBUS library

WARNING:LONG_LINE_COMMENT: line length of 86 exceeds 80 columns
#131: FILE: client/mgmt.c:867:
+			 * causing the bluetoothctl process to crash. The change below

WARNING:LONG_LINE_COMMENT: line length of 82 exceeds 80 columns
#132: FILE: client/mgmt.c:868:
+			 * will ensure in case if no input is given by the user, a

WARNING:LONG_LINE_COMMENT: line length of 83 exceeds 80 columns
#133: FILE: client/mgmt.c:869:
+			 * conditional check is added to handle this scenario and a

WARNING:LONG_LINE_COMMENT: line length of 84 exceeds 80 columns
#134: FILE: client/mgmt.c:870:
+			 * default character ('N') will be passed so as to avoid the

WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line
#135: FILE: client/mgmt.c:871:
+			 * assertion.*/

/github/workspace/src/src/13492807.patch total: 3 errors, 11 warnings, 37 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13492807.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
client/mgmt.c:872:4: warning: Value stored to 'input' is never read
                        input = dummy_input;
                        ^       ~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============4444500505010420088==--
