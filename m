Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2208C2DE6F5
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770933048; cv=none; b=hJ12N8+3kmo2JegrIMD09H17WaaXeDPyYCXFiZ5aTqq1lZsEqa186/e9WBYNX+3gh2e8w+t3frqzR5Dz0tQkuGN8A5T548fR0E9s5H4KY22UPm8VGZZQ2Sb3d4fT4TR/2+84stw+hmnECk8QN0eQSNgA4fG9Ek7E5pfSdr1qH6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770933048; c=relaxed/simple;
	bh=T6u23KdTGgA68ji5j1gJKKO4MsgbE0DN43RYcMMM5GM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=R5RgvPEwaw4st5vbxsH8XaQaOCpWL4gYUzQXRPhrcnLiOn/IoEIvAWdJNwk1EnOn5d0dzsW6+pLs57BbuSTXLlN5bjkXsY1sa1AkWs2oq3LglT5Y+QaY5nSB6Pm+wJtGOFfPTZqoqAUOmJ8kwLjEsa8qyN9uSY/1UkVkxjSdgps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gb9Ssv5U; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gb9Ssv5U"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b740872a01so569330eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 13:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770933046; x=1771537846; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZMK+IzB4+TCWyZV8wT2mHglJ63SKYnDcj+l/jkVsVI=;
        b=Gb9Ssv5UwxT6lPLlkSPaJWXyh+lrmH3Jf1+jouEZF6ywAyu5TEsCIyaT0sIwV9HY8D
         /3Dpqp7VFwioQqAZKQ5wciIH0QNk6cHJ2YZSixRA2775ZqbkLXbVW86zMz0xga7ykwny
         cbFfk/aXxBceBEJromj3R3E2ih+h/RuWT+6Kol/Gr0m5/U4ZJwcgdQhIcPjblthekWYk
         P+xRyJPtZOlaGLb7YWimg4Qszq0RIo/ohV0jRpodkKmt6o83FhRH8JT74srHr/ni49pH
         0y9EKbOeD6B8+/hAIKfXMXGhoFLNZdo9MAC+hMH1kIL53O7zeBvVUTchNGHA1iByCPMG
         bdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770933046; x=1771537846;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZMK+IzB4+TCWyZV8wT2mHglJ63SKYnDcj+l/jkVsVI=;
        b=cEKVDiDTYrMkFGTu/5K2aWfpbDdQDblGozH6M9ylBWjVDC8LpnrjAKvlFHbvXb26Hb
         IfZ9Uai9gKvKVE+WwDlHJkoad0/8jPaaoCAIiYIzyksyvnvibYYpmvEkrRR6Jdv/OdZr
         Zl+6XkHw1nCuO6b29r+UPbGTvz9i0a5F08sgvC6A5yDHZy1ZISVHUNHITiDWj29DVBuS
         xtTsgLmCA/jMiWspY94gdOkqPukUBneRW2wdKTyCKFtpPzIdxUqw5gw1d+r5ZgD3icjh
         aauD80vzKHqrw5Qn4gEtOyWRBKKfbP0kzwhY1AL6L2ja7H0gAo2STzrT0Fw/+kyrCC9/
         I/oA==
X-Gm-Message-State: AOJu0YyuyKaxDKGJmgXUzPXBwGNzUBagydlQ26pyTGHSTpeGlkw0uNJo
	vmQ/Juc8JiTiCGe3/X3Jd7K3jMhc0yFs3o89O+aLHKgUNaksCetCkDZzgM8MOSJL
X-Gm-Gg: AZuq6aIRx+/FSR1WUsfV2yJExgWnB5RwxeDRU1fR24o98mN/TzLNpEpqO1vag9YJZOQ
	dTLIQ7XrwJMdiaOhJ9UqDF2Way7ZjxwAiFHwNdCpZnMnnlW+j4qQvQXjGj69JqfR/WSl0WYrxgi
	S1vQ4EIOgc+kJsPBbvkm75j+AL/0rEpTecsDemvean4ApuxUB+rBGUPVrnvP0Djto2mVmRsY8qB
	KVKnMiL4QuwUMX39RCf4jesKWBzea73l8TIAg4pOOHYP9NVJ9Bm+BxoTvTvQDJ6octEauMd2Naa
	spQJxNC9g5lkcZ/oYC24OYOckGBMqEJbgJyY1EIyJ9+pnADgCXv+48SOiZp8y6NFV3JEonBpQN9
	K4G8Bp8Hnpqwi9uIdRYl/EBQFrry0E4mmQzX9ZtuwMlQtZeyr9JS6Jl+QLvdDF6f4tLKxcHv6uo
	Qn5eQqXSwK+jJFMzo331qmOS+Y3FjG3IlDRoPnsahSQA==
X-Received: by 2002:a05:7300:cb15:b0:2ba:72b1:40c7 with SMTP id 5a478bee46e88-2baba03cf71mr168374eec.4.1770933045933;
        Thu, 12 Feb 2026 13:50:45 -0800 (PST)
Received: from [172.17.0.2] ([172.184.174.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dba2fe9sm4311869eec.7.2026.02.12.13.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 13:50:45 -0800 (PST)
Message-ID: <698e4b35.050a0220.314f02.84b0@mx.google.com>
Date: Thu, 12 Feb 2026 13:50:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2549771436610533645=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] bass: Fix crash if setup is freed before bass_bcode_req response
In-Reply-To: <20260212205710.1690782-1-luiz.dentz@gmail.com>
References: <20260212205710.1690782-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2549771436610533645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1053680

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.43 seconds
BuildEll                      PASS      20.88 seconds
BluezMake                     PASS      645.63 seconds
MakeCheck                     PASS      18.61 seconds
MakeDistcheck                 PASS      245.36 seconds
CheckValgrind                 PASS      296.80 seconds
CheckSmatch                   PASS      361.71 seconds
bluezmakeextell               PASS      184.54 seconds
IncrementalBuild              PENDING   0.38 seconds
ScanBuild                     PASS      1038.90 seconds

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


--===============2549771436610533645==--
