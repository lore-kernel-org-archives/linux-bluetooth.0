Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE0A4307BC
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785509435; cv=none; b=igMU4cSQhG1jcvHwnLYxKAG9xvtuGoRRKBWzxXfJTZkySU0lYEL1x/gm6aBu5UaJ0g4M5KY9xjj9FHBmJ1/PJBvLUvHBFM2OHd43QNsYht7KZ+g6B+IQV4pqzEzOsytbcuQgMdbzedpzVJT8TTqDxR5VvdSFBJ0ZPKYR53KErz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785509435; c=relaxed/simple;
	bh=BfzqBY1hgZN2IXxvdpyQrRrpvJOmUvCt4XFaeDb7y5w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rFvMlsPMmL/uawORwlss57+9e9ci64tlVp6lSVLVfXOTr6/OhEGVhGASJWPys5Mdy5/QbHKpKeE/00I5Wtbudv+l5q6TFls/JdIWHlYOW3X/lNCUVjAHL9DyC7ijCoN+ZYqmeQtxORPHDqKpmOiVCd/Vd7w8ahqlz6DfVfMqtkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOFuiqmq; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOFuiqmq"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-930fad20240so53400485a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 07:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785509433; x=1786114233; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xjUwzJpM/uCXdKN+lxxHNcyxZbz8UwKPVfqyFwxUIiM=;
        b=NOFuiqmqGACOVamSpL/5rxf/OdA1LRft3S9v52qtjjAyyKE7/ifHQ+9kBbLRsQgaao
         MQN/2p6Ry88+q069YEvXWEGDebdwjYfyexcf9tm98DM83ne2SR4IVtK0YBVRhzWuPx7s
         8Od398MQdKhzKeGiTXfUVKvwiKsXjssMzSxkuZPPhKKFwMrk9zeC0vnydXgJo7JicX+S
         9I8Dh5z2rqisrOTBhH1kdW1kME/6oAhoz2C1Al8ALALp2woIXHKOg4HCcyeoLQTrUF/l
         5Fi0iVCBmqwiL11I6563DFyVycM3WclD3s5FbfGCmnWnGyb/f+ShncukMTc00RONj54G
         5mMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785509433; x=1786114233;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xjUwzJpM/uCXdKN+lxxHNcyxZbz8UwKPVfqyFwxUIiM=;
        b=mgAZwytwdmQ45zzJ4O5EgrZrwXfweVBtRJ7ovYIlbpE1lGLPGsCsXtErr5WLTG3ppq
         sqT0gtfMMS99DOg1/v0SXD8UdimWc15doUEkFkzORh87MwK+cXIT428ExC6JaSO2+MCY
         /RL/bh2pJE0H9kOLnDT2NDhExRcv8SH7rbzkiflkSyH1+bWw+QSK23yokPvNy6yjuS6t
         wx0wPCho7EavWWriHT+3n1QVfA7Yhl//lQVJCFrNy65DJfDSONw3biHmyQ9tNIn96gax
         Y9F8ttbvLpGf6aUVfYIVkk2oqYNhePazW891Bsk3/Rs79ufcAUKSrS2W01WX/GXtyzNN
         ASvw==
X-Gm-Message-State: AOJu0Ywh3eMpSWde/XoJuPEFqa+t2LbHUhFXPi5Hnbo7ZjIlD+fXrKQy
	I5Dio5stTx4cn5froOLMtJkgNtfXH90wHX9i0d1hS6xakzG95YdJYBhZPU+x/A==
X-Gm-Gg: AR+sD11TpZZg0dX0ImHXS8fayLLDKnO7bEm+aHiLvlNxyCXNdaZaWytVlOizS5BPYQR
	pTHysE8qH4jcS+ju4ilCEzs3Uhlt/ax6cgZ33iXV5VnSvEnLEIZ2KiQax1KFr3VX4hTppyb8JFP
	39Uzut2NsoKZVNPurl/VqUm9I653O35V451WYejRloTu+FYTJsRG/UTm63qNEV0ffxsgkbveq7J
	J8yqRanpMWEniKs2sawa5Yzva1eN/EGF0mjihQwnZHNam1MHmiI6cEywsxOFoJ8SIUUdVLoxZ+g
	5zt1e7f48QCtifcVnGawOYyDk1Xc6u/1cKh5iRv9F35fdciG4u1Fsznz3TI1LDtB7ZE27VCbZne
	qH/ScLItbIS9BFCy1qaSqoA6TCZ+T/ZUi/rKACoePtfJj0Hi0JDu3PbL673z8xu8fDHWP0ImYsP
	sjzr4FniDbp3xP4SevF7BGWVatJ/VXGuEQl+GMsiTp7aKiG8hErJTqjm2cp2wkjkBYL0c=
X-Received: by 2002:a05:620a:2802:b0:92e:e8c4:b66c with SMTP id af79cd13be357-934a0759561mr50642385a.9.1785509432727;
        Fri, 31 Jul 2026 07:50:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.87.113])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm70145185a.33.2026.07.31.07.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:50:32 -0700 (PDT)
Message-ID: <6a6cb638.e317185c.3a4f18.f1e9@mx.google.com>
Date: Fri, 31 Jul 2026 07:50:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0469661611534365616=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: [BlueZ,v1] unit/test-rap: Add PTS tests for CS
In-Reply-To: <20260731131352.3154342-1-naga.akella@oss.qualcomm.com>
References: <20260731131352.3154342-1-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0469661611534365616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1138148

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      20.75 seconds
BluezMake                     PASS      566.26 seconds
MakeCheck                     PASS      19.29 seconds
MakeDistcheck                 PASS      154.58 seconds
CheckValgrind                 PASS      222.09 seconds
CheckSmatch                   PASS      297.48 seconds
bluezmakeextell               PASS      95.21 seconds
IncrementalBuild              PASS      562.00 seconds
ScanBuild                     PASS      903.55 seconds



https://github.com/bluez/bluez/pull/2366

---
Regards,
Linux Bluetooth


--===============0469661611534365616==--
