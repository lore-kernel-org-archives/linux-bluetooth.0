Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC4E209663
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739383776; cv=none; b=gA89Emahi+0JVV1OHc7mo+z2gdBCyU8YUk1jEGkzLEDOlFNUb8eekxE+mIHxNnBnoUtL1gkH/ioQ5roWTpb9sSOUO3vt0jd79mNybRwVgf1Bz2137m0ox5kByuEna54KzQxJPKrLj4jJCA6uCsdexMAJwQ8lkIb6FpKv3H5DYwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739383776; c=relaxed/simple;
	bh=tQJWxdkvU6nU4IzHY09MZ1vzzgB3PIV+Em3DHnZILc0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jPqp5ASek/z2hSCRbMfYBcHJ3nEzlH7NCKowc8hb8ajBl/f7PL+T0Ek55vhKUEKJmlwziruqDEeAQPCDiHsnzxG/yJoGJtv51ylVupLbyxJb7zgGF55DhY6vS2yy4Dsr4WgJIRrD30COo1avrGtYCRbgbVz+Q9ggIt7N2+SceaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3s4YShn; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3s4YShn"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46fcbb96ba9so81320871cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 10:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739383773; x=1739988573; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nVU+zv7B8B7m789AJbwJQo3xc3WY3hhZ0rMXrPhgg3g=;
        b=h3s4YShnQusOpZ1CBKnGLa0LIlAzrWeMei4A9qHwvsIWZpA70oVQoyhDGkl55wzZJE
         7yLnAWUEAQ+643TS8Y46XyTf70a3TRyVz/yXzcmReKs00PeOKdK2ocsiVNgBJiNfxnzd
         JqfGIs3LrYqUmYkxU7JLQNz0GxAASFvJ0occgX30do+SizBpBXZMPGyWGAOw5ik+W4yY
         LvSSa3KHZxVKJOJoE+2kpbzjbkNuI+iAziRerbhbM5E1Is4L+aYYGv8nhWQO3ZBFnMYY
         5jG1RrYoABHWFcc4/2DMWVzeFQJJ2UEqFJVawRH4kr9hniKOrYJZxnTgP2EhRGhGj0/b
         u2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739383773; x=1739988573;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nVU+zv7B8B7m789AJbwJQo3xc3WY3hhZ0rMXrPhgg3g=;
        b=BSC+idXKrbZqht+lwVqaIqDhKIYgTNoDumRFK17W5Y9BBCQtDfXQFE62fj/GGDX6KT
         YAu667ukXH5YZmx4kCRtmfHG2kH3JMFzfa1KeJzHI7AAUvx1++yQop5+QMqOW6DCqG8b
         t8m74t2OyVadmZ/RiJD4OdPrQSxLI3SVKsQj03fwhEZC3/NCc1ZUHqCmB399Tw1HoqES
         TMUNz2aUzlH0qDLeCdictoPOuoj9sSNNXLNEeUrs/OFrlvpzlB+UjE+ppdHXfgYHW7BL
         +m6wJTFl794QodD+qlJRUhmTYcrq7azNodUZH0uLTAspvEcB1RgKLENTsGjtpKOZvU9Y
         Y+Ng==
X-Gm-Message-State: AOJu0YzZ1c2pwpdrJpXgKcA5pTffhk3dZt1K70MAogltbP2wYyoiS6+Y
	8fsiKZBgaMsiHPiTrJ6svwKJHU954aOwNn+UxZvq62X5deKGA3LJZEM/rjp0
X-Gm-Gg: ASbGnctYidFSfI6SCyaC0x8kdPMiM4dgmLIeq63WymhEL0oO76nVtw0tF2CwktyiNQ9
	DqoVqP4NZXzV4nyflUBBg1uP9IGWCFV0dA3G3oEvvTAoh+VCXwEU0RY8k+DhF0MMoh1BbuxOC0S
	twp08xmiLiQCHkB+E2FgrszueqSnJcqlsah7sNUH7uIM3HWhz6po7BhpTzAUAESJlSnF9lnr1lL
	HiNZgWOJkKSEEcL/zQwJHAHv7LC68H9Q1NJRKAkT2YbVXUf2DbbOAyjJqzb6dpJhelgFEeAl3Gz
	zRT9EOnYPkp0afZDs1Ghwng=
X-Google-Smtp-Source: AGHT+IEwtUKxoyaMYbCzu0BHJ+t9IPJJj8g+/9+gxOOCUbgdSQOeI5PxIO1RkGiBbl3mEE4N0HZybA==
X-Received: by 2002:a05:622a:3cd:b0:471:a902:7e5d with SMTP id d75a77b69052e-471bed52bfamr5374841cf.14.1739383772950;
        Wed, 12 Feb 2025 10:09:32 -0800 (PST)
Received: from [172.17.0.2] ([172.183.111.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471492a8ab2sm78324461cf.32.2025.02.12.10.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 10:09:32 -0800 (PST)
Message-ID: <67ace3dc.c80a0220.19ff26.b4e9@mx.google.com>
Date: Wed, 12 Feb 2025 10:09:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2953814249284967973=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vibhavp@gmail.com
Subject: RE: [BlueZ,1/1] adapter: Emit PropertiesChanged signal for Connectable as well
In-Reply-To: <20250212165820.179487-1-vibhavp@gmail.com>
References: <20250212165820.179487-1-vibhavp@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2953814249284967973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=933274

---Test result---

Test Summary:
CheckPatch                    PENDING   0.17 seconds
GitLint                       PENDING   0.19 seconds
BuildEll                      PASS      20.59 seconds
BluezMake                     PASS      1547.01 seconds
MakeCheck                     PASS      13.33 seconds
MakeDistcheck                 PASS      159.52 seconds
CheckValgrind                 PASS      214.82 seconds
CheckSmatch                   PASS      285.50 seconds
bluezmakeextell               PASS      98.71 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      870.26 seconds

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


--===============2953814249284967973==--
