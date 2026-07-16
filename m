Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05927433BCC
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220974; cv=none; b=eoH343frqS2/fvcwKm4zWGjYbE2KGxNSszJ7OKNHGxP2wwxWDZQiezKaEggH6gsQhDszcy+RQ6IKQX+Fh8vhGo4HjbBg0y55U0sHUcCrGd5pJbBv+jwy9gVv3RSjf8uEA8/khTAUPaR1NXbrsutiZKWRg6LHs52/sef1yGyqiF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220974; c=relaxed/simple;
	bh=VexEaNeEc5AchWmUaJKZSIdF4r8yWHkv57laLyz/cG0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JfNYjqE/5eJ3DGsO/7ppa3mF+QiYYGRX9OKAfxAy+8EJFcuCli8AJQtC1utlZaRGf0qMP9Ax77Z5NcDBi+hcB4KffVfAIiZfkiEZmLcUQ8xYOfWbFRFHEPx76y+wTiD6pVSKwBbyNP7YHA6bk9trhABf3KzjPbwJmp0l1xbEtfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngwZkByj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngwZkByj"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caea3f742bso83670655ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 09:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784220959; x=1784825759; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VexEaNeEc5AchWmUaJKZSIdF4r8yWHkv57laLyz/cG0=;
        b=ngwZkByjwQZSScpPmLZYqp7cu/x39MzJ1Ok9M0UDbhgMFUo3DaZHfOzG+ZfQLTd/gf
         NP7TIvzXRV/j/XJxjk8WyAh2c44htaSqEYvm4CIh8zHwO7CKLF+B3euQypYVujuiHSrl
         ABJUV0dTyjPG1yCH8R6Elz5NTrJDC7c8FH++ViNM+ELcR4gybvfRHKQD5Ko1pme+63Eo
         aAebwr2gf0mgUutvxVpmYNfp0zm/MPzGbttwN+zYhL6psSICJhXKANcTXBc/HPW9oAmi
         6CmHrJm1aQRU2E+WjYfjIU+1taqr3Y/CmkO5E2cAK8Oq4oSq8Gzks/4HbBmGFkJWSbiu
         TKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784220959; x=1784825759;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VexEaNeEc5AchWmUaJKZSIdF4r8yWHkv57laLyz/cG0=;
        b=kurSPC1ZSiyXQEAwFChFquLYhZWeRaNVqzWIc9645hMcHmhhLBJEDQqn0u4YKpyj5Q
         e45d/XnSLVfu3Q1Env2CkLsgEOIpaRKWSsbGB3099sc6nRsECCWWd26vwrC8zWVGh++F
         Dxj10kT+/vsf1LjKrr6dySvNBy7gCOI72vNddr7mBG3lMpYbePSWJ2q3RKihp3hmradn
         smR65jZJcf/CCcwKF4GuT+2LU08JJoXONbpiRj0otHttZqdxVdGqFA7rMZxD94Ls9eM2
         vxZg0ItPtpnv+W7155e6iE7dMYBrQaGeQMIID9mElzl5zZ2Li71225OGQLMoFa3S44MO
         KRNA==
X-Gm-Message-State: AOJu0YyNHuqDCbwCJTIfKdNFzOjFmGOLd/6QrbQmDGOFVg2DaRFHCxUC
	67Ahor/2RNAUKg9T6xyMc0E1LTsCVlE52ySuJtWZkig9xFQ9Yz59vW0b2vY9oQ==
X-Gm-Gg: AfdE7ckwacViMJ7aKSDycwrhWo/RmlKDovOs8789WrnpCm92teqfXBlbm86FUFYZTgp
	JRJlMIQMeGkSPIDPeOaOAVw9OT4PY2szTsNoP+p+zSx85JLG2wyVo6f6RfxzVQswFzb4MINFP+L
	u5m7/w/fBVRFRXrRJvWJkeCXm1lBjrp6pi90F5lAAMbjBjaMjyJws122RzKbN5Q9OcW7JRfMjkG
	bA7xGVMD6Flude/U/Xv/0CY+1cggHmHhHHo+UBw66vqpnug0godFEzrxhFXZLHa3RTLYkOXBkfb
	NvTe/weA9K4joUgWYisEz6X56NBeMRfpVoucAKfxT+d/clB0V5fuzPUA54/jvZVi0k8tPdNihLx
	YTmoLNBOGDu4HBB2AndZrH/NOajrL0NZ33FNpeYrBqkoBvt5JpKT9cyLXU1kt/PUfVSnknuHCUL
	iCx5OYPw==
X-Received: by 2002:a17:903:2f4e:b0:2cc:f43b:fa4a with SMTP id d9443c01a7336-2cef12fe20cmr130690805ad.24.1784220958962;
        Thu, 16 Jul 2026 09:55:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.29.191.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf105affd3sm22743835ad.60.2026.07.16.09.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:55:58 -0700 (PDT)
Message-ID: <6a590d1e.5fe1956f.17fbe2.5296@mx.google.com>
Date: Thu, 16 Jul 2026 09:55:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5371204854794050862=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, loic.poulain@oss.qualcomm.com
Subject: RE: arm64: dts: monaco-arduino-monza: Add support for LGA WiFi/BT module
In-Reply-To: <20260716-monza-wireless-v4-1-9b02e6f549d7@oss.qualcomm.com>
References: <20260716-monza-wireless-v4-1-9b02e6f549d7@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5371204854794050862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/power/sequencing/core.c:991
error: drivers/power/sequencing/core.c: patch does not apply
error: patch failed: include/linux/pwrseq/consumer.h:25
error: include/linux/pwrseq/consumer.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5371204854794050862==--
