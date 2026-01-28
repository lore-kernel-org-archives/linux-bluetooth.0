Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F362FE566
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769604461; cv=none; b=CO/rCNVuUjCoguWi1Wj9gZ6vZz8VHgBZfDL3/FqMDrDqKWT/RD/iQBN98Rq5rPnzjlrGr5qSs8mwi1Q5sy6bhO5laaG9oaEvszk2D8jO2d6Tjg/LTICr2lINo+VYwVRXMpQx+1KxUN4ZBZfcu/X2oNb0XwFPAG0h5Uhk2TTaUHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769604461; c=relaxed/simple;
	bh=01XNrs83Iqkw0RmNlB4h+IMy53WZL9V0i6b+c7RkB8E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=I8mdbmgpQbqFEbQNuuUmqArzZet2KBPpdnqYPvlQoWM5tNVGxuSjLg6i04qjhZGJHBJ/TIRINu+MmF/v7yhXoBiJ521ei6rQ622rcVGc5Z2hY4WroPRMKUEYnkQxTeTLDzPWgYCs7dIwJ6vDWBb1ODZa1MTDSrqvRu00ZWzLmt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cipU2NsN; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cipU2NsN"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b6fd5bec41so4471326eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 04:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769604459; x=1770209259; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V9V49mDY2RAvZLfLcXZVnnj3VABPhVeTM4lOqAqcmno=;
        b=cipU2NsNAeaHhTChzHFDsjBxhhuYnzUkuUfUMrq+bXZtqDTEzDYpag8+LiMV8AJ/C2
         tzH8mY3Xxk7ZWgF/v8Pt7mi+lkfOdGGfJRWz1Bh8scRrft/ujVIqM3wVebQP2V0DSgkh
         iegTMpZdMwi7sZS3lPsaneJRPOcOJsW+dmeZGpsfCtih8vKqoBuLkJ1+FpcLY7HrnAtQ
         tOHdYKkUzN4VyIJNfsHjqd5IGdk+cmPmKOthOYcXQlc8KA2JnmgHFXFCApD5/b1nJGaE
         7a0DU7BMcJ85qKnjiNDyVwxYIQdZsVNvmrw9yAEL9BVrlG7H4xBk8EPEKFkfmPL+VCoQ
         j7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769604459; x=1770209259;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9V49mDY2RAvZLfLcXZVnnj3VABPhVeTM4lOqAqcmno=;
        b=qAnRGb/c8wj1FBR1Y5tKKBDbuv8Em03J3xK2wYzFkWgCof6/+956sN5D5LMZnmDWby
         kNy0QJ0S4bu8uNsikj6wd8z3dLyP7UxL5F3iKmXiDJCqYJDBxjBsu3aZRrHo0FPmNg/+
         0jzge7zNFI73umf+HTtf80rr3KUHcsE7+HyXQe36lVAIsyTRVxG/HOzc1V+Np8NP7JA0
         3wTcMRy31g5ARuNF/izxf8YIF55J28hh+sitEhImOBUWGGuTp/7T9pqJ3AaFEdF5lvRi
         L0+kCVRUnEj76Nl/5H5K+B+PAS6z0BzVN/lkMMkIzNUPwA3onvnPn9CRGAUqZ+F/v57T
         pyIA==
X-Gm-Message-State: AOJu0YyTeYGZv7VNVlOAiubcuzW9pHf438ZPF0txLpcazgSGoyVRLeu5
	bcbioBPODWItw5zLRz88QEVilmoJRI6CsxAfUzIDl66aJWUli+GXrQ10Su2cwx1h
X-Gm-Gg: AZuq6aJNW61gMBn8kFZlUjcRQf3ww4bZHMG77oak6U+ynQtKejgrsQbaPopxKX+hVtD
	y4Em6jOIeV7I18+VfcP2ExJW/d+2lXB80XbjucMzedJEy6+uhU6a1AwyeAF7A25QNDTtzqM3EYl
	qq/VlBG7wwS1LXdbBQlHVfatAl/iUZLxEnrBafH6MFofqpaI2RJ3oTUO6oHmy5ChygT9DIc/h+v
	rwmpFNNDg0AUIioPrwqTpmYdSGt8BLkagcmaCPdo9hgYUBh/pFB8FUYWeIdtAXssgt+Lqn2djkj
	h23/ToNUDVgEzMG+/tYjgBxYaH9/mhoCQRKJcO51x43mkO24RTlZYRrVTZ+tLmxd9rmSPbJgVvg
	n5x7e/qPkqXPbKod1ZufbxHMOImzYPfObOn6+svN4H0S41zqf9hDAiknHvjuz400PWwjygF1T/b
	McQvhMYJo0uMmh1UwZ
X-Received: by 2002:a05:693c:609c:b0:2b7:a2d6:b309 with SMTP id 5a478bee46e88-2b7a2d6b796mr841054eec.39.1769604458541;
        Wed, 28 Jan 2026 04:47:38 -0800 (PST)
Received: from [172.17.0.2] ([52.159.244.85])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a170ca0esm2472434eec.15.2026.01.28.04.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 04:47:38 -0800 (PST)
Message-ID: <697a056a.050a0220.310b43.96b0@mx.google.com>
Date: Wed, 28 Jan 2026 04:47:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3214126390355390079=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] doc/qualification: Fix typos
In-Reply-To: <20260128115359.222251-1-frederic.danis@collabora.com>
References: <20260128115359.222251-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3214126390355390079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1048044

---Test result---

Test Summary:
CheckPatch                    PENDING   0.48 seconds
GitLint                       PENDING   0.40 seconds
BuildEll                      PASS      20.21 seconds
BluezMake                     PASS      656.76 seconds
MakeCheck                     PASS      18.78 seconds
MakeDistcheck                 PASS      242.75 seconds
CheckValgrind                 PASS      296.35 seconds
CheckSmatch                   PASS      352.38 seconds
bluezmakeextell               PASS      184.53 seconds
IncrementalBuild              PENDING   0.51 seconds
ScanBuild                     PASS      1067.63 seconds

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


--===============3214126390355390079==--
