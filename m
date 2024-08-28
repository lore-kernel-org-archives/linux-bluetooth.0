Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E85B15B968
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841184; cv=none; b=pdpQN9EzGZ/4pHN0iQ39Bm7ejh9E/aOFaCfzouCg2q3Y0iAYn5kYP7nqk3oA9h0AWmDvuI6fwDBtYmxEwoLwyy9OBrIA7FdduZWDGB+owsN/4dZC8ZTUJhaBCBvUFTVzHBpZASPDI6hA0lPvZgDSdVKSTB1j5I2Rwj1pwcR5grs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841184; c=relaxed/simple;
	bh=g2s0twKpHSFZqo5bRCbZxbzCL6LxxkYeNlgNdjioGkM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Qs+mb6iWi3NmJzzypAFZtyd58F5Jp4+78zPuT8DVeZ6znBHE0H0Io0EuX8FOcGy8SbqPdBvI7GHWLroYx9Rr9ip0bcIJNk6Ekx7m9BEOE6EvCH7CwBYeh6WVRwiGzTyWOyl/Pq/PlDAN1HQa84zDEK2XXbJjiIo1RIHxSKeW/0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVhirpEs; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVhirpEs"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44fff73f223so34157391cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 03:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724841182; x=1725445982; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbYZQ6UPsqbNtkxC5CEdSaHVtn/501sXB5NdJuoQpvA=;
        b=MVhirpEsJK5xdN7R3L6d7Poov2kGmobw12YSwMZTYFhmYux49pyVdpiu0PWinlC/G/
         D5Pw3xInkZh7rvGEQQuJOTDYX1Gkiah2R8ZX7PFGtxH3HvdvH0vToQH/nMTkNB7HN1GY
         eHu9buzyLWvqU1JulFUir3AmAmHx93SSS0rETvMOcKWinNjuahfQGSHVliDWnNApCznb
         xRlISPlDaBcxG2QPCvz5oTI62VxdLO3SexgMWvAqs0tYcQVZ5ve9vgx2BAr1s9tczi1A
         jbK6rE3bn00u+iE0u5G/n9kaRTxgx3wdByRz2hKxTBnbzfE3CE0cYelMXnwFHB5YMlsz
         mynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724841182; x=1725445982;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZbYZQ6UPsqbNtkxC5CEdSaHVtn/501sXB5NdJuoQpvA=;
        b=bPxHZpJtz6dS5IWY/q/ltM7AQDTzdzUpdk5XYEAS/lAL/SQHO/rWyvyNvi4Ms3/Q5A
         bJI8uaL++erRObEj8HWvx5SGyzi4cmWpGS/EDgKZvV7GoCqDXOJgKB6DfgXKjUvR7pUL
         I6ZHqCT+QoGcrii/b+572xDnQ5mhk8zbd5d8yW8OKoVENEwjmzoyUXqUQyNjgeBMfYV7
         9dAyWT+yR5UBsq08r5+ouBVh2wmBZVHFrp+lNbcjAnfS11U1ml/1B7ZRSMO7wFRh8gHr
         TANH8fRpZE55c3EoPTKRbucGgc8AUsKfD2pr1waX6GvA0YBwuHuKUlUKB3/O9iW3FuBZ
         sE2Q==
X-Gm-Message-State: AOJu0YzsDnUAtaAkkasLQ2PHoruDQgkO130jeUOQnveXajnjyMuOBWl7
	uiO1Kqc5c9HC5JSLJXEXwUTfuDA9G3PZ6xRKSVSgE+xUUOUEs2MZKQRi+w==
X-Google-Smtp-Source: AGHT+IEkpQKDCZX0w4Kq4l94o6jBq4dQv6kpE4qYpHe6P9nXdKADrVuzML05sqY++dMTZIOEBsQZlA==
X-Received: by 2002:a05:6214:328e:b0:6c1:6ed9:25cd with SMTP id 6a1803df08f44-6c3362baa8amr16177466d6.2.1724841181587;
        Wed, 28 Aug 2024 03:33:01 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.111.195])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162dd1cfdsm64375446d6.129.2024.08.28.03.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 03:33:01 -0700 (PDT)
Message-ID: <66cefcdd.0c0a0220.22258c.8541@mx.google.com>
Date: Wed, 28 Aug 2024 03:33:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9152948059103581544=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tot0roprog@gmail.com
Subject: RE: [1/2,v2,BlueZ] mesh: Add provisioning algorithms config
In-Reply-To: <66cee09d.170a0220.239498.270e@mx.google.com>
References: <66cee09d.170a0220.239498.270e@mx.google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9152948059103581544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=884146

---Test result---

Test Summary:
CheckPatch                    PASS      0.84 seconds
GitLint                       PASS      0.61 seconds
BuildEll                      PASS      24.73 seconds
BluezMake                     PASS      1669.32 seconds
MakeCheck                     PASS      13.41 seconds
MakeDistcheck                 PASS      176.62 seconds
CheckValgrind                 PASS      251.76 seconds
CheckSmatch                   PASS      355.73 seconds
bluezmakeextell               PASS      120.32 seconds
IncrementalBuild              PASS      2976.71 seconds
ScanBuild                     PASS      1104.88 seconds



---
Regards,
Linux Bluetooth


--===============9152948059103581544==--
