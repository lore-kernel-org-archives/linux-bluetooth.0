Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7179C1A23B0
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Mar 2025 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742922844; cv=none; b=InjsVnIH0L0/ML6mwOa2YcOfn03Wigct2RZsKH2m/hFdGrHHMZiG2b8FRIZGrney12kgjnRcIMaSm/AhE7KeW5o73sqG5daVlnKC7T+Tmna+h/A17F525Iz5X6xXT91pjoBzWmLRSazmNNMR2THFmjFh8k4ylLBN+7MFvPemCYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742922844; c=relaxed/simple;
	bh=K7rN+guza8+NjuyFX++RPuo4hgAD4K+Dw/TXdb2grIk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PL73fLO5kQVnouUcEcUXxbuHVcaH/OBOSAcLHuN+xdGGpV3SiiC2Nu6eXitSBq00dyBP2YE2gUTKdAMPdolMuJeXi0cQKHhp7izr1F+9IPScLuuECkc/KW+q4p2EQgyxy2NOUdiHyNxCyb++xAEUxCg0enNcNBNq7bof9IIE4lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpFeO9uO; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpFeO9uO"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c58974ed57so589885085a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Mar 2025 10:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742922842; x=1743527642; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0yZSZ/nILsRP+dosSYY4T2ZoyZyzxT4Z2oeIRr2dVYA=;
        b=cpFeO9uOtnb21+MD0sfdYoT9y0UQOiEtzX+xsvIlRUQyJs1Q0JnNEE7L0vx9JXBUe4
         htmxcDUe2MUH7q/5QtGc9oQYijC6q7Al0ALhXAhpcf/dXVYg7UUMwihhe/lCeSU7M5uw
         p96LqiKrANnu/O0LGT+oaBEklci3jvlUL2h27fgsNfpxdnpFYuPHjHftl2IQ7PXOpPTD
         Ah1zpfQ1Tmh70VIDTfguqao+SWpW+L6RKPBtZfNB09EG3u22hhV+HEmmfDkE9Z4qjQff
         NakbOu3z0YUBTBVwYIziO7RR9LWmVwUQP7sScbr3tgD+wD4v/Jk16LBBtxhfLmpZ5scd
         fbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742922842; x=1743527642;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0yZSZ/nILsRP+dosSYY4T2ZoyZyzxT4Z2oeIRr2dVYA=;
        b=EdpA+clEE2q/MiwXejZXQYjpzM6nDubbB7ONnaafS4WkkpoQSJBQXdP4rKWPkPJvx2
         plXovpq5/4SIr6dU7XRiPBF0apseXQS2qJ0mgGwo7CD0+bQehIqQjihwVf0DblLxabGU
         W60GiUN/z0oT4Tt1E0ECsG4HLO22vchi0rR5OnWR7Ryzwf3DhAgobPlwMdASIYxDKi/a
         3/h7D8qMNTXE8txhXW/lqj7j2I8a+i68nCfrnb+B+lwpRJkoVD49tkaOSIJ/suK82AxP
         iM0ONQ3QY0L4AouFa4MWrmJwuOfijlhQ06/gawQsZUqflcjJWyDA8h1FV4hezDq1BdnF
         u5Hw==
X-Gm-Message-State: AOJu0Yzc+uOXoTVEUA7r0XoD6/Fwympse6+SvOttPm7xx4cr6STqTFnW
	R+Kc5tJBmhpXwgpTTdVblNRKe8DB9C75j2Kt69Ld/edbOAsjJfUxwi59Gw==
X-Gm-Gg: ASbGncteilN9ZJp8jjNXYVogA/x/axhdkgiSyXYpjxs+n3V4cKcZlAcrM4obzAx7GGu
	EtX/xyYr3JxePhYbyEish3xOO9VfCUFLyp4KLHe2jD9fGYsRhQ5VDeu7lpZ8XHefBzW/87FSS2S
	B8r4bgUrqS0hn0UJ42/tcGQI6D6nA+GCcNu9RiDXIacSbGptrYuWdVOO5OJ5yWOvpIeFAF/4Puw
	5/PDhwZHE//ENZclSvVSP2PkRVnBBBBDR3QwE5zhUZdWGR347t64HA9t5YLinbcoJDe3CKzlGWs
	Yh1g8L6fupp6cwkAcs8NiySeH+x2jtjU81QlnJNdVS8+AJ3AnGo=
X-Google-Smtp-Source: AGHT+IGG/yMMU6OYVdxvO56upyxI0o1Y64yOk5T2GUBxmDzgF7bK7XPCUCO39ZFoT7pTInoIH8pXWw==
X-Received: by 2002:a05:620a:d96:b0:7c5:94a1:7975 with SMTP id af79cd13be357-7c5ba08b40cmr2490466785a.0.1742922841782;
        Tue, 25 Mar 2025 10:14:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.192.103])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92bc0e3sm667488485a.8.2025.03.25.10.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 10:14:01 -0700 (PDT)
Message-ID: <67e2e459.050a0220.48784.d3bd@mx.google.com>
Date: Tue, 25 Mar 2025 10:14:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7437445795830936955=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: bass: Add support for selecting multiple transports
In-Reply-To: <20250325155211.18111-2-iulia.tanasescu@nxp.com>
References: <20250325155211.18111-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7437445795830936955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=947208

---Test result---

Test Summary:
CheckPatch                    PENDING   0.20 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.74 seconds
BluezMake                     PASS      1491.75 seconds
MakeCheck                     PASS      13.29 seconds
MakeDistcheck                 PASS      159.23 seconds
CheckValgrind                 PASS      215.50 seconds
CheckSmatch                   PASS      285.34 seconds
bluezmakeextell               PASS      98.71 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      875.13 seconds

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


--===============7437445795830936955==--
