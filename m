Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E941FA2
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Mar 2024 01:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710208473; cv=none; b=EAWL+JVknyH5W4mNC4SRV7WOxdng7EKw2sxdSdxsFWTCFUH2vjmWva7wZUD5wjQP4JK8xukfqJnZcSpufKbmoi1BKBq85NTxoosJ5ofT38E917RSEGVaoR64dlUgu669KNj7osRhXIVa0UbJyVAIGii7o3msB4WeNBwmmtjfN4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710208473; c=relaxed/simple;
	bh=in3WCtfYS2FVSZBiVi1QxnDKB+bThaOm1Q4RM8r/Qv8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=T3MRM42kkeIZq02THY9DNr8HpsTjsx/ldug1Frlz2UwdGRDaeohdDuMu+7uSrHIP2uiGAZ6IpHzhpVW5akZ8KMEAU1LuhQkq8NsVS+0BOTMmDnbPwnOJfkNZxTqOpHOSP44AQOBjNbq7oYVma37ihX+PVQi/Ce7fTBGa4v8onK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFF2y8WK; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFF2y8WK"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-781753f52afso358095285a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 18:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710208471; x=1710813271; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UHQXU596QmCwFyU2lw6iZUnRI51WpIS4/3G+yYjjU+A=;
        b=eFF2y8WKx8wTntxyaatvawbK3+0HWeIaOKH12unsuSKKowkW7vAoUIATr853lXKS3e
         4uc5LCWaGSaZ0YRM0CvXLQX/ChyijMuuJ4rDXgFz0fWZw93Ny+KTKYJx0TDeUJiW5BFE
         Hp4mBMaP0Gz9qcpGTHW3r1UvsRxgaL6EOskCLHVsd3Dx1zmMRkYlj0yCATrKMYKt9drB
         Kk+kKBv/JvsR1fk/RMhaQ8oaludLN78FkmChnusTg4e4/7W+AscRBolN5jPOvAWg20nH
         uQ7IPxmC2gWv8PK7LoGTqL1u82oYxcGVUYzsF3p39b70GqbBlvc6K2zTkhK9+8HgKr6R
         UIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710208471; x=1710813271;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UHQXU596QmCwFyU2lw6iZUnRI51WpIS4/3G+yYjjU+A=;
        b=vhGPa8nTgMBe+VfPu3Io8g69bIQtQMggLAfwcviZF/OVnXcloIIn/CzSYCeni4OZK+
         IxCEczxEEGgWlJI7VM4vdZ9pBZQsvxqynEFhuBswMf0wNi6W4LhU5sDBP4bYpUttAuTy
         0ZdiHOsUFf9Kq0YwusD0v7oyG0Cw0m4ZTFYTypkY0lDwipaCGPobYmTC+hEdMIFu91sq
         SMK/dsYd5vnznU2sFoG5Y9DwC7QB9+whPME6b/vJaNxNZaeZ9bR3nK88LWtzRZNGNGQc
         EYDhP5A5rFlnzqkigGsIAIOErvQRvQMJ3hkRIfNLcHtf3kNQXps0D7avsGODT0Nex62p
         sqFQ==
X-Gm-Message-State: AOJu0YwwfWZ7LtGFB+XknbFIAJZ7A0ufYfnRsGplMgqazUN8ZNMYYVSE
	UudEzOdpiz+F9S93PEETxS/VaoP4GIh/m7EBnSgQve3XHLZ9g3A5qslCJVpI
X-Google-Smtp-Source: AGHT+IGWRrlV6tXRcYL4s77y4r04eQjumsJ9/h8D0nfrwofwokBcOVMigtCp7FahCz0X4DW4F/8t+Q==
X-Received: by 2002:a05:620a:a93:b0:787:bb73:7b0c with SMTP id v19-20020a05620a0a9300b00787bb737b0cmr9364752qkg.58.1710208471146;
        Mon, 11 Mar 2024 18:54:31 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.13.182])
        by smtp.gmail.com with ESMTPSA id g29-20020a05620a219d00b00788622ebf52sm2725133qka.85.2024.03.11.18.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 18:54:30 -0700 (PDT)
Message-ID: <65efb5d6.050a0220.d284c.a9c8@mx.google.com>
Date: Mon, 11 Mar 2024 18:54:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4597949901970277249=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v4,1/4] shared/uhid: Add dedicated functions for each UHID opcode
In-Reply-To: <20240311224327.1023070-1-luiz.dentz@gmail.com>
References: <20240311224327.1023070-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4597949901970277249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=834468

---Test result---

Test Summary:
CheckPatch                    PASS      2.00 seconds
GitLint                       PASS      1.22 seconds
BuildEll                      PASS      25.08 seconds
BluezMake                     PASS      1601.22 seconds
MakeCheck                     PASS      13.81 seconds
MakeDistcheck                 PASS      176.59 seconds
CheckValgrind                 PASS      246.14 seconds
CheckSmatch                   PASS      348.92 seconds
bluezmakeextell               PASS      118.82 seconds
IncrementalBuild              PASS      6046.28 seconds
ScanBuild                     PASS      1009.66 seconds



---
Regards,
Linux Bluetooth


--===============4597949901970277249==--
