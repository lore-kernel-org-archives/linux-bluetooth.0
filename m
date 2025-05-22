Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2627D1E7C38
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747940362; cv=none; b=UdRl0hMWft4Scvjg24yebpyK7aLV7PjOpbT+O8YRIMkiyeUOFBW8ESfE3kUNZ4YdRz2Qbfs0BDgLsQhE7rk6YaAe3FfnSpiLHxdqEZlirQo86GAafI0nxUSPpYXQI824mvIXYTdiaCS9Z9jbp3TrGYPash/ZrczWnN1+8Acvbmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747940362; c=relaxed/simple;
	bh=Z612W78QJWkVuQrqIhOEVaHm1pD6BZdONsk0oupeoyo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=K3gKrQuyJBNhprDJAh6fGxW4A87l+FSVOglZmkuGXqz4nLwE9KdMU4/EsTqL0PCu8pqpdkFl1CWMl1iIt94+6zXG1CX00KF2LAkm9nm7hhbz5m4hOHKm+s+Qs/F5lGm8hZunUOf1dwbOm+bx6qnwzZ6WoBVuyVjoHO10aB4JVGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpBOJZkM; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpBOJZkM"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47662449055so45656051cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 11:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747940360; x=1748545160; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mvjuVYoVFkq8CQ7SzNLcgph8ud7Dp63PxcoNFhEJ7fI=;
        b=RpBOJZkM2jnSoe2C55BNwaNyXEwwJxJamX/ip/IhpXz5mdS4SUofRxxNX6LNUL3vGa
         zZt9eZ219DdcLKp9cXSp/UghQq11kNCOHE5amWxezL+dCErt9hOfPYEaMkurhC2ISDX0
         nkhMgmyD1mm3bNQG5dj8m8fg1BX5LMXFMjv0L75QdTQff1WxiTFBDsV7pD9cE9VuLvSx
         YbKSucOcqsseIYsYMwBlOjyhoXULlAMHRirKKYewfYYvjFwx2XunuKMi90oVWPoiYTv9
         2dvv4xTZX6xdzSTdSrFqppfH3QXOODCZ8Lj9zTUNbirJLgiVJuXwIJsbUwuB/LHPGrPw
         k2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747940360; x=1748545160;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mvjuVYoVFkq8CQ7SzNLcgph8ud7Dp63PxcoNFhEJ7fI=;
        b=SCPpDRUJwkPEF3havrypO8CKItWRFQKowi133tcGCcJwaumh0LdK5UDw6pw3w329PN
         vF4DQhKBZG1XSJ4FHJjCSbSxVNtsgq1Ng8fYCKAO3IOSrCWuN4zdafSeVjeNq1RfFSlM
         wmwr5xtfLPxR830JZLzgCwgEgMchF0/9zn9rAsh8CHLw0VBpytUXlrdKfBYkFgHcm8If
         Nj4Fd3nFFDOXsrXeXxsW25SEKzXmt3J3077C7aTm2NKACK0/z2y5rzjTbcufXxTBBLA+
         zviY6lmojBZ83ZmOw3DQy0hJHUoGz/58x1uzkATebo+A1AQ5AAZyLiNNetDNOOm1f6Pw
         e+NA==
X-Gm-Message-State: AOJu0Ywn777XFAkCRx5iX1aEC1UcN21uTYE5Df7UabiAs1Tja0BiNUWk
	dnCAS+OJ3vhFx2cDdubM2iK4JJSSPm79S01o9XoOPc3gKQzndB1Yq5BK0X7gBQ==
X-Gm-Gg: ASbGncuWUrWD5T/7OpeDG9YXZUeh/LuLrHyXvJTWiyciAw7/FdYzceL0SqBbHV0hfMH
	nUGH1vnKq1JlrF+cyi4YZYRD57G//+BpOeH7aW8nGJInRdVkuuqjAFf7BwHOY30WbkqE+hqInDD
	h+MJP1yuv6zywOHP2iTGlVPf78JTnCNnkAuGKKOXo3+Ul7uMzKbkkuw7kpr/3yEaQqkzzSfHgbg
	7O+qBsFqNkkYI5wnkSkeJqC93E3ArxcdgFIg60K7LWD87Ajj5OOvcCpPDa5N59aM6yGZAg/AGeJ
	6r91NLA7DNVtGWQSEroNvLpzDFU+0TwuuOD+qyLRflXkXG9Zw2bnAbZtERk=
X-Google-Smtp-Source: AGHT+IGYi3xr8OXe8FLpEdxpo8duBaAcyG4V99M02qChq2BMEI58fnllMMHlNMyRV9Fgi0zk1BBcyw==
X-Received: by 2002:ac8:5cc1:0:b0:499:836c:23d9 with SMTP id d75a77b69052e-49e1d654e56mr581151cf.10.1747940359428;
        Thu, 22 May 2025 11:59:19 -0700 (PDT)
Received: from [172.17.0.2] ([172.173.165.97])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494afbabee4sm99389821cf.55.2025.05.22.11.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 11:59:19 -0700 (PDT)
Message-ID: <682f7407.c80a0220.44a37.6f52@mx.google.com>
Date: Thu, 22 May 2025 11:59:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4821212708443386379=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/4] org.bluez.Adapter: Add AutoConnect to SetDiscoveryFilter
In-Reply-To: <20250522172952.3312270-1-luiz.dentz@gmail.com>
References: <20250522172952.3312270-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4821212708443386379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=965496

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.02 seconds
BluezMake                     PASS      2678.98 seconds
MakeCheck                     PASS      19.99 seconds
MakeDistcheck                 PASS      197.25 seconds
CheckValgrind                 PASS      274.37 seconds
CheckSmatch                   PASS      300.61 seconds
bluezmakeextell               PASS      128.76 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      900.10 seconds

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


--===============4821212708443386379==--
