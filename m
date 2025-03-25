Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EA415FA7B
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Mar 2025 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895555; cv=none; b=O67GRyBLVHWMKq2XmDHC7mkKShLWSoFfq8nYmBU+xTvArfUtqka8pO84Aw0kptJjP16l/GO1kvsi4tdo9FPCtUqMEj6RJ1Liv19V5IoQCOVDhwNPi78X/SOsTf0a9U3N8Ws+7WLSDyc36hfJ+8Mmfrt9D+HCeBt3NkRnTa4i/tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895555; c=relaxed/simple;
	bh=cIKQInaWzp5GPnqmQSxRpBnVZVRK6Y1MkI/BdmDazkE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Jv7MYYJXxvQFWRilv0KoiAfoeQZJmce7yNXlDEHseH/ahQr0qQpL65rnNAM5OWq19TFm1L07oxMyiWfQGQ/Hgt/auXeW17CTZskO3Ex1L0KF3qm65q2VoHSq0kTangeIVHbFqpPq7VaK5Srq1PvEQYIQBaJduHOk6ojC+AKxuFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUngm0ah; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUngm0ah"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c07cd527e4so497867985a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Mar 2025 02:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742895553; x=1743500353; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Cm8F3zM8RHEIPNCQlapfe7pXBWRLbTse5Kd7DQ+ZtTc=;
        b=iUngm0ahUuYFL9zdIzXygAvBgL1+N7vZx0d8al5tYAtHvarvgFF/8rR1+jzjNi31Y/
         Bkw9MsqO4kw2Op8xYtVV3vTGPzYSSp10gAgKQZApQP3zQWeKrzOomS/RVUTkP7vLXgJ0
         N/xqd3nKzajcmDFqUinSPo8gbqTY9p7T/JhxhunZl1axpf+uigcBUQwmk44rdkf0NpP2
         aEtBAFArrMRBqEh0sdlKEL8qEloN6U7YfABkF53bW7DIpoVDO1HXE3aDdZfVtu0Vb4zy
         CapgbQWEms4sXjGL19mOq0ZVNu57wHGe0KskUsIMIcqtfziwsgLrw0NKmmHZINZz94C+
         PhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742895553; x=1743500353;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cm8F3zM8RHEIPNCQlapfe7pXBWRLbTse5Kd7DQ+ZtTc=;
        b=i5UW3l0EYP+MDzwYL9NW0C2cgVBgJTGHaPi0ztmiEWSB2DZfD+3qLuJBd6y8S6cDun
         1iqaXQvNn6it8k1Di7Oh2dWYWOirp5tS9L8EfzSopQDD8Wa8O0VxkSl4NSnBRfja6MqW
         kTgDV5WY2TLy9CDFcujJlo9ww3Qsxx7NrcjyWW2dNBzNWKwYjNZW4+RZ1OwjUO8iib3b
         t9psia+EuehekuXcNadadmWBR2LNbKQcVONKLfmQu9kNLq1eFh7TMJSe4DTaOJdRUdUw
         D2hCAGcX1PtCaTwDdhK+OdzNRyXvFm0g0rdbfzRT5ruYHJAHmTHsWVYVPBXrXDw3jvxV
         r1tw==
X-Gm-Message-State: AOJu0YzKrGA7oM3s7aUEVfym7W9MqYCRM9xZUhGxH0Rl9wHloIxYH3LR
	vMPNnTLkSTLcFt+VJvjknj/4XCYormX1I4AHYWWecLUYgne6oTPyr0oHtg==
X-Gm-Gg: ASbGncsYS3IymJigo1v0BNR/BF/8v4MXWbaQB0d2bINh/hi/PMcVCGhe3HDMn1s9Wr8
	HPs9aXAuDSf3izRPKDyGi8JLJdrXYI6JOfE2eDh07IsJsCNZvWfCEfMPRwmQ0p91OR/h7/zpXhe
	/CjFjJa7fwULObDsORlrWPlj9FvFgl2Zb92TMNcd4gtTqiUFpMTx1jC71FNWCXGL2/da8SWnB4i
	cW0pW1U+QEraXMho3qskWijl2Qd1kFzHgzSX+O53KQ2V9LPMpopxfIIZqHhs+A8ELkcXxRHdfIK
	ubb9Pk/FuxtswelkkdrYLwThfhlD25J7m8XMGME+KYuyzaB0gEwwcQ==
X-Google-Smtp-Source: AGHT+IEXjkpRNSgQW32LMZJD2qOgtRlF7oxgTDucvdQXNkR/fmK/3U2cEaHWdMDA/iY+CNMbxx2IZQ==
X-Received: by 2002:a05:620a:450f:b0:7c5:3d60:7f8d with SMTP id af79cd13be357-7c5ba15c1cfmr1952197085a.19.1742895552564;
        Tue, 25 Mar 2025 02:39:12 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.175.194])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92b8271sm623558985a.24.2025.03.25.02.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 02:39:12 -0700 (PDT)
Message-ID: <67e279c0.050a0220.10b2fc.8225@mx.google.com>
Date: Tue, 25 Mar 2025 02:39:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6471014366473904355=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ziyao@disroot.org
Subject: RE: [BlueZ] client/gatt: Fix pointer assigned with character literal
In-Reply-To: <20250325083546.31597-2-ziyao@disroot.org>
References: <20250325083546.31597-2-ziyao@disroot.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6471014366473904355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=947070

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.20 seconds
BuildEll                      PASS      20.59 seconds
BluezMake                     PASS      1501.71 seconds
MakeCheck                     PASS      14.08 seconds
MakeDistcheck                 PASS      160.64 seconds
CheckValgrind                 PASS      215.44 seconds
CheckSmatch                   PASS      286.46 seconds
bluezmakeextell               PASS      98.54 seconds
IncrementalBuild              PENDING   0.71 seconds
ScanBuild                     PASS      898.19 seconds

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


--===============6471014366473904355==--
