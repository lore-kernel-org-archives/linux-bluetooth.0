Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2350762EB
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719602197; cv=none; b=QMSj+fl25Oo4ENga9pdCSY2UCyiaHENwF1IR4SpIQjrABjeTr2T1jSQUIfyrhqf/p2Nqx8Rzu9qFUsGOBJL9ImKo+NllXlDFWbmyZR+W4iyWzUG90P4wCoUdY9y6jQ1RKG2eUW+DB+LS0KN6igm4ZZSynwF1ez9z1qjJHAFGdUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719602197; c=relaxed/simple;
	bh=iIYjNYvgbx0rYOp8Ly2SI0d9ZW6CJ4nD1yk2zJKZDBk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qrBz8uzmxOkqQOlOk0T2RRcuHGqoZ88lp1994qwk3sMblXcN2gDNwfzsbaHl8vvRBz5lKEUSfXSSvES1/aPT4ox/gMuThlnlNCKhH6qWlv7gAQQgQfJY0AmK/GdfNHGv2cQgTUL5K2M2rnlRMS3a8cq1gQuAvWzO4Ro9qkGTOPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBMInEWc; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBMInEWc"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-79bb8dc530cso77757885a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 12:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719602194; x=1720206994; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T06GZZIP5lqDYLOeuCar8gORbrEdBPr4XLGPKFATy5I=;
        b=QBMInEWc+yJMDU7xGoVfM3KhBwV5lcv58a3fs3DNU2FCQ8H0vGgFbe0K8GO2WZMRtu
         8piyBc8Od8zXuIfO0YEki8hbp/RGtinTj+N82fiSoIza0bGsAITtwPLW72T3RAzU2ufV
         DwaY51Pm49hZC0+iUxnw1kjMfjEA4aQ9gkQHdztDZQkicwDY5mGrKIBFO8dSckP5srPM
         Sts5Gb3f8OjxQb8cRCXIu0V4vnEyMSvG8kO5HtwyMierVOkE0vcDFFcC28SdaJc3sk+8
         IDZfgwlQfRtOpBpzG/MR8fCbNyqtK/aFEk/cqqbVbcrJEhoP2PvagYT/BSdEaTSuPyFZ
         n8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719602194; x=1720206994;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T06GZZIP5lqDYLOeuCar8gORbrEdBPr4XLGPKFATy5I=;
        b=vZBxrsUmfm1+4RXXXhsriQMMYEQrJnXDrTrwGU6WiP2Ojvm2bt9CmtK6i394F0/+IJ
         D3Lv6DGyL5d0RKsVO7De4nBgODakzN3VDEzOT6TbBwU15P4Sl0jCKae0pBRVFrDiDfmN
         L+pHeXa+5Y9JrHLNxu/WFNeZ0m21JDA4JXIj1+rFrM3imfnqJz0yfF8ApPksZlSsYnnx
         WKAHhLqgjtdXBkW22NtoiBPgPQdUaxubQG4F/GrgRuQW7XLuje57TRqPzoM7bweP4bJX
         tFy++3j9BXMuan5NYPnGXTWeQ4uGDMODLLj/xRyYI2NmDogxW3Ui4sqFC4TR+P7eseZ+
         n7PA==
X-Gm-Message-State: AOJu0YzXlWz0DL0hw0ZFHa1M+BhHtd9pEZnfQ7PKHr+8S8VI+meHwnpW
	ME4+Ghtcw//r1RZScz5xjiBT7yZkLY3S+wZFhU34rruxUFxZp3zdyzgcMQ==
X-Google-Smtp-Source: AGHT+IGM5ovGQIIHNag5I3mlezwLA4azUsXHnJdOzhLnrwn9Gm1asTo7Bb908pQzD1l9vAAafSDqCA==
X-Received: by 2002:a05:620a:24d0:b0:795:579c:f609 with SMTP id af79cd13be357-79d6ba69f7cmr465680985a.19.1719602194562;
        Fri, 28 Jun 2024 12:16:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.46.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69295cb3sm98041985a.55.2024.06.28.12.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 12:16:34 -0700 (PDT)
Message-ID: <667f0c12.050a0220.300df.5288@mx.google.com>
Date: Fri, 28 Jun 2024 12:16:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9019845343593559192=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/2] org.bluez.LEAdvertisement: Promote experimental properties to stable
In-Reply-To: <20240628164701.626148-1-luiz.dentz@gmail.com>
References: <20240628164701.626148-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9019845343593559192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=866685

---Test result---

Test Summary:
CheckPatch                    PASS      3.46 seconds
GitLint                       FAIL      1.02 seconds
BuildEll                      PASS      24.75 seconds
BluezMake                     PASS      1650.38 seconds
MakeCheck                     PASS      13.34 seconds
MakeDistcheck                 PASS      176.89 seconds
CheckValgrind                 PASS      250.18 seconds
CheckSmatch                   PASS      350.63 seconds
bluezmakeextell               PASS      119.05 seconds
IncrementalBuild              PASS      2992.84 seconds
ScanBuild                     PASS      996.19 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,1/2] org.bluez.LEAdvertisement: Promote experimental properties to stable

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (83>80): "[BlueZ,v2,1/2] org.bluez.LEAdvertisement: Promote experimental properties to stable"


---
Regards,
Linux Bluetooth


--===============9019845343593559192==--
