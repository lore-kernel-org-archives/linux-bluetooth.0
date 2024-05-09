Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD2F14A4DA
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 May 2024 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245189; cv=none; b=GTT099EikvuQuzmDEu08j6Vlo5gxlSa315XRF2EbaiV/IHj+O9/wz9Nd7KtX8nJnfOz/puioSGz9D/H8MbLC44E1z0HuO33ny1o/dLUKSdbaQdRWT3KOXDKuf1Yat8vK536gHSpvvwuvrQGygC8M8wXIzC4ZUYQe1ScxaSZG8V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245189; c=relaxed/simple;
	bh=mxpQKvy7FY2BN2yHQT2XSiioB/1XQdMKrg+nnKVv2fI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pu1oqMNA/9bgRrAgjcY6hylCrFgD/6yYEN6Nf7W5o3qU9+htB0Dyr8kgJebNjAt6YDsXZrLb8PWgyhtp3jr8kFusuX4qjZg6VAuBvf3FbcSmN0k5AUsIxNKFgjErxBgqliSlRVuA8YH6L2T2nGbz9Ds0daxo0/Gba8iQckCH9as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2F8k7P+; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2F8k7P+"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-61bb219737dso6013607b3.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 May 2024 01:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715245187; x=1715849987; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QrdiDsRU8DUl8erYFH0FXtMuekucsNcqllJryw3RStc=;
        b=L2F8k7P+M85JsgIKvawQKn1dZRc4cLF9Ayrw6hglcTZMHnX40qGp4mErYrv0uD53lT
         8QeyEJzEs3cdygWDeNObcrcecwgscFTesL8USwDwGEiECaeTaanYrp3hiC/XLbFvrbQ3
         /mY4Lf9Lj5W4jYc3p7+XktrvxhqUo99m75QwqAEwjRmQPj17dgbJjk2UBx4CUeLHRgLZ
         ZLPoFPjW0rJ1qCDO2eXodLzYyN2BRHHJ5Z86J7CWJCdpythIhkTRBuXCzEzcEY2d3fnM
         Q12UX9d9gPrkG/srTOc7Wn1Bh1QgUdJmMoR4tz7ALGqTYY9FCBc8f3wJszXKc6danVg+
         CigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715245187; x=1715849987;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QrdiDsRU8DUl8erYFH0FXtMuekucsNcqllJryw3RStc=;
        b=s8ZX20Jqeh6donnokNKF9cVquK0tkGSTRIHXaCbajDVLTi/I1kfQmN52tIzNXbczfv
         cgc/OXGZTrQ0teHp3OgsoKJc5qdeQ5fNoxdbaDyAH5PrhzLukARn6H5yfdpaVJiJxUKK
         4Lou8un4VlO3ioD7zBP/mWJ8KGSrVlxUsWd5ri22HTtPCPyS6WJEMU9cbxMLR9ePnDLd
         uUa/XB6CerSofpnp3j+/RLSR5kSOOimLDOrXZqHRaO6OZXL17J9kGAdzX0R3MuKDGpUP
         MTorPBcHOieoIMrKY86TO+Ol4I19yKicDZT6FM+/0TmBfmDJbpWj/LTcrg2zwqFYq31L
         k/ag==
X-Gm-Message-State: AOJu0YzziO5mXvU+3m0yiNA/WT62AX0+pBc11j55kZPnaOXO86KRjEqZ
	a4u4L8WZdploI80annUyrNRFxIib98jccUxP7SIgGR1VLS4Wp7gCVvWb0g==
X-Google-Smtp-Source: AGHT+IFESL63aQZESu33MSBtBO5ylRGtF0jrS167t6E+lwaR6lo4LuvurBlCAyHu/HKDu78wi1ol1A==
X-Received: by 2002:a81:5b02:0:b0:61b:33e1:4eee with SMTP id 00721157ae682-62085d65109mr46378097b3.14.1715245185583;
        Thu, 09 May 2024 01:59:45 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.13.141])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df5397e7dsm5856911cf.0.2024.05.09.01.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 01:59:45 -0700 (PDT)
Message-ID: <663c9081.050a0220.c7511.1226@mx.google.com>
Date: Thu, 09 May 2024 01:59:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0428637960883915597=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ajay.k.v@intel.com
Subject: RE: [BlueZ,v3,1/2] doc/ccpTest: Add document support for CCP test interface
In-Reply-To: <20240509125855.2585411-1-ajay.k.v@intel.com>
References: <20240509125855.2585411-1-ajay.k.v@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0428637960883915597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=851799

---Test result---

Test Summary:
CheckPatch                    PASS      1.13 seconds
GitLint                       PASS      0.66 seconds
BuildEll                      PASS      24.45 seconds
BluezMake                     PASS      1666.92 seconds
MakeCheck                     PASS      13.89 seconds
MakeDistcheck                 FAIL      73.95 seconds
CheckValgrind                 PASS      245.74 seconds
CheckSmatch                   PASS      349.71 seconds
bluezmakeextell               PASS      118.98 seconds
IncrementalBuild              FAIL      0.07 seconds
ScanBuild                     FAIL      0.20 seconds

Details
##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

Package cups was not found in the pkg-config search path.
Perhaps you should add the directory containing `cups.pc'
to the PKG_CONFIG_PATH environment variable
No package 'cups' found
make[2]: *** No rule to make target 'doc/org.bluez.CcpTest.5', needed by 'all-am'.  Stop.
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile:4657: all] Error 2
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


--===============0428637960883915597==--
