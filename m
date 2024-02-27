Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812373D541
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 18:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058064; cv=none; b=CvjijIlPhp9GuZasMsqv2I78DFqd1Q9X0WE2OkLgoXOaIS9k3C8/mccZ5fQ6/yoqtszAWVWMpUVK+49RHREocB6MVum37ltpajzBY8B8WEEi8nn2oZjwbX4T8xTwfPOiAsgWEulvHMiolpCNwILL3dHl5inMYTHkOZceXmfq2RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058064; c=relaxed/simple;
	bh=Q+ZXUxm9qv1HLEUJeP73l3slPtjkottmZrXGDLDXkAI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lLAsOaud8uqV/KVqFtYZJa+DhBIoWT99lOIEK2h6IBPIyXydXqdpHd8ayLlG2AP4j/S7rslQX+decr2uhfEKAUx2SvDV7ZNBHCEDVs9pSnnKHI1NVZ1pMhni9SnKk07kgpIpLhAfAGQJsDEs6WcyrKk0g2z8HBgoGxCWQyw4UvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYIXsAfc; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYIXsAfc"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so4097991b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 10:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709058062; x=1709662862; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EmqB7ZFJr/OWy7r/QhiZSnp+XUYNchxGR1tTqObRMqM=;
        b=ZYIXsAfcwNDzY1+9Zed/JMEjhBRvYnmtO3CKV34RYLkukbGsslM+gtpA+ZRlmqudQU
         7QfNmNHxbErBNt+smO6wHnyDFa2HhL1RTh52lHg2HzQz4J4u6vlErigTcOazRz5vFtom
         5l1yGs1GuegoKG9e6NfaIN3ocwZIstjpKYJ4UrR/xZjFOtIWUz/bDWHggwt1BZa8lXeO
         NxTf3HypmFCwlvc0Qyc+kqMJJGz+U45tk2DlRnXxxqmpyY2EzEC+Vuphlkktsq2AiATE
         GZAYfsmDJZsYPIysFhcZaRk+cu36RDDAnBu2bzhstL++Q7bhihYDvjvXmorBGXKD5GPS
         xC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709058062; x=1709662862;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EmqB7ZFJr/OWy7r/QhiZSnp+XUYNchxGR1tTqObRMqM=;
        b=dBoVjZ3dQJpOwzGqcF/+0IecDypsoGcmPcNE7LLt84SiaYAMDuxdEUnR5A86oreiuN
         vY2LztH8YCRMdeXYibUUUTZrxtMaboxbmEImOpdIaaddM9p9FnU/tZRbnaNDkpF3IQKh
         mfspDNz0GSSavuNycbNUYjwqdTjDN/LWA6NMWhn1Zf0f2vydcWEgxT/7p+rXToy09iEh
         zhEl7s9iCgBTySXUrrv8z8LjdQRIsjjD+Kx1pEABD0vQU1fYgwW2XxM4wXd9RQRXqXms
         G92HkO73s/sCoiiNWW3ihqZ6iVNw94shO9YzGvC04H6NiBDeZWtq3m0m+EknqLFzwyxk
         bypw==
X-Gm-Message-State: AOJu0YwKhR2Our3Clo22HF+z7qQF80IESUOBQLKbcgP7ZmDP4tfhMqiE
	8YF8Jkd26WOoY4242TS1PWEiSrNZwhRPizQevrcskwqO9OsEXM1LGmdf0iYQ
X-Google-Smtp-Source: AGHT+IHW9ZN67+5dSpdWTT+ochuNwZmhFTmcR9bvra90YFSsEn5sWSbkqRh75otGIisSZR3qs4fWng==
X-Received: by 2002:aa7:9d9a:0:b0:6e4:59b7:1dd4 with SMTP id f26-20020aa79d9a000000b006e459b71dd4mr11004481pfq.31.1709058062285;
        Tue, 27 Feb 2024 10:21:02 -0800 (PST)
Received: from [172.17.0.2] ([20.172.25.79])
        by smtp.gmail.com with ESMTPSA id y3-20020aa78543000000b006e3f09fd6a5sm6176131pfn.163.2024.02.27.10.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 10:21:02 -0800 (PST)
Message-ID: <65de280e.a70a0220.1d3d.6855@mx.google.com>
Date: Tue, 27 Feb 2024 10:21:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7534574916838206710=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] btdev: Fix not resetting big_handle on HCI_Reset
In-Reply-To: <20240227164403.1904213-1-luiz.dentz@gmail.com>
References: <20240227164403.1904213-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7534574916838206710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=830344

---Test result---

Test Summary:
CheckPatch                    FAIL      0.85 seconds
GitLint                       PASS      0.42 seconds
BuildEll                      PASS      24.00 seconds
BluezMake                     PASS      730.29 seconds
MakeCheck                     PASS      11.79 seconds
MakeDistcheck                 PASS      169.51 seconds
CheckValgrind                 PASS      232.43 seconds
CheckSmatch                   WARNING   338.75 seconds
bluezmakeextell               PASS      110.48 seconds
IncrementalBuild              PASS      1377.67 seconds
ScanBuild                     WARNING   989.44 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,2/2] device: Consider service state on device_is_connected
WARNING:LINE_SPACING: Missing a blank line after declarations
#127: FILE: src/device.c:3285:
+		char addr[18];
+		ba2str(&dev->bdaddr, addr);

/github/workspace/src/src/13574121.patch total: 0 errors, 1 warnings, 25 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13574121.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:434:29: warning: Variable length array is used.
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
emulator/btdev.c:1099:10: warning: Although the value stored to 'conn' is used in the enclosing expression, the value is never actually read from 'conn'
        while ((conn = queue_find(dev->conns, match_handle,
                ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
emulator/btdev.c:1386:24: warning: Access to field 'link' results in a dereference of a null pointer (loaded from variable 'conn')
        pending_conn_del(dev, conn->link->dev);
                              ^~~~~~~~~~
emulator/btdev.c:1508:13: warning: Access to field 'dev' results in a dereference of a null pointer (loaded from variable 'conn')
        send_event(conn->dev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
                   ^~~~~~~~~
3 warnings generated.



---
Regards,
Linux Bluetooth


--===============7534574916838206710==--
