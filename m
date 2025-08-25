Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A039301006
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756141667; cv=none; b=GTr/Owtg+ZBfQOsKIhcmaJ3a169fHhR3I4cK3qQDad4zLm1+AfA/weHFzz70QHkNlIPoLFtTtQb+Xrg4esF2efMqvow8wAGIgVXwZh/9kWNMdOSONYMXbMdiWUYafai2LK4mzb3vz+2vFsJ0Itq263qe3zeXQ67heiJl9I1P5HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756141667; c=relaxed/simple;
	bh=YpnGk2TtrgRYFBlo+zUIOi7bzSSGKnaNcp8ZazKwnoI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kqMnxo9jlsuZDoWeGDCSyuV9Nd9oYHEA+XhLpmfhb2TqL8g7385Dlcj5TO6nrL6V6fnENvSrVB7dgwh33ATqrPsb/mrsYvslQ6mOZRBcrd7vfYtXKNtepFmavvqgSnGrw6xehSS//OjVEtKqL2km48I3MoHv00ZotiYw6s3++l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ml5sXOOR; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ml5sXOOR"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70d9a65c335so17995126d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 10:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756141663; x=1756746463; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VqsOeFyYmI+GOJnC1x4zVSYqsE4aZ2fqNFWAiDwrlk0=;
        b=Ml5sXOOR6cimrJ/mmwSk1cqOezyEsWT4U60OSoyorvAhkm3j/v5Jqry14cSwyzjEXu
         qoKQgQMBZVX4hHtgrw+27gOw6jMrd6UPQ/fFs44M4V1ryG1e0hPmhRP1dqnoniSu7Q6E
         qrsLNZ4zML3RluotTgmROW+OGAFlPyc9duIMCnMJVyIZ8aKuHBZvxk06qM6b/FyDsEor
         rlhO4xASa90AVspRdi7av+q+FRQp3my4FaCu1TLdFyMzzASscHXYrEzfpCLFxM5swUUh
         IIqiqqqj2tllSz4C/Tqf5b28KjSlpB7/TZ8FnZNB4yuYyhWtf4jWwNci3aK75mMJgjX0
         osww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756141663; x=1756746463;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VqsOeFyYmI+GOJnC1x4zVSYqsE4aZ2fqNFWAiDwrlk0=;
        b=kFMBZM+KRn00duiXHb98TM9+bXIHRYgh6wdMegeG+IWq9Zsrzxp+QdRUuof46snBIf
         EL5I/ENFlQDKIgRFCzOaZxicPAruWCiI64WgT3MtpO5139C/Z1GRxaBZYOjvvQBWCOqY
         dSXxmAwbXvCcrn5K43kxsjtYMfY2z3dUIlqobKGRezKbkt24CFB5Afef2j5MSM+y6Aw4
         8vYCDOpp+rlKBK9e2lEVflHckQfWakib6Hj2xXiF7yAey/xKwlPzd3wbCE5KrKMj7pJy
         GW3u0RDQ4WnRfgEq+k0/ogfuA5jUK6QOck1JxLlOmEEUlEdxn5t+Casz/w9XPhH5tSIz
         ZqZw==
X-Gm-Message-State: AOJu0YzSQwZYDag3uYDc9FIbZMSP6nxx4H0v4FrCksq+QEWWqFvQyB+E
	APV3Ig3Cg2wb2D39BBx+yqXBBwPIcOBk0VmHwCKQo6/TjFb7xpXmZQ9ZX3Nbdw==
X-Gm-Gg: ASbGncvV6PdIW+xjiNsnqpJTJU5f1fEO2o7Fg6FbA0XrR0uYVR9DVDLcajM9SuNHqGs
	yPQz2L0mtrSU1pXQIN/vohK/m7txRJLdOrTVLzbseuP6J54fOp2jCUbUCwXNu8Dz0UpGgVspgRO
	Vmidq3nNmmhsmBOp5vAeeAbrZvH0okhtS0c423CNLPMvM+36Tn1A8u3+hgF4vs9PkcF7h+jvqXn
	lcZ7Os3AVS6WlCh5yXPb1cdqewMM/O3civqImWpSVPuc+d1mBj/b92fSxMn5WfvJ8szus51+0cE
	1Hd0kMEIYEig9xJsLvrHu+1yowBWo1vNSubTTw9c2yUtatPO0KNk6eXhVnR9AohVsQPx5vJx0V+
	iSgI6vr/YDCDYVi9iYpYIgFoADctk
X-Google-Smtp-Source: AGHT+IFJS+zCF5vu9LegFJ4eIYwx8dIwFCPg69TKY2kDWmXMQH0Nqflq43/SzT/eNOISTKa3S0gJoQ==
X-Received: by 2002:a05:6214:5191:b0:70b:ca6d:24fc with SMTP id 6a1803df08f44-70d972c5165mr135888516d6.24.1756141662449;
        Mon, 25 Aug 2025 10:07:42 -0700 (PDT)
Received: from [172.17.0.2] ([52.150.29.104])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da728a250sm49207836d6.47.2025.08.25.10.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:07:42 -0700 (PDT)
Message-ID: <68ac985e.050a0220.155e9d.3cc2@mx.google.com>
Date: Mon, 25 Aug 2025 10:07:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2920181145088916184=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ] lib: Fix includes in installed header files
In-Reply-To: <20250825154632.336611-1-arkadiusz.bokowy@gmail.com>
References: <20250825154632.336611-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2920181145088916184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=995294

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.31 seconds
BuildEll                      PASS      20.33 seconds
BluezMake                     PASS      2672.70 seconds
MakeCheck                     PASS      20.59 seconds
MakeDistcheck                 PASS      187.71 seconds
CheckValgrind                 PASS      238.14 seconds
CheckSmatch                   PASS      306.34 seconds
bluezmakeextell               PASS      128.14 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      922.38 seconds

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


--===============2920181145088916184==--
