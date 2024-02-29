Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C463612E
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Feb 2024 18:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709229974; cv=none; b=sCiBJg2eCYhKrXdBpwUP7kz2bwmW4atsfO0rLXC/Usz4kodF0WkfkBtDhg5B0nvkqcII5A8j3EHmDf0VfXUz45eQ66ZUh9CFac0H0YU/CL3I3CcNhrrFpPABa3U1aj0qX5EhwYdILWDp1Vh6JQAwc3HHkWA2XxKQrWDYeihSb8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709229974; c=relaxed/simple;
	bh=11MXlIn56oCck9adY/wf9iPfyBz23EAFqyXBVJO5yhk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YbZ4zgtJXfmFOK+Ht1aGevzwWDrNg37N5wf64ijazpKZ+o1/F1RpO2wjBKbVmjb7hy5gkLZwfkzqY+3mDDTwft/FaZi181wT9FKEN182JE7Y9ZGv4VXvsnt2s/h2x8//pugJeX8P7W2yg5ULvDipoUZ3Kxfli+HlkaGaEDQ1HTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOSdMlTy; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOSdMlTy"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-68f9c01a148so5385226d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Feb 2024 10:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709229972; x=1709834772; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zuNdEp4skMAQKlvJsve0fV5N85aIjxWJQmW98+WMLpQ=;
        b=SOSdMlTyqRBW3GbStcnINZQ5qxgV5AMp+kT3sqtUJfndeSjHRj6YGT2SDVK4qlALVd
         4nyun+F/i6ZiygeNnDSyNc4UFmk5DyZ3VjKKl61aVc1kpgTNlHqVJzU9NTGwqp/aeJC3
         H3pD0cdHodDYENKk1igaG9TpW3CjYUDu4VqbUeGyPEYQRIyMb4aobyxrqZvGVlv5pWWQ
         gd4LBtwZlP9jCbS/7Uoh9zNwLoVPCls7iDwIpGyN1xeQO4tUvD6b7r8k5BkG9oF3f6uJ
         jaRS1hquZd/8pTswvwIhXaFMxW7P5uVlAqzvfdto+BFRCeiW+YMETP8AOjDw0jt0Md4L
         epQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709229972; x=1709834772;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zuNdEp4skMAQKlvJsve0fV5N85aIjxWJQmW98+WMLpQ=;
        b=nxsDZa3akpDZLymiKeq9LRQggIA5sFm+UAayzDJ+tku1MUuCiCSMJBBG1hAUVYp0RI
         e/ttdj/dQ07gPM/eb5sMMoggb+/cjKW4gbCTy39qoSxFxmK6K8REDhmyDhuS9EwXXihb
         PAzrsA3XnmZZ3OQaBSyuRlRYl/6ipRqVdWCGRvu+me0f49/j9J3Cy3D/VG+O3daOIc+o
         lEtTNIxZ2470XZaxIoNlDKIKmqQcwhAd8FNBcWnQyt/HBO5cOAVRMJQ76DKDw4d5Cgh5
         4mFRZplZVRHppWwTQA9o/l+D14pvbesd4Ehx6Q+KhGzwQKRSwJolBEC4ryyK85q7QvE8
         0psw==
X-Gm-Message-State: AOJu0YxEAJZ1PSLZHd6zoDFLvWfQcbKoBUwHJ3mNL4BBGhtz6KkMpehC
	AgC+hqYhkniNMnse16uonkZ8ISnLBJ76qbajiIzJb1POHY7u0i/N0AIqDtSx
X-Google-Smtp-Source: AGHT+IFDE9rsJd6VdYbgZO+dBQap322uDy1oGB4yWX/WADwLYCsyeZcxyM9CK1sNHOXOXIwOfVvkwg==
X-Received: by 2002:a0c:e402:0:b0:68f:b710:511 with SMTP id o2-20020a0ce402000000b0068fb7100511mr3136262qvl.39.1709229971885;
        Thu, 29 Feb 2024 10:06:11 -0800 (PST)
Received: from [172.17.0.2] ([20.55.46.193])
        by smtp.gmail.com with ESMTPSA id lr9-20020a0562145bc900b006904ca1971esm572462qvb.42.2024.02.29.10.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:06:11 -0800 (PST)
Message-ID: <65e0c793.050a0220.97ff0.379c@mx.google.com>
Date: Thu, 29 Feb 2024 10:06:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0218032000784542696=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xiaokeqinhealth@126.com
Subject: RE: [BlueZ,1/1] avrcp: Add strict checks for supported events
In-Reply-To: <20240229160955.530638-1-xiaokeqinhealth@126.com>
References: <20240229160955.530638-1-xiaokeqinhealth@126.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0218032000784542696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=831186

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      23.86 seconds
BluezMake                     PASS      714.52 seconds
MakeCheck                     PASS      11.47 seconds
MakeDistcheck                 PASS      162.63 seconds
CheckValgrind                 PASS      227.31 seconds
CheckSmatch                   PASS      329.91 seconds
bluezmakeextell               PASS      106.94 seconds
IncrementalBuild              PASS      671.86 seconds
ScanBuild                     PASS      945.34 seconds



---
Regards,
Linux Bluetooth


--===============0218032000784542696==--
