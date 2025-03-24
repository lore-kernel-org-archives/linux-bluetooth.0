Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B5319F421
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 22:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742854221; cv=none; b=YSud4kH6KXfLEGzi5fr4ZyG/RpaF8cbevziYGD6Bo2seFDcJ3xzMxfEciaROP8lHvw67EqQwaWbEjGXoPSIigx7egYPFYeyLkgNAqma1W4BDFQPa3irxUNvW2LbVIjmmeaWjtxIBXL4ILluv/PaxliKKlPvrvlUax+TxVWrZ95s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742854221; c=relaxed/simple;
	bh=H9p/MqAj+itQs9xpQdtQ+W5kwnEU6oylYqjIdD9h6G8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HA/pesqVZifF04Y2RD7+u8xamXuNeLnFWAS/vwVOh3G4Py6IABjSMAFTvqnR+UW22q6odLNqiTueoJ/BRvF9J7cr+ZQ6GNMkBFVoucW0HwtTG01qR6jCD16SyhC5QNR29NPkXqZqvxg6NNnF7GWpRrSZuDLayG2FAcXLPCxNS7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pjs/FdfF; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pjs/FdfF"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6df83fd01cbso22697746d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 15:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742854218; x=1743459018; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QpnFo7US52TPGCG0poGJ8pgIywe9BDX31q7tBeANBGk=;
        b=Pjs/FdfF5GEZh29is7CTw9YgrjfMIKTbxU0XSWCeI39VQ406BMr+xGZVjmG/6R8C4o
         OCp/tZPasybYCANeaQ+AQ36V/QJyST7e6zc1Usa8HNe3PfuTPsXowLQB5LcmiVl4yfd9
         dfQ3EMuB8ocNsbyHGgVXXDkYomEQlq/862C+Xugdhfhp6BiwDemuS2Eivu+kmxTDZVuO
         eTZ2V7aeWp33r/Hn4HYE15sj4tE7G6DfjMMSfLDP5tBso6PY+NU22Bcv5Yb2m2N/i78O
         8sarSGvTxpoPreEDn90shUal6uNWx9HaADIof9yG0lsN6t6fcfF5UWHqzh1iAPGBwM6p
         OSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742854218; x=1743459018;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QpnFo7US52TPGCG0poGJ8pgIywe9BDX31q7tBeANBGk=;
        b=fBVzIGRoreEC8W3kVyomXiIgEhBuaPbFcmgDWwjEIBkVEqi7MvjGEV8XmO8i6+cl3t
         3mM8MvKb9aQdsex4PPUiHWcNMs8pdKGFsnQFEJ80gmjiaJHoWj4SotUTNn6E3WPYmmFj
         QmoX0LqMa8wCZykPc/XTgW638bQiRo+LVdzKlFOhLdbPleUnIgMHd0KAk4pZtTt/Cl/J
         j2pzmjNltKuvAfZtJOc2YbrhlwdAF/0+UHjFhb+kaavZP99J1/Xg7LxHeFQ5Z8JchzDg
         r/HszbW2f+UalcQT944FyCxzLy2uwIr+NkPZfeUbBZf6kSfoxG5lFsBFGfitWKNYBm6E
         C3kA==
X-Gm-Message-State: AOJu0Yx37slhLN8dn+lw7wbRbGk4fSHYukV41kRbJc6t/yN5SUdsgV+f
	QAgVwzELX7/8KjqFlAIXdYrRIXx7Kv/0NykQFghys1btLxNHyMop8/xkMQ==
X-Gm-Gg: ASbGnctwUxDJxvesN/J8+7u6S+3ueEwIkmVR2ngRTzfofHSdPzzacp+8n5eOsriTwxA
	sInJmbCQ4xdexjd3nLD9q0gMVJoU0JjSAjwIwLNNHKpklAV07Hae4ptJhACoZdiqWm3YjlXMTiw
	Bh5h2sFj0bXqn93tf2OhGpe6aEBkCSdobVcpOukNgQb/7+zi8hX8uiY2cBsJtMZeZ8Ci/lWWCvv
	LGXKoDN2F1NsN3XQJzcPnR5ZZAqfxl4XPcxV91JwC/+Z5n1Y2J8ju/qu/2ILYaAA6MAtJ134PLO
	Uyobqc+AaHGZX7gXYcC+Zcwe32Fgn7p519gLBR9LPcutEZTdOIKdrA==
X-Google-Smtp-Source: AGHT+IHdHtlR/zMYfi9TN20rY234m8OtP+T2LdV9oFGmm92eFFu2bbYFhuV9I3IcdreCAR/rOdv5qw==
X-Received: by 2002:a05:6214:2122:b0:6e8:9a55:824f with SMTP id 6a1803df08f44-6eb3f275059mr174483436d6.6.1742854218423;
        Mon, 24 Mar 2025 15:10:18 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.111.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef0ed7dsm49354556d6.25.2025.03.24.15.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:10:17 -0700 (PDT)
Message-ID: <67e1d849.050a0220.1e4b41.4340@mx.google.com>
Date: Mon, 24 Mar 2025 15:10:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2571290861116476864=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/2] device: Attempt to elevate security on Pair while connected
In-Reply-To: <20250324204550.2196697-1-luiz.dentz@gmail.com>
References: <20250324204550.2196697-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2571290861116476864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=946951

---Test result---

Test Summary:
CheckPatch                    PENDING   0.51 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.39 seconds
BluezMake                     PASS      1517.36 seconds
MakeCheck                     PASS      13.08 seconds
MakeDistcheck                 PASS      155.76 seconds
CheckValgrind                 PASS      212.67 seconds
CheckSmatch                   PASS      286.63 seconds
bluezmakeextell               PASS      99.19 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      904.50 seconds

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


--===============2571290861116476864==--
