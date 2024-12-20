Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF6B207A1D
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734708902; cv=none; b=ivtbazYziw1Xcg8AUsDhcETP16e947SSaOQzf4wX1oaDPWpYV2039jy/DP8rLEFw5nmOTKSl/+Zea0B3bXp48hvW/86YUgAH8aS/knXIuRUT4TaUr/qKaLU/f6BoaZ1xrbVuqj9pUHZporzvf7j/cxuOqXJv1rFR6Id0Ud80WEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734708902; c=relaxed/simple;
	bh=ZtcfPdqjObxRdaPye2Oah6a952dS/QC9c4FNwEm9Xkw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=evMLO+ldk7+hBxUBwGRzJGb8zBB7m+3SBFv7sKJ284Q6LP1FcszA1/Amyr+bZMRiBSHJFquNPYBR+91PU0+gkpOIF+hL6z+IPXQ07+27buPFr8DXuQ62q/4e70hkxPCgpvLAcNThuJ31wNFDF1bbm6l/bF6rfjMq36ISlGc2C/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnhHaSeG; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnhHaSeG"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b7041273ddso154924285a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 07:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734708900; x=1735313700; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ybujMeIc792bF+3UDDsP/7Nt9kxWYnmB+53gMRc7978=;
        b=RnhHaSeGmpXaIMkvKM9pOt9U4kHyw42rR5wJ4jH1kjeFaYxJ6DlvLhuRzQDMIq+QzP
         z9cWbNgUYug+CjBZtGYReSMUBFFqbWEUpYdo7uqSgYddMtB8pqeoH4vj4k7HafNi5mss
         skZxXZbBvBMsc6HIYMyA0ryTekF16Bq/v8HpY1OYMSJhugJ/soniPJ+q7g3Px+NxoiZ+
         diZzqt7y2jpXFQCO/t6vt7PHfDBMlJeZyhWA0xPdxzbWrdf1ur55h1saiaDzrUMgIpD4
         9GafvkCtYXHWGcBAGbzbtp/SCBR0XqkLw6De2JHbKSIDIkJ4nnqoZWmTmdJRfe30B+I6
         SCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734708900; x=1735313700;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ybujMeIc792bF+3UDDsP/7Nt9kxWYnmB+53gMRc7978=;
        b=KQQQzjNnGvC/3Sf9eq53xGv+RAChoRC5fPI/hvwK0L15djyCipmQyravZ/PaK5KiKh
         VpSdNnaZ8E7FeRZgjdXCRiIb4dhNKjaNIEXyZvsQngWxs5foWXk7wXY6mUndbryxqD2C
         HpQlyrEL+t3Jspv8ryKnUJaa0K7+MSUmkts/2OlQFK3klPh8pn3PzSffHufXTN/LB833
         aOGk1jYSJAjRtDT9AUKp3ZJTNYWAOV4rLRGFgIgfUJLyMX0F61x1GywYFGoeGyIgxOHn
         WFYl9AwNDpLGT+ofBnfkyHdPDqcVhLEWA23n3Vit22S10XzIaqQQw1lB7KeY07Uao/G8
         wveQ==
X-Gm-Message-State: AOJu0YySZRWIdQ7OmcxeHBmfjf3sDlo/xE1xskipwpQ0ILAQrcvJUJt8
	hJ1fZTplRi695ka89Fxo8S1aYVSvRAhvryBLuK/lL+ABQwzaUU+oJh/VCw==
X-Gm-Gg: ASbGnctkVo8VqjGFhmhq+srOWW7NSdEM+s1vZ4R4P52Jauau20Il1bzWV2FP0bOU31f
	Md0dnmVMrLqokxBNohDEEfE7MzxlFBvt7RuvtifC0x9eJwNF9rDYkS1V1ILsvQ254AHAIHR/z5V
	c2YKdRCYOLKaSbYXpyn/5rB/41Q1gVclGT2HAxH2N5SXEV7SDs/9t8GfmPc+b+j98hNONJqEHDn
	jxCT1UCfQb0dCvU6VidZF2NiLzfgNbrRu241cilwah/pu9tPhQpBTHQdz6D
X-Google-Smtp-Source: AGHT+IGstrlQ4s3NHx+LMKGsSQqbhBJvNcGsRJSYbKNO2hzX0ep8ZT1nZM+RIDTnHftmUQzz8sLQbQ==
X-Received: by 2002:a05:620a:4145:b0:7b6:67a6:5adb with SMTP id af79cd13be357-7b9ba784a1dmr625597585a.21.1734708900051;
        Fri, 20 Dec 2024 07:35:00 -0800 (PST)
Received: from [172.17.0.2] ([20.55.15.29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2ce6f6sm145012685a.27.2024.12.20.07.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:34:59 -0800 (PST)
Message-ID: <67658ea3.050a0220.1a6637.6218@mx.google.com>
Date: Fri, 20 Dec 2024 07:34:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7850042795347744324=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: bass: Handle Modify Source opcode
In-Reply-To: <20241220143106.27443-2-iulia.tanasescu@nxp.com>
References: <20241220143106.27443-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7850042795347744324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=919917

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.17 seconds
BuildEll                      PASS      20.81 seconds
BluezMake                     PASS      1644.46 seconds
MakeCheck                     PASS      13.38 seconds
MakeDistcheck                 PASS      163.45 seconds
CheckValgrind                 PASS      221.17 seconds
CheckSmatch                   PASS      280.05 seconds
bluezmakeextell               PASS      100.02 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      847.94 seconds

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


--===============7850042795347744324==--
