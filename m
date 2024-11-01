Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644A115697B
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730451790; cv=none; b=ljBL2S9VmkqNZhUKlG+LJkgcJTRBGBMgH/cABUqEtzUfXq2VufewzZdHFcKh2Tx1VRAvmeF3eKyHDDSKofOE/WTVsCdsXQS7Zxd6xVuaJx1tjY/2urWVEOiHZE9LVqCAaKSho8gkj8iRhLBy9PLexT8SoFoLWWlUzT+u/oDNV/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730451790; c=relaxed/simple;
	bh=kH6EVAG34ChQNJYjkBW3cSCrMOFNHcC3SqE1rMrytns=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nkrq9ULu+nRalratskPvDQVaXWw5YoNp/8jbDO+rn5BOxAJHpax8nVMJfG2qkKlSYWjAYf9ri75gK11CrmvrAWmsWZ8XX/blB1wD/kosjnpUt8ixLhd/BxHhOKCZbLI25yF51Kw1hxN49SAfP2TGoo4C68XbadOBeEX6prhjykM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PerEBrj5; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PerEBrj5"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cbd57cc35bso24073946d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Nov 2024 02:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730451787; x=1731056587; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JiH0Sg6UYj3q1UVIZtTI1pSa5LkKJwXcMVvLbZT41nY=;
        b=PerEBrj5aA0IBG4CgXe5Dh9tPQYFG3XmTjqNmRhRDxT1nq4TeeKD7kkGlIWZLpw/kD
         BCub2howGlybrEZUAgYTKypX+rCBS/dYJ0qBMJ6TYsUM8fbzpq5uFYLGgRwlhecsB/Yy
         o75Pi/YIfc6MU/XkvOh3q5AIEac2pQmRMjg34/CZWbYRxD0WrFv0tviznhmgMvsPPOS9
         QYXRMcagqE2HPy4L0Rd7XeLMa4Lsnce7YabhEhirB3heeZw40F+9qx+rYOkAkRzF/1QF
         KxjRb0GF4ZtcGm0PQG0xFSanfBvJCOLNM50rAHNILlErayFHcCljYY2SfXwYkLMZvlie
         /Y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730451787; x=1731056587;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JiH0Sg6UYj3q1UVIZtTI1pSa5LkKJwXcMVvLbZT41nY=;
        b=qpWfmhLKKyNo14UumHOXh35LCuhHirkmpcFnREcNpj3Tvvzk7u+Awi5Yb8NU2eek9+
         mignoNCr8/8N42hIK500nxRzWiM1M1yOCb/Dg0NCjeK5Ryz5ee1lRUA3WLHP52m77CkY
         3nKPZg2RTDK3uI7r5q/Po+nbR0hJZG12o/w078eNuLEt8CYyl9oYvdIsM1etcIQUsk3V
         aHzIeWaWDVASAUrf2ybyz1zfBZKrOro0HYtTwWMK/kH0kBFsaOS9vFXey0DrD59JO0Yy
         IyPs3ETU7EJ7VaUVaWjOG2XAcWO3Czoz/eLnb6RQUGzAoSmM0SfjNQr98ZMgtUPiqKlj
         WXUg==
X-Gm-Message-State: AOJu0YzSgBYa8NS7P5y+hsQuF5gXKgMSIql3PfhswyUbcAel/8eoNHdm
	3wM3XZ+tUdDHqOBVExjixX5dzBiKvWjMbUaH0T7rl8vs6P++ywyjnV9ADg==
X-Google-Smtp-Source: AGHT+IHOsD4h7sEEZN9y5Bwf+AEQimC7DoGp6GfezZcyjb0qkVxw0/1XMLoK7rWLT5FgKBuwSjGTlg==
X-Received: by 2002:a05:6214:5d0e:b0:6d1:9f1b:b669 with SMTP id 6a1803df08f44-6d3542eddbbmr93012506d6.15.1730451787024;
        Fri, 01 Nov 2024 02:03:07 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.154.251])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d354178071sm17109606d6.116.2024.11.01.02.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 02:03:06 -0700 (PDT)
Message-ID: <6724994a.0c0a0220.1c010d.5590@mx.google.com>
Date: Fri, 01 Nov 2024 02:03:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7115094863404059668=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v3] textfile: Fix possible bad memory access in find_key
In-Reply-To: <20241101151939.Bluez.v3.1.Ia122d85386d6c2fc69f5b3d7ea7a7169f73756e4@changeid>
References: <20241101151939.Bluez.v3.1.Ia122d85386d6c2fc69f5b3d7ea7a7169f73756e4@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7115094863404059668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=905285

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      24.94 seconds
BluezMake                     PASS      1647.13 seconds
MakeCheck                     PASS      13.70 seconds
MakeDistcheck                 PASS      180.49 seconds
CheckValgrind                 PASS      255.74 seconds
CheckSmatch                   PASS      359.28 seconds
bluezmakeextell               PASS      121.22 seconds
IncrementalBuild              PASS      1464.70 seconds
ScanBuild                     PASS      1018.25 seconds



---
Regards,
Linux Bluetooth


--===============7115094863404059668==--
