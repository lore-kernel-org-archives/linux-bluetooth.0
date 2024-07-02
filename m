Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9073015B561
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920562; cv=none; b=JKyWs2Xd74HIQlrnUvpPn8kZIP8Ra08ZfeOqLdzzwJVp7klxvB85qBEJJx+4JNFMlD5cProo8o1nFJn1QeDSqCYhbY7SQepYMeLNYBNewMx8FPM4AQLKBSHUWkbg5UV7SObWjT/1ENS8dgHZVUBx7ooXo6bR2CMz6ASbOnDxKpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920562; c=relaxed/simple;
	bh=vGj3AY6anOyOrfCmsrm31Dtj/YfVAtQBDcBZBCv2GCg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ovg+zhy93XlOU+li0qyP8uysNh0wU3EFIVJTMRMPmLf3ORk6yXtOCureGSzDDb7BVBboCg6lY2e+/fQ5KjOSQDVKYVW+xKWt9FnhohH6XKe2sdVQ2FGx41ZJg6QnHGww6ZNBz5AKXiaLmlfxaGs6rqONGQzebpEMhKUnOCPEqXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eh2kosWZ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eh2kosWZ"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b4f7541d7eso19933786d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2024 04:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719920559; x=1720525359; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fcyo12kkYPYKqo3+4D50KUQUUY8sDq7WfPyQkUWnaPk=;
        b=eh2kosWZZdvYup3Sv4YS/K/eVf2r1KSJ7IH4qsAOHYsl3aVQ/EEhXdL6lOaCg23IFv
         HsxSEZEyLBeKm1yVFA+2KLcRQ8pJEaHD55P+Y70usWNFii9yDJjHrKl+V5AVp0oF0GYc
         L/PGCSJIz6W8PEkvVSAAD4mc36sAu9tXdEjuEEBDBtejnbfXqveCGC/j4PgXiePKPJKg
         nDvLddfcre2Mq1IalLUEdpujTUhRIrPOC7MINsl1Yq84ut4k2iu9u8KZ6WF70HI/wY0h
         Smvx0g6aKsbjFwTw7hOPm9gd1C9tCBQM9KHO34+CP5ixI+5gfdxIVOw9Mm/5j9cxE2lg
         c2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719920559; x=1720525359;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fcyo12kkYPYKqo3+4D50KUQUUY8sDq7WfPyQkUWnaPk=;
        b=meFVKQqlmDkbjlRAXKsvYCg1TJZ1i/5TwXRTMlgNszJsnnxc/oVHUGWfHnhTaJqBDV
         3l7t4KtzscKOpBdR6s+A86/bPDJdsXqQ4pMd4fGc6XYJyIheuFlPyFL7HjSrh1MbC6wK
         pMubYfh6COchpO1NUTCZQWuMQMxM10i/HPiJMsTsdmjvCB3x6Oj10QTiAWYSG/mZRhPK
         Z7ivvBsJvYw1BftFh7o9zHCmkSDCZ+FvbRSG99pUnid4xU/Ke+bQ3IAhVN48PuS7L2dt
         L9I7P6lICobKgr8ncabP1xZSp7qkgSKUpHfoeHwMOe8fimezn6s2yat9SR9lxBez7Iy0
         6Pfw==
X-Gm-Message-State: AOJu0YzyUuBi4pzKrDkOjZN/g8NG3QaHgZYOuiKbMrFnPLcCtSickF0p
	DM8R7nRfthsGx4lzVUT0wZRwpRRVNt4mDg/FInGhwRpxuVuHxOM9MU3niQ==
X-Google-Smtp-Source: AGHT+IHEnDzqrOBZ1IDk6QRvMNpQYdUT/kCiLt8zNMbV+cG3tHkSE4WDN2batAjS+aYUEfrdpj1FkQ==
X-Received: by 2002:ad4:5766:0:b0:6b5:2655:4518 with SMTP id 6a1803df08f44-6b5b70a3b52mr120676236d6.20.1719920559393;
        Tue, 02 Jul 2024 04:42:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.206.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e576915sm42641436d6.58.2024.07.02.04.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 04:42:39 -0700 (PDT)
Message-ID: <6683e7af.050a0220.db00a.0c2b@mx.google.com>
Date: Tue, 02 Jul 2024 04:42:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6042845060377046721=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [BlueZ,v4] obex: Move size emit signal to plugins instead of obex.c
In-Reply-To: <20240702093523.12158-1-quic_amisjain@quicinc.com>
References: <20240702093523.12158-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6042845060377046721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867473

---Test result---

Test Summary:
CheckPatch                    FAIL      0.64 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.98 seconds
BluezMake                     PASS      1710.56 seconds
MakeCheck                     PASS      13.61 seconds
MakeDistcheck                 PASS      180.60 seconds
CheckValgrind                 PASS      255.12 seconds
CheckSmatch                   PASS      359.73 seconds
bluezmakeextell               PASS      120.97 seconds
IncrementalBuild              PASS      1488.37 seconds
ScanBuild                     PASS      1027.41 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v4] obex: Move size emit signal to plugins instead of obex.c
WARNING:LONG_LINE: line length of 96 exceeds 80 columns
#120: FILE: obexd/plugins/ftp.c:178:
+	if (obex_get_size(os) != OBJECT_SIZE_DELETE && obex_get_size(os) != OBJECT_SIZE_UNKNOWN)

WARNING:LONG_LINE: line length of 96 exceeds 80 columns
#134: FILE: obexd/plugins/opp.c:90:
+	if (obex_get_size(os) != OBJECT_SIZE_DELETE && obex_get_size(os) != OBJECT_SIZE_UNKNOWN)

/github/workspace/src/src/13719323.patch total: 0 errors, 2 warnings, 27 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13719323.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6042845060377046721==--
