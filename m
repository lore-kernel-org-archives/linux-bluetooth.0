Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724069;
	b=vvVVI5nRFnz0aUohZxfhHV4jRHon+nsn0OY1IPAvzcUP6yzAKescahEhaMHRzWWLgx2c
	 lAGdd3UmX+2Yw0qLOfpn5Q2hE7bGP7yEWAPdOKnpZyeJztlBDWAYGHOE9wIO3jeeW9N9K
	 l+SXHVKD5zd0/+v9iRIs5GKJ+E+dnQxq97mfUtgw1cQcMbSHF2D+2CnnuPHjl+CO/chJI
	 GwehkamQpLOntYTgLJDbDMcve+XUBTscYwFyqS1l5ByNgvz0Gnm+yqSwfqC2xj5QZqhwh
	 zUr6Bz4YW3ZpXYkaR7pBhuyUQ7pyZSW/pBqCN8ZzwuyeLbTVONszzC4+wPTcJGlE8IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=FoIFmRvQ2TCrRp721594FHug0TYNwGSktiTDSdRLDNw=;
	b=3tLRWNfy6sXcsCYVLmeH26Cm5UB9ELJ3du9gDneSbLKaTcrJ/sinEXV9SSNi6LDpOeEM
	 1SNjOhW5hGPyMrouRR0b5LIEAFoHXyMblBoaDEWU9niHCH+TDA/Wu1OxI81YCYba8VzEv
	 K142zWm3OgHox6f4mbh9TodMxfC05Ma+FbHBDI579Tp4t/TL0dZVGleZyZKCjyEJAIbmK
	 1PcE4lXcLvGeP65SmeoIFH9aEpk86FGksoqOvJ7TmO2shtAghKKz2VrGJ5HEKitpVWG6Y
	 BpfHFSLxYI8RJ9594lhF73YIJqzSr2qItj1CgQu8l1w0A3OYqRizUj2+LhmlP5hGcVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qk36MvFk;
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C557606D838
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 16:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C557606D838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qk36MvFk
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-845788309b4so2001281a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 08:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793724067; x=1794328867; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FoIFmRvQ2TCrRp721594FHug0TYNwGSktiTDSdRLDNw=;
        b=Qk36MvFkirb7lhVQuQxTRwC5NAe9ZHlDK1eaE1He9d2MLJ1t3YuR+d84RehMH54dEs
         DGIKAy4gSI26rrXmi7PkiO1IiT1uw35hid3ENN62bjqXWmRLsrabReWL9nsK+TLEAuIR
         qp5sBasrypM7r/qI/Uru5yEkb0xI2rrvKh21vELmAa2U9CctSQHmgnWSE2oirwwDMd57
         nNRWxnqWJpV17fS/WHrtyGJmn8rMFnPh17T+vKctKlwkO9Y9SF93BkAip0bFkpbWknhM
         U7q6OulzyoeI0W5Dg0MAonWwinq87PW2dJmeAdoPBn5U7br5Na4Ck8KM1kM6r6F8JZ2Q
         rbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793724067; x=1794328867;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FoIFmRvQ2TCrRp721594FHug0TYNwGSktiTDSdRLDNw=;
        b=H+hHq1nkmtl054PReHSpEKOGbptzROME6PXudiDUm2HelG4VoIlbBPXoCHyya4VEN7
         0EivF/3SWv+m0QSFqPCBX5kilGvKSNxIBNTOwjY40gJWRgQ70enKO5wJ+AuPeuFcG43K
         mBEhP1g+O/Kg1WSyCxtVlafqUgFHRFvRqOoVpz0YaZzJufRfywKkCRFT6SjNNDnCpzS6
         F+l6DphYzglgI5e4hVcJ9I2bnIXb2gOJHafNZBbdWgQu5qNEd4KR2lBE8rZvlTuc02nM
         wTuGv6xNFydZNgdZ0BE7/2cl86B54iWvWkufet691eLu7qJoKRYfK5YBbMQ8V/oDzNMR
         WBkw==
X-Gm-Message-State: APuU4Z9xE6/WsNyQAGiy3eEcpebvScyszpQ1doiWXjip1A9TXCbZMd5C
	8IVcdePR1VcFeOGB4UJ9fah2lj7homnYyey9or95In1EbBbrjCfCYhj1jRfn7g==
X-Gm-Gg: AYBFou3pYAcJNq/esQoqKYvl0iVHGc8vVcApKDov7bGdEobAjH7I3PA+8ssJJQZ5MUe
	FW3mwgtpJrlqBnJX3ofYg5Ip3gjK8peoghUb/lY9XwCcdcASU8rRDxsaparXnzFfcnAXgVQubIQ
	7jwl/Bup4ngZAmSL7oTqkMORiS3wX1yv73CR1xQneg1ZeuVsHsy97nerhYYjioyeThefgZrjf6k
	QuicRFM5hFgXNySbDN9BWK4YH8/gK/SwCFNL04+dtnEJ6gBehi6oZLBgqLc8Be5bNevcXnyfwqT
	o0pMKsa0qzR4W1XRnGmC+/ll31emvBtYGT4iZIQEp6McHtUsyB4alaymvhgDOF+rIh7fNbk6qU8
	Al9HWpgVmbga6YbKizjd+ggTDnAFW4K6EaxRKJ4ZIt2cHlc7c3jEIXBP31YeUaKmIkOp/uTdZfq
	7Vsq6caRFTOFqrxZCnnMxYCvNdW9duS7zX+5vuw5XfixRCQkLGFD+sTwukDdt6vOKUuUmNByIFw
	PQVr5zg6E734JbrBRP2yJLJUn4rPqDLOIte3PY0f+XntspsWn+jqgNB0EFijXkI
X-Received: by 2002:a05:6830:640e:b0:844:d703:a2a8 with SMTP id 46e09a7af769-85d36561053mr9913547a34.16.1793724067502;
        Tue, 03 Nov 2026 08:41:07 -0800 (PST)
Received: from [172.17.0.2] ([20.112.237.221])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354f2325sm12199484a34.20.2026.11.03.08.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:41:06 -0800 (PST)
Message-ID: <6aea0ea2.a24a1a8d.1c9a72.95fa@mx.google.com>
Date: Tue, 03 Nov 2026 08:41:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7448710912015652787=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, valorcool@gmail.com
Subject: RE: Bluetooth: qca: Clear 5th byte in TLV tag 27 for WCN3950
In-Reply-To: <20261103103529.804025-2-valorcool@gmail.com>
References: <20261103103529.804025-2-valorcool@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7448710912015652787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1200171/

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      20.83 seconds
CheckAllWarning               PASS      22.94 seconds
CheckSparse                   PASS      24.56 seconds
BuildKernel32                 PASS      19.88 seconds
CheckKernelLLVM               PASS      21.46 seconds
TestRunnerSetup               PASS      448.77 seconds
IncrementalBuild              PASS      20.30 seconds



https://github.com/bluez/bluetooth-next/pull/1052

---
Regards,
Linux Bluetooth


--===============7448710912015652787==--
