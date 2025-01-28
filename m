Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B24D1DE884
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 22:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738102242; cv=none; b=EYrOf6H/AiG9RXDuPkqzSfQ1y4KU2X2MuawRqsb9Cj7Q7fxRMJLNmIxwT/HPK8boS8mCdJlBqwGG+ES36MXy/Tt/FptkQCDjVMd2LRHWFf8jj8Wuzp97AdzYCcUysjW7lrCSwCRk7w0iI3jB6tTCtKYu4gsGuNOwGpfrtIRaLT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738102242; c=relaxed/simple;
	bh=xp/txuGGsNT1kHOWQ0SJkDhDWZ7UxKmzwQg1ouLmOkg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sI70G+Zw+XKpdOQh9rur6yAlNA0fQvojTmpxs1wIxrHtsvrzSd4FKqnejgB1Yfd8gAyQq9zvwGpjSvdrhphPqM34zQrf6MLxCMmaTCanbrgpy2knM4hYhQwhSA7dBSZdaXlhiKZTFWe7IMlZWmtuHkMLde562whX5fmrGtm/Y1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8JdsDP9; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8JdsDP9"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d88cb85987so1123736d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 14:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738102239; x=1738707039; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vfDROgf+YNXG1F8mB0+KUCcy3sBALm+Cwcy9WhbOL6o=;
        b=W8JdsDP9syXj2XvWJrbVkt/LzORnwXWHIDgtgSLfTO8W9ez1radQ1YkV6aIx/ZyD/3
         3613gqQHS42PohpCDaTfnxsl5RFeSwyNK/TyFNPH0KztWWemDQD8IvDyC58SH3Ys6zJK
         mGPRgidY9VoKgfIuY7WBtqjge8nlTqKEV+QEueI+65meZQARrWKmsyAYcjPTeaefZbGr
         MY+yCPM1bRw469IgFewSmdcoJUD85N/+dY7bIViSydFqMBpAGgHKV4K7gPAHvBJ4TYsM
         guTfkpM9nD12E/nKe8cCM/E5Ww+RNW55U6V/dLKlXwkYFIWAMFHkqHFj+nWHVy9OA0So
         rpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738102239; x=1738707039;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfDROgf+YNXG1F8mB0+KUCcy3sBALm+Cwcy9WhbOL6o=;
        b=QLLTLudujaJ5cKLN9Uh5BvIrckkX0gjRyFgzpuEn7tRj79I75/gNpMH4l0ban7o2/I
         fqxWek8EaeItq7DG2eGd/5LFNM8iaHNMnE8z0q/h3jZKeJUTUeIZ+UYBzhZRcIxNW++t
         aFJPqseRtv7fNKdkBgWFMUobvgPS0XioIwk8EA/zQUGEkhTKVyaAmzGEpw05snI7I5Su
         dCSPhY8CuFkhe3QxyBuRJHEZSCPpElYPGxwg6T8myDJz8ygS+quDVOV4ZMLhn1dnOEsT
         shnvHYTOsH9GQSzkncAO8JMjF+EdS95BKB2MpLkJUWvlpseQtvJ28CGTyDnB3O3vnpnA
         hHkw==
X-Gm-Message-State: AOJu0YySbUMsX4eGUKFP/8eJxZIp3RfZwHbFX5Pc1Z8uoLbd0pTJTkfy
	WtU3wugov3f+zVilxHVVUcY9EPkPUub/SCE8zythDrGcUIbO/XcXNMjTdA==
X-Gm-Gg: ASbGncufLOBRIElbC7+yCp/q/yoZLyFclAKqfCz8Xgp7U2atgD8o01I/Gf74okBDKJ5
	h0EXC4KYr8AwlVb9iuAUnrzfBQ+N4HVHk+OEDxRzVb3LtYBzWvVQV72mNYzL+leggYBbE5ITgTq
	uGGGTolfRG4cJjoJ7AFObfAlfA4ECUp4D1//Vbz9SuFe9ut+g76KOWqEG7e8hG7fkjAXwJdTDE/
	F0l5F/RWfL7CQw1feK4758ZvKlKiqQ7rF93UrpcmtYZVHQUSPayqG/3D0C2/NoiWhHZ60M/9HzO
	wFToxPMcVBedZ1QWWTULt1k=
X-Google-Smtp-Source: AGHT+IH+QwP/N+G7FntTwR1tfRP67KNL8ZMHE073eCmNRluxbVhrOFRb9S44+ZzALw+1+bgxQDyrFA==
X-Received: by 2002:a05:6214:3c8e:b0:6d8:893b:2a13 with SMTP id 6a1803df08f44-6e243982061mr18507806d6.0.1738102239554;
        Tue, 28 Jan 2025 14:10:39 -0800 (PST)
Received: from [172.17.0.2] ([172.183.76.169])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e237200e7fsm12554236d6.44.2025.01.28.14.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 14:10:39 -0800 (PST)
Message-ID: <679955df.0c0a0220.86b7a.5853@mx.google.com>
Date: Tue, 28 Jan 2025 14:10:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3830076029375183224=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pchelkin@ispras.ru
Subject: RE: [BlueZ,1/2] audio: actually try to enable MTU auto-tuning
In-Reply-To: <20250128210354.73732-1-pchelkin@ispras.ru>
References: <20250128210354.73732-1-pchelkin@ispras.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3830076029375183224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=928933

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.21 seconds
BuildEll                      PASS      21.19 seconds
BluezMake                     PASS      1617.71 seconds
MakeCheck                     PASS      12.80 seconds
MakeDistcheck                 PASS      165.05 seconds
CheckValgrind                 PASS      221.45 seconds
CheckSmatch                   PASS      279.76 seconds
bluezmakeextell               PASS      100.71 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      899.96 seconds

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


--===============3830076029375183224==--
