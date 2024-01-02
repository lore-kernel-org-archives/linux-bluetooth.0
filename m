Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1FE15AD2
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jan 2024 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bv03JJk5"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7810c332a2cso870652985a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jan 2024 11:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704222646; x=1704827446; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fYMftWOv9Z2rnx71C3jXBQk5K4lxwES0qwKU6tDLdKU=;
        b=Bv03JJk52PnCQmSPsoRbX9tijqqF8QkeatgIbieIeaj9lvIy/ontKEdqL2/GkLNLhX
         sQSEMmQf/lnA6nZ0VPWXoiaikB6O4XknF1cBgvctvANZyfFudC/TYniuaS/uoN1oYJ5H
         dBozC0C2AncMm9h8yYFj2RBfxCOGEXlz2qTKkZL82rdBnR2EBWsKcxlhC4GPerM9U9mv
         nuca8Cz2nzgZ+Tbt75UyOMciIstfykvewjnSI6l84xA7KSzSm6RvxGrWOi0xkiXbjJda
         +GmKMeD2F1KXvbvziNEEEB0GKB8e/62Pj6g2uanxcwYXYL+nFiiEp6VkFtH11wuK2DVF
         jVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704222646; x=1704827446;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fYMftWOv9Z2rnx71C3jXBQk5K4lxwES0qwKU6tDLdKU=;
        b=QEgmtCdhzvNwf1ChyyX8zkcYxTxIxn5mp3K/THgxaiijwN0qfVGGsDnu4NXLubtez3
         goVhPt/VNbtILczEDw4DjK+Oo58CIMaEEt7D6/gBsSQR61nYmZFtbNNw3ZWfSdrbuBgW
         l7KEP9s01daEF0b99YWSxBaFxUfMhCAfuGYZyDZV2TFVHlLoAeXCmzjBFCArzc0e4HbP
         SNZVrBLMtOa0uwWD5kU0ZA9vdfygBXyPLUR5nrFQpDl09Y0s2bOsvByqMJrsQVOVzEwR
         Z+VvL9s7IdAzM7T3/XzywERK/w0t1WBtUJIKtX+7ZJX4OkQT58bKE/LBaxrGccZLz4qY
         zLZA==
X-Gm-Message-State: AOJu0Ywf7oAooXpABp4xlM3x63+WuvAwcezwmicoEr6Ok8m6w28yj7b3
	6DSc9F6YWjhFR3hZvuyqBEmzKJYX2iM=
X-Google-Smtp-Source: AGHT+IH3dHa3JhVBXt4uFwrA0bdnLwIioIaI4W23dSqtH0O8TJfspAKI1NPcLEPDLK+xLrWxshRWRw==
X-Received: by 2002:a05:6214:23cf:b0:680:b175:1d69 with SMTP id hr15-20020a05621423cf00b00680b1751d69mr5321822qvb.53.1704222646622;
        Tue, 02 Jan 2024 11:10:46 -0800 (PST)
Received: from [172.17.0.2] ([40.79.247.107])
        by smtp.gmail.com with ESMTPSA id v7-20020a0cf907000000b00680b1947dbbsm1780182qvn.111.2024.01.02.11.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 11:10:46 -0800 (PST)
Message-ID: <65945fb6.0c0a0220.c3f36.42c7@mx.google.com>
Date: Tue, 02 Jan 2024 11:10:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0838137005032080699=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] audio: transport: Fix crash on A2DP suspend
In-Reply-To: <20240102180718.3735855-1-luiz.dentz@gmail.com>
References: <20240102180718.3735855-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0838137005032080699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=813893

---Test result---

Test Summary:
CheckPatch                    FAIL      0.72 seconds
GitLint                       PASS      0.50 seconds
BuildEll                      PASS      24.00 seconds
BluezMake                     PASS      722.25 seconds
MakeCheck                     PASS      11.83 seconds
MakeDistcheck                 PASS      160.48 seconds
CheckValgrind                 PASS      221.84 seconds
CheckSmatch                   PASS      327.10 seconds
bluezmakeextell               PASS      106.56 seconds
IncrementalBuild              PASS      665.20 seconds
ScanBuild                     WARNING   948.25 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1] audio: transport: Fix crash on A2DP suspend
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '052534ae07b8', maybe rebased or not pulled?
#76: 
Commit 052534ae07b8 ("transport: Update transport release flow for

/github/workspace/src/src/13509235.patch total: 0 errors, 1 warnings, 40 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13509235.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
profiles/audio/transport.c:620:30: warning: Access to field 'pending' results in a dereference of a null pointer (loaded from variable 'owner')
        struct media_request *req = owner->pending;
                                    ^~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============0838137005032080699==--
