Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7B2748A
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016625; cv=none; b=m93dDEvUK9ThTXPd2Uan1EuWAs1OEvUASjsE8q+vHDGlmEEwXWRgqKz+s3ht7teeVnApJIrMm6g7bkOXMqe4Pz99qKfbKcEcuTdoam3VET2mQicSVLd/jyBeFsK10NJa16x8ixZ8DgpTHGOoq2IzO2BCH5uyKa7nyGGxnz3WASk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016625; c=relaxed/simple;
	bh=Ggl39lp0fK5B28tfVa5GIInOv8Y1rKOEiPUk03Ti+2s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bA78ai1aTjUdwJsCsjK88XxnBjlS35ykLmfhgTQwxKigtmBGU8RJGkR1tBqjsYw4grnfUu5ZTiRI1ahUQFDQYG73nlPQCGUIE06KstOqSFo7fFGlyymueihDGeDMxks89s5Ok/qOSJGCXgKhWyiDoIvuFnqPjloaGy7L/m0moaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAkJA8i5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAkJA8i5"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2161eb94cceso5193195ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 07:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734016623; x=1734621423; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ggl39lp0fK5B28tfVa5GIInOv8Y1rKOEiPUk03Ti+2s=;
        b=LAkJA8i5HwJDDMTiKHDy7AACOH20rojd/A08fwRNlyibGmV58gje+CjQmr4hbzf6XV
         nQGm30teYxeEr22MR475hgsl4vAyUJtZ5FuUn55CYfTFS/zOgdEJ4gwwEz3EGVJa1Kc/
         AMQftWOuBDpAg2vnpnyT1Io//agte7wfSIm9cM1bZX6ofBqhD69NdsjHyXq33vs/PhaL
         clvHRKOjBvJLADOEsDx/JImEUMsdgtMhhxIPOr+icAiu/MHbtnrpfnzkVyaTF9WS9qoc
         OMGTv65X+W6v2RMynllLsgSJYrCHK3XNyxBcRYf7nl3qIiyBAXkKIHjstRbwfpnPZ+n5
         W3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734016623; x=1734621423;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ggl39lp0fK5B28tfVa5GIInOv8Y1rKOEiPUk03Ti+2s=;
        b=qnXZeN1N3MUB+MMFiZ90e9jUOpl3MKa4O1sSeqoNDUO3cRiRF/8zKroQEp+9uDYPxb
         wktl5Vqa49nkn4RrTd7f/ta6QUbQ8KnjP0KjJnL2T9M3My+bKSOrV5xY2UXRvBXQFkQJ
         3ITyaf5rjDmuGbPsJi1WwsD+Tp9bA3J0SdUMHpFHPyhU7oa33dq9YH8NoPODIDw4sfjM
         JyYja32+g+A/wPxKKij3F/61mc+nosaA3cmkyoy6KvFbFNHFWUoYG3bnXTI9fnRX3muj
         N9mylnbmCCGe7ZLS0gDTTksQPiXPs/xutUsS+V/eNDimIL4hOj6t5AeKLphcPDVVYELw
         KVRA==
X-Gm-Message-State: AOJu0Yx3QkPlpTb+2nFhwBhdHNr39cveahVPMadLWTOps90yHk6zxqwx
	+cQJLJQ3kwvD00NmiE1lqFgrqSDGgAKA9NZrzlYMPWR9YGJq7Oeqc2t9fQ==
X-Gm-Gg: ASbGncsll98PslCcOp8Uzzkiwk8cGrP6Soz2Mk1lSumnqMHnKvIhjdH0r3C5JuFK5CZ
	7UrMYmlxVJBoHRgR1Y92ZLP72Nk16bTIqD2e1LwRaqneX40yIjKD0QL/QV5IGhrscaDUOCxptwv
	iEl83gCbfpniM+XGupatd9k7H6IVq30PZGCEDFZZNRSbNu/BUhZ7JKGDNw5KfnpUVe42LugZuHs
	Tr7k2pyzq61wO7AILLb+nDtF5vV/+xRFxEecZScJ4ar6opmejKaI8KqH7cySA==
X-Google-Smtp-Source: AGHT+IEi9BsGu5ZIx3fuZv9SbX/VV81WiwSnhKpxwNUyrMa5eUrJxyy0vwPhOvg/nZBK3EXbEk7Bwg==
X-Received: by 2002:a17:902:ccce:b0:216:46f4:7e30 with SMTP id d9443c01a7336-2177850596emr131818945ad.43.1734016623311;
        Thu, 12 Dec 2024 07:17:03 -0800 (PST)
Received: from [172.17.0.2] ([40.65.58.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2165590a8ebsm66190715ad.271.2024.12.12.07.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 07:17:02 -0800 (PST)
Message-ID: <675afe6e.170a0220.2d20a6.7c0a@mx.google.com>
Date: Thu, 12 Dec 2024 07:17:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3210158628687466216=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_chejiang@quicinc.com
Subject: RE: Expand firmware-name property to load specific
In-Reply-To: <20241212150232.3823088-2-quic_chejiang@quicinc.com>
References: <20241212150232.3823088-2-quic_chejiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3210158628687466216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi:857
error: arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3210158628687466216==--
