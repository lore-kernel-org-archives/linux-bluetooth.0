Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4E5419307
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781009327; cv=none; b=cgfZWJ7iLlRlN2sc1rGq/tVDymMAePME566MW1ZUYEildxHmK0rB6MQicvCvVP4hF9PxMzvj8QPOIU4c74fpR+lrtEXyG1Ydpot4/dJnzd36W64tW9JlzTX2dtvmS1NXoF+UhHwYaLJ06i/SQQfzK2UBLwfOA+kwGho6U1aeKTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781009327; c=relaxed/simple;
	bh=xyYznNg/jDKCVoWC4j5S/LzeheFrfICukg/Uhw+fu40=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IPDYqiSCTHFUQEAYltsyTkui7aS3xOeDxa3C6NlQvgKTuCa7dT/6RNFunNmzEF/Dhlk719Py51/wqWkuPLFmAtAEQgYyLQgTlf3mMyy2kRyrC390y3JfVyLetUgqrrqMq6+YNcuWXYlP9CEjEBhtJKsy/2C8sVUO/US+JaXuHi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rIzPAUpF; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIzPAUpF"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8ccda0ac4fcso55882116d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 05:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781009325; x=1781614125; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v6Oi4Oq61TinD1UG6DOpPDYYUrNyHowicHCLHkNi4L8=;
        b=rIzPAUpF0qLSRWO7aNSpZ4UtUCNEQkrcN384iPRkxJTFiQeeyVMNmtEH1HcPXbQVPI
         joxvs2cDD+W10V0uQ6D+BSia42tBjInIn1yYoOr2RM8pkYXKJZ8+NJWL6x/uI/oeiPBw
         dHullbMJED5t+8yu+H14o9xvjy9VeCdSpeOndKviT4NuijucBr36M+mRvMwCRq9qGbdf
         ydKgORzy6u86WamWYcf16pQVzk8AvjLUbf4ppr5v6puZ/+rhnx5F5M0cJNDfumALihMx
         28auD4+2o7PqzmLd0MkBOP5SpjsqvC8+jHq1/Cs0NwKYPctZ/p5niOsBV2DBhbgWvrga
         H/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781009325; x=1781614125;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6Oi4Oq61TinD1UG6DOpPDYYUrNyHowicHCLHkNi4L8=;
        b=VtE8UZmQtcgJ+4SWWUUhaOK2w3pff9ZMTYOpeX6qMqCH4lLq2wTMASVwBhwY0yO99n
         9zUNP4O2KJfWSlpMrpzvP3lW8Zy2/YH8C0icgC0HzLp/hfKBD2bSJwqE5mgvj9U7EWqk
         QX0WZRqRfGiyggGgTQ+7tZb/KVOQZpgvX5DWGk7ZmOSVGXz+xyE5d/zwycuxE0NE6PFj
         0pUjjIqFv64CUZl1YyTKCPe2NVXH9DUEwyqvyytRcRLao4coz55id5wv9kjmYNu3GJ1C
         kcTN3GAdVaMoaRCv9Cm/ub5h/IwPEg/Y5gQoU0XvJS0NZb5vw9ekaR0zuRET49TJS9d2
         yRYQ==
X-Gm-Message-State: AOJu0Yyfq0kMOw+zuS4wc6MHkrusN7YiHvvmNyyim/0SjZi7DwVcayGj
	31GccSP7xj9uAx2UC8Jnb3B2t7omNUit7XMQ1gryI/h7lX/AENQUI/zuqic2Og==
X-Gm-Gg: Acq92OE7Y0qU8Gh6G1Slh8/hCvUewjdxmdTB+tjywbiB2F5rQrkMh6wCYHzfUiD3cC2
	0SZCerA3m+q/rHeZ4Qm9LYN6u2C3VDNseyM9WmP8sebUXj8UKujUHLcsyDqFcETIEZTz2N0bPFO
	OcHAvvlc4wxzMFuRfqHHGXF59XgXWZ7RDdGGxqNvQOgFEQQ9anVBvUMymgKq8c45sKkK7ou8vYe
	hlRNw7mA6T05LWr3bRCQvFoMK2eMhTpOGKXJB13yngtpmjJW0j0wBmzBkoOzUN0ag3PcDuPonxM
	3YDoMVjz9ISLopphY9NXImG5JawZEDRW+FukSxgM6S1M/HgjBlX9EAK3Zapb6z5nXA7pN3LwT2X
	kbx/9LwOIz0jpuT5YXd+fOnISDXSkyRFyymIggj2IknCe7ZY/Qj7+c4etHpLfsaB4/IEHfdoD+h
	+K8wK31yCnxPrX7N195M1YFfiNI4F9ggbqiwW0SDjLPA==
X-Received: by 2002:a05:6214:2aa6:b0:8ce:b2e9:a4be with SMTP id 6a1803df08f44-8cf1cc97a6dmr36593076d6.20.1781009324991;
        Tue, 09 Jun 2026 05:48:44 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.141.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd275dd2sm197998216d6.47.2026.06.09.05.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 05:48:44 -0700 (PDT)
Message-ID: <6a280bac.19be51e9.1c7d2e.8caf@mx.google.com>
Date: Tue, 09 Jun 2026 05:48:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4701285302219417856=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, raghavendra.rao@collabora.com
Subject: RE: shared/bap: add ASE Control Point error responses
In-Reply-To: <20260609102548.6887-2-raghavendra.rao@collabora.com>
References: <20260609102548.6887-2-raghavendra.rao@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4701285302219417856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1108483

---Test result---

Test Summary:
CheckPatch                    PASS      0.98 seconds
GitLint                       PASS      0.65 seconds
BuildEll                      PASS      20.32 seconds
BluezMake                     PASS      611.99 seconds
MakeCheck                     PASS      18.42 seconds
MakeDistcheck                 PASS      236.40 seconds
CheckValgrind                 PASS      275.40 seconds
CheckSmatch                   WARNING   324.66 seconds
bluezmakeextell               PASS      165.73 seconds
IncrementalBuild              PASS      913.48 seconds
ScanBuild                     PASS      925.24 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2199

---
Regards,
Linux Bluetooth


--===============4701285302219417856==--
