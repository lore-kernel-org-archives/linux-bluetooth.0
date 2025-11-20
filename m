Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBB427F736
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763649756; cv=none; b=LIuaH8I1PAT8C2vWqR4brWJ9umXEcV7XiQLtlZDIhFMgrzKEU86U8c6JFlXv1s0P0I79r0W6mcbdIpamkYIfu77S1oGLYuz79eV4YGq8bUEW/AIyV0Z9skCpwQs9v3m5FdIYY9GY6jij/d28tX71LZSMLovKQKXUTtj+GJL+fOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763649756; c=relaxed/simple;
	bh=qVWVQehVzivEgQW4TTik0WBPqMi64cjIoVcj0BY03J4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nVrGqZQHwaxiW/QPGA6QzknXdsMZt4lqJEiUnDGqnBcpQR+ExHNtcw8CD9wijg6RnGSpkTNREvujXfKTY7KVVFQREZxRw+EdfGnC4T8K8/QxgsO+IWCVgnIPH4D1nobPyCohcyziAaDgk6pEUmKyiNO2N3bQs60CPfnzuQ55w40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kq5ByOS5; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kq5ByOS5"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4edb6e678ddso10943131cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 06:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763649753; x=1764254553; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+IDXkrCKunuHRc+tVxh4CGOAcvWSpXCJvomdCmbHOKI=;
        b=Kq5ByOS5j2x5ooqsqVxX10cmvz2DSlUld6QUdxIOMfBU27hPQKk0mQpp8QxNx1P9Ec
         cccUUXmiEfykbHQ9NUCJPEeBhBqIHSQjHw8mWtM6dXH4beETc5o/IbUeAdqpFQDWtW+y
         ur4RwdyYx8Ja2Nn+wWoRUgdo2B85ZQqxccCPkZuWSBRgF/CD0cVs1X9tDYtlB1iozkN4
         ufWiNibr2FPai9LZWC/yPdJIezK2DfOUfB+0d3WEWRCMYxc/BRwFIHYvNv7Cvre+XAve
         OLOXibM2Vx2kAv1IzLTv88yRSX14Sc/h7OY3shlpYbzy8mRzJZL2wy441IaUXKWbQVvs
         YwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763649753; x=1764254553;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IDXkrCKunuHRc+tVxh4CGOAcvWSpXCJvomdCmbHOKI=;
        b=XMblBIDGtob7y0DuNxorB2YSWXLI4Xkmj54UdBevU5K5kLzP2i6pAYT/A5G1Sp8IlA
         b9Uexy1RsHgQAYnMOe12UVKOEzrmoQRvS/egyXzjIAvgfwqVCHr+Nkyb26c5hgiQrYFM
         e/BO3Hq47/Apnh1TmQ6T1fFJXyeeveafoJJJIQhBEsXk+/gGo5kTz51UylCw6Z8adhmL
         oDulNB7OCTkO9zaMs9JO9x5IdZWhiZQv5IJvnhkuiLclZeeszcOsaTNwmg+Ki5NOHunZ
         DlMOWJcq/A+oEpAppCFg0rvP9yWihL3U4rsZ1AECTNT1Y3Drxlu2svbPp5m7r79WbhsH
         Ycxg==
X-Gm-Message-State: AOJu0Yyam4r73aHsPTOWkmouI2PkyvhnTr8rsl8XVbSnQ1GcOnWdiOZh
	3dqrDZDyjKm9LLfdpBnkE4+oTE4k9Lwe1j8eDmSv9ppruNKgqNK+oOdmqlksHg==
X-Gm-Gg: ASbGncue0uKWYAICXaF5jZNabUgVHgB4HDhOpFdy2uXzefYx9UAsu+pesXjxViKaqCG
	gesab2f9XtEHl59DXohQ7iEurczBvDvIsT5nUkuBOCyKdKxGQ28fkPLJ84ksTcEKprKz9u3qjbM
	kQBigA/QJp08/7JkpqHYyOAXn0qfg+Vx4xtvGe9q/fbpOliQY0B7uX/COEwveDt3v5EiVlKB2NM
	jGbfgpwSeMnf6Q9p/6mJo5baECQczDhuC6nAfpCOlqr6WPgY+JA52iTeXU80W1hZzLwSd63CSRE
	bej9fqW4Nky23jM9wFLgaWEFowfabEAfgj7vPWgBCewFIUF1hERIY9ZUVxrAKUwdhsmc00bdWZ8
	vAv+gzmsmjkmvEdjtxKY3ZaJTt6os8nODkTaKuWMH8vqtN/ijM7V/SGcRdeIu9Li4xU2czwk6jA
	qqAKPfCLVVy5lbgONI
X-Google-Smtp-Source: AGHT+IE9ngJte0dvRm3G7RI3nhiJ/7jb5mKBKbm4LMm6eqtvltTarv2fTc1bBN8/jtqBuYyMRYh0Rw==
X-Received: by 2002:ac8:5d4c:0:b0:4ee:1907:13ed with SMTP id d75a77b69052e-4ee49705856mr35419011cf.51.1763649753098;
        Thu, 20 Nov 2025 06:42:33 -0800 (PST)
Received: from [172.17.0.2] ([52.150.29.102])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee48d3bcc4sm16254331cf.6.2025.11.20.06.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 06:42:32 -0800 (PST)
Message-ID: <691f28d8.050a0220.64d68.484b@mx.google.com>
Date: Thu, 20 Nov 2025 06:42:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7845341082615234354=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/5] doc: Add new telephony related profiles interfaces
In-Reply-To: <20251120135417.820220-1-frederic.danis@collabora.com>
References: <20251120135417.820220-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7845341082615234354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1025836

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.43 seconds
BluezMake                     PASS      634.20 seconds
MakeCheck                     PASS      21.36 seconds
MakeDistcheck                 FAIL      43.78 seconds
CheckValgrind                 PASS      301.06 seconds
CheckSmatch                   PASS      344.97 seconds
bluezmakeextell               PASS      180.63 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      980.55 seconds

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
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

../../profiles/audio/telephony.c:45:10: fatal error: telephony.h: No such file or directory
   45 | #include "telephony.h"
      |          ^~~~~~~~~~~~~
compilation terminated.
make[2]: *** [Makefile:9044: profiles/audio/bluetoothd-telephony.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile:4111: all] Error 2
make: *** [Makefile:10553: distcheck] Error 1
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7845341082615234354==--
