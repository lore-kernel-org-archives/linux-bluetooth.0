Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9385825C821
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763369141; cv=none; b=Lqf+DifoouFw+E7/3gBJU1h5d0kdpqBTT18SDotItEwk5P3v/DjTdDG2yerngUutjVAZpZQrNctSBTkS8k7Fo1wbGkPJ4KDoMLymRkbC3Y0zDS+ghgrvixKULL/MYTqhDtoiNoj6Cn+fXiq/aM3nslUcR629blQcviYI9AqxDRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763369141; c=relaxed/simple;
	bh=0ZCYmaHzMGClphUaeBz4rOBGcd+MQZyDIYaxtK6Sd2k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ucYCuGmgh/bLXDu2NcrPpU8CQcSvGx5V1RDPAGpJLI98VR7SZPHl/+GPJU9GH/qEVpui9swkxJmpnkQowZYxRRnHJ52bvu5U/CPgepdwLOe9Wukgi5Sn7Xo28VuTQDfMGE97adXuwLBWeyphB9WJ5h4Od2pW+WxFFBQcOOB7zMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdYIJCC5; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdYIJCC5"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ee13dc0c52so11992341cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 00:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763369138; x=1763973938; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZCYmaHzMGClphUaeBz4rOBGcd+MQZyDIYaxtK6Sd2k=;
        b=ZdYIJCC5+jroIaHwY97WBWT7qqlhFlp4u9n8hIu05SHWDRnbHiW6/hKWmBheUHe8Q+
         VbPMUSSKK8YYIOHlC5Fn0jP7zywduNZ+Sxy8grxNa6JYwfdfy8odAgSqFP4EX73bOmx0
         ny6NgZhZfEzJ+e90a+JfKOEMGBByGJTRpA+/5eTuPAIUrHAc/n2mVsCZePhjn4fwPxXD
         HDuj6rmeg3d6BsKMfCP6vOscDPBX4/x1iTXmsOqANga+iFYEWVVBKbZ8z5Nw2fE8qifu
         vh5I0+VrWlTnbwtNWKDwSzgufS76ny28ktOsw2A8EX68lnqWldGHtlt6RAinOh2iNYiW
         Q9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763369138; x=1763973938;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZCYmaHzMGClphUaeBz4rOBGcd+MQZyDIYaxtK6Sd2k=;
        b=ee9F1kHRnLrJReKfUXLJGUXmS1TGdH+VjKwEVyr94YR18Gw8dfk6+80cn6J6+UlhDi
         zPOYJqIsvHSqIoLf1HmgHuLyqYamIRvVfwqFCHL/+y2/+jfvF7D8P/5Qeq3dPBXyri8i
         e5u4RTW7pEnUkx8TSpuhOnuxtDqGV6v33Qp0fZrweapuNDUXiazDLZ3aUV2WuMBhndlW
         UTMQptkb4n+dBqNmtBkP5yRBOskB77a838lgVdsG2TwMuxR1mpZhxgj7PKlzEBzlbP5U
         Pp6azpdE0fPYyjZWVhR8JTrVLq4//1HKf9+iUqOs8veARlW7HfE7GtlPHycpA70KnYBA
         qK5A==
X-Gm-Message-State: AOJu0YxZ+f2KB4NL/LVpwjd3kwfpOCJUd1cQM08Q/uMxdnp+E23VgzAC
	4eHHg5lQ+Fyhl6JYR2/6fGEIVcOew6TnDGjTpGmzSGnEKEkTeX60LnlBWF9qzw==
X-Gm-Gg: ASbGncscEJyD5NQriEJVpGCyEvFMiQtoHLBmfj0AaBGgnfhTWU+c0d/Blhblt45IPTt
	fg1Z0qtXJxxDNYIhXn0eb2VucrniKj3D3pAs5b7sduJ7Kpzs70R1M7oDryAw54vb7wYorP/8dzA
	GidNrQ0Lq01Yv5Ki5fGTjh4jYchAGYw23P0aSzE3qbNb87+VxicfnGKFIo/y7qIOaRvfvHropp7
	1FxPalYUlfephVE2cdasRYMcPfGUHS1uo5fVw/yKR6W70F4tvztQ4n0aZ9AYUxkF4+y8NX3JGCm
	n+Jvjd8Q/JUMQQfbR/DXvB7zyjxfufyrzJZrf9Obeh9+zwdGiowWLIgrqcsjq9j37ei2lFRuUt1
	nMlGdJx7ffGonuh2JjefsRxygWk3fodmWVWG7eroGaSqk8afNbJjM26DILAhJQiUFb7NzdiPBKq
	Hm+i92iL84288n9WVx1HjLBppO1w==
X-Google-Smtp-Source: AGHT+IE3bGd+yh0RxRAPyz2kDlvXX/EFc2pX4Fp02xVV1wJEi5q30TieAidxxg4jdGb/GF4NbCmwXQ==
X-Received: by 2002:ac8:7d8f:0:b0:4ee:1d3e:6aba with SMTP id d75a77b69052e-4ee1d3e71bfmr38540171cf.74.1763369138098;
        Mon, 17 Nov 2025 00:45:38 -0800 (PST)
Received: from [172.17.0.2] ([68.154.54.34])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede881ac9esm80049231cf.27.2025.11.17.00.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 00:45:37 -0800 (PST)
Message-ID: <691ae0b1.050a0220.7ea54.21a8@mx.google.com>
Date: Mon, 17 Nov 2025 00:45:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0757893309712412155=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] L2CAP: Accept incomplete SDU
In-Reply-To: <20251117083926.332188-1-frederic.danis@collabora.com>
References: <20251117083926.332188-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0757893309712412155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: net/bluetooth/l2cap_core.c: does not exist in index
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0757893309712412155==--
