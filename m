Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D413C07A
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 04:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791866980; cv=none; b=epGAv2pUAl34/D8JFujCQZQb2HownGMqKDuekOXfcWrdnZG5of8FxCFwIpRwIEzYaL2PDcRoKJtrS/j4yQNnghhEkalKqEqWsuaxhdrtZe+FnuhHzzxURR+bAvRr2pTKHLDFJ5RXlDgA5P27R99na5mHDZHD6QcCIS9J2QPMXJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791866980; c=relaxed/simple;
	bh=EIn537OCwNgLdRhxTVsmytylHG85ghL9pxz1DFEh4pA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gKvrNxPZ8sCHp4a5ez/qz62QYFpLT/oQ94YbmWyU/KU91h4Fz210b9TLjE6QKRCHbL24FvWG4zHtNLOlYXW5xMDMDBkBC8v20zt/o1SNif5d/lvlI2bQZ0BG4WjcBA+ImPGvk+xYrvEvlgXrOHTDJe8AUpDEgeApmi0hVTNJUys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOrhoo3m; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOrhoo3m"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3282db206d3so4919458eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 21:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791866978; x=1792471778; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2oTig4FSnyCVcQ2bd4J6shoWaSqXAEMTUp+dUIKElRc=;
        b=aOrhoo3misIX+0hDOek7qqPxX+fyzlCJFiQsNs7kKmSnlQ2aEJdnuCRnLVXsSp0t0m
         Bk3eTLw5Cn7JhDmkCaazZRNCGJvN1pvpzJfJANZAAhjIRUqtgKo1lwaaP7CA+pZo2qQp
         r8HnvP63bGc9e+yCpbcqnqHWUTcPKNTzPfiptyRs+kOuAgRxj400U1FO7kmnA6R8Htdk
         aH3ooNRvoK5Z/H6RDz42IwRE4VsNqG9Yu9y5uAkJ6txRM0UXIVq3fxwDjnWOECuIXNHa
         kQ2ivNu1jNIWrWbbjHfpqWAtIGDNRN2YXLcuevTwxXDgjmJzYtt24qZLPuuOMjbxoOPq
         7dIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791866978; x=1792471778;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2oTig4FSnyCVcQ2bd4J6shoWaSqXAEMTUp+dUIKElRc=;
        b=BC/DpQWwwkFcx/TTgAyjDzcl7jMVQIg0WeUYv18QI899KS0u34b3RZNeOjjE6Op8mu
         0Jsc/ud8i6JJlyfEq7Qdwb1LLnKx3DBKQwvSr+sqMkaWIuCaJnE/TSDunQQxsysmCna2
         RMVPAfakiDOZl2unCZV7RKiC99XGBCXc0cGV07bBMrDJNjWAEpGUgHC7Zb3MUSnUvAnJ
         xbIMBnHEvSIuGbN5/cfwGoJb2Iil+8CH+TtP9Sp3LNKZt7l5juYAvr1g6QxqrhchH/zu
         luLtxlurc6Vzmga7/YnAicd2F3i5u8rmuv5LYm0TNGlSV1drP+kPP5gB9usD9fEKGfaX
         LQvw==
X-Gm-Message-State: AFq9FYJAsLZx7NHh80psVWbxOly4lI1Wz2zs1RgJZX9+rccyjCBkHYqn
	pPu7gLeegr/U4ZGCzyFLXned2sLYg398aNXMEer591nVTb51aIonBdZuKN9iKw==
X-Gm-Gg: AYBFou07FTvzDBASGVS63BkJv7W79rT856S7aCplppTfZKpxNmumhi5FtIAX3+QGBV2
	mMF+wGLx4e2Gi7RBQ4dDbQQOdsVbPkPH5ckfbf5pQcb0riwuEbEvk2b4JK7RqWYGGd6TaAJMKB5
	J17Wfu5KH0M9I8TzWciXb0hgd/74vlEduzWLLJ3JB9wejNFSjMh+YWX6JejKjUQ9h/eFwZskifY
	YOXBdXY+ZYv0Yf7YXyPnJETAuNBTP8PExEjVsji9MMOx7XFYVT1d0yKNEp1YkA2ztXNVzOJqsbF
	K+4ONI0YpcNS+QxuYS5iKzDFoaQj6tlLcEKJyQDMt/DfYloDOrXBDZiBA+jkfvxYbWIkFTiEUrh
	OxZ3kqLOz3CLquL1zVOKrx2RbM++l8hKu+2pQD3Sf633H04aOMK2ylkPzXxzr5XhrABTOkDGTLc
	B+0gMmC/LJeOzLoJLu/y0rFHaR2tWkeYdm8gwQynq4XGf/FzAJ+hib+hGXNxLuhYZLREGbMMaaS
	gQ=
X-Received: by 2002:a05:693c:414b:20b0:33e:a0c3:4163 with SMTP id 5a478bee46e88-3537e00907amr17552276eec.24.1791866977759;
        Mon, 12 Oct 2026 21:49:37 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.39.81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca79536sm39927179eec.16.2026.10.12.21.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 21:49:37 -0700 (PDT)
Message-ID: <6acdb861.be2e0958.2f6bbc.9245@mx.google.com>
Date: Mon, 12 Oct 2026 21:49:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6937668966850099417=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: shared/asha: send STOP without waiting for a response
In-Reply-To: <20261013034345.513789-1-cochcoder@proton.me>
References: <20261013034345.513789-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6937668966850099417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1184353/

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       PASS      0.23 seconds
BuildEll                      PASS      15.65 seconds
BluezMake                     PASS      223.77 seconds
MakeCheck                     PASS      13.57 seconds
MakeDistcheck                 PASS      114.78 seconds
CheckValgrind                 PASS      183.82 seconds
CheckSmatch                   PASS      219.50 seconds
bluezmakeextell               PASS      71.55 seconds
TestFunctional                FAIL      958.79 seconds
IncrementalBuild              PASS      225.37 seconds
ScanBuild                     PASS      823.69 seconds

Details
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_hog::test_hog[sci-hosts18-vm2]: pytest_bluezenv.rpc.RemoteTimeoutError: Connection recv timed out


https://github.com/bluez/bluez/pull/2664

---
Regards,
Linux Bluetooth


--===============6937668966850099417==--
