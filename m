Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1C243A808
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 21:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790974896; cv=none; b=V2KmHxCkY8L9mPklg1YLlzL3Wl5GFK9GDTcKm0xWBOxrVKlzKqmOt9oZtjGgIsvm63jiUHbnoNnlG15429JYUSpzhq/gr7elHNdGEpqdra6SjPBceoiTZinn+JhwXhz/BcbQePG7+tH2nysSszASLpYvCWezdvgaLDBCVYeqB/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790974896; c=relaxed/simple;
	bh=jNSzrJ2uqa4mUhJvdBrAwWioGZ9kRoYXeGzww7bQVeI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JKiQUrc0n6IL4yp9Djey61R2l4IxXLC64yDJT8Jc0z0LYekmKcsXx3p4XucqFEIHfCHvjvyVJQt/pbZ1Ei5FmnW7zHRcN7ZkfXUpb6gwnIve0aD5g1C4LPqzy1P0zqmSVU8TJT1FPvT9YcSJPIGMuFfy9fH6weue48qG5dHl8FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pQzMXf/Z; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQzMXf/Z"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-145ab8fd39cso15912c88.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Oct 2026 14:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790974892; x=1791579692; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cn1EM6Jc/iI3ccYQWNPdg835YJppBEiVQq+A2d7WKeo=;
        b=pQzMXf/ZuGON6lv/yH//Veo4P2vpyz+LQhqj0o5XVZjaKt/R0gAWXR1tTny4rB1mPK
         J6QF47vktz7luMNDr8Io117wCn1Tj/eaIpcWHTDEYqw/J6j46BiXURfoXiR2b9iPXDGT
         HR+fjwbp3hb4/TCQDIvyBvHnmGIP8wOlvkZQzfVvDeoztC4tjKU8sKWBGEfGCeFGUzWD
         2qIAKqfsIwxO63gyhnlTRFCL3njMtZme6sbm91qiN/hev8b4be8YBNOUwtrgvZi4NWyd
         k3QIJ9PNx2kZXvpUL56QRoxVmeUhjPI644e/M+KRESURVB5zlI1vydBncv2JYCpRy/Fo
         APFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790974892; x=1791579692;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cn1EM6Jc/iI3ccYQWNPdg835YJppBEiVQq+A2d7WKeo=;
        b=xkVR2ZmUqAl7HlXVjMqkfQqPKNQ/FXc3J2+/rp/uriE++6atAGtNu5x1VlGW2lMW3k
         CwJHp9KDQCvmrk0MEAhEh5eXk4msbj+WSvdWOV5Qy7M3ndILbUvuH8rRssgFBoMuUWA8
         0zJ7g36XkNHKo2FLNNkHTtfI5lY/zZgedW7ND1DP6EMtMC7CHvh5UP0HHLH5dtQMN+MR
         HI2wjnt3nyhN50yIU/6SxRjlNE5k/T9fsx+vm2XATyTNEMIg8h+Har0d/V2UAaUx1jHq
         Q3mxkjQT2aKM3wjhZtDlE2rc8xePczs3Obh5/PifVRFTWFxsPY38k6r8jgMW84xo+6b1
         vMiA==
X-Gm-Message-State: AFuF++mNTMeJ6gw5kuuI0vTisZbYvV1wq1fNVXxl/fMB9OZWQYGygarW
	g1xHJvaemInRA7eff9X3lF1SvIovWkfnK/TorzEeBKqV34zULspRTQcA2oenaw==
X-Gm-Gg: AYBFou15ahpoFhbZYjFilypsFbkcPujemxhNrs0vH5SNWj3a9SU3yjsHyrOMNrADWW/
	Bq124OIptBrBzklYEHZmpMKrS+MS4hazPVmqxnKGAgbctk5t2SwjLJ+toY+scbunp82V/MHsend
	zZLIzkOiagcM7hI8CG+LQn6HfCAgNmYEBdNTtadhhmJUv5PdHn8M15G3KgZX0D+Hopdlz+FreNw
	W6fne9pGP7AnZxSssN8od5xY8+KEIRyaRAVKeXY1sGdxRBRGiOwzwXTwNgqKPkZUYp3S2QqtrE+
	+QG5F1AtYV/qvhOq7LXjMZvInwIFnAcuXXLvUow6jXMVerXmPH3FZ9hJqG5MwMMy4zzieJyKPrf
	gYKiBlSamvC8DTR6nAEBpCzkpri7NWcq2TuIwDq+n/VH5fRyyLhZx0cV8c4zNapWcgpESqgrLBX
	TLQVTIA5tKegg0hF/fKu1tAroKJA1IFr9RWO4+yPNWbTSjOOC3v4SvgDBZfwSCWiWc8mLcWFp2e
	IcuLU2A
X-Received: by 2002:a05:701b:454b:10b0:13f:b41f:bda with SMTP id a92af1059eb24-14f5bbfad15mr3865265c88.16.1790974892334;
        Fri, 02 Oct 2026 14:01:32 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.214.211])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fcec9f1dsm26264c88.16.2026.10.02.14.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 14:01:31 -0700 (PDT)
Message-ID: <6ac01bab.a0fc269c.2abeb4.5dd1@mx.google.com>
Date: Fri, 02 Oct 2026 14:01:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9001522549360113729=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, derektern@proton.me
Subject: RE: [BlueZ,v5,1/3] shared/bap: Skip local metadata Config callbacks
In-Reply-To: <ys4-B1PGqhV2wgPjUFnZLGOi_QkoCs1ZyOZl679pGV8nNJLfR28E4wDuGQti0eyGwIYHgFGa4GqfTi5Vg_nvOqQBqEhRaTlA_D9MxgEblZo=@proton.me>
References: <ys4-B1PGqhV2wgPjUFnZLGOi_QkoCs1ZyOZl679pGV8nNJLfR28E4wDuGQti0eyGwIYHgFGa4GqfTi5Vg_nvOqQBqEhRaTlA_D9MxgEblZo=@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9001522549360113729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ,v5,1/3] shared/bap: Skip local metadata Config callbacks
   Pull Request: https://github.com/bluez/bluez/pull/2542
   Created:      2026-09-17 20:04:30+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============9001522549360113729==--
