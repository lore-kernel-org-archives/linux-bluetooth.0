Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1615293B75
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751016734; cv=none; b=LfPCQdJophk7E4R/Btf8IQ31zxB+aoiXA5c4J/CBSc7yXX/SQ9YFYuL1uzDm5isGCqYeYuel7zRpAYg81+YpIKm5oge7O4ypJuY9A1dCUh+TafEz5JgwuDQ/ghLEhdS75bj8/+NazBEiv+yip02NQTp+VAGIEv3pfskbVtIr0CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751016734; c=relaxed/simple;
	bh=QJqUPQl55qDmcg+kZcPbr9lk/ygRD9uCln9KDiZXHSk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pQ8p3Yg3pLg+Ppw2BM0lxk30eBOY+Jc55sdpNoEAd8dCE+I+V/WyXqWLfT+/YX6JZM0MlcOLtKn/7UqnK+WYiOW23CBPCvNGDO7SRJkHhldFPvr/brgVXU/5ug76Zc5H0YBCT+5rMotf9kqwUrWKsB3C6kGiVn0Vr8qGk4JEwFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXmRi12y; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXmRi12y"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748e81d37a7so1322688b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 02:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751016732; x=1751621532; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T0QjKoKHrZINGPkqIXnqAlorU6Qv9FRvYaepSZlk3nM=;
        b=HXmRi12yn16CWbqa0D50hSadazbqTd3kXo6ElANnp6I3v4UtqQMW/hloCo+7+O0Hco
         T0Mcs/gFgaWVrmYLsJ5X90EoLiQIKQ/KcPSrBzeriKcJUyCRhT0+EsUjsb6AfVD64fLn
         GbeqLCvZ5EWh9Ycz7v4vjaGbbWxzFuPO/yc8aeibrNgIVU0gJrOZYPN4wPmcE0RZSgwG
         2/MlEMvxNXF8yFVFwigrjXgpiE3gWvsYkfBfwcSpAXL/nF/08yQhQZI6hhhZksF00c19
         V1xNpyWgRr1mp2WkYP26qvIvinZvJNMCTDl0qzK7wbENfAJllRqQ+S7wKp8/9fwmQElV
         TGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751016732; x=1751621532;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0QjKoKHrZINGPkqIXnqAlorU6Qv9FRvYaepSZlk3nM=;
        b=bUoz2CdgICxQI4ovOqBK8L3E9UAmFIpN+CJ4ZWY1KE3hyZAOP59njpZPzcDqfoAQvI
         wBVpgVN4SPZvfFMyR6AMisIPc5qlKRpJNjvHXlUUcXF27Inu931JTAiHVUjud1nwKlPw
         3UICXbsQUj9gGXZzknKD0c70iaT8706Fp4Tnh+5zoqp3zrvCMCCoWQN+M1xZnSFkq/yC
         eBvQOA1fwQ+CgX8hGaKbyXyUtBO+WATX6HvElsiJZcXB1ZO0dzi/zttVnPGzTd9FlgKw
         JTaD86Pzx+a6Xl5zgpDDFzWm41DH2VfBl2n1U9sxxrd4vHN1WZMd8HoBRy9+foOY+PfQ
         Umeg==
X-Gm-Message-State: AOJu0Yyzkfq1qZLPrE4y6N1mwu1B2WP+GlvWUCkGoj138SaJbEhJnHGJ
	q35TRCGjUULSAbNB0N/alpK/qFT/nnzzgvQkP9Ugi/Du3axTztmvv/hO0MTqag==
X-Gm-Gg: ASbGncu+fEaQJfoD6DH0K/MaWV2NqmjldxyHLpepC+Pz2j5ZrgokH3EeKjU2xE7yWBO
	Evk9Uy4iZHuFydMTSYOl8j1kx4VS7mjF/XoV0jSF+Ny7robyxoKPgdc+/eLPdZT0sUWjDNv/CSj
	ytWL0fTOzIjCBj+HXZRdEaBYd/yZQAaOjwLcc62/X2mFZeMJaLL14Lr77jv39HCZLGlX5a29YQY
	/kJL3ifk4BvB85fpiUArp6ARhrJZJeygBUSUSX6qcSPrqRrCe1vdjjx1u4OuhG9f2hAFQf4RjxW
	h32pIKHH4nvB66ax6ciURoAhN6Zr+7lVHclbgecQXQRQlMZSVNMDknjkcXkKbR44gKSM
X-Google-Smtp-Source: AGHT+IHvxASb4trJgljicEXAUbsgde4gKW2/3ZRcKk4GxNdh3yKIx3+pIcXAOJAHltkKukz+pEP4tA==
X-Received: by 2002:a05:6a20:4327:b0:220:7b2e:5b3f with SMTP id adf61e73a8af0-220a16b18d4mr3773450637.19.1751016731808;
        Fri, 27 Jun 2025 02:32:11 -0700 (PDT)
Received: from [172.17.0.2] ([40.86.178.238])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31beab2sm1218955a12.47.2025.06.27.02.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 02:32:11 -0700 (PDT)
Message-ID: <685e651b.630a0220.1e5dc7.28aa@mx.google.com>
Date: Fri, 27 Jun 2025 02:32:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8696060422081294867=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: [BlueZ,1/9] doc: mesh-api: minor copy&paste fix
In-Reply-To: <20250627075928.19788-1-ceggers@arri.de>
References: <20250627075928.19788-1-ceggers@arri.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8696060422081294867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=976514

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.35 seconds
BuildEll                      PASS      19.97 seconds
BluezMake                     PASS      2655.92 seconds
MakeCheck                     PASS      20.50 seconds
MakeDistcheck                 PASS      198.04 seconds
CheckValgrind                 PASS      274.38 seconds
CheckSmatch                   PASS      303.68 seconds
bluezmakeextell               PASS      127.34 seconds
IncrementalBuild              PENDING   0.37 seconds
ScanBuild                     PASS      909.61 seconds

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


--===============8696060422081294867==--
