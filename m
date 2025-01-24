Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734AB3C00
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737706114; cv=none; b=m+tl0+wgGMnWnUHB1+BHwtftSTUeotCcVGAkMfjQcBc7YupO8wokQ8oPcgsIKa/3ilyQIY8U5jn8vGowPQQuljBX0dMFL3IQkfY8392Pqadr52XwwFhxPljZ2BG8ObQgoKRyhAkGOfj26RzsCH64+VT/b/QKUomRXf95CtVKD90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737706114; c=relaxed/simple;
	bh=XMT3HtrO52fZ1D8LBqUNQzklZ4WIGGvQTgejVDWlAKM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cVVRNTig22ouLWTD0qdac67081D/7BgLxROdwjJuQzdy6fbiN6Df7FqwUWIxJqWoiqoguejn9bgIX+noicFQl+l7YBBsyvgJ26JN3x5iuPeNZqPc+a8Dzg7gUAyOm+vOaz1io0L4flGihRpKYB+TRGuB/KVbzbcb3WloytwNURA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FB0MPU41; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB0MPU41"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2162c0f6a39so55548385ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 00:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737706112; x=1738310912; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G8LUerN1SYRz/XOTaZoGIyCddvzyhSI/HB/lPGGkNnQ=;
        b=FB0MPU41LPBi0SLhqKuZ/gCZHHYbY6Q1PmZsjMFxotL7d0QxLm+iEW0Zo1a4z3GeH+
         7YrHeT06sfGLOtW5ww2NZe1CKv/YFDPK6KqDY8P5Vi+EL0ByRglJB1n9op64zTuUC6z3
         wj2o9LmIJ0UOAU09hjFpcVLl0Sk0kUn0/G1/FShn3ev6B9KyQCCU4nJ33IaorVyzOZjM
         /hQk7rEOATg7r59ajPM5qvlR36FHhwhPqOyDUcesww8R1bxLwMO8ZXe35MyfZ1muVX04
         XG3RJNWZOr6tHdz8+fikW6IC1hu2pmW25M6fGGABFbmqO8UEokcAYTN500NN/4zVITOW
         gj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737706112; x=1738310912;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8LUerN1SYRz/XOTaZoGIyCddvzyhSI/HB/lPGGkNnQ=;
        b=pTveVMdlF0YBFYZ2BvA35FgEStEc9nNob5xZNRaGhHuVJtzkL3WJqSIzccaPPNgSFu
         jYesH7a725hr2RvWQNg8KJvXLOw4knFzC8QrNx3FOu0kOH0G+eJUa36c3tHdS/fa/51L
         tYkyv1qXO8qtfXXb6iSFoCYt0dy4O8TvtpJW3y2nsJV/I16AM7EIYDnb4mexrSTjaQfB
         UJ9lTUZ36/vbFkeLvJPjeMBVh4Qeudel2GSzS0GO115DkbFWkJq/Y0LZzFUF+iVQJxZg
         ehQJ7KUc/VOa0UBZuuN7Zdjr1+KEErZuJW/uTXkYOZaNuwo3Bpmcvp3eOIWjJf6Z0+Ac
         +SDQ==
X-Gm-Message-State: AOJu0Yy3qr/q+c04rtqmQxKkeHkA6PM04gNnwl04heRV93OfKE2TLkzf
	B7EZNiBeQe4ukMVtnQhlZ2PviNfh6dRw1wPbZ4U2s8pLs6LfvTB7TKDyzQ==
X-Gm-Gg: ASbGncuUVkce7EuMuEKobnRR/uKb2WOp3PyHRmHewzk1Sy/Z6547RzfC0XyN/yFzsY3
	NnUz0iNJYTm3ugRr0CkBv9Y6VCBCOcPrbXBsk/UQPRes7WjgxVlBWIq3DsY4wQVcS8N4QCTQ/PK
	SD8ebfwH7Anq5kGxjRPwvXiqheebjwjfI571O1a4W/FraKv7PdfwUJ/RkuM4Xn/Jk+dVq8NFYJs
	Oczf/G8Gqm0xlUNE2ewx1fHLh6OtcmjGFmSPJWz3S9QOh2Xn3cI2Yigwi3gBFjCUVu4fTB1GhhK
	m50dkTVVARl+
X-Google-Smtp-Source: AGHT+IGKHImO4nDZp5tqjQ5qtCOkdFr1j0ylrj4GvO3f1hprxgadwPQMbYTLKrbU51j8NTOMxCgHFQ==
X-Received: by 2002:a05:6a00:2e08:b0:72a:b292:1e96 with SMTP id d2e1a72fcca58-72f8b3f238fmr4651810b3a.12.1737706112340;
        Fri, 24 Jan 2025 00:08:32 -0800 (PST)
Received: from [172.17.0.2] ([52.160.161.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a760e2asm1234841b3a.88.2025.01.24.00.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 00:08:32 -0800 (PST)
Message-ID: <67934a80.050a0220.386972.6a9b@mx.google.com>
Date: Fri, 24 Jan 2025 00:08:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2471835725175672709=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v1] obex: Add supported features tag in MAP Client Connect Request
In-Reply-To: <20250124064140.1071458-1-quic_amisjain@quicinc.com>
References: <20250124064140.1071458-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2471835725175672709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=928030

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.37 seconds
BluezMake                     PASS      1505.59 seconds
MakeCheck                     PASS      12.85 seconds
MakeDistcheck                 PASS      159.41 seconds
CheckValgrind                 PASS      215.67 seconds
CheckSmatch                   PASS      271.64 seconds
bluezmakeextell               PASS      98.52 seconds
IncrementalBuild              PENDING   0.37 seconds
ScanBuild                     PASS      868.13 seconds

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


--===============2471835725175672709==--
