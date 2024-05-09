Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D468578B4E
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 May 2024 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715281452; cv=none; b=Dd/h12jtLioI98xwduyiFTFEgtAaut7B3kfPDfXtZoBYKYNv4PHOHxv01b1sKeJrfGtaZ2GSBT0p6ru+pMmMyd+ZnCj1RPMaNbUoVz17PuYZq3dCZpjWISKmQsbVcLPsiw0INL64G9Tp1Vot1i4OgHp2yWk+OT684qlWN57YZKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715281452; c=relaxed/simple;
	bh=r+mox7CvMapnzzsf2t2r4f9O9n9LZUjOsrLaSSux/Yg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cBEnuf+4tUvTSOz1nDJZsmoxougSAmeMCmr32C2jOFfWKuUYck2ZGNBt+wQhOrIT/t4MYfpbrvNVQFIxwFw6CzcRMcDdfuaqh0wD9xFs+nW960V/uX1ttIMqRivSFdiGii4/fTxwsuRHDYDyQk6D/hHCZJ8MZVu74Q9HaFVN1LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZFpcGXd; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZFpcGXd"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-792b8cd0825so106229785a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 May 2024 12:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715281449; x=1715886249; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S5rQVEosgUfZKZONN7bXMv654jhinAzugetgiCkn/cE=;
        b=IZFpcGXdZgEMowga+vJXlIP3nq+Ss82R2OzznxW4Zq9L02H4+7mfpaNlXnhAPxhAis
         n31Qh1zFA8cdjM4Hkqp4j8VrEfj0aYvpdJmvYEOrSEc2pc0hrL/5Y4k4Vl15hIeDVuHP
         Ex3aLVW/O6lSeSFSWki8V0FOiYX+bEDICBqpGtKjVmxW0Vq7D2H56HfeCGjtL7TDLG/n
         pXZ2cX6e46T6fOvq8sSlkTRXqVDuxa3U+LWhdjSJX5SBxGSG++n9eIrN0RhJSAdB9C8Y
         f496K3b/cCLIZ8OzofcpVwrjJZ/v0yJbaGtezP9EA8HdkdEZjgwX3ymmPbiGvJaaNQC+
         EDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715281449; x=1715886249;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S5rQVEosgUfZKZONN7bXMv654jhinAzugetgiCkn/cE=;
        b=MbXLQAKbNw0NLLSPz3VFg45+r7e92o3TrXq0dZDenQnCXT5m14fj1CZqvAUJ3p/iEw
         ShQN6G6hhb99/ba72LAgAIRipAPZ/sQgLYrV0VzjjC19Ht3QiqgZIbLiR6f/zaSVRrKw
         8Vdps7pnzCC+qmkOzhuBBkO3Gr/G6HdQsA0aJUXsf8RjXOmuqRVrfyimiCr3SYdTPD9V
         2EpJStwDYNernbyBfH15capwuxcwVkdyTgLrHOjIqtVSLTizbUytKMj32vKNmDSssFXh
         Kq6KCSCD5hN+cjgFQOSSmJqUy5vA5pwRR5eKjwEKiaKWpgxLlaBRC11L2YcS6PT6NYnS
         FzDw==
X-Gm-Message-State: AOJu0Yz6HjDNU0yqo3ROMQPNlPLvhIL9F7/Lf9ijR5iBScI06AcAlxQQ
	PInCaFNL/D+AF+D2C1vg7m64iSDOBrPo85GOR1yTuwFkBIUj+Clm/8S3ew==
X-Google-Smtp-Source: AGHT+IHoeWkJlYiqg11whoneRjG7GsW3UwnZGYM/j7ZnzaQ2VHhzhTkXaHM/JyLoeT5JqFpKXEmmTA==
X-Received: by 2002:a05:6214:4805:b0:6a0:c903:7243 with SMTP id 6a1803df08f44-6a168253247mr2706146d6.55.1715281449558;
        Thu, 09 May 2024 12:04:09 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.132.80])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f17a3d6sm9672726d6.18.2024.05.09.12.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 12:04:09 -0700 (PDT)
Message-ID: <663d1e29.0c0a0220.d1196.30bf@mx.google.com>
Date: Thu, 09 May 2024 12:04:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3352797716302083476=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ajay.k.v@intel.com
Subject: RE: [v4,1/2] doc/ccpTest: Add document support for CCP test interface
In-Reply-To: <20240509231839.3005270-1-ajay.k.v@intel.com>
References: <20240509231839.3005270-1-ajay.k.v@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3352797716302083476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=851987

---Test result---

Test Summary:
CheckPatch                    PASS      1.29 seconds
GitLint                       PASS      0.55 seconds
BuildEll                      PASS      25.41 seconds
BluezMake                     PASS      1769.40 seconds
MakeCheck                     PASS      13.25 seconds
MakeDistcheck                 FAIL      183.54 seconds
CheckValgrind                 PASS      259.91 seconds
CheckSmatch                   PASS      370.06 seconds
bluezmakeextell               PASS      127.54 seconds
IncrementalBuild              FAIL      0.06 seconds
ScanBuild                     FAIL      0.17 seconds

Details
##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

Package cups was not found in the pkg-config search path.
Perhaps you should add the directory containing `cups.pc'
to the PKG_CONFIG_PATH environment variable
No package 'cups' found
libtool: warning: remember to run 'libtool --finish /github/workspace/src/src/bluez-5.75/_inst/lib/bluetooth/plugins'
libtool: warning: remember to run 'libtool --finish /github/workspace/src/src/bluez-5.75/_inst/lib'
ERROR: files left in build directory after distclean:
./doc/org.bluez.CcpTest.5
make[1]: *** [Makefile:12185: distcleancheck] Error 1
make: *** [Makefile:12116: distcheck] Error 1
##############################
Test: IncrementalBuild - FAIL
Desc: Incremental build with the patches in the series
Output:

error: Your local changes to the following files would be overwritten by checkout:
	doc/org.bluez.CcpTest.5
Please commit your changes or stash them before you switch branches.
Aborting
##############################
Test: ScanBuild - FAIL
Desc: Run Scan Build
Output:
Setup failed


---
Regards,
Linux Bluetooth


--===============3352797716302083476==--
