Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410CF629
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2024 19:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734463117; cv=none; b=g5+z+N6q/6y03edisjTvGbRjdkZXfjmA/tjisCCclr26OhBdtTqTs95g17tdKzVTolYinHRzJ6TX9+XlbLkchy7DCNs6GvwSFfM1DJxKD8Nl0WLxYDSRLOk4V9JGKUkbu82N5psDz8tJZhqTphJuIFjz0w5RxDiYQ1njW8VRFOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734463117; c=relaxed/simple;
	bh=j3LvlY1i3m+OHMkxNY741tm15M4jnSqBvmqVjb80mRU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QOEUM8ZcnL0RT45VOyHFmSgocFaSpzA+rWnsGPswEn4fTz52wJVY+ivPnyBgqVnlxzS1llJJwlQ2yW40clCxDj42IhqtjoHWWi7qZrJ0zRpFJilBXTiqRf9TgY1WlVNsST++9LOAH1YA7ex/O80263jCb4+VP6kAq5i5NPn+f3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBORUVfR; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBORUVfR"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6dd049b5428so4895116d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2024 11:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734463115; x=1735067915; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ekY68zdz/rvnguFgUDFnyuopL+q9HtZPRTUO7OIfgyQ=;
        b=gBORUVfRzExkSFxXEM0IDdG1n3dRQHvmhPmzEHKn7bICZLvwo0GncK2Q7CqBdRuQWD
         fxSf83Crp3k7OPmhVn9AxwKsyOlXf5i6aAKY9fCzddbyFQ5J0gYIxqntN0EbTsjFy5ld
         WdKOrZiukNZuQbo+tu8yRM4oJsSV9KddlcOarKsgqwTXgSo3+8LvlV5i3/TEjz5BLi3F
         02C1iEVT3nR3y4NKXAvXbyAZx3z9ORwQgZNJpq82P9mxwVBO+ShiyOh90jld7l2onK0F
         ycOwOj1GNClwlUFPAt2I9L9jUt2ZI82vQzVoIJjDHgB2141dqKVZrP5uxDlRCByLtw6m
         S9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734463115; x=1735067915;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ekY68zdz/rvnguFgUDFnyuopL+q9HtZPRTUO7OIfgyQ=;
        b=JppWJUYv2eSrTaAHcfePojqYdTp/1XwoRRW69qZpoHOWdas5BZ/PhM6/5TKFknCiaf
         04hEuX3xS+rnOcxUfdeaVSZcMN2MALxu5IFb3rgrbXffMydX9ZxRW5W+U31JeeUoHDjG
         sHgZNnJ4klLCbc17QLu6e9uaGi9yxSA9gKL90YZoJ6XYVIIxsSp4GnFgM/H9/FDuom/u
         L5DBZyPR/wRHYK2B/NyTQXauepPuhohM2QAHk5f5EQaqv4zXFzfzODpukNwAG7nVtc3L
         4YywcX9Y3yzkpU1z2tcyFTazGB1PKzIEoAqBDAeX7yxD58gMoRWxdj/Bk4y7an0bjt6t
         zXhA==
X-Gm-Message-State: AOJu0YyW6JHEokcRtayGULSS/wFqVltwIhre8cae2nV5NWLZX4Z1rsDb
	LPY4Iy7DH95gHdFqRPjmKNIC0+scsKET/N912F+dmAPkNcCcMSzTfG3T0Q==
X-Gm-Gg: ASbGncshcuemVpcm5Q6ylsJshsWAJ0lamEutzYKehXuIVnPg+n5Ae1rdm9i1S5gU1aG
	fnBt6/CzmffzdV9nz/NLVEuXO2daxR6I2FubfcanPz2am3eZ3FHr+prs64tCIxY6wKUz6UWVNxI
	VpiShFnEDdfMcdHZS/x+iVaRCGJ6WKzb7MYimUjgQlRJpj/MNgis09rqlpEUVH95+FQCi2I9Aqy
	xwFiwzZdJN2NJXzroHO21E+4wu0LeNptdV1MCRKjULEQ75F/db10Vl3BPWeRH0s
X-Google-Smtp-Source: AGHT+IGrjwAIdvtUza/trJO5aYcCcran8tyrmGQHf4hxGlNblMQw+JXEWf17JcYtSnTIsM8h/wJu4w==
X-Received: by 2002:ad4:5f8c:0:b0:6d4:1e43:f3a5 with SMTP id 6a1803df08f44-6dd091b0317mr2967506d6.13.1734463114841;
        Tue, 17 Dec 2024 11:18:34 -0800 (PST)
Received: from [172.17.0.2] ([74.235.135.255])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd261b42sm41316686d6.52.2024.12.17.11.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 11:18:33 -0800 (PST)
Message-ID: <6761ce89.0c0a0220.63d60.e8d3@mx.google.com>
Date: Tue, 17 Dec 2024 11:18:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4703946235930925021=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] client: Add command wake
In-Reply-To: <20241217181334.3243011-1-luiz.dentz@gmail.com>
References: <20241217181334.3243011-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4703946235930925021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=918786

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.19 seconds
BuildEll                      PASS      20.44 seconds
BluezMake                     PASS      1576.00 seconds
MakeCheck                     PASS      12.89 seconds
MakeDistcheck                 PASS      158.77 seconds
CheckValgrind                 PASS      214.09 seconds
CheckSmatch                   PASS      273.04 seconds
bluezmakeextell               PASS      99.11 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      845.50 seconds

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


--===============4703946235930925021==--
