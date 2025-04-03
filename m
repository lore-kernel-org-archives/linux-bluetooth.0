Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E801F2E62DE
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Apr 2025 19:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743709311; cv=none; b=mbmKq4EDowUPjr4dvh+p4TgWN4ZwK3E0z6H76U/3BdGAriyGXybCg7E5SX9P4gq9sXvdnYcFIJSmgfWqb3tUKMN1Gr81+d807oa7nXwcUHL6D2mOPOVHd5cOCoXACvKrTuOx7TAGi093smIrMeED6/WVVmucrmNga+jh/cJw+nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743709311; c=relaxed/simple;
	bh=eWzBFkaUgKZqiGcnJDAtcw9tY/kKXcd4AJP+u8kQxZE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FMakV46n8D44QEIP90UT8WQHXIU8R3yNkOBzItAtGW+IkeHGY9RU/M7zsDT4zfvQKyGcyR7SwlurS09i2Eir1YLJIozhp0/6dfb+ZCNXqG6c6xpS9SoD6X+S90VDum5CRqfzUT159gxAW6EJxRkelS4Hw+NT9vSEMYOWYm5JOoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMcrgp5I; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMcrgp5I"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-476a720e806so11371661cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Apr 2025 12:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743709308; x=1744314108; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5NyoPnvvIF9yZjA03rJ5w0a8J/VsKV3Ry0hC570H03A=;
        b=aMcrgp5IJG4UKJrrIYzTXop0qjLJnrMxhKBpIe+9t4YEP78hctYV6+V4A/cyhhAESR
         361lyo7OZ+9HrdBIwZnB9i1Wk7akqmUkiHk0tXasvs8CPc5/TdrIKPxmFD1z1ouMbXwC
         18VhJRwNb1t6T+ptR9aRHpMyrUUgd/+u4B4T7q6++dX8p4o4xw+0vOL2sK/HDYoD3CwL
         S5fwcf6TW3yfHfv+C8I+Tm8KW4VV2VQAJsEJxhe4l2O40TGQ4YxlVDYcF2P90QdagnIw
         GHixvAMk2gFb+NYbBSYoHCCToQsgTEEZz4gTysLgbesW/mxiAUwue3G++qG/ACA9TQfX
         RI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743709308; x=1744314108;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5NyoPnvvIF9yZjA03rJ5w0a8J/VsKV3Ry0hC570H03A=;
        b=nYWH5NXPmjtZyewnH/j6eznHGGW6hU9Ja/2ktr4uJBLFQNWdWMb35/KKhEM3F/xiol
         V4BBktNfbfhc4kujzt16PvCqQeleONHEaqlSsxcWMJu4nbRPfoSyZAzmot1L6WGuX/u9
         U3vc6g+eu7v5vuvtyWZYI5/y9kiDm6FmGyXQ1mQkXh6d38hbvUwPvtzbYSRug3Y9XTNG
         o+JCkIyfwMYUfKxxz066LkMUoRBzTk8SiqxrOQMGleDYWRYd0eAbNBwtGL9bJtCSX1uM
         M8U86/ejZ7xfMiB9w4iT74+qElixQnfHS2A9/cJg6twQ9IYLwP/eaNjafO0c3Lph4vTn
         LGSA==
X-Gm-Message-State: AOJu0Yy/Xo0ZM2B8nGj5GrWgjqG8DWcs+gYzeP5BTlLYb4I1o6Q9jP42
	FDC3NhbE6+B726P3jbD9YRv1pVAh02AK9J1iIGEcoEQvQerrg8G6nW7FqQ==
X-Gm-Gg: ASbGncvqq6nsXW8hYzouaVIcImKYslWwKPQX0CtAX1M8jV7oqmS/WMWT2BI8h9l8UR7
	aCk4mxtzledEmG6vgZinkzd0P9rMdSDbs/O/PGdZTIF7aES8G3DksQyBfnwmuqe6NPMnMqkcT7Y
	+YMNrZsMKIH9SEKotU0iCiiAZTIf8dFf/hDawhHIvGirYD7KKcir1uUGOu3pmJqjft7URCkFlGf
	/aI9iSn0IWCd46f8JwKgQ8dgDtKijaU1rpHMRcIVtewFIg3jY2/i+TvGW8AI9TszzPQ02MM4qzq
	09TOicOpT9ZKmZdfzBgd6KvlrA/wjnrcZsUTNeI06XC/4/rtBzQ=
X-Google-Smtp-Source: AGHT+IFj8z5ud4bve7RcoJDCNEQpNcZzQ9TA+ROcxDDCrFsVeefyzQmp/t8Mn1tvhWGxUohwRzlcgg==
X-Received: by 2002:a05:622a:142:b0:477:c89:3813 with SMTP id d75a77b69052e-47924910309mr10480481cf.9.1743709308564;
        Thu, 03 Apr 2025 12:41:48 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.77.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b0713f6sm11397171cf.21.2025.04.03.12.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 12:41:48 -0700 (PDT)
Message-ID: <67eee47c.050a0220.ca0c2.4678@mx.google.com>
Date: Thu, 03 Apr 2025 12:41:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3393036110236505643=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [BlueZ,bluez,v2] bass: Set the service connection flag when BASS connected
In-Reply-To: <20250403-bass-v2-1-7925bb16468a@amlogic.com>
References: <20250403-bass-v2-1-7925bb16468a@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3393036110236505643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=949647

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      20.61 seconds
BluezMake                     PASS      1558.06 seconds
MakeCheck                     PASS      12.78 seconds
MakeDistcheck                 PASS      163.31 seconds
CheckValgrind                 PASS      219.19 seconds
CheckSmatch                   PASS      290.61 seconds
bluezmakeextell               PASS      100.96 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      898.04 seconds

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


--===============3393036110236505643==--
