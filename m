Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4273F86E0
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566263; cv=none; b=qv4KxlW1EUu4Y3Ws2MzraqkUsoQvzG5bYKc91vNTAx7zaq99q6j5+DZ7xAnTppxS+/Av/FR6tPcOFAVCmgdkeTO+hZaULCj4IVtZoue4WTzb8/JQDUvqP3z+sumSIhr0EaDLTjGttBxhoyA/QYHMXjqeJHpXBBBRrvfB92jAYoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566263; c=relaxed/simple;
	bh=1aOLzWCI8L3Vh7p6y0wovaNGUVnAB7yqQBbKuNPF96M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=miJl1+mkF9Xl5g6JVeN+RmNFusxHpy9bJcz/EQ1Bt1jEYi313DQVrIRXy8KTuBPvsHqwsLqg5GN9NHxKl5gK46ffRtfBMzkjAkL5TqbypvYzJD0+Hr18HLEJDP9LkW2RO0GiR9IbW65Kr+o2OJGEFSQHfcf2j5kcNUCDq/GR2cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRN892hy; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRN892hy"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c4436d02cso17006321cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 03:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787566261; x=1788171061; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1aOLzWCI8L3Vh7p6y0wovaNGUVnAB7yqQBbKuNPF96M=;
        b=XRN892hywm5GAnP163yzi0JrWjYWP9KsydA/8TFJuRG+E1o3GLUbV1OXMtuV0cqJvc
         e1sDaAqqhAkT0AuLY9J6l9+huaM6qVo10qzAI0wNnd0p59bzhtA7oqCRwR7gyZzpIf1i
         y0v15k4pfEIO4CqOR6JcODYsSiVijx0GwxNPHqeJe3Sj50a6X1TGNyXinHVa6ioPGvaK
         1xxUf7cWtxe8wkn912eP50Z490ExYvB6I3CSEV7sCdGGE4SdE+bubjFV9t4WZ8Zq0ibf
         rvd/u8gHRpdneZmVE0H2x7zVPyEDU7SlVYoSZMejLufENrOpn+fe0ZrhJ02HvUnYfsWT
         oFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787566261; x=1788171061;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1aOLzWCI8L3Vh7p6y0wovaNGUVnAB7yqQBbKuNPF96M=;
        b=oVX02Artee46bbFAimrIGG9PdQ9veSHCNjDwn2JNIrQF6Ir9AqvAXsAFgsi+M5CuyA
         rwKtVQAdn59KMnIySwaedvhIvhWJ6YcUvY7QvXRlb8yO/CU5Isq+CVwKqGM76oIQ/oXN
         hd29MRa8Gf3BTGHTwoamZgLvJIVcHuU/c5fnPp9zOIBG82QUf8dMeJgq75wWOo7MbPdM
         ULm23roqDSzNF1CVZ1RmA6JqIW2X/NIIoScmQ1qulbHLsowgrlQpQ8bBv7XnbvWQlEW1
         3l9n2RPaG7oKSLG1XAFLqFK1K+F5i82byw4kinGp7El70Lt3/ctM/yGroveX36vpXE+M
         jcUw==
X-Gm-Message-State: AFuF++mdpg5Pp3Gg7PQUtVZk6IkxrZkJLuLlT5v6yOe1f8NzrgAcyBii
	C0ROvqlt3+Zyqqp/5vI/VR33VPn3/JSqm7uVtjGlpgzDuxBpDleb6m8wSCYERg==
X-Gm-Gg: AR+sD13N+G1OPc1DfFoaYOi5i/UKl89gOVXim+WTtCbPut7EfurZXVkHDsZ9k3JEOvm
	+zOvBsTVssRGgst26YgX7xQJh5+QigSWNJMwt8ljkmq0HVoSm+tGOg3xk55NmNly5x6Y0ST4WfF
	T5+f+aIumUo07YBYytZiSNU59JoyVWgoqMZIoJo/kh3GOPiEKi6IhdJe6hwg//sOfl5+qGaANvt
	0Hx99E3XbqQ0aUNc/xCoJr4JJn/SOODY+lRSkIDww50uFUl9NLUyN4YhBJzVQJWrwNsYcrEv3s1
	OKCghp1SEzS//C7iH6JvFuN+vX1fnYerMl3sSmF+UpwoyVCr2/BCwddZLFxHPuSZ+XfdWD8Swsc
	9jv0MKOE3VIW93aj0iB0UMjkXd7ORgkaBQrGUlLEEsuN7vz2KhhYn/xGfphi2QvPPYscHRhCPEc
	ZItvBGyZbe1BW/XA+nK8/ON8Z+sb0e02DHCOdJOwr6ewZ47HA5t5k1C3ujJ2jvefRj1PmS
X-Received: by 2002:a05:622a:2309:b0:528:38b1:b539 with SMTP id d75a77b69052e-52df572806emr273715501cf.10.1787566261319;
        Mon, 24 Aug 2026 03:11:01 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.99.100])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c935fb90dsm58206436d6.14.2026.08.24.03.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 03:11:00 -0700 (PDT)
Message-ID: <6a8c18b4.4c95d0d1.32375.ef68@mx.google.com>
Date: Mon, 24 Aug 2026 03:11:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4534932820190996110=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, radek@podgorny.cz
Subject: RE: Bluetooth: do not leak an hci_conn when a second LE connect is rejected
In-Reply-To: <483d88b5-138c-46a0-b377-a6ebb43609f2@podgorny.cz>
References: <483d88b5-138c-46a0-b377-a6ebb43609f2@podgorny.cz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4534932820190996110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 10
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4534932820190996110==--
