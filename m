Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7F65616A7
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 23:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932689; cv=none; b=CM9CS6FTWhQRLTG6ZR1CJ+yUw7mfABU2fpy5dVfu4v14OQ9pWJDxDO2cQRbJt72/I1piSPUt9n2/LxaC9atOhahalk41JRhOECSLRqezA7mPC0z7EZMybK6gagGiJaqFRm8DIs6YZlPXL1xNoS66qmnKTpK3srP7wjyaFSNF5GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932689; c=relaxed/simple;
	bh=7rpVwcthdN9+SKPC54GTc9o2+EO9BTo+lhmSvYLmGzw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oBVbaRAmczaZ1/tDTEmjwMG6hbUHKQGw2YjpPu69tPTqcedpkkCQS7+hA0GGjIlfOfEuOMTBWW/dT23ENYO4nIRbxeB3prkRvGjXujzFVvesjcZ7/wkyQswozizvDQrWSM3aMDYrFzF+hSBvJB1+IBMwcdw4UJoWGH97wLjhmiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpUl4RUd; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpUl4RUd"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93e64d52949so326801185a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 16:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791932685; x=1792537485; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eRO8n6G1hzKNYNAYmWfNLMKcsL+NZ/RHb8ZcVZ1Z7pY=;
        b=IpUl4RUdiHhw0PlsKnzUAf6l5Ibd9X9/ZGFllEEG7OLnKoE5VsCB3E0x+bLUWByT7F
         CW5hPEjL274iDX07taJVMOjlKdlDphD+7RWnMJKYmsIT9HqqA//NJAhvDXLCXZnyGmaN
         N7EDQxyk2U6vZAhD4Oh1El9jA2QdngFqYLKgcMKZJKUmnEECQIXq2LgCgwxLSP6TsrsX
         HZX8eVdKr+lwRmIx+qkHj6ykbnm247FvlXfSCdPAhnppHOIWam822QCzLc+kDRXIN06c
         Dm8bQ66xcu2IH31HnWNtCcdsVqVHZysWKUEf24ksBdjUotExHkJz+7v0vBIuXL7Rgl7S
         tUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791932685; x=1792537485;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eRO8n6G1hzKNYNAYmWfNLMKcsL+NZ/RHb8ZcVZ1Z7pY=;
        b=WlfuHQqwvjEK+kyXu1p9yvq0ZMvXCgygcx7eUdd9MsDcMKkAL9PLPxEV0F5xn8D1BV
         Keb83NXi6YixgBNpnRB2Zv2MAWQZZZnF3AAPtrMDRUhkngFfUKeRugJGUf3b4wBTztJz
         GJ9+q8QOrAZQK+totUVcEgDrQ0is0T45K3QxUNk5hxJ/jIsfHiF7lQ5FEhnh5xwSnOHc
         fip+SszRjWvGF4G9se3EtTnPjLctbkDcdxzLiRojyicuZnZTJdCl7k5/QWS0+Q7NFZHZ
         SBXqVC/pkURPLKN1wsAbTWJn9EYRhPYKFm00t9iK17b7GJHv52zIqPbbE71V4mauNcUC
         HbZw==
X-Gm-Message-State: AFq9FYKWJVebFi6YEAQtmnz5tV5nkF2RSwRXeN6hDR4Xa9pH45cm4oPG
	C/XDVwo6UyZLoqcTUVgpAFUsBdICKzMpcihReMqbhDs70Ul0yoysBa+YKho8BgkK
X-Gm-Gg: AYBFou3HQXkCziIzsY+T/P1k9TjYUYevBQf8aVL1/E2wsBJvZGwbMIoaFw5HGa2h6SW
	YjQj3xPBxl9M2q9fT6fPwPLcAMbYVn24YXTHLjZEVRPOwsfa1Eg7PEFEJq3RyhGEhXc8fHMBIbT
	UJ3+xvLqRd7Xgvz/8x4VX3buL1ArpIQZSfqLM69W6Pr+v7pIZAYAxeLQROak/VHkSO0/i6K9UCh
	aBBtEYkbFftRKOV8/zwN14nsrG8ExD5NhnvyjHpn31YatV/x0m8VHBdyv2X1S1x75A/IlfuDtDJ
	DEIrnCuXvnh+dmvERqSALXnvbsQ56cq5mhFBd3h0ntzKUo/nGxfFNFg9W25wlrTstncPXuwkQMB
	xBzFH3vP4hFxMcr6lxGf/KYMt9Q54LsWT2nk7+Lon2oqy96srrc/Oa+VDdWwBVB/gFZXGwcGHTy
	TXmXKc/NCWtYQijbSZ2X0FPH1441Jm2N97a/UrRMKF5zKxVbHl8Q0mXDC1dVFo8VfeHZFNEL/f/
	C0Xgkk=
X-Received: by 2002:a05:620a:2992:b0:93e:5fbf:a41c with SMTP id af79cd13be357-93ebd228f54mr2104679785a.16.1791932685275;
        Tue, 13 Oct 2026 16:04:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.163.133.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5090050sm349940585a.40.2026.10.13.16.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 16:04:43 -0700 (PDT)
Message-ID: <6aceb90b.d72ae9ea.21c6a.0444@mx.google.com>
Date: Tue, 13 Oct 2026 16:04:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6924485759315701797=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Add HoG functional tests and shared/hog
In-Reply-To: <20260928200031.1209311-2-luiz.dentz@gmail.com>
References: <20260928200031.1209311-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6924485759315701797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       Add HoG functional tests and shared/hog
   Pull Request: https://github.com/bluez/bluez/pull/2600
   Created:      2026-09-28 21:31:18+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============6924485759315701797==--
