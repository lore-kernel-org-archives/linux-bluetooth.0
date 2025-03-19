Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF599255236
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390914; cv=none; b=O+v7ok2py/fiP0DZU+F92+LqhAgrObA7ERLbquD0aBKBGSccciNvzN64Z+7ejwm7TRmkSC79KrNIS9JZMpWGJtKuC/dWAf2oLMTI4SFPUOt7xBFPF6BITpAsWIJuyRdxNNur9/vHFgrFThVCLS44CaFsz9JVex97NcncVR5JjhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390914; c=relaxed/simple;
	bh=CbEAxcW8Wa/h+lb+waRLF79LInFZ91PbumTE7dMitHU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rlKjhn3QlA1AoN7UZ/n+hsKbl1hapVwXmzDW4YSzXR73dfqDV8m4FLV/wtBOPIN3CeayJqdEJYWSB2iOFkHPzlFBkMTfGd3ZbXiEeo9mR3bHlM0wg5cIFFSCvmbUse9MxezNrM0MADBOk+E7PQN0mW5yhwiDM1eTqniEuXH3u8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJu9Waxe; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJu9Waxe"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6dd1962a75bso47466946d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 06:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742390911; x=1742995711; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bcudvGW00yPow2jGb9U/lpoLV2q7BFs6vetFRSepA7s=;
        b=WJu9WaxeF5fwEbDmt2AwIoWsqgs46yNk7LQUDoSfJoKmZULdxgKm1l/2OQ5Z664NhH
         ud6BuTqAMEK/SeVWK/7u6P2l2lGAmgkDo5PSuAo8Odm2/ehunYFqmzBsS+WjELk2iDuv
         m68F01prtvVP+C/G27PF2uEWcV1xk5OE33j81hCXYj1zbtDjF7jsBSSAkKYXzlKAvZ0y
         Aaqi5TeF5QAGkC1QUa6LQsQGnwSjPGyou8Z9f6grWguK9L0KLukOIsy2xvbIj9Q1gpqK
         IaaZFg4pozC3X72N438lONtud5zMYLI2hjQC1JZhfQExoE0vA7UKCq/BrkYqbJQq/vOK
         TqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742390911; x=1742995711;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bcudvGW00yPow2jGb9U/lpoLV2q7BFs6vetFRSepA7s=;
        b=BUKFdvtamrKUnofNmisF6dr3xOt6eIk+XxbPi3Aw6/KDlsufPCm0ZaDCMkhZYkHkn6
         qwPmBv32xmRqg0CKMTpQepsvWplEzQWODwURBGBZAwsUSjgZRYo3fJNC7dvQPxW5+Hqa
         tK+qHpshSw4dh9dcT+HLx5KmJts2D7XAt7kj61fjYn85pjVQywSw39pWnwqMVYZLDYmZ
         xi3wkyQ9zV4ykOXd1o+/xHVTfFVoool6Z6CNrXgiCzXbySthyyqGcnLXMa6RbCtpWXHv
         BCziHboQlLqOSRKVUEnBsgTZjkWgu6rQqThzU+xCckCaihBp/Djsohn9XtTPnapcoQES
         0MCw==
X-Gm-Message-State: AOJu0YyOBnRIwy+BaaqCl5AVnNJ/yjUxamgc64EsSL03lcKAUTbloZXu
	CHqo0T0ZC2Oojq3ngAtB8TG38huvPSQ1vEp7plU8wpRQ9yGa+ZImRppTrB/8
X-Gm-Gg: ASbGncthVwdpd6ZMlJDUEC3acff7tXEngWQW1A2fj5AbtkTMrkq8q+biIMZswfJ6PwM
	O/snsa6PIPl3a8LEtuIU37u/FRB995eyoCz49Pq+9xq1YJnl7mLJfkAVnuSV9ek9PNHGD5mO8UG
	R3ik7ah85ZnIunQV1062lq0+Oo6yw3zq2jNHJmwOoBYIc+LLzmJVqg3sBCS/0b+uJc32Vs5PxaG
	oHu8tpj69glAm3aMurXOJKX8wH0iMVqrxccw1HpCOF3xPkxkNvkwcBxDj6FxbWUrPtMfYWYn6tJ
	1uAVDPpT2tsJPTJCSarhIaGr8fTdpFp/5pJ9QQqDUg6Wio2T
X-Google-Smtp-Source: AGHT+IGM2dtl0fduNd9c4Vnvskch45R70saF1z/mgFkfJ58Cpyy6IW+iQbSS3ugPRGYOq0ldQT1ssg==
X-Received: by 2002:a05:6214:1c44:b0:6e6:684f:7f6f with SMTP id 6a1803df08f44-6eb29282e82mr38974106d6.7.1742390911482;
        Wed, 19 Mar 2025 06:28:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.46.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eaeeb1370asm62816576d6.82.2025.03.19.06.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 06:28:31 -0700 (PDT)
Message-ID: <67dac67f.0c0a0220.388a83.6d00@mx.google.com>
Date: Wed, 19 Mar 2025 06:28:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5290967110519384720=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] profiles/avrcp: Fix PDU for SetAbsoluteVolume with top level bit set
In-Reply-To: <20250319121218.166878-1-frederic.danis@collabora.com>
References: <20250319121218.166878-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5290967110519384720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=945569

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.20 seconds
BuildEll                      PASS      20.99 seconds
BluezMake                     PASS      1518.84 seconds
MakeCheck                     PASS      12.87 seconds
MakeDistcheck                 PASS      163.50 seconds
CheckValgrind                 PASS      221.40 seconds
CheckSmatch                   PASS      293.42 seconds
bluezmakeextell               PASS      100.91 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      904.44 seconds

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


--===============5290967110519384720==--
