Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5F617B425
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750865986; cv=none; b=RpDRZCqNgVuwX3Grt9TxI7XiEwAYcM8dHm0kxSYAVJwNQuw4VTBmINiOF0/iVnZ7QmwsXS2eq9r7vPR3ZZXNpoSQlOEYTwHnUV5XOqv9TSTfDx/dmp8HgXLB7I8O8opIAtS9pX6Pzelqc+lKG85xetT+kCImEYEpN2VfRd8+lw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750865986; c=relaxed/simple;
	bh=D1cZoFm03dvREJ9RkeLWJad5F4WWo7KqgSf5uNT9yp8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FzUKXMn9jRjfpwHMTQvw30FaM3/wkYjdaXktKoldosBj1h7V4egjwxaCo3LiO3js8VFtzr/nuxUqqTnacOfOPS4SQQVSaLgdLmoqh+3MCGIml/Liib3lxF7zcFA1Sxbhg67haYDU3XdMwx1CGAFu1Gc/o1YF4qMSGpQXQDPb29A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRY4aMgs; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRY4aMgs"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6fada2dd785so865366d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 08:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750865984; x=1751470784; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7fzAn//EPLmyCKvB/viA4SeCzr+g/KvUklPdUnofSPY=;
        b=KRY4aMgsSKOhRY0nMPXAqTEfjE3MYHZqGBIx5STwNemes8KWZflTne11uDXPT0YCTS
         lJkPEyJ14umVn0pNMjzBWLK8XwHltb1W3okOrDBrm976C36vtwDF6cBfcaWrytnuWlAn
         5neesjIAUm/pHcUK/E7iAwTz+tA3W0ENHh0knHOW1YvQg5z3zpKVVgNYufmUA819T7mE
         mmsStP7T4m/YDkqIlj/DuBAgWy/59th4mXiWBfjhOKzZKve3QFhBBgEwV9nAJd0obzEW
         BVIkJocjfNf45Yz0odbvNhtTsZ2qxWOm1buA1eXFvoyqlg70Yn3ihClextXR/LYAy9wt
         Xlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750865984; x=1751470784;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fzAn//EPLmyCKvB/viA4SeCzr+g/KvUklPdUnofSPY=;
        b=Trr41sgOxmmPmv71vkD9cJOLciwxjTtRq+qw6tVNEv4NUbeeLkh7YL3UFA/LboIteq
         dCqpFVtPa4lyUOIFOFHKKVUItaTIVYYlu490SpF7O7z4nZockRG5EV2g1oLzK0cEl29e
         2CBOQshwKoPFCi8S0bl45dohsDiYdo6/02jP18q31Y6IJv24jMUJya87fJ7OAVp/JOo+
         KO+Bzf3uSM2AMwhWPg9AQmNE+5MN1+gx8wHNvprr5GrxtYY5kRDAeOFJqjdUIAXyrhUB
         V9u15eQQk5u90pNvZ35CWiN7Oll8oPhOwis82sRhLacqYICi3yv7OTf6iTq5QC7TaHWs
         u/yg==
X-Gm-Message-State: AOJu0YygT27psR9t0Eo//oX0vAk2qZdXw317Qbfnz0qXKegNXy5Ylsli
	CxSGrMaUxGHth/rVflQScCkiNPyE0paNXmLG914/zXTRFTV6Yjf9iO8D5p43Ybyw
X-Gm-Gg: ASbGncsk3xX77r2uDRnJYeh23bHuNkDUP02cWYSjJJ1mI+588kFtzJbzWeNGl8Q+4ol
	P3+9rJn52ixZORMSZHbDB5VYKdoDybCJkxH2ejSU8dKCDIv0SAXoUaW2jLyVcTd0pULgJKTEDjx
	/MWgAlGns7vy3p3UtdoswuPisk+Rkck8/Hy29TUVV9/si5zR6PI5ziUGeH93OA9LFppArmX4VCm
	qE5gWPfIbL4OuNBjwKuvhhySC7ALbyY2bt0JaSpTfyuRRERBAM8vVIBYhleBdCPsd8ftRs+UBTu
	lXLU86+nhWiuxvOzpW2kYIMV1oCFV0OwEgUNoF4S0oVzZIqKTY/YusBx8WgZmR0GgDHf
X-Google-Smtp-Source: AGHT+IGX3+tmeRwE+1DHEoUMtVrxZz4KIgQBkbiJXzDyyG8CIx2QiCR7CIsPz3SKQhuOPLt2uzBsEA==
X-Received: by 2002:a05:6214:54c6:b0:6fb:4e82:6e8 with SMTP id 6a1803df08f44-6fd5ef454f2mr59316666d6.14.1750865983599;
        Wed, 25 Jun 2025 08:39:43 -0700 (PDT)
Received: from [172.17.0.2] ([52.237.143.10])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd09538227sm69720536d6.72.2025.06.25.08.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:39:43 -0700 (PDT)
Message-ID: <685c183f.d40a0220.1b15b0.8f2b@mx.google.com>
Date: Wed, 25 Jun 2025 08:39:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5661409996796160232=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andreas@kemnade.info
Subject: RE: gatt-client: avoid UAF after acquire notify failure
In-Reply-To: <20250625140545.1610812-1-andreas@kemnade.info>
References: <20250625140545.1610812-1-andreas@kemnade.info>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5661409996796160232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=975818

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      21.42 seconds
BluezMake                     PASS      3050.39 seconds
MakeCheck                     PASS      20.88 seconds
MakeDistcheck                 PASS      214.61 seconds
CheckValgrind                 PASS      292.86 seconds
CheckSmatch                   PASS      315.51 seconds
bluezmakeextell               PASS      129.49 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      926.90 seconds

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


--===============5661409996796160232==--
