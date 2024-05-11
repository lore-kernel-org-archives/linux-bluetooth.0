Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F3F52F70
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 May 2024 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715435481; cv=none; b=JW0eNPWIo5nrK5ZgRalqSt+dGnEPHfI4EQtUJkFMiuaiD5kZHODWb1gIPu9GrE/QoNwpjgwkdsPm+ewADmlRAthIYFGx6zV33E7iyZTmX2Z1bKRdNp4AjVEExR6WCSjRunlZUZPsPxftXtCu5OuOJi2XW3X5HyDLTcsZK59XMis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715435481; c=relaxed/simple;
	bh=vCGIuisMEfrmISk2n7SeuvmWwuSBAzczx0xOj0tKKsg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=clbmALG3OAKeUfEvd/FCES44hV9MeKFrfYLdcgqVnSL56PUaur0cFvIbb5eyeKjxKPLlR+MMmTNDDdj63f4Ift5EVmWc+9QLO79xIQOLLcpbKxtEQg31yqWGfdVd99Y6FW/Xcv+9Njj14UMDTbZv2N3Qd0k4J+SCEp8gzgPo3B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngyNu8Hv; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngyNu8Hv"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-792ce7a1fa8so94456385a.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 May 2024 06:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715435478; x=1716040278; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3bB8PVqtGGIxK/Eps1doEZSDScrlxTgPdf7BMQfolGA=;
        b=ngyNu8HvqtxjGC+qFB+8TQv9A+y8zb2Dil6hBX+C86Bn3YrzV4hm4fR6FXwszhYIJG
         PuliZlzu5Uc+R8FdqCfWzRk+AIMUOZPKOJHKMeptn2oQYHegjQttRC6DGUALK74HDXPA
         Vr6QjZ5XHdBPogAMTFErTzgoMlybhwalaf+/XOy6y5wacUzEJ44B7pWAuA9NiSU3zpAX
         cbYf0j1KwvgFIy1ovhylqFzrQSvUtRNJNF/yt3YudHw0k2nTXJFsETnC8ED1b8G5/Jed
         zCp9ntodLnvXzwnQGi9Qw1x9MngEZJ9eZcnuYhhSIZxaesS8YsaEsJOdDkDTYvoakCxp
         NPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715435478; x=1716040278;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3bB8PVqtGGIxK/Eps1doEZSDScrlxTgPdf7BMQfolGA=;
        b=no03+jJPbbjxeOGA+MFbtYAr4zpbmFkcQqZ5Ns4ir7iTTtFxAiCmgXxRSe5wm7o6qB
         NOU3in1B4Q0tfOPVVA+pPcL2wHf9fAwKUl5CJ39gm0F4H0jgyyguWCpLacABrfztd8jw
         3gudbS4WiY/12koA3/JG1sbs0IsRJLN6Y8ELJX45ZhfxK3347I83vNm3REGXrbB61QVH
         R3DqIcnmsWrHSw55VI0uEUURGVRwRIP4MMvAHASjoDl/NIiKlr3DlpWN25ax6a+em/cT
         XiS6tiTOiuBNj8l2aPkdZSWP4c8JAXPeDzz4g+pXZIPyRMxMgr2tT4DiWSmufrUW/KtL
         +CUQ==
X-Gm-Message-State: AOJu0YwWy88vBR1+KzygejiU3kjGnGVloBS3lJSk98hHpX3aaMPhBDtT
	kKzb5YkKjx04tJ1+/HJaB71sMU0kwSZyre8iXyQBVbfoIx5J3hBk+Eoslw==
X-Google-Smtp-Source: AGHT+IHRPF5cb1cp68C5kr9+FqvkTmlcK8sSXl9Jg/QrRMXxoZ49wZSqcbpt1i9QBKGhk0VZJAA78g==
X-Received: by 2002:a05:620a:55bc:b0:792:92e5:4f1 with SMTP id af79cd13be357-792c758ff1bmr601393685a.24.1715435478554;
        Sat, 11 May 2024 06:51:18 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.107.241])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2a11e8sm276535285a.58.2024.05.11.06.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 06:51:18 -0700 (PDT)
Message-ID: <663f77d6.e90a0220.d3627.8a58@mx.google.com>
Date: Sat, 11 May 2024 06:51:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6339949491598195915=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] client: fix ISO send data rate
In-Reply-To: <9b88a0238679d24aa5d68a4c473483943a8ea2b6.1715427163.git.pav@iki.fi>
References: <9b88a0238679d24aa5d68a4c473483943a8ea2b6.1715427163.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6339949491598195915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=852520

---Test result---

Test Summary:
CheckPatch                    PASS      0.41 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      24.81 seconds
BluezMake                     PASS      1755.50 seconds
MakeCheck                     PASS      13.61 seconds
MakeDistcheck                 PASS      181.36 seconds
CheckValgrind                 PASS      252.17 seconds
CheckSmatch                   PASS      359.45 seconds
bluezmakeextell               PASS      122.46 seconds
IncrementalBuild              PASS      1490.77 seconds
ScanBuild                     PASS      1058.36 seconds



---
Regards,
Linux Bluetooth


--===============6339949491598195915==--
