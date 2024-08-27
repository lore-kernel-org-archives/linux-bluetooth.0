Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EBA19D8BF
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752502; cv=none; b=dYOd27+ibXefA1OIxCCmgYpYli2eXRMLMGrCH3DqY5qbVMzWpCgNBuUYZJkUq1bwwQzg3+g5nGhs8f3to3f4UK4Qvl+gMwDE4D82D7UA7q8FCzhqfq11BK9Kmgod8mjOHDwEz4ig+CyFLX0xhkLisCn+qU9tXTacfCU/FgaIm7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752502; c=relaxed/simple;
	bh=MBElzrpto+DCEoNsVpAQ7tWj2UzOEhwKi7A9LJa7kyM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=s+t4A/ELb+TDcZ4YfMMVs6yQkWVZRoCsKDPpMd3g3Vpuewp6NvRrmvCxZuaD2weirSMWsxYeyvvJLpBa9qdlE4OjW6c/Vpex8YeehiQwtNMyLUEh6gWaqLafvZtn06w/eMYQ4NX/Qe/s7I4r4+L6m1J3h56VGF/y7V2OSOgiZuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjL/09Kr; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjL/09Kr"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6bf8b41b34dso26592556d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 02:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724752500; x=1725357300; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0yi5ys6PJC7b4gPZbA8T6NmjN1rUoUM6tMo+/IHt92k=;
        b=AjL/09KryFRAM9vb1nBgxx2MSguFzUhz3hReRa/lo64gdlhyGdo1zADEtirPIcA+Jv
         J0OhvWR07jy4ojgIlRu74eLIEcNtcwC1ofAhGzyY5dxvL7732s97g74VXBi5pgO3O6yi
         oXNKxxmgSHJO3y6mUBDiZemWsHKWkeBTWOPu6Mpd7DDYASyr8+tPH9UMpvh3xlhkNEwH
         yABuhbIPM7h9FxymcFlSg95GHTevTjG5aX89dPpm4P3wxkYCDjtUzwYOhaawNJYJlPZ/
         AXx6DpeqsqmVgqzERBSeng7cYVNKxVtVbjI5ax3sSYF5ElynMPvbKoj6v372jsDl1WT2
         vDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724752500; x=1725357300;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0yi5ys6PJC7b4gPZbA8T6NmjN1rUoUM6tMo+/IHt92k=;
        b=j2wviZJrfHISrA8sxIuCBfXhlz/5fn5apLOLBY3fTw4af9E2vH2U/zmthC8bKaUd44
         IuZmptsPtRWK06Lf6gKXZXAYc7bH0RC/NKH7yGvT/Gdz+I4AkWGdnO00gi669pvRoQQ6
         3IA6royO4RRirR4QAJWHlWF9JrrW3jhAwyknF5Wbnn2y/ZHIYVmnJXey/9NDEpXKYQ8l
         JFnbW5TZXl1iD7rjQeKZV9gIR6RpDCmnHsgPlM8mSo8Sbls9fXN49HZOkFUJTYYuIiKy
         2ku9XyuHd7efwaRktZ2VlvtYvr9NsNGmQ18Ycp7J7wn9H0AX5tZbrZELMljLdnq16K1Z
         vvfA==
X-Gm-Message-State: AOJu0YzM9zdXkfcNFtxgET6w0TO7iNNiBzsiblEmfGX8MHJnqoxwJsjP
	YIfeWWXYObSRWrebu/lL246RIA3fvrb5XIvY2+eN61S6bv7RBUHxrcbt4g==
X-Google-Smtp-Source: AGHT+IE+B3cDoyGvGQOQ0AC2tk2dYqoliHjzo3ugpn/dvL0+9pGhZmvZuvTPAoCZ14+MycZ8R1Gybg==
X-Received: by 2002:a05:6214:5691:b0:6bf:9a8b:74e2 with SMTP id 6a1803df08f44-6c16deb456emr132791346d6.53.1724752499541;
        Tue, 27 Aug 2024 02:54:59 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.111.168])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162de80e8sm54365366d6.142.2024.08.27.02.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 02:54:59 -0700 (PDT)
Message-ID: <66cda273.050a0220.2af004.2e44@mx.google.com>
Date: Tue, 27 Aug 2024 02:54:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7952802935142985004=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xiaokeqinhealth@126.com
Subject: RE: [BlueZ,1/1] att: Correctly handle negative return values in can_write_data
In-Reply-To: <20240827080925.55684-1-xiaokeqinhealth@126.com>
References: <20240827080925.55684-1-xiaokeqinhealth@126.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7952802935142985004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=883691

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      25.24 seconds
BluezMake                     PASS      1776.12 seconds
MakeCheck                     PASS      13.66 seconds
MakeDistcheck                 PASS      197.53 seconds
CheckValgrind                 PASS      271.73 seconds
CheckSmatch                   PASS      359.10 seconds
bluezmakeextell               PASS      121.55 seconds
IncrementalBuild              PASS      1697.00 seconds
ScanBuild                     PASS      1172.61 seconds



---
Regards,
Linux Bluetooth


--===============7952802935142985004==--
