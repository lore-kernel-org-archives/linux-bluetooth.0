Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40203768EF
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 02:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722221521; cv=none; b=mViGztloHKyEOVnFx73hCksh3Tn6GkiyY7kePy4hM6aNOTnfwchj7pyusjflcty5M54SJ9gkV40uIuLMqDwbg3XNQ3B1WJYkFU7eXs2Y/p0CnweqptbFKcRPu5rc4ZXNtCuqJrRBlwzNhYlgOPi+rL1FOnAbUVt0sJk9gA+ng3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722221521; c=relaxed/simple;
	bh=PbY98qErof6k6DQ7PIDTcW0MiuFpUQHIIgHs6kyYU2U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PGtTqXpj9EkFMl3sFxNLmMzGlYG00bKx0H+tHxjB+sb343SAHJBthQRGibswcW/Cz+ZOuaXb0jiQldC3x4rNOq+4XxCKWNvqZRSe+g1io96uvQ4U29Gk7PlfYbY+qXBGmzIr88rmxsd2l/Qa+xSPzmDFBUThPqD3jGtiA0WkRQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JooIQliP; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JooIQliP"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44ff6f3c427so10703911cf.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jul 2024 19:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722221519; x=1722826319; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PbY98qErof6k6DQ7PIDTcW0MiuFpUQHIIgHs6kyYU2U=;
        b=JooIQliPpT1beczinN8aofsjmu+iaPKTQ+EwfBOgjM9BvDoX+pv68mmAhccHjh/yw2
         JNuZYUqo31ADJvk6VXrgeHyZxPTzbMGzp68/Yt7BmZbnC2GEjYMUlyDwJxcVOsJr8cUD
         H5X+oeyVMJhk7DDd27YWMVhpUztOat9/S5xLDfKekYOMc8lylhqup4F81GXR4RNLC6xB
         Ln5fQkUxNCOzsPg/VYOMZVUGJr1RpOiC5aFy9J3jrmNfEikwoB6bxfHOW7qqNzJYAK2F
         ogmx6NaWzqSRlg/gzCKoHxETkR7pRWJLc91mP+FajHKFj8lLAKhW/OKXFzZGLx2l1TkD
         PZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722221519; x=1722826319;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PbY98qErof6k6DQ7PIDTcW0MiuFpUQHIIgHs6kyYU2U=;
        b=MzjBnAGb9pNdirQtYxK2uLQMSB23qdqFmJq3NANpVdIPNnO5rV5eE9PKy1PL4BmbYz
         M1ICFFABgD3+Ri7S+Eyd09ucDiRdUHLfZFBS4ZIxfdJ10eLgu7fU46/KGMENB9hmc92J
         bfQc3VPFiBcdpZHiO+ccoKLiSSNzZ4OeqL2iLwr5GjZP3WmdlH7SFHjoBx/+kyypoYdo
         g675i9dJj8ZFVcUSbULr3ftKW6ZNbvc/8XpApXSDRKJHG3TZLQGIRLER8BNADt2b0qSZ
         HvjZl8QYljHYvTWOmazM/2YLUGOz+pLn8A2Vc5T9b9ad+4Xx5orLZx91k8RqiTJ/x57b
         WN8w==
X-Gm-Message-State: AOJu0Yz8MQEq/73T8YLaxf+eIfK937yCBM3KdFtDMLg9RxQux19H9XG5
	zYGZaJ35D9QWUcqiO0e4VTKYLxIfMsaD94+TUwCJ+B8o0dLiYT2O02mAaw==
X-Google-Smtp-Source: AGHT+IFf1ljM9LhWx4aRrUvL9OHlfmhv+NeCCNHn3rz+D1M26MHgo4CzeofuzhXqtwb1nqs7XDNdCw==
X-Received: by 2002:a05:622a:180f:b0:444:a454:8922 with SMTP id d75a77b69052e-45004dac31dmr57882611cf.27.1722221518856;
        Sun, 28 Jul 2024 19:51:58 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.58.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe84146b2sm37885461cf.83.2024.07.28.19.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 19:51:58 -0700 (PDT)
Message-ID: <66a703ce.050a0220.2360d3.a969@mx.google.com>
Date: Sun, 28 Jul 2024 19:51:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3904171313175820582=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xuerpeng@uniontech.com
Subject: RE: [6.9,1/2] Bluetooth: btusb: Add RTL8852BE device 0489:e125 to device tables
In-Reply-To: <103A367645D125AA+20240729023508.12747-1-xuerpeng@uniontech.com>
References: <103A367645D125AA+20240729023508.12747-1-xuerpeng@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3904171313175820582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:554
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3904171313175820582==--
