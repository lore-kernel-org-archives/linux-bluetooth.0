Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D0B25E803
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742818103; cv=none; b=E9q7aIuWYPShzIWK3/4kg30NKwVyda6NqShEzBGX981GSINivbKz2jTFVwIGX8WkxFF9MC5+Hn0TXByuCcl7I2yYSXVwewJHsZEEpCVNMo5OG/nIGzEOmkMBw1nvV7MACGcQOB5XQm2tGXeiZFCau+YvTAvZPgMxGpBU4zgxCzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742818103; c=relaxed/simple;
	bh=pbwdpRnsAA37H7N4Og1Ovx2NEg7Vfvc8JT9usfG0+sA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=N6GdMBa3CtBfVQI6G3M/kHhrq0+z/wtoSYvVZlk7hETn46z6sezIDetIth8uFOGpQ3irJHdP75XfT6lUTjewc/tdQzjzfa3j6S8Osc/jNsX8DXAq83urUyfUFJs/6yOm+qeVcA6QZ57uCmZD7CGjTHfecuRn0W+Iz74tsjos/+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ib4Qd4kk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ib4Qd4kk"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22438c356c8so79980395ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 05:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742818101; x=1743422901; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qKl/m3614rvZNljiDgTGGRHQ+Eqq4m+ce3k7wME83b0=;
        b=Ib4Qd4kkbGCy2dGq8i5qagvsdeoNUIbXGkMV9Dcpfv7s4kdWRgcHyP1gtdRYHIi47I
         TxUoTx7Z/+82jDA8O/6NgQ6Lmf0/VKRtLPoTfROrELzyvVpLm69ELzl8u9tPYz8zG8h9
         1aTUZTTr+rN1nO1TAO8ZBGAtRf2m4XSneeJKlxoe7z7cz74qVBdSOdO/hhuvkk+WDwbj
         LEvzZmB8WaKy+vWX8sFNC1MO0WG//e8qXx0NeXl881c/xmrPrgw17e5o2moepmUvwHAD
         FbY9IpJQhxwR8BMdZ1o6aGxP3g2qF/ZRnndyKZO04MZosaGLCZVw7L8i1PCp9GrQ7+Ti
         0ifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742818101; x=1743422901;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qKl/m3614rvZNljiDgTGGRHQ+Eqq4m+ce3k7wME83b0=;
        b=OGfw6Y4818tv22hCmnI+u9+BtKMqnqyLSjtmmPk5AAtXuZP9wfFaKyIKMZdlzl8iMc
         3pGyisK6feETde2edf3FCOrMrrZXg/NXxqHfwPFzA6KvRunlrwYd9hBqyiGfAvvxMl/R
         Pz60sxTxlwNMo0lzK3wQkbkKpHUUejEw5fWlTSsi+ROWieXBWXrEAg87WC0L6RgyYZz3
         iXWZUf5JCHqCOwXcfB5K8r5DxFTPb7aVpEYHDVaNMhfKpzeipjWhmd4BdIYBnaaXHJsI
         nlfKnhbBcRyHx7BuKRC58JL0br3uziA31mrl+W1s7k7G+4Sds9ah9LK0rrsjLhovA3m+
         LhXw==
X-Gm-Message-State: AOJu0Yw0cieTbB27DY37q0+oQvXt0R9LCxgZ3DloujH3KcakyQBTt9U1
	aRhc+K3Q7x3rTN1NVt1YHK8VI8IfbeX02XsDteTcfCBxjskf98RYoFlglg==
X-Gm-Gg: ASbGncuGi5zjCvK/loz9a6fJSxIsVmhAS+Q9bdPf1rvnBkOoB7YrbjstdiuxOZFWGzH
	3Os1nO9oZzHYREygcWS9Hb645u3Y+Hgr7qdQWaHMQ1j5uy2EyL92wa8cygYpyJMjRiRe78MWQ8l
	dJDnqb4eZe6x7HuUCIFZ6OjdVfnyrAZmstuCuWCf87M/bEP3XW0I6GRbkZ9euvzNRPl5462Z0mB
	jRLbzKxFnHki8uTg1xX6xFDbG/OINOrNXzqE5CcUZlO2hstAeXsRqLUd9P4qr7z9gegTSbdDET2
	Fo5MDun+7RmhODS4RPwNAHfxtDHsSVre+0BCQWHUHTpMbY3lEA==
X-Google-Smtp-Source: AGHT+IE75/gIdIUbRVe4s6Qm/76bg1TLozEWw2KQkc3aJzLD7+o6437w0XebGGZA7bMD9nRPGKEAPA==
X-Received: by 2002:a17:902:ea02:b0:21f:507b:9ad7 with SMTP id d9443c01a7336-22780d8ab07mr200428915ad.25.1742818101069;
        Mon, 24 Mar 2025 05:08:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.43.247.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f45e72sm68616585ad.85.2025.03.24.05.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:08:20 -0700 (PDT)
Message-ID: <67e14b34.170a0220.1e2261.67b5@mx.google.com>
Date: Mon, 24 Mar 2025 05:08:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8250146827601441940=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v3] obex: MAP MCE Publish supported features during connect
In-Reply-To: <20250324110429.65866-1-frederic.danis@collabora.com>
References: <20250324110429.65866-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8250146827601441940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=946760

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   1.35 seconds
BuildEll                      PASS      20.34 seconds
BluezMake                     PASS      1461.70 seconds
MakeCheck                     PASS      13.17 seconds
MakeDistcheck                 PASS      164.00 seconds
CheckValgrind                 PASS      220.30 seconds
CheckSmatch                   PASS      291.55 seconds
bluezmakeextell               PASS      100.68 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      892.24 seconds

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


--===============8250146827601441940==--
