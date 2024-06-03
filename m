Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF2F132106
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jun 2024 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419944; cv=none; b=dlHd8gRr1+7MpUARUeuGj6ppNN12JguIyNPPtMcgSZ6XGjTuiQS7oviQUPlZa73SQq9B3fudLbPxeYKzPjfRPDmB6P4+klv/E1Z7itid1VN+CZMIXHnbNNjsHLYhAV4yvOjHDisCpgX+DxFxkU2CzmcHayTUzU+wQaxrc4NGbbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419944; c=relaxed/simple;
	bh=oRrXHboVTtYwQqI/Ai7YRBqcC9c8IpY7IdHq4YSRF5I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qnZ2veuMIpv0msDtgEFhXBFrKB0l1/9M8fisVx6P9hqSsRWzoe9I72UIKqG5rG9DDNRpTOruqbqZCwyuS7oxCVrGCiR/FpcNB1he7vJM/KPYgTOiPH64Jj+HRBJQuf8hUtA4AnHKj7FlSPMaijdPDkzTxlaOthFPU3EF2WH9gCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/WIPyor; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/WIPyor"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-792ecce9522so287381085a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Jun 2024 06:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717419942; x=1718024742; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oRrXHboVTtYwQqI/Ai7YRBqcC9c8IpY7IdHq4YSRF5I=;
        b=e/WIPyorJJYa+WExIaYmQiXgNIHBFOaeUWU3CdTCqRfX8Ea+Lak58LnXCpd28NS3sT
         QIpTImRAhEz87xt5QzgDnncHBixRrahDJszL495jh1GO4WesVVDhIPESN3Rqtjt7Eh9V
         AZg/ncHpwzK0RYHOuOpw2CKU2nDcd5xTXyZpfypyHIG4yx388JN7hTcYY7HCYjh0wHNw
         V9CQe1FMiP9T024XUYBJzfN7QEQhfeDv7poAVDNSJWPp+b3el/9Wbijtk0eD1uIYTgbU
         MWyanfKuFyWSbLOWBWDNO1n1Z24UjDQqYgAF+0vEoS+b/5qmrVSOeTG5hPYmbdTlIA+t
         vPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717419942; x=1718024742;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRrXHboVTtYwQqI/Ai7YRBqcC9c8IpY7IdHq4YSRF5I=;
        b=Nop5B7iX6tXNoS61TL9rNO9Ygb66asZmA5pJYyFhJLMyRxdtOSizGxFg7AV7nd0R+l
         shxFspsVD/ZxlFPWuULigBSOr5vvvEfogkXf6v/2DGoR1cJa1j7oNwUiVph4jNCzPJ4+
         A9np2dVXXSO6YR1Nsia0IQXdevk4Ft7ynXpEhvlAxK+cWwqqveGPTVeU/8RtUOFRrlJl
         a1tFsxS0Je7besrO1T+0Z+e0LV9TYUZVFRiym9jsS/OzSzQ73kg8JA++eCrWN+uZttvs
         eYoBfLCCD9elE832Qet3y5MWGL+8oATn1crT+CFVxTSNsOwjr2WGi5DQeSjles5y9jYR
         9rRQ==
X-Gm-Message-State: AOJu0Yy3KY/77Qeq5XMfVsN+TAlEx+JOL8I6O2yFsjWaBJagD0SxiumO
	I/EiwfBKG7GTtuyi5G/XXutyXQEzuCmHiMGGRPHedyzIUo7otv7CFAOFKw==
X-Google-Smtp-Source: AGHT+IFBYUd0bihxm0wGJWjmxsT3J6ZLMxiWWeFk9nXwFR8/rho2qc0exyJtkkYRQbpJIlBmBcQsJQ==
X-Received: by 2002:a05:620a:12f4:b0:792:cd65:7311 with SMTP id af79cd13be357-794f5ed41fbmr897877685a.66.1717419941458;
        Mon, 03 Jun 2024 06:05:41 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.82.224])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f3172da2sm279896185a.123.2024.06.03.06.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 06:05:41 -0700 (PDT)
Message-ID: <665dbfa5.050a0220.dcdbe.be0d@mx.google.com>
Date: Mon, 03 Jun 2024 06:05:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4334935119680859976=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_janathot@quicinc.com
Subject: RE: PENDING: Bluetooth: Increase settling time for baudrate change VSC
In-Reply-To: <20240603125357.3035-1-quic_janathot@quicinc.com>
References: <20240603125357.3035-1-quic_janathot@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4334935119680859976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btqca.c:600
error: drivers/bluetooth/btqca.c: patch does not apply
error: patch failed: drivers/bluetooth/hci_qca.c:1904
error: drivers/bluetooth/hci_qca.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4334935119680859976==--
