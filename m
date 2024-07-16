Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D976E4687
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721159467; cv=none; b=TCNq8FT1dWM8Q8gZEalkKOZ/NvK33A3WDF0epMqhf7Ym2VDwK0/jN2nFIiiuTIEQFLnsPpUO7Kxmk7vVYeuDUbCCtONzQXgKO5cc6k50zYORKKf93SnQdag2iIEcsLdByopGvVg1qk1G+papIaRANQvDKgmb59LIhBV5LNoo9a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721159467; c=relaxed/simple;
	bh=Lc6uRSh6SDw2RAu/6+n3aHR4vfWaWDaqT3vSoxJmEK4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RLUV5ngqv6wsdbsyRWa7WKmDeb/KA96/EOKTd6VoHM6EixblcwvAG9t1C6c9jXj77gV433WysRoX2YNTweXhnGEuwOYpyIsWnzSL4kRbKMh092B6ctEhOtyN8f8oj4CENh3zKCo6PmyVjyjCTaAXL0UQEG/u4QGczXvUzX20Q8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmJwGD2o; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmJwGD2o"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-65fe1239f12so26486667b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 12:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721159465; x=1721764265; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h3E12kjherb9OLso6afT1vmlmu+HTxUtnmV6VLwOKoA=;
        b=nmJwGD2orYxmedKJ9AV604viRqnM4fuJ5YPqaFRNSSntw6a94S4f/CklW2iR3ke3SB
         o2gWY1dGiT/F7inTn9nYoh39CTIzx8wRsUrNZPilNiZStrKGIcGn6Ph7wpYXrclE0UmG
         WAgOqsnMySI1/UEr04XZnzsB6IGx3NEpsyye2b9LvAfJV5TNbigwxVxG9rb+hrTTpGSl
         i0X/psy9iGfBZ8RXtpj2q/HxMX2mCDdf3eJRrL3hLZvfukaVyvWDUb+m1UXhiFF3MmrH
         5mb7EqBJK+rwJ+oXmotQNSdQWTe5qvjLYvJyUlcs47DfD1NJiigHPUWJFWZx4rZ+5kg4
         B/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721159465; x=1721764265;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h3E12kjherb9OLso6afT1vmlmu+HTxUtnmV6VLwOKoA=;
        b=G+Zj+Zr8PED1EcLxwx/w4ZkPHbKD/r1b7fd195gjti2mO2rLxnmecZB835xVssh9SL
         zr8XiR9IB8MrD7Kl3i/49XxI2ou32wkO9c4wncAPlM+bZDckgHFvj2Q736VyGxZ5K19D
         5L+ItkXeLBhsg2w52olsOA7/k9mEaIHPdp0Hvcv5xrXS0TUsQuEeS8snRfoqjwVE0GDF
         AqxdEb5i8Gy24qMa8Qwm4FX0wRAj+tNLQ81xk36wqsurslJYe02E36F0CAJW1mGbK0tS
         S+upzq+PFxr8rdzPLaDgFnrMWLoK8Fj0KHqsc0Yz9BdArVt2Q15E6wLSA8+sLzgJDTsT
         jYCQ==
X-Gm-Message-State: AOJu0YzcRAedskLylDlnZElUEjRRLz3n08KCZqXCCTI3H8cOoJYItHiy
	qdprmSoO+jLFhi67CSZ+9OZQn6sv/16irLHsAauBIjoWgbIi4GJtmgP0Ng==
X-Google-Smtp-Source: AGHT+IEorZbyBU3HfMB7s5TTtO1K5uijWHd7ziIDsiemAUi6lAxthPgqAYK1JmforEfYhlAq3sFG2Q==
X-Received: by 2002:a05:6902:2612:b0:e03:aa52:d804 with SMTP id 3f1490d57ef6-e05d5dff897mr4239329276.29.1721159464619;
        Tue, 16 Jul 2024 12:51:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.55.66])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7619a7218sm34151646d6.73.2024.07.16.12.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 12:51:04 -0700 (PDT)
Message-ID: <6696cf28.050a0220.267b2.f50c@mx.google.com>
Date: Tue, 16 Jul 2024 12:51:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8735163501478303359=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Initial implementation of BAP Broadcast Assistant
In-Reply-To: <20240716142207.4298-2-iulia.tanasescu@nxp.com>
References: <20240716142207.4298-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8735163501478303359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=871698

---Test result---

Test Summary:
CheckPatch                    PASS      5.26 seconds
GitLint                       PASS      4.31 seconds
BuildEll                      PASS      24.50 seconds
BluezMake                     PASS      1613.31 seconds
MakeCheck                     PASS      13.73 seconds
MakeDistcheck                 PASS      177.55 seconds
CheckValgrind                 PASS      251.52 seconds
CheckSmatch                   WARNING   355.39 seconds
bluezmakeextell               PASS      120.08 seconds
IncrementalBuild              PASS      15176.95 seconds
ScanBuild                     PASS      997.92 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============8735163501478303359==--
