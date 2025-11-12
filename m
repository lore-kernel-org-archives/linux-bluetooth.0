Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C9E53363
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942992; cv=none; b=jIBcbK+P5G32QlTTuZsVMZ+64Y5dnTJjd7PgaEPeUzDpqrzavpTSb5OWqF8m9bZkU65JC8X1ttHgPYY7aJI+gwZ28H0EiWxkhax/Zcaxa2pzjDaU1OnRaYdKjnlMNdueLJ14uwpJTyaujhbqycl1qE3poBMYZaazJ2gRKPgcYi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942992; c=relaxed/simple;
	bh=TLUrFSzNpP1RIZl5K3y0eO7vq8u5tM8Wp8WyqfTpa+4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hStGi10i0+SYUcKWQbq10DcfUPFbYx00tRU+KZSs3aYlNR2mve9u7UhttrxB28htTh7AF7yI3EJ0RhMqSHeoES9uLMXPGZSQR+eJJ4oMNmqSLrJJpqxiXV+ESjPnwlzLyYF0MclBw/mnSN4ZTQI8e+GJXpCKJftyRQclYFB/tYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqonpXqG; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqonpXqG"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-93e2c9821fcso66249539f.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 02:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762942989; x=1763547789; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3TkmOGoazX0yZQI7DQNftkmw+n3y9wTAOfcVngDpHJE=;
        b=RqonpXqGdAY5I8RBbwy+9nbmYDFvy6N1Vrh27Azl25ZeuKkTfhCEsRIFAnyaKVgzkt
         GyuTPTMHWM3xLafJKAJIM62ckCDYfz0qjhXuMVvZjliJXD1EVRgT6JSnQycBgE85NoIc
         ec9pd0mdzGYHnzVUGl4b5sbKwWjHyavqVwhCIJAGYO6AOtLlNx/pPb6c+dYzeYwoqN3/
         duLpNjuQy2AoKqEAvlyuIaIr+emC8yAwgW8A+zMnHeK0twOUCyGTHEYrTMj/yKQR0uIh
         WfEOGHSRpK73+cl7huM/DXqNhsJFB+XuxwzKYyzbLSslW+zNIMLIOMqIMpSaaZPov9br
         8+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762942989; x=1763547789;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TkmOGoazX0yZQI7DQNftkmw+n3y9wTAOfcVngDpHJE=;
        b=K6+5+AMo3WWhIsj3mjpEBfdqZjDfsxCrs/rXkoqI4FSbxknLf7MWF4g8uvujijkSj+
         HLE2abMC1TjvdsHhUf3PTLewMVSCXptrkbz+RzlvYBp3Ex5UaoMCulJNuEsqXagnXv6L
         ZK288mAdUuxh8AOO5yVOHt38RB+rlIhKMGWfFSGrsXtW9/1yroWDNQCAGHl+uG0qxMfw
         pKc4sBPv1jd2gEaVo3z59IdYZxI+LVjKzaFY5QMOTHDa/qDQancfn+I6Nv3pLZqC3wEt
         +sDeKsRJcZaz3Ka/2bHPbww6Tn1jG1sEPbZT+HN0ERzcjztyTIukoDzw5G5A6QjJAM8Q
         6OGQ==
X-Gm-Message-State: AOJu0YxbON7jRPquwZCA1hWjL+PnW0BxxHVUebieCcx0Xv8l8pDW3S5J
	yhTkts8H9Xt0tNf4ihAnICfBryPOzGZugGzn9CkKl4OTwDPOTQBETF3dd/actw==
X-Gm-Gg: ASbGnctgeE5jHtdECQ5aefu7JlbW1kqTUztt95F68vkVgEFe26Ns7h1VGjDPfIeEmQ3
	PNAann0yDNw3w7RHKNyI3ZbFM033VJyYbpS9OLvqANJhakod0jGcFExkgzg5X59UjYU8U26O5tg
	vShtKAA6VuOLWsPDlKRl4NMf5aHcb0uJ5VLlNTgUiWldCgfQZ1sHh8QMthB2rpDpYo1eFD0Y/8q
	eeNyWk1KNB/Y2NoadrCsw+dmvihjVPH/vZv81ORegLODE+2FpKLgiwrUq8D3hrm+mlkkTn1fNFf
	+onYj3Kj/glkYlaepVm6Vi6tusI24b0BGjgYHBtfkasedGjcexMv2rlUiWcv0Vgcnpt6FovyCvc
	kIg5QSnoKUZynI/k3fIQX2GkZ0kvQ3rb6shLvF47/gVzRDkkrT5Q7k0ASJv+b4kA+bNdldMN6Wl
	YvABFWdQ==
X-Google-Smtp-Source: AGHT+IFYqIoBxOMXho0PU22QM+gfETHgQ9YXlZUvpAB+PVMOOaAoKgYIQ/E/JBjuj5jpVtdJkAW9Ow==
X-Received: by 2002:a05:6602:368a:b0:948:a3ca:15c1 with SMTP id ca18e2360f4ac-948c45bfab7mr338612639f.3.1762942989518;
        Wed, 12 Nov 2025 02:23:09 -0800 (PST)
Received: from [172.17.0.2] ([40.116.92.116])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7aaf78f7esm883828173.21.2025.11.12.02.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 02:23:08 -0800 (PST)
Message-ID: <6914600c.050a0220.1f2398.17b7@mx.google.com>
Date: Wed, 12 Nov 2025 02:23:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8965791866324032726=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/2] shared/hfp: Add simple 3way calls support
In-Reply-To: <20251112083150.54641-1-frederic.danis@collabora.com>
References: <20251112083150.54641-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8965791866324032726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1022376

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      17.72 seconds
BluezMake                     PASS      4140.52 seconds
MakeCheck                     PASS      19.82 seconds
MakeDistcheck                 PASS      175.21 seconds
CheckValgrind                 PASS      233.46 seconds
CheckSmatch                   PASS      276.37 seconds
bluezmakeextell               PASS      124.60 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      858.54 seconds

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


--===============8965791866324032726==--
