Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443793;
	b=KR1z+k5aDfdBmeu484+PkYOT+5+L7CqfOuI65N6IJ69QTk55VDLw6KSEjjaRiORbjnqr
	 O/nZsFxvrbE5lid09pdlFnL6Ccl3NE2EUi/A9tGIM2fwpcfWjIOS+yHb7AI05Ndlaq0s9
	 PKkro5yfT7o529cFwmRf7cPGuRND/AW3ZjSYyvF3c4+89B7vXHZhpaGg2i+LWKzCJWlEI
	 oNfMn5c6IspMSJQh1ceUoaNsL5Qob8V6XogPu0Ny0WJbfjK2qINHpAOV4DAISvi3yp+qN
	 w413M7PV20bmdVcTmTcOnTPUR2TpOSdguXEzclA+r9zq9OF+9XX5TquGwyLg4bN8YKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443793;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=NwrmsKmQVaNRtOG1vdnHvP46wcakSuPoc+S7eIJMquA=;
	b=D/TyWfeLgN2E1DLDxF5BCOvhVF2bsonIMog9tNGvWmIbj9x0tKGUS8ogj4HZA+4W5dZv
	 bO+Cni/2O4bg/J8Wxf7UGBvDE7x4nEIk6Sw5eL+j/ck89yGjDBApgQNM89icGh1LngVKm
	 zcbEx1lLo1dtccbZjov65fMApAqsmYq9U3sw/ieiUQmls9bc90clGk1W5rcpSUNYcawkR
	 hiOr0wdfxol8zqjxl5VWhfNygCrt7vgT76BZsMOMU1uM3iXrOLgen/qVYoqUIE2f9kyDI
	 9Zc6EW1aKtTQTKbznNEZxYaMfxzBPDeyKPT6E70mEaZQDcd6l/eIpZxzrwzLXQ4qnTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QQehHLt3;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245D4606A886
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 00:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 245D4606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QQehHLt3
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2eddafe648aso6306095ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794443792; x=1795048592; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NwrmsKmQVaNRtOG1vdnHvP46wcakSuPoc+S7eIJMquA=;
        b=QQehHLt3UWYXpzmpWGebGyVxwWBFFpB3gFVD8kX+km/gcy6nw4oZd4Pi39egnsuJhc
         Ss/9qIuxMbbNgK6CJ7Jc7fWt2uEhhrJRPJ/NCRqhfNV+0a59PdebjSHM6HPUBt2Skn2n
         FdUfFRWI3E3gV+MiDuyUXe9MVZ/4E6+lccHeoTDELSC2XxMUJyWQO6kPHddQC5O3EUYh
         ogGPe3DXI+cY2FTVOtDwxig3hVUa0FMcnUfSZi2FuJU1t6EhuCHdnfN+YGl52zW3CPLd
         pNFfTc6a1gHk3P9xz6JQlrbwkyuI5/emRxjHLF87xOSGFUJcTW/J9n+EhvhiV3a+1tep
         qSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794443792; x=1795048592;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NwrmsKmQVaNRtOG1vdnHvP46wcakSuPoc+S7eIJMquA=;
        b=mu/z9rurC+Uo4Wo/NVtIPOyZWjfTxUzesC941UeQM4VsrCVyY95SsRVzDCHSsVM6nl
         UwAtMYKaWp/b7vGChQ1LKwTeSnM0OHxCXZJwxy0AJ6AKLPqfFHSfdMKrILU/D0Xq11kU
         cQOKC8gsREKH45Gi/WCqqtCjXR+ru4PVI/P5dsWFkeGiVgzYy9uiBTy3xNa9scpUVGcZ
         dyzBo28EPern3H12HB9HS4t0yfbFIEOMBCUlXDnFIZWfxUpZQNZ7nGsYAYFzLwCdMM6x
         V98EwFDplJYdas2IWvW3KUOAMa60DrV9Z5NPlVFR6lCO1twxXIIHTAqA9eN6c5wleH0N
         ZJ0w==
X-Gm-Message-State: APuU4Z+hcWrHSMfM99/o8FXFOvtEQa7m5cbP+T5opx3R2U3vUn5LfBqM
	/INWDX2dpgWOGdzhPapl7GiotTFBGkX1/TNhSuweLu2moW+L5hhwtjIKITd2K90n
X-Gm-Gg: AYBFou1gqgNQqDmVzkDTK9ozYiLp/1LIQtdnRPObbfDME3gsG8NteMSPSHT/pQQNMg9
	8A0PIzHKcG/SULDUhcW1WVjBb70zFCrsoPQ74vUeC5vQ5Bg0tsCQJeOXMtlp6x2lU2nwYgU26x2
	Ub+iVZgm7t0FYygzyQyWqzABrKtJ8HNXN2SNThLtK6NEmJNYlpTDoO0DhsGSepPlTHbo1gZqWf5
	eBwnNmWajnwkZPtoSK1uCpPhL+9WzoBqokVh2JRpC6nrmu0OIgljrvvqf/jMvk78+9f1JL8cVUP
	6ecpqkGeVwJ38E80LnK08Ofo6qDH6jZ9K2YY8wAykqMmVmA4C6K/DIuzljkwcVISeFwokzO8o+6
	7juDG43GRbkNwZdj1AGh1dMTXi7HYGpJEx8SuBgjzNjhuj8dnnbTq0dE58QNEtO32w6NWeAcXGZ
	Cy+UdunJCGujGobTk8kAlEqt/3kYCf/ZQATubL8bP+fHWLmOun7aMYk5fhWiDzkK8fEBwcEYtte
	wY+KkCCdTfgshmd1BRDFxPN6P9hkRj9Jj/CFa1m2q67XMopAm7cKR1C7AxaNgc=
X-Received: by 2002:a17:903:32c5:b0:2d9:599e:df95 with SMTP id d9443c01a7336-2edd73d7fadmr43692105ad.3.1794443792333;
        Wed, 11 Nov 2026 16:36:32 -0800 (PST)
Received: from [172.17.0.2] ([20.64.175.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6e0e50fsm25841975ad.73.2026.11.11.16.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 16:36:31 -0800 (PST)
Message-ID: <6af50a0f.3a86f7e0.209f67.6823@mx.google.com>
Date: Wed, 11 Nov 2026 16:36:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9154962047499308861=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yaroslav.voytovych@gmail.com
Subject: RE: [BlueZ] tools/sco-tester: Add SCO reconnect tests
In-Reply-To: <20261027165059.2402360-1-yaroslav.voytovych@gmail.com>
References: <20261027165059.2402360-1-yaroslav.voytovych@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9154962047499308861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ] tools/sco-tester: Add SCO reconnect tests
   Pull Request: https://github.com/bluez/bluez/pull/2724
   Created:      2026-10-27 19:32:25+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============9154962047499308861==--
