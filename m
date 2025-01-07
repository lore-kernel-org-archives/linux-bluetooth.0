Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5461F37B8
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jan 2025 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269705; cv=none; b=XaGN79uttSgyCA6RfQ3ViHXcSup5PaSRNHbL/UaNEaVOWhvmjcLu9WogKJ+tefRMnQRLMeoYqBTLdti8dRDec+tvOKribGM9vMK82JW1win0N7nH26OuIouuEC95Ol/ngewsZBcxjSzLubvNLPgjORSgEaniIkHJ41oZKHMw9Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269705; c=relaxed/simple;
	bh=oZowZn5DeU8QHPKtjmJE+uE+r3D2f5uCOtAeNAinodc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PsPG8Ax6/N8kXx+vWSZX6swtuRwNE9uvkMlGjtJwFB/VSsD45hriK2oX+Sh6p4mk7PL+vyTDYIUT3vDqISYbpjTO9ZZsMKpdd4Cgu1f/NI1ikQdYZ+kJG/b06xaWrEgNfdMr2VT8wSKb0JQMTUJb4sWB5F4D75EHVW5aX0NdJh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gj50TFQF; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gj50TFQF"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d888fc8300so77594176d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2025 09:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736269701; x=1736874501; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jNUoFrxkJLbA+CZlB661vo7zpzOjj5ojJ+/Inf0qWMY=;
        b=gj50TFQFF8UWezAaLEcqSaRYHpv81BECz1wmoX8BdikiOI6mhtl9XRp7/widE+I2DU
         X34FYc6MTc9drza+hniPANrOOVv7zTMk9am1zlszWPVyZsD8IOOiMWvzopSVIy+CjU0G
         TMtYCxnvvjFtyTBFNKdYxeOPFZW3FtQ0MNEQdrKBsbOfaARrIvQggFQjlYcNMZWXjVOd
         88cr7wqa2NJoWy3fW5fA9W9lmSsWbyqnsE5ZU8d5KgHChYXDtgiWN42ZHqLbt9GGoz+e
         gXSBsFJv7jRbsB91nvhmFairbAFdB9FBDG3TUwNrTLOzgHeuIkR/It3XrTeU5zz5Sj0/
         IY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736269701; x=1736874501;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jNUoFrxkJLbA+CZlB661vo7zpzOjj5ojJ+/Inf0qWMY=;
        b=R2zxaTJYCOxUqY90tKxGOTpeEF/qxJosX61wb0kQFI9Ug9IPHdHrF2802CuxZ0Vl4I
         tBScL+L09hu51kM2sLnoSad5WxfeCrg6B9edMQUNXepzIAz97zx5f1FoblBkFnrffWZy
         xnozTopLzXMZw3xsZh+esFqV9NvuZoKG0m4U+iVnTs0BfW+3+uFbhkvBdCqlR5Pz/0c1
         i8boH3eckQNWuTC+trdTiNUxSRkPKI/VbLe+9VSi0gui+4hOHuV+7/HSKtKX+XLoaD1/
         kuti6QboQ3v3SEUAPN02BXaez2pJhUIBub4lDBCtUat1/yUzpN7ImN3Tbax5pRGmYoDI
         EAwQ==
X-Gm-Message-State: AOJu0Yx4Cv46vttCl9wgmdlb4CS8BvwgyUQ9HGsuV+RUU0IG2JUY6rYT
	kZ2mQxyDXC0l++2oA3OGAa9Nx9RBYQSJoYgMDi2IfS/9MsojDtql64t+3Cpu
X-Gm-Gg: ASbGncuSyDjwV4OMrt1CB0aGtOXYV0JgKAVZGanqVuL695NR0I3qrzjs4zjxBrJlb4C
	sjpQKFOrMkZjqYp3odBB3G45NORXITvttrdlk6DUQXSYlMY5BOsMl56jqFHzdO9X6JfBPJziILY
	oRw/IC3a0zYmDtiNbZjNMmoBI+sU6reC52MsVe7jqAzFbG/55skReej9TQ06WMgp8ydMva5me8y
	rvFSlGtkL5MzeLsDVem68RToVLDO7/qqYVPy0M9G0pbQpYQqL6ghG54jdURFQ3W
X-Google-Smtp-Source: AGHT+IGdMofewxOAPKlgarq5IW/G/hRTImD0FmkRRDV8fiiZ617z44iRXnjXAJVpfPkzVbIwQ94lbQ==
X-Received: by 2002:ad4:5aad:0:b0:6d8:d5f6:8c72 with SMTP id 6a1803df08f44-6dd2332e380mr1084987296d6.19.1736269701358;
        Tue, 07 Jan 2025 09:08:21 -0800 (PST)
Received: from [172.17.0.2] ([172.214.137.76])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181d3db8sm182488016d6.104.2025.01.07.09.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 09:08:21 -0800 (PST)
Message-ID: <677d5f85.050a0220.29ef1.c3f3@mx.google.com>
Date: Tue, 07 Jan 2025 09:08:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7567121018797024320=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] autopair: Move handling of wii controllers
In-Reply-To: <20250107154208.1414463-1-luiz.dentz@gmail.com>
References: <20250107154208.1414463-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7567121018797024320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=923027

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.54 seconds
BluezMake                     PASS      1567.06 seconds
MakeCheck                     PASS      13.16 seconds
MakeDistcheck                 PASS      159.22 seconds
CheckValgrind                 PASS      217.42 seconds
CheckSmatch                   PASS      273.27 seconds
bluezmakeextell               PASS      98.73 seconds
IncrementalBuild              PENDING   0.36 seconds
ScanBuild                     PASS      844.21 seconds

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


--===============7567121018797024320==--
