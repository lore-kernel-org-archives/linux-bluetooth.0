Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8EB2690EC
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652545; cv=none; b=NM6dfnI1z2f8fO9iP8EQIuntscvlJlMpwjD65WBPs8HtPWOL9C5PX4h92oNtHVrSEmfsXOxa79eXwbTenreucGeVrtV8gDMqli0ZGaXaCjL8nmUunvwv6g3H8uZk+Kwc8Jdy4kYNJOiJ+bLGSPiUIY8xTdE7sgvh5dSZnzvMU8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652545; c=relaxed/simple;
	bh=roCkNe/9TVHGc/A92u6aI2eA5r8Fk1Md41DdO+890RI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DW3VJKTlrqdmrrvJPLZjhpGvEbXMImYwUZRA0uA4uGFbdgQtvmBNWanWBGXIU+SvuR/bYNjespspOXGCzD73vT2uzOH2LL60qP9gTPKhE7Eixh2N/Mz4aSX7vco2+NyH+0FUqEMNEuuevNpLRE/QBoxzP1FjNrjfYCIXfG9fiJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKrkM0DQ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKrkM0DQ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22c33677183so55482965ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 07:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749652543; x=1750257343; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+UDz7g4Kz1014g4Y9tomWsCf1SEvfL/dzTDyDqXruMo=;
        b=PKrkM0DQ3iWQVHdP2bmphYbMFUAIDPJiTVZ898JeEnOuc10ssUYtQAI7cQTuoOcy5F
         TL40iZUxdC+xoPkFn48zm4R+wtbMUj+O2QJh7GQUq6wVu4OiirLvDTpch9NiFTAY17CT
         BrAY30eT069voxJE6AtXxvXODuvE9epuoEoNZK5gcg+q1RHXzW7iHkH28Fl5ulBKGeFN
         vFpkG8YkcaQk1iA8l8sN3btWKxdfH1rLR2fFinZhx7amLhohP1HSZNEQIykccItZ0dhr
         47GXXvSe1o7jp4u14aWGtpzsw5Z8zBfAkG6qfXXQ599jVxkIFdzKfS2VXdeZmqZwry+d
         hHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749652543; x=1750257343;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UDz7g4Kz1014g4Y9tomWsCf1SEvfL/dzTDyDqXruMo=;
        b=CQWYYrthuIoIgvN2Ya69eXWcMhoRARulcOCZQlPaI9hNtaVlBHROpxNNa1ZqHCpGsc
         ZK6KwlkRqhS0ZaCcTXtp9riXY5EikMIOumMfov/XyY9G9f+AOSrSynwjkGz4iO1JMRr0
         p4xYqFBrU9jd8+HrU4lieJFRO9FRTypO+YYs/eA/ZyBfXb9wcIh4Go4YKxefYk4bk7V8
         yQlPYLrGo3CUbjyxhJJaqExN6+etteHhDOWct5MD0c+PrTARmGzRGyJqK93Ygw5aJY1x
         v2tq7eXkC1PoBS1hLzIApJnTaOu0QTcqBN+yX30NxlBWhNNq0LnNgMgEQ9X4KUJl/hKH
         2vaQ==
X-Gm-Message-State: AOJu0YxWPnNZ4h9IQKWXPj0JS79eDzR653Ef7o9Ju5XWCaxhym/A+3XY
	C7jALodOCdxM29sqAiPJbGDqbmWxcxupNmN2lsXSNqYCtfpKnlAhdNQB3LOn+5Pa
X-Gm-Gg: ASbGnctEe9N+0csgcnrxKnjUYvOHXu7qcoSlHLQ8r0Tsfi/DslGLeiLkvMjhymItjx9
	ooKE3dgsMqWbmxiWmdLfPmgL5XV/P8wbPNXGZDzgLGAsPLx8wi9ivxj1KWSlQlHOs9v4juVGzIT
	kzfr5eiTrZfwgLxA+7JZCM+0G6vCTxgOzWYb/SMGXFzNlLfsJo/rm5htRAjQEynuYBcBnP7bN5n
	rFeZI2FzCvCBN01oJqChu2Jmsrf6CVxiVWoZX5gBPsQZK2b3BAjsd+CT/jnsQ35SvNrfegUZTOk
	azTiyFC56/Rw4TOkqM0N8VMeuao4v4TPP5+6+GurEchhWrsxfw7HNS9NaTVGz1oR//GI0bgXH+a
	Rdw==
X-Google-Smtp-Source: AGHT+IFKjbQn3v5Fe0t/aL240QI/MTz2faRVKEKQJBF/X66ACMBVydbucvFegC9fOoQJ5NqG3IIlhA==
X-Received: by 2002:a17:903:2ce:b0:234:bc4e:4eb8 with SMTP id d9443c01a7336-236426d5b9amr40873845ad.46.1749652542738;
        Wed, 11 Jun 2025 07:35:42 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.91.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fc7a7sm88165055ad.133.2025.06.11.07.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:35:42 -0700 (PDT)
Message-ID: <6849943e.170a0220.2381c.d8a3@mx.google.com>
Date: Wed, 11 Jun 2025 07:35:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1656555622956007845=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kernel.org@pileofstuff.org
Subject: RE: pbap: use the public DBus connection
In-Reply-To: <20250611131125.450039-2-kernel.org@pileofstuff.org>
References: <20250611131125.450039-2-kernel.org@pileofstuff.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1656555622956007845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=970848

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.35 seconds
BuildEll                      PASS      19.98 seconds
BluezMake                     PASS      2634.06 seconds
MakeCheck                     PASS      20.60 seconds
MakeDistcheck                 PASS      198.09 seconds
CheckValgrind                 PASS      275.31 seconds
CheckSmatch                   PASS      306.04 seconds
bluezmakeextell               PASS      129.10 seconds
IncrementalBuild              PENDING   0.37 seconds
ScanBuild                     PASS      905.63 seconds

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


--===============1656555622956007845==--
