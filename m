Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C58321FF2E
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771444098; cv=none; b=MERXx0amDEIx/svx930m/dYInstOo3ftTTIu04iJnMev54BRvyIjAS/0f9KW359JpZkGvcbBYTDLuOdVPERg41u5iwIlMwX/smdQQDcUycM+UwDuBi3sxZbFBL6qRbANRrDg2XXuLjnMMDGgSCCdJ6DiTHtnOatli0k3ucNQrN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771444098; c=relaxed/simple;
	bh=zRRPYgs7mosNX9WTZOnqBn9e+7ZcY0QJKX1yBtbYuRs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aUfMBx9L0xIIGEiHK1OITbsgS4QbHAW7TqME1j3PYpLaGh97Fz+rBeRLmJJzZCInqer9wJ9dU57oX3p9+77Z0+FNz8l07LmOk5QjdHGSfPFCxDkQQKPLjJzbn60D5m+EmdKUddvq9sKCKpyN7t4d+ZoSs+qjYo92dX5yovA7hhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfe1D86E; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfe1D86E"
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-506989e8516so1144431cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 11:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771444096; x=1772048896; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qYkuZPvCvkR+m8V4dzAUlqRxAWHrE92Wvk1/9KBYxdI=;
        b=nfe1D86ETXuBLN0Sn6lvhK5R2xIttoWZH+/AVl9eLIya8KHwKgepqg/o82jb8wFQCe
         PbMhv0lCc5h2FDop78gxZPbG9DeRd7sKFr+0hS7DPUgCZquhU+8kzD09yize6L1ektrY
         GH6B0FSs0S5Xo1J8Rle+nU2Ud8Niw4xjedVBWJ924NHb32BpYg9ehR77oR5iO4psuBCZ
         f4dqfqT2A6UYLuutp56jQlW7UMvux71DtGGEGSHGTYENYUBgdvPw+v6/cWImcYix245t
         DlcZtKUs7evqoQSajOdPh0RMtQFcpuIokKsA6y+WpOz1K9APW/Iu9RfpiEs5/FYGkgaj
         KZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771444096; x=1772048896;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYkuZPvCvkR+m8V4dzAUlqRxAWHrE92Wvk1/9KBYxdI=;
        b=Ht+ZTNbLuY7h0cZvNIZ5lTU6TUvCaopZo2hmBn7zrztaoRqH6m0V8YiCiFzM7qiTAZ
         l5YZibWIOz4AG0f9aA9FtuLxkhYWVmvyjYzAn0WkCAQ14VBkP5QR6v/3X7f3H9+kYKId
         TEgMiiIRy3NnIoEGcFY/XXlQi8nBtM1nBerpPz+jSLXEPEOBKQ1g48fM+S/g+x8zg74n
         2s8oTSIrYdwaORRTISynRUgAl8qY2vNSx0eu1h5Rw4tHV4YVbPAx5hk8VhlXov+YizHI
         wrtUsEPAoAKC5SkUDeVEnIBDXGTC7BfmHG4ceGLDheAk6rUlfm5FOkE+7AafTR++Oxuu
         iRpw==
X-Gm-Message-State: AOJu0YyoTVoVbJSXmA9kQKbtsgNhuxeakR1kBq2VUGrg6PDb/o+sSQlI
	FIew6jHXs7oALZq3pJuKK8jzDz6LEHXvuIvmdz0gSaUbhrgBYx8W8GR9rKaaGMMY
X-Gm-Gg: AZuq6aKltzGUNleZUxw3CwLLB8We3GNPHi0W+OuiBYyOzMxMf+QkcHapzDT7kFnNgSk
	RzT8yyIDOqrNddvmP0jERS+7fCjKDH08SMgvv318VGjTybF+twUGF7+R4lcUNJwiFV9bJijxllA
	TJU5QaDZv1eymGWjg8HYe5FFs2XedZnBz8Rla+/lOd6QoJgUgqjlRpVfqzDN21NDAoWUAWMqF6S
	tRJGwMMEaU7+6gCnd0N3s3PU5oFjqKLD7xY5rIcQG4Y4jcQALs8tMvzwtsKk4Z6XlTlcvtNcuH+
	OK0NaYBd6mHbGmAQg/3UNpoCBSZmjhixEGOIuv4mj1H88AGLDSrGIjvcZwKG2t+d/bp0TRcxOSs
	jyJ8CbOabh3oDWL83UzLbXNQMp39SgJbc2zovq5d2jKMVbxVRY0SNL0Q2jETbNLZ959Gy92O19j
	CXXLEh/t3+cOcbMZtwd0EyLF7tl53E
X-Received: by 2002:a05:622a:11cb:b0:501:466b:5141 with SMTP id d75a77b69052e-506e91922f3mr40168661cf.18.1771444096165;
        Wed, 18 Feb 2026 11:48:16 -0800 (PST)
Received: from [172.17.0.2] ([64.236.161.38])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cd8d1e8sm255807206d6.24.2026.02.18.11.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 11:48:15 -0800 (PST)
Message-ID: <6996177f.d40a0220.30cfa9.b208@mx.google.com>
Date: Wed, 18 Feb 2026 11:48:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7677158927127852105=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/5] doc/btmon: Add missing documentation
In-Reply-To: <20260218183110.2840582-1-luiz.dentz@gmail.com>
References: <20260218183110.2840582-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7677158927127852105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1055296

---Test result---

Test Summary:
CheckPatch                    PENDING   0.49 seconds
GitLint                       PENDING   0.39 seconds
BuildEll                      PASS      20.88 seconds
BluezMake                     PASS      651.98 seconds
MakeCheck                     PASS      19.25 seconds
MakeDistcheck                 PASS      246.20 seconds
CheckValgrind                 PASS      297.28 seconds
CheckSmatch                   PASS      362.17 seconds
bluezmakeextell               PASS      183.61 seconds
IncrementalBuild              PENDING   0.56 seconds
ScanBuild                     PASS      1029.34 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7677158927127852105==--
