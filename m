Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvDbq38r"
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFB2D8
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 14:57:20 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41cda69486eso1338001cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 14:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700693840; x=1701298640; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Tb0qm0IJIKto0c+VjVPYC1aiIR0pNHvLnAqb0/DUsCU=;
        b=EvDbq38ryk7Vn6rLSOD2cE4dOf573EedmguRlpbupI3wZGEK91JPI35n3zAaQw3Ald
         xale0AEpVFmn5thdZgsqdxBcAWUTj/HrRM1mT2lJlkfWh6M3OIJ51sVhCnzwijhM8tqd
         6iaCejuLIx2a+DfR6llSNG3UFrtMnifyW5rNQVu6/H+QlYzW5NKO48Wq92cZXlETQ9/e
         IehlfQnURupL/3a71O9lan2aBdEB3Pm+XuubtEZZT0a88k7P63Sr+SlumkPJCaHOOENW
         myOnLyuJBaUQ2S3/3Yi/il9/sg7NwJn/MIDrYQHipBLJMuCA656YAvgJ+L1QsGSV4XAR
         x9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700693840; x=1701298640;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tb0qm0IJIKto0c+VjVPYC1aiIR0pNHvLnAqb0/DUsCU=;
        b=sSnktZCbJ/ZZS+Ejpcq8J3WMEHigbnYH7GvEGaLNxkuE/ikxJGr+e3JHX6fW54BfiC
         Rz8NSF9lznBw5VcAoU2cYHzvZOIZLmt0zEdOtdO7tSTJlyhX3+i3e0Dh8sXuBnKwP2q8
         8qBmjCnrSQ6BpiPIE6jboEsnUZM3nxej8bvuSVtHjTHAyF9ZUIgm2kIiQw/1Mf4yGygj
         hl6ox8uGETWbsd9B1Ck7txqrTOSkO6o7JT7Ch9VNqmnlrfEuErSZZJBkzzT+aCUNfotU
         qQLtnS92xvSmrDplkOwRM5xBsJ886S5DEF4chZEmntIZQhSOpQXyEun4aXwMsC0AoC94
         ofdA==
X-Gm-Message-State: AOJu0YwX7fSn/OcqUYbG9dFotpRvg/wP5gxHHTnwu1uEXjEzgFZ2ityY
	PTPY6xWu0piJbovjNL6Ow4Xm+fK3Nq+CiA==
X-Google-Smtp-Source: AGHT+IH4rOJNxXn+4SXrOze5c9GXw9CkI5T7AmJ6IrxU9dgL3bnoOhMdFA+k0Y7rNrV9sxO7i5UeFg==
X-Received: by 2002:a05:622a:100c:b0:411:616a:4bde with SMTP id d12-20020a05622a100c00b00411616a4bdemr4430947qte.18.1700693839822;
        Wed, 22 Nov 2023 14:57:19 -0800 (PST)
Received: from [172.17.0.2] ([20.81.46.147])
        by smtp.gmail.com with ESMTPSA id z13-20020ac8710d000000b0041ce9ebaad2sm181372qto.43.2023.11.22.14.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 14:57:19 -0800 (PST)
Message-ID: <655e874f.c80a0220.8ad82.1407@mx.google.com>
Date: Wed, 22 Nov 2023 14:57:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8500854284735052930=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/5] shared/util: Add GMAP related UUIDs
In-Reply-To: <20231122210727.893872-1-luiz.dentz@gmail.com>
References: <20231122210727.893872-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8500854284735052930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=803430

---Test result---

Test Summary:
CheckPatch                    FAIL      3.57 seconds
GitLint                       FAIL      1.76 seconds
BuildEll                      PASS      24.17 seconds
BluezMake                     PASS      551.15 seconds
MakeCheck                     PASS      10.80 seconds
MakeDistcheck                 PASS      150.98 seconds
CheckValgrind                 PASS      211.28 seconds
CheckSmatch                   WARNING   317.05 seconds
bluezmakeextell               PASS      97.05 seconds
IncrementalBuild              PASS      2548.70 seconds
ScanBuild                     PASS      886.11 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v3,1/5] shared/util: Add GMAP related UUIDs
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#72: 
[1] https://www.bluetooth.org/DocMan/handlers/DownloadDoc.ashx?doc_id=576496

/github/workspace/src/src/13465437.patch total: 0 errors, 1 warnings, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13465437.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v3,1/5] shared/util: Add GMAP related UUIDs

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
8: B1 Line exceeds max length (94>80): "[2] https://www.bluetooth.com/wp-content/uploads/Files/Specification/Assigned_Numbers.pdf?id=3"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============8500854284735052930==--
