Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28FA2690F9
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634431; cv=none; b=VwFyY0KnVVeJzGlqpRMyKJC9s0IxEnduM1/gQEn8FLuojSbiRD4LVanawflkjflviwFeKlKQe45CU4w/WzfdV35OoSuHFaUGhxedOHWuPh3E1Dyy3756HT+JI+uWrZGt4YV+qLjf5EUQjIt9v25AAFtGYkscfdF+QkccGmQ0ztQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634431; c=relaxed/simple;
	bh=o7/Qkj9xaJ/2kU8rcKIRBvL4tiOn4BCONFHeK6jl6VM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LogtMX9tFDIqZmTle83EQj4hZrnwEKjxfCR8yJjWdCPQ8iNiOPpIibIXbtLV5JgaOacBJCs5HCtCXmufqiEgPG988991W7qB7uOTGjGRRwrgHDqTl4yYEEBW/gKH2AjNTrF/4e++xStHRnySDmNbqvyQEGreqcFe48NkTqcD5/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdXhTrUv; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdXhTrUv"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6facf4d8ea8so67143586d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 02:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749634428; x=1750239228; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yUnhPHl/eIeNInHL3tcC4zdtvdwdtz3mCDOEVEd/vPs=;
        b=KdXhTrUvHNKm7nCKl/YI8cIyd5Dypcxdot4vEU+U4AwNcOJjSER6URcApKglNFu1S1
         g2BGUUrLjs1og/uw7ZH/kzun0dQzp5Tzh9rZn4Htjqrr3J2vXq5OMZadcZM9Sck9yEuB
         NoI8zx0zgnTMOjgbAzot34Om6peRlvS6/+P6BBI6bKCrDOTjoSXJ8FJBG4PtPECEnZZq
         4/4Il7nQ444k+XFOBYsn6IaA93OvEHvy7+X9W8SQe3upgm0fDNZ/qjZrcgRr74+kADPr
         PZWtNhz1TpkEvlxp5mnptm+qneQUzZow9RF771VVeAhSokisMLEJOrhjZFa6bAKP1Gta
         yZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749634428; x=1750239228;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yUnhPHl/eIeNInHL3tcC4zdtvdwdtz3mCDOEVEd/vPs=;
        b=s8d0mPx08GngMVCzs52G3Q/4AnOaNMkfm9qdyLq7D1XYcOTNsoMnfPE1aN1IiKKrAf
         6ffijd2GwxoZ5rKIF/D5hwGP7dn27kBvBE2aZNs4PacpUZt+uAsEIH+HPdO88PGHZ1/v
         DlzqeO825k4v8uCO4XKFt6Zg11oF7xeK85bLMNrk4NyCCP/Pb8M7j18dBqd3fBvhWHfq
         WdVdNfig3OMPQB8QWORGleeeG/JcjCqjBMcELXjjpJCfEt6qsvD05aVvmhqxgAgx91/6
         puocRHOXLBcalmyRPcWbED/Ca6vEe02VgFZALZDcTDbLSrNPFBJXMLO7l9CUyI2m71qQ
         aXDA==
X-Gm-Message-State: AOJu0YwDsEPVfc38CjW43+qmdVli9ocJfPjAgga0m2AtK6R2BNQMAOVn
	5e7ai/55001g3/Z8Yv9PPjclzJWPYNIOqYnYMFgWmgzYNPN0FKSyVesEzPSkvw==
X-Gm-Gg: ASbGnctMRttGcWVBggbrP+AnXV8X5wB6KsJdH4KE2vxKyo8OU6DAUnkd2fGFWZc4Ztj
	g7QAVyvhR8DsNgtQvrRxDqmps+HNvCKa0QoLMKggTJE/YzlXUQGXz2LvlOAfTK3/gM9lmHkiJiH
	Eoyzed5MlBRDPttbbrxFk3A9OgNoJN2KEIojrWcLV2FOBpkwNLj8r0yi2ka9pmHeyCUpPkozSIq
	E6JfewPjwVA4t55xZkgdQAFDCsJNtVvXh2vGJhIBC3MqEM9Xv3fLMKo+yRrTKitn56Gi48GmGuJ
	CuC8JGw3IHyiHnlenMJMGtat4Y0dqyhaQ4BASaBMUGMQdp87ReH1KUqzQoi5OmtQyO8hRwa3obR
	HKg==
X-Google-Smtp-Source: AGHT+IFJV3yTX2eVW2aTo6YrpPxQDL/pbxwqx7P4qWWZHXJ2MfMcNpOnzWxo+IpDQeAxyTX5cIRuHQ==
X-Received: by 2002:a05:6214:62d:b0:6fa:acc1:f077 with SMTP id 6a1803df08f44-6fb2c37278cmr41015226d6.35.1749634428105;
        Wed, 11 Jun 2025 02:33:48 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.218.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09b1cbb7sm79633706d6.57.2025.06.11.02.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 02:33:47 -0700 (PDT)
Message-ID: <68494d7b.d40a0220.b76fd.128d@mx.google.com>
Date: Wed, 11 Jun 2025 02:33:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0878765098380604971=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, adrian-constantin.dudau@nxp.com
Subject: RE: tools: Expose the raw advertising data available on D-bus to PTS tester
In-Reply-To: <20250611080044.26730-2-adrian-constantin.dudau@nxp.com>
References: <20250611080044.26730-2-adrian-constantin.dudau@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0878765098380604971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=970691

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.13 seconds
BluezMake                     PASS      2712.63 seconds
MakeCheck                     PASS      20.10 seconds
MakeDistcheck                 PASS      198.89 seconds
CheckValgrind                 PASS      274.89 seconds
CheckSmatch                   PASS      304.25 seconds
bluezmakeextell               PASS      127.76 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      907.85 seconds

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


--===============0878765098380604971==--
