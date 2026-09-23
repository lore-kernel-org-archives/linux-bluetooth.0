Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311724756B1
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 10:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160479; cv=none; b=Bt4PdrSPVHpLjwElJoyhkbN5zTWXgwUqCag0W+Pj1GyyO+QzimdQ9zF/X0JCNikm5YcbvAJ/Ufk9rBGZjmkUsSlTmr8ukEbGYnZ2D3PxZ5FaF6Iw8ZGD2qG0OEaDvzdQ7sovLNL7E+f2Jc3bjg549r3ZdDjN9/AVaLN+9pWUfXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160479; c=relaxed/simple;
	bh=HiOd31tWhe/0BVgkdMmjCV4ymBmjImgRj6R37petuxw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DgMfus4M4AkHZ8IYV6E1/UkBhp1LIuDuAD81befGvHQzwExAOn2Dmb/Uz+F6JG3xIGWslj9CA/sFyJmqTMCrv9VXSxeoh1efUfKRFz/6fNj9diQ4YvJLIlOEPDJuQMOksgBbaAmcSw1638ouJrhWSUvUu07t6pSK8eKY+TN+U2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGo+qUDr; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGo+qUDr"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c3b639adbcso659640b6e.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 03:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790160471; x=1790765271; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NH/mjwqZt2CpYx54A7gF8GtoAf71u5JBihWhB0SQ90Y=;
        b=EGo+qUDrafwHonmiu5ueHwrh5lDHWv/B2VCS6tX54nU18+mSZGIDskcXOc71fUmkDl
         vRmEv5lLofYvAKZdu1YfnEkF45HuHNbNVmOLNMtfW1yEz07MmiUpwVqmtg7sNjhykIP8
         SfjB2UfvNGmGzGVhcNyYGhgds2yew8qwQQGoOHrU9AzEXligD6uDqkp/gfzX5y9UO7fW
         mBVv5XJRqMiq7zZg+j3K6qzG2s8/OtKYOeULVfqgkXHtRa4mEQj64DRKY79Bp7022djK
         cpZ3jiFd91XRu0DzMyFaow/FjPqobPpAf7IBpeWi97rcaYUdQVAkW0aczm7WdSibJvVk
         btgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790160471; x=1790765271;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NH/mjwqZt2CpYx54A7gF8GtoAf71u5JBihWhB0SQ90Y=;
        b=IAYeft9YOworSqCwz+isVMZe+0WclBfaZiBqCg62kDIqpFcW7T1YjPzqC+aglKJdao
         WwJYhsj5u6sp6N+ykPYnfaz6RbJNu5wxPCmV2V1lpV9BUJ1RaZP/KbPmB+ActqE9LDW5
         UmPa4CA8k5n08rs5pCNSUvFlBatEiMA0TuV9HXtHCorLrlN6bDmbuoSbVnTBL7MwAX3G
         6FWVdbZiMCGEV8k5tUZE5R0FL6UOmRj+q/Gc3O9UlJ0ooOGa8xsb8vU4JypgSZwnBRz6
         VIlDV8Y2eru8ajQE+PQG6v2QCwev9QZUrfYrj9SrOt0kPYmJrXkFDfokbrqxnb1DT87d
         xlPA==
X-Gm-Message-State: AFuF++lCTpSgSw+TrhOzPftUcs0U2JiXGk2Il5mBMnh7W6sHFypYyfTz
	Z57WOk9v4Pf03cWT0vrnNWIdZJg7IeryJKv3VweOmXySy40W15lxpk5CDtJfYw==
X-Gm-Gg: AYBFou3aYqRGxOBK0Z23Kr/TqCIaQr6xgOVfraY896bIb38Bv0PFeAHpNy2Wz0M+/E9
	kDdc5Aurt1Su1IaWLv0mwd4rxAgZwkqWvg28Y2BSBR/+jpkHvZlB/Ea9bVjjpTIrV/xCTVJKD8F
	It5bJDGLnWruyReBqyQhI7aHFv6Rdp7/PK40WmVgrXE3MiZNyX/Uf/njiR0tSKUIOHdN9ts8NMq
	WWlamkBOoOZXwIWR89lt/azExSysGv+5XNgfwBTjpY+TacSX0fLN1AElF7ZxVbJR5NXrz0AcNJr
	QFb0kYfALo8b6jvDmECnqmjJljWHBTsGUFk8LxVszZW/vaCVm6I6ZQBc8VlIYc6R4+FW42v1c7F
	IgoYT+aYp4o6qwxNfoz076T9OuEuI4mF9BIMyPweS6p/8EHvpZbcecwk1Msxvp4iO8rnoFx1+G4
	+3b6plMWyxro5AaB6bDgxsXEsf8sgtmR0X2ySmrdoqOPWpfC8eirbB7oVDGX5UumdXkguyp+REk
	HRN
X-Received: by 2002:a05:6808:17a2:b0:4c4:d8a0:2773 with SMTP id 5614622812f47-4d5b930b034mr2306741b6e.32.1790160470585;
        Wed, 23 Sep 2026 03:47:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.142.55])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4d5c522b9efsm1755008b6e.18.2026.09.23.03.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 03:47:49 -0700 (PDT)
Message-ID: <6ab3ae55.2fe18630.18fe47.04b5@mx.google.com>
Date: Wed, 23 Sep 2026 03:47:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0682738225280880529=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pvbozhko@salutedevices.com
Subject: RE: audio/avrcp: Add AvrcpVersion config option
In-Reply-To: <20260923091827.4496-2-pvbozhko@salutedevices.com>
References: <20260923091827.4496-2-pvbozhko@salutedevices.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0682738225280880529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1172081/

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      14.88 seconds
BluezMake                     PASS      262.58 seconds
MakeCheck                     PASS      2.86 seconds
MakeDistcheck                 PASS      112.36 seconds
CheckValgrind                 PASS      117.33 seconds
CheckSmatch                   WARNING   191.58 seconds
bluezmakeextell               PASS      71.86 seconds
TestFunctional                FAIL      903.64 seconds
IncrementalBuild              PASS      259.41 seconds
ScanBuild                     PASS      760.61 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/main.c: note: in included file (through src/device.h):
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bap::test_bass_past_transport_acquire[hosts8-vm2]: AssertionError: Failed to acquire: org.bluez.Error.Failed


https://github.com/bluez/bluez/pull/2571

---
Regards,
Linux Bluetooth


--===============0682738225280880529==--
