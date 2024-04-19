Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9716C12DD97
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 22:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713564722; cv=none; b=U4/yU/5yGUk1xNDol0R7MmOzFAW2arZ8kzSdiYo1MWfUs9CMBn43TiXrkrnq5QbIltOamd04+vq00JXLhvsGy8dMyG9DkHfmSqsvTeGskkV46mgf3YNyLE9IcO5QMRs2bM5E7tSgwHAjPXQsxUuiPMLllsz/ye06ylSeDFvcrQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713564722; c=relaxed/simple;
	bh=EkTRBMfqFviDtPXhrrXyMrd7xPOAOhGgtEBnqoUUnSw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uz/69JgOCgNmsySZBMEVOfp6zaAK9WSPH4a+JIqXh1Vun+1WphKR2Uuix/GiSnp6SCpe7j8yFvXMKyct4uFthN+TsuGdJV8KLwWDomf/3odnGoNX+W2tnslejJXEY7IcAWXchU5s55AjKFJ5+LfMwoS05l/bjpLmmAd3EaclajE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6hEjfOQ; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6hEjfOQ"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6eb75c202dbso1394512a34.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 15:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713564720; x=1714169520; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EkTRBMfqFviDtPXhrrXyMrd7xPOAOhGgtEBnqoUUnSw=;
        b=W6hEjfOQnl66+hcpn1v2M+ADTb/VDkEam/uNmZzP+Sn2sdV7GBirXIIIvdx3hYl3zc
         /P0v0VMtFF3grOmProzCDfaW+yzKqaamMJ+kXSIjOXF1gHj5qbQYawxpXcHQsM6+w9Au
         O0WLEN3tflvdsv7pIlAUyGwgDYnS/NSiwN7CqnQAMvu4hY2h5XSYmO+/qn4r2wRH2k8u
         oFdJ/or4fcIhzpepdXksGyORdZjJNug1ZYJkMW3nnvV4tI5kU8Uun1eYisIDQchxD9Qw
         cRa4hKXkkULWcjSYnCwGwXxtgVtrH68cfMBooVoD1/bP3e/jIGr/ZWEWrTAYPd4FWNqu
         zlbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713564720; x=1714169520;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EkTRBMfqFviDtPXhrrXyMrd7xPOAOhGgtEBnqoUUnSw=;
        b=R2Ay+oIoMKS1/cHou6CMf3U94zBA7AyC7WSticnPQyrFVmTFDn/e9plAL9lP1Lhzzj
         bAbbbc/ucBUjtzbe9DHVc+GSN58k/JPitKneRdYR4DAm89iQ7gUv7PwKZ4qUT44CikZA
         2jdaDJ4ICSs0n+4GRemhoqAAs3NBKIvM8if4Ek7+z5IWZpqikG/+ijHltmacYPuJ+A3j
         /Kdo6+JgdlH+jrxScQZ/XHoWfNKYoHoWESU2/fofNrXVqq+yIJ+0Z3ZZotRL5sj52EQQ
         py/uoI2s5qVSO+N0ftgfJppIH6qC5+M1e6Aq4I7lXakZ2GTFw/64bp3jzYerXSMl/o7P
         dqZA==
X-Gm-Message-State: AOJu0YwHfjJtF40fIcOzF4Dz+xijaynrS9cVOEju906s2/LmzQLovv7/
	f9WBnt9CWszVGjn0TnuawgTA32atmE7eeeOoaQWB+JKdSYaLev2NoJT6Fg==
X-Google-Smtp-Source: AGHT+IGi+hnOCDGvIIFjZKtCFZHm8GWAScXZQNRHoSiyKrg0bjUpEBZcTIHf62ZBbq7WTKBfwOPiwg==
X-Received: by 2002:a05:6830:4984:b0:6eb:8434:9a89 with SMTP id fc4-20020a056830498400b006eb84349a89mr5127261otb.1.1713564720532;
        Fri, 19 Apr 2024 15:12:00 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.46.114])
        by smtp.gmail.com with ESMTPSA id pj19-20020a05620a1d9300b0078f1ae252c6sm861195qkn.49.2024.04.19.15.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 15:12:00 -0700 (PDT)
Message-ID: <6622ec30.050a0220.44ccd.4c50@mx.google.com>
Date: Fri, 19 Apr 2024 15:12:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1485156720379539492=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v2,1/2] Bluetooth: MGMT: Fix failing to MGMT_OP_ADD_UUID/MGMT_OP_REMOVE_UUID
In-Reply-To: <1713563327-19694-2-git-send-email-quic_zijuhu@quicinc.com>
References: <1713563327-19694-2-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1485156720379539492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/mgmt.c:2623
error: net/bluetooth/mgmt.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1485156720379539492==--
