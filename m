Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A3B392828
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447069; cv=none; b=vBhxt5WN+qeFSGtGBe+ddRWDRfFsRkhGZZytURz2RmcWw/BBjodWj9Lwrf+aN4uHQ/keCuxnAYmBkwY585MsaCziGi3VKR7PUBBqBL5AVMvtBv+Zg0RALUoFooNQ0hBn6pMwQNTdtFZPCLCP5fPV2J/h6kbEuYIqh1FNWIjTTGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447069; c=relaxed/simple;
	bh=CzjsM3ChMd0sEXsU+pINBp1GNw/PVUSt0kOk0pWSx0w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mh7LMZa/mQo6CjKQ66gyTFpoR3KzgUEMJ+zXfu/rseN/Oq0KzqawZH/0Z6fbcrvAPIZz2M5zb2xEzKTxPYdKEq58zU5j7ikYuBLXAB3m8wUHwRr34s6TytC4saZI2pxue6+68LmUxm5oV1kvU21vEKG3VyAOYiYuxG0yrl8ALa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+J5h4G2; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+J5h4G2"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-126ea4b77adso5382432c88.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Mar 2026 02:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772447067; x=1773051867; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Imw0UlutV7XkuWU0JJ0tzuF3SMp7uK6tgfh67rvhSkY=;
        b=Q+J5h4G2N84kKHsCSNp8Zbxi9kj+ZjoR52eM85YWp2C5aOjIi3RKjgzdhJuwyHepTs
         g3vaz9Sqi7LiGpWAX6bY3gR0Lemenu4SxHMidnfdJy4D+w/rNpNKHpKh2i5Z7Fd56gKO
         wFBg+bCrQKKmM3g1qyV2uEdxOabQaGSSkyjW55nU8mDbBAeIzpSFIL0+YtaiGgkA5Q9w
         Pkg7m5rJnKNFI6m6tAmZ0dtCPsY5tJNbr8JUkN7EfgPj/9851pvvTE7p02Vxk3d4YwfV
         Q3HjyJkgGvLIPygTZkycGmRVKltPT1L/19VZswQXIK+hkbXt9oVcObairK1VW2aDuQUh
         1bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772447067; x=1773051867;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Imw0UlutV7XkuWU0JJ0tzuF3SMp7uK6tgfh67rvhSkY=;
        b=LHgJyxcD7nPnyNgREaXrDjbugsuwZFJXgDca+Db5HoPvHXTTOj9osqfjrxWu1caJEr
         xYBOaGdQXzf8+4+o+ApB+U2FniW1SMLEVHDNn6T+TpHpVY+pgyaT+13hxDzCa+fGEd+Q
         i39nw+vOnpoLMq2fP7nl5qXWUN3bCDfrd/bDUFIZP5b1zclH7YkZddhZIGgDclBKndMP
         1mSG0VwYerCoMXbDt1o1nRIdOkiPFbiA5iVQ0Ch7IiK4LEy4lEG8ObGVFKMSsfGDJE8I
         by5h+DqrTbb/9EPXSsRsyONVWb9PkslMy+Y4lo9I4NCLjqnuthEdWyPFVW9JYd5Ypny1
         z9Gw==
X-Gm-Message-State: AOJu0YzYnlT+IgO03qT71PNd9A3o1ON5R9JE9XrrncrKvF4o0WMyqmRL
	K+dP13A5gZpS/lQzAQGUlLDAv6zpDA0Fcv0Jl6In3tEqaIf9IP8yxJDQwoPvTg==
X-Gm-Gg: ATEYQzwJYU6oVso5RmSBNhnFi67qV1jxOMNaiNfmuo/p0JPA7M8VuPYcQWaM8ou5ENy
	mwjVdOG/FlGYyoq6gN1uR75EqDqDHikTM4UZpaoBIr7PXJHn8BnoiFf5nrzSAI/3Gb0gVPoiHZ8
	tTxMY6ifit4dRoVrd4w09DBajA2HD2ZHQlp3LjyLZsps2k4sAP7uxG8yASgJgQ2DklYJFllEEai
	Wd+YTu6wP1W/lpNk9emx8qeMtEOISl8Kvr6Ghz5kipqGsqFTufk6BTS8N5EED3KYe1SeUCjwkIi
	b+JwtMQOyYmR7gFga4FHdvrMQGp8lfDppVArIbUwc/iRW/71QOgMdlZIYxLzVETJONevdL878Rz
	a0KdRpNKa3Br7jJeJNxoVdM3eQUhPOIrZxrWppj9HwDDOA3fBDAxLiu3un6qMo52V7qkfY28+Rc
	P59CGwd/Pal2UG6lwgqQls0dI18U5TEw==
X-Received: by 2002:a05:7022:608b:b0:11e:395:7dfc with SMTP id a92af1059eb24-1278fc24c14mr4648073c88.28.1772447067016;
        Mon, 02 Mar 2026 02:24:27 -0800 (PST)
Received: from [172.17.0.2] ([52.159.247.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899df36asm13462957c88.4.2026.03.02.02.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 02:24:26 -0800 (PST)
Message-ID: <69a5655a.050a0220.1cae63.b235@mx.google.com>
Date: Mon, 02 Mar 2026 02:24:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0023281633349196999=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pvbozhko@salutedevices.com
Subject: RE: [BlueZ] audio/avrcp: fix EVENT_VOLUME_CHANGED not supported
In-Reply-To: <20260302092203.12775-1-pvbozhko@salutedevices.com>
References: <20260302092203.12775-1-pvbozhko@salutedevices.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0023281633349196999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1059867

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.53 seconds
BuildEll                      PASS      20.71 seconds
BluezMake                     PASS      634.60 seconds
MakeCheck                     PASS      18.88 seconds
MakeDistcheck                 PASS      245.24 seconds
CheckValgrind                 PASS      295.57 seconds
CheckSmatch                   PASS      360.31 seconds
bluezmakeextell               PASS      181.51 seconds
IncrementalBuild              PENDING   0.44 seconds
ScanBuild                     PASS      1031.10 seconds

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


--===============0023281633349196999==--
