Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741461FF7C8
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790943374; cv=none; b=r5W9LWRSON7lstPRktOpIETvbnbBgMheJ+H1U7aGmPzd24m2yg5O1Wlbtjl/wjkDZdtVpwZ1qlbsiJpecC25/Es6WGEWUk5IvBBct574kKF+1/slxOC2U7g4VtzNMQJHhXXU02tBz+TbNV4pUgW7LSzkaI2cmYW/tgP6WfwlCd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790943374; c=relaxed/simple;
	bh=Wui01z4tFV4cvOiQn/zR8Uf7z5A77umRX4fThQHA3vw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ys5gVoXAxWSl19d6f0SH4u6P2/109j9b2O4dWnFEMhk6zqK/wc7sqoqoXOfhbsE2mjw/gx/CMWkfXOp4cZ3VffJi1g+haMInPkYQvb2ug/K9t2SSZq3w17wfoLPQtvOjc1euuft2PXzIt93xFYG1e2fvIUFXtiExISH7FdK+N8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGe/qJw6; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGe/qJw6"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e62211987so7460230eec.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Oct 2026 05:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790943371; x=1791548171; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FX7HkrRZ+mvC6W9idYj/fFBHt9i8HJj9cqjZCrK/HCY=;
        b=HGe/qJw6D99tyNYd5mHUWiL3nZaQHKMoY/BfOpk3a1n+fmx2G7vlPRbXMS3VynCoow
         aZMQKk6ZTqsBzCnhDyBZ33u33wA64v7zEvuE6QRWK/TrHlsh9p9u22FgibHzHQ3ZzSYA
         dONeM7Sn9oIeu0kEJXbPgzQ3zN9Cd+8MeMrTcTrEsuQEkpcvt7MJGhJsDXsM/YdlDVNj
         QvrOi7aJgNceYARbF8P7bC6ZGJLMMdOQSyE/fSwL/HCCpxAPWa7oZ6AsRNmPC2u7yfZe
         sN+3pP0zPwTdruGfvl8imui5xn6MkcO/wiljndYcuo0m175L3FKorHQinMmGFhn5vUQg
         z0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790943371; x=1791548171;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FX7HkrRZ+mvC6W9idYj/fFBHt9i8HJj9cqjZCrK/HCY=;
        b=KpnXJUHukRfJ3tuI94ixFPn+vX+gfuKjcWiV5/AYtotY80eve3TqReoRjh42zEIcVk
         oc1gpm9JUocsU1iuLWO12VXmEbA+MyWibLCtG5pFqA94jLySFBK+kd18RFhQTfifTXxy
         53G8TMpYZz7Wpc3SAuyfZLl2SM5OtEeX3cs1DC6u3zDlFdDrw8WC3Uab9FzDIidMvW6M
         sBHRyElR6Gvsb2tSlLPam1F+HoKG45gtbRUJfFrabceV1ur3/R9JyU1AJSsZ/xozBb+U
         uYna2b62hWfQfgHDdGAw3y3q4ap9rd4n/x/Bep3MFnmVf4Yg9sxiJLuIk+yUaq2tkRGP
         MpnQ==
X-Gm-Message-State: AFq9FYJLTmCie4+dgqk24k+Uz0KGVu5I8lU/Y6S5nKwVmrGjA5r/YDHx
	BV4014a2DuUUThuQFPhSrd/zXzm50a6HOQFmi0SOdOPQswK3oyp4KSxJUDN0vA==
X-Gm-Gg: AYBFou3S54K8UM0gcy069hiByTRF5ANPiiWqDjUgy2bLQRmRe8G8Bwiz5RAVWmwiaHW
	1+tfE+KbpRz6SjzlJqPF2bnNfvITMiL+29VbJ7LqmaaVaQK3Wldro0FT1mWwbv9oxmEEDORIx7A
	5ZC3y+Ij4FmC3uuP6oqcXpbKiQanmBF4tC8oM+9u3Cz3jc0nftkiS6Zun14Kh402PRzlninIHX1
	YJz7UWfbWWdzBtOXoIW66+7YZoWy/s5Obe6hoOm7y+l61enR2yDV4Sm+N+TYftZVaMmyr0ifSSh
	aCYwz0d0A+NvB3iCfOoINkos07Sh86iDkdgcL7qgM8luaPwokC6Tnulg8AeLZq/7Tf1O6XtJkMo
	B7zVMvFuvxW4rScJD57dpvYeiafCAtmfpsOxW/pM1RSr+srrdSnSw57sVJv3l4aTOzim3OV8ly5
	dKenDnCsgmjD+JyM4qXTVpHrYBW5CdiOAtYSn/hCae0TCXQ1HcSe8kFT8j2GdMxCLRTyRJsBuCr
	5zQv4k=
X-Received: by 2002:a05:693c:8843:b0:34b:564d:ea1f with SMTP id 5a478bee46e88-34f150a168cmr2534245eec.18.1790943371316;
        Fri, 02 Oct 2026 05:16:11 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.163.106])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f0672c2d1sm8678904eec.4.2026.10.02.05.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:16:10 -0700 (PDT)
Message-ID: <6abfa08a.058548f1.4e9b2.d7ae@mx.google.com>
Date: Fri, 02 Oct 2026 05:16:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5209502668265330529=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: Add Connectable property to org.bluez.Device
In-Reply-To: <20261002054618.30994-2-kevin@simpleble.org>
References: <20261002054618.30994-2-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5209502668265330529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1178077/

---Test result---

Test Summary:
CheckPatch                    PASS      2.34 seconds
GitLint                       PASS      1.58 seconds
BuildEll                      PASS      17.22 seconds
BluezMake                     PASS      305.01 seconds
MakeCheck                     PASS      13.85 seconds
MakeDistcheck                 PASS      129.73 seconds
CheckValgrind                 PASS      213.03 seconds
CheckSmatch                   PASS      223.50 seconds
bluezmakeextell               PASS      84.08 seconds
TestFunctional                PASS      976.56 seconds
IncrementalBuild              PASS      397.38 seconds
ScanBuild                     PASS      886.61 seconds



https://github.com/bluez/bluez/pull/2622

---
Regards,
Linux Bluetooth


--===============5209502668265330529==--
