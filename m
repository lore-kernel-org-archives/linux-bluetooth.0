Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A9A29CB24
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 23:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782172394; cv=none; b=XZVHuJvhopQLN4DbeHs8Jsc4/TDfvn96fPN77PuMOeLEbPjoaBf9QsrdubReb8oAJZmPUSuFVWCBKX8DBxkqc1E06VspX/LJ4ZKDT8kk5f4o/GEmU1mwH2D+PPghdqoLddJ4PKEhNuU3SYRLo8KLyFjYwLsL/sAMzGeOGcl1MOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782172394; c=relaxed/simple;
	bh=QpIkdfj8QPG4CpSin+9lKteup4B2txgLoMBJDVW3cZw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bqZBvNxiZKyNVnROAM8O/Y9Wrmc8Xg9OzXKl4tO8w55IfXHGKBaSW8ESX2PZCgr+LmhmfrtkfxFu5i53w5Sk272xkKpwDvKuPi4yK60PNgRpt4fIowOSdFPMjCQeCEL9Z4eEpw6cIbFcKPkAwHV4vmX3yx/mKCATs37gVR7Ia9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nW5ymIPd; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW5ymIPd"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8dfd7b11e1eso21142486d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 16:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782172392; x=1782777192; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QpIkdfj8QPG4CpSin+9lKteup4B2txgLoMBJDVW3cZw=;
        b=nW5ymIPdjXnX0V5vX+vXHGMYZkptJQDt1fOU9gOgcZ8TIW2BLfVqFaIbey59ZzHxxK
         +hD4f6CZ7A8KupBLAj31LHsqmBEZoZnxd8di+lS436z7+3YKiodA9WAvdv9FOgaRdr/7
         rfpt6wVjcZZHmtlAl3iGswndXMuZbqNl5wPGovEPuRQqDUOlgQf41WjiBLoXSwTW3/4J
         s6oTHOYifIXq6VaGoBHHK6EuNou/SlE+9shxvrDT78Ok6sTWV/W0rb/S3wCNBWdbey1v
         F20WhU2Pvb97ajrE777kXFFzx4WQUf8PMtGXh4/BxxCqv74PpIwnWXi+cwPkRfz+evr4
         sjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782172392; x=1782777192;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpIkdfj8QPG4CpSin+9lKteup4B2txgLoMBJDVW3cZw=;
        b=Jfb8Z0hzz7yXXt0Pwn52h1eM2DYlRrxmKVmIyqmngdCBo10htCIVSa3kwa22VR76au
         5vrrr/38mRMpQQIzgTufNwTguE2U3DOZ7NYFNtuREQgkN8KWw2ZAr5lSRDqhMdWKzF5L
         3+ePTY1Zqt/wys7jpESKGApn2rKyeoW+yzXEIMfP7SagmNOrR7ZUgncKz7GRh4UOP/19
         Xy42hW84I8WJURth/InRX9cHQ+VEY6DtLBp99wQ+Bc4HUACs1WQQnpOzVwcqBTXISEFj
         kupXNYZLlCygediP0aZAlaB8EGCjnZIbBqzepmbOcfIBdYcJd2SHhAFyublbDz0R0qGI
         a9Ng==
X-Gm-Message-State: AOJu0YxKB2CMH4nc2U63c5dh45ujWeuwV3c2VQq3BGhezagRNeq27gcJ
	33E8QTsc1VvOyz7n4mRyqpa/YwXahS7UeL2+TkgOowGAgxH3dBXOdeT+Peoh8Q==
X-Gm-Gg: AfdE7cmar+Yw4vTtP1ZnWYgaQUGgoEWKfw6fPoift4y7+fRKCAae6zSSfliDjcR7oSX
	3aXWnoAH8Dczgqf7vOrZY5njoMO9kfam7pp6diZBJPtBWMhZw7hRcjGgQtTyNt2ic4ner0uCFn2
	p5pSlBwjJ4Ad3kt52b7uEIRUWI/x+2fKWISnRphk9fVq+oGfGjvVdNedEi46JRBxI1nfYq/et1a
	lo8BDsaA13t4yV4i4Qvf32KES3hpPvffXPBlOLQ7LoQaYjdsXrEQPdUwqhm8pIEYg8L1VPNC87c
	iqNvzslI6YY+TFv0tOWaCI+FeJbo96AH3x3AGkvmj5m7tB/NJMt5IV91kM6scWcPKxFvcayJBMA
	sCscjuF9kQVaP+D35iWV2UYVHw8b241UReTJFw/H1CL7vGb6yhMEu5swQOTAteJussdEOWuCubp
	FfYcXgM5o41kQYwhnoxiRN
X-Received: by 2002:a05:6214:578a:b0:8d1:d1e1:8360 with SMTP id 6a1803df08f44-8de40b076e8mr300750596d6.39.1782172391711;
        Mon, 22 Jun 2026 16:53:11 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.118.33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cdd8e2sm111421656d6.27.2026.06.22.16.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 16:53:10 -0700 (PDT)
Message-ID: <6a39cae6.e05a70a4.af863.7b43@mx.google.com>
Date: Mon, 22 Jun 2026 16:53:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0072250173490968566=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ebiggers@kernel.org
Subject: RE: crypto: af_alg - Add af_alg_restrict sysctl, defaulting to 1
In-Reply-To: <20260622234803.6982-1-ebiggers@kernel.org>
References: <20260622234803.6982-1-ebiggers@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0072250173490968566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: Documentation/crypto/userspace-if.rst:10
error: Documentation/crypto/userspace-if.rst: patch does not apply
error: patch failed: crypto/algif_aead.c:342
error: crypto/algif_aead.c: patch does not apply
error: patch failed: crypto/algif_hash.c:380
error: crypto/algif_hash.c: patch does not apply
error: patch failed: crypto/algif_rng.c:199
error: crypto/algif_rng.c: patch does not apply
error: patch failed: crypto/algif_skcipher.c:307
error: crypto/algif_skcipher.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0072250173490968566==--
