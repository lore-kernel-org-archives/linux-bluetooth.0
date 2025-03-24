Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B2C25E81F
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742818065; cv=none; b=eA56/eUZJMt7GR4kQ3AoegEDqGIpYWQeuPp1HYUm0j2puudOubBJwxglcv8ykwVyZk/exuHGo9Ofy02cr3YP8RyM3CkzocKhiZ4i8BfyOkZYBCS6C8TUzh73hkhQCBQpBRpuAs5hOrAGO+NnPNdNsamtX/9gxOVJQ4ff4wkrn1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742818065; c=relaxed/simple;
	bh=znMjOtUxBMHlE73AXkm04DgQhGEQBZC4cdcn3Q2NSnU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iPRbCRUnuw8P7vbL6r+2S8oPIBHhvx1zDHooNiG+Bw8oH4EP96H7nHAdiEvn8qVkCWJIJdobvvlpUsj5HAowOp5mYhYMvBliQ5+7VdLN89uIcBizr/2xQWJZSSqqO9VdoK7xBaV7j1Ja0xBtFr9ltzFmVpclcettumbNlJa1Yxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfLu4Dw+; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfLu4Dw+"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c56a3def84so425139485a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 05:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742818062; x=1743422862; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jgkQ9UfdgGTTXc6nWr2385d0hkJBOwk4hU5jaW57u90=;
        b=LfLu4Dw+B5hkS9Ui++l5Y2waMtut0YWTeR06ejJq3bbsKj3YvB6aLOhHNMj9Ztw/uk
         1krHJSW2/63AZx4YP9dPkYAsnA4jTImimh0THpoA0o30JTQUhUGzYprSSs0V+m6/LD/K
         kX7iIG6Qr9isP0c3cwb8LtccEoyAmH0Lth3HN2GS+sqsmNKffMpwlzddXsAzKGmio+YR
         J/1VDbPWbaZL9rFi2U+2DASOUiGlOBVqBZj0VcY2cqF4uc0+Btmg13/IKQ+6U5je4keO
         /BuheSAGpkhMeOf4JpFGCC7Jt8nChbZePL+r0WEXJwu92N/MYZXA5xW+Zhf3vNoqDQ89
         wsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742818062; x=1743422862;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgkQ9UfdgGTTXc6nWr2385d0hkJBOwk4hU5jaW57u90=;
        b=Sd7fzkIjALe/gIJEFwdK/U9KubeT/FCJEmTEolsLGjmhiTd7P8awQyyqdDj3l9xGOe
         e5EqL/xLEcOrlpakAlEoXXYUANLaO56GxopmKy7jwRsneCIv9AyWgSbRdd5g/2wwf7XO
         Eb8EiXWSd24ZN9XQ+j3KFqSTzROXrd1aRw/3ya83vHOeKJimcOVWUYqhCJmeggol4IVU
         saBhVigcAgteb8pGcnEgrIA/JBSPzhK13t7EhZP1XmHM9SqixUw5UrPkNNV3w9aUdX7d
         NftUokOP3BGH/MYv7wI/hCOhShrGl0079vJODcWlqTyo+NUdANXGHiy2VAtDivdatrqV
         9l3w==
X-Gm-Message-State: AOJu0YxLx+YgP0foKflY7K+FsRaHlIJXPGA44fQDEQ6qB9Rco7Kxf21a
	1YWzrquuXcK+mtJ3kaEzmvaGc1HPVtNcVpxBRgx9Y8Ehru4ei2RGWQSQYw==
X-Gm-Gg: ASbGncsX5JrsqhfjnD/lrSoKiV8vEMwKFEwv4N0MTXWZKypgvHl4oRY64Mkkea2goCY
	h3lJ7wdNPFyAlqQ5wBiH5OsDpar52LaOY6ZvvN1LpVcvYGyhaD2T1/vcbmdAzq6DqzS66qXHC/V
	XTSAmEvKtvA3PPqxxzMGXlwUIyJrhw1+lhOBFgxhb1FoXiqZa8483mAaEKVyaRSkbyZUqpYZ7uO
	PqVIVXA/fu7x0fGz5WxmTuRYYczr2QWaTtOgeuUnfG8Ayt+uV5TLWdu9niZ3YG+mokJTRXvxEIM
	3v9nsGpA8m+Pk9zNBnawPeTJo0jJNBJ9fJHQ4+H+l7U//JoDuCZvrPU59Auf
X-Google-Smtp-Source: AGHT+IHOSg4BjZuO0JrTzHxSfH0+rFqaYT5wFKDoexc/9InXdn68nPjJCfKOoeB9AbaRqQxdjZdj1g==
X-Received: by 2002:a05:620a:1a19:b0:7c5:3c0a:ab7a with SMTP id af79cd13be357-7c5ba13a64cmr1513555985a.3.1742818061961;
        Mon, 24 Mar 2025 05:07:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.51.121])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b93484b8sm500802385a.66.2025.03.24.05.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:07:41 -0700 (PDT)
Message-ID: <67e14b0d.050a0220.30eaa.19cd@mx.google.com>
Date: Mon, 24 Mar 2025 05:07:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1587118047555072473=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v2] obex: MAP MCE Publish supported features during connect
In-Reply-To: <20250324104346.64309-1-frederic.danis@collabora.com>
References: <20250324104346.64309-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1587118047555072473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=946753

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      21.00 seconds
BluezMake                     PASS      1465.45 seconds
MakeCheck                     PASS      12.97 seconds
MakeDistcheck                 PASS      159.40 seconds
CheckValgrind                 PASS      214.22 seconds
CheckSmatch                   PASS      286.42 seconds
bluezmakeextell               PASS      98.98 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      870.08 seconds

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


--===============1587118047555072473==--
