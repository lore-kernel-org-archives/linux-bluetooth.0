Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794931387;
	b=eb+wlXWslvL4jXCnpaQQey0d1NTAwdeehDlLHk3a47x/iNjznlZSBjhawSe2RxU+4bmg
	 F+hZMN+04HEPbd5iXZ2l8lAFHCib/3y19Eeb6AIxqtEdRkMlDKLpx5S1HWaoaz/VfyWwl
	 H87WI72K6mV89hL5NjxLwEkjJGDvAU7OC0nnPsx6cOMb0xD72HqYnrLBu5BkY2rxbJUMy
	 lZNOxADxLKrFbMif8O+8BBdoI+j4elo91wJNIwbvtiiqBE3YsAUWYaX4rihPQa7sboC1q
	 x4bFJHZOrfPmYWZLNjrV09kQ9LUB1zVXkoei2LBtEgpKdKGmCj7Qfx1tatZ/3hfRpJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931387;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=D4uloH17z1ecHM/6wfCzJlseE2hH+6h3/EAZD/WkUow=;
	b=b3cR5qw6m5AHw0gMxy8VIBT22QsUa0Ppyo4jYCkpzGHttbiYJjdbSv9FUXyEMpWFu5fs
	 skg/tXlPZWCa2Qr4Sn7LGCd4z4QyL1hFCua/DJu1PeJkvT3ovEyueSOalwUx47rYJ7uvj
	 8UVhG7o0jzWLS393EXj39oj6n2zxyC86CFWWYEHr2yLjw21Val6z8x13Jnmen9RMjcfNX
	 apwz+3yAmVkV8XN0pk2BmqOa9LFdfhb1GivaNovWuZ51h524AtTI6MncAx2PWYY1gQRX5
	 LTNqOvCnRLpnxn8I/vzFcMFS5rYylEA3ue/iBQx/a+OeTq6vf+vFyMgLumO3aaHNzBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="PWWfA/bZ";
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33B6606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 16:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A33B6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PWWfA/bZ
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb5f0c5348so6775e9.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 08:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794931385; x=1795536185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D4uloH17z1ecHM/6wfCzJlseE2hH+6h3/EAZD/WkUow=;
        b=PWWfA/bZ7xHv/ALXaYXZetkra9KobmgzC2A1LKdOuvN+FPfh3RA9KNiw8eIqPrJfuL
         B59WwFAu5AMH+3Y4OOj3P7ptcgGHGOWoRpojwGHl/10R0wfUdIsvnKEQJjqyDRmCcYU/
         8jfcSNzgCAoSrRlq30cK+wHr8iHTaQ3h1aESCkEvt7ojoSlf7Vo2Zpz22Hkh6xNyzZfD
         P2iEij7NAOJZqTBgGM9ZpfDV1mZQSDKoTiyUhWIiJoQp4x4Wkp/+utjLV6MW9F0tjmiy
         SufRKCzuQbqHxizYFqM+ny20WvRih5dUwU2JwwGa+oMDxFABehFHGgEtJ4DgFB2+EoNf
         lFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794931385; x=1795536185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D4uloH17z1ecHM/6wfCzJlseE2hH+6h3/EAZD/WkUow=;
        b=iZzBjK6xt5F8j0soa2jeVEK3Nl1X7UdcJaLK2Pl+JP5TR+GdKLto9FOnFZnuwWWlOx
         2COzBr5DEDKQ4BSqNjex67ekzDbbif5rW7Jz8OnEOv2ug3dzsDtPkzNzQaZSI62D3Yp+
         P228PQnXxGbgiqS/JzMe5N7Rlgz+e6TbYb0xTrtWH6CZMbFx9kknqbdHTEOdLhC8CL7d
         jnuI/mx/ZFBRgMOkWzkvRmCAva7boDFlbBNgLTAb/+ExQl+0+PIOS2lerieaLTFxAAyL
         kIoKJcK8j8DdZRiWMxE/QA31oqo10Rw0eD7AUlDLX+smeTf7Vn/SicexOt7E5x05+BJ/
         aASA==
X-Gm-Message-State: APuU4Z+DFkPtLMyKtRVAi2Ehg+V7VqOD2kthtFbSXPNEhtfB0Xn5czn8
	Ak/YA2O1VqV4O6YoGRpqhk5zOA9RwV+1qEVM+qU+KD7vr00cTws/DgFnWvF2XA==
X-Gm-Gg: AYBFou15WfYrAZt1lmI++a7gqxVgIKLSBDpCsbwYesddrqUFtJkqzsI/h6kz/elpr/0
	AQG96CPlFiw3YhW6dP113NVwXDsIJvQxFSrwMcWzbEMiJOgs9uXCsoo5BSOMLKkOvA1tUyrCS/L
	b8KFQ1jjSqGlobHHCU3WqtVIpQTWLcjb5N3OCqVWfuL1MOMl1VEA3pcuJi9zIhBZP5A0rquSt9c
	9rVCIOVDQZvv6cydhwjWaAE7XXuIxgKhedBSQqPDBghZzKESnOWbpRnUqceFAT0BWKhFWM1br7l
	R4fjX+RH1JRuBjWeYwbXK6oD4SLNYNK2QrqsQqRssD77WpkbZaOnx2aodA2rH0WBdqQumDa8W39
	YRrbYEOiGuOtGv64rlq+3td1OXHnpPHJaIKsGTJ6EUoe1xvNBYR/Hmv+A9YC+Ow3aJnceJQFvLv
	3OiNsSNWIGaciKeWnRToX0wGgdkte7cOY59yDTc5MTgRpmwCq2osXdqC4DYTOzV7+5QOUBTL9Sg
	pKyq8SmhfqJgxVQz9Of5cU+I2LH4YXUJSVQeu4AFz0cKnIXSOFO2HAqa0H+th/znbY5Z0kB/xJZ
	iWmq8m22gXXmdznjx6Dg7oykXYaehlXeQ+IkJVVGUhRPRHoYVw==
X-Received: by 2002:a05:600c:868a:b0:4bb:7ad9:2f22 with SMTP id 5b1f17b1804b1-4bb7ad9386fmr20525035e9.0.1794931384596;
        Tue, 17 Nov 2026 08:03:04 -0800 (PST)
Received: from schinder.fritz.box ([2001:9e8:b3a2:d500:342a:4be9:726f:4a50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7839c5c3sm75158285e9.12.2026.11.17.08.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 08:02:55 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ 0/4] monitor: Decode Periodic Advertising with Responses
Date: Tue, 17 Nov 2026 17:02:36 +0100
Message-ID: <20261117160240.222556-1-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series teaches btmon the HCI commands and events of Periodic
Advertising with Responses (PAwR, Bluetooth 5.4). Until now they were
only listed by name in the opcode table and the events were printed as
unknown.

It is meant as the first step towards supporting the PAwR advertiser
role in the kernel and in BlueZ, which is what an access point of the
Electronic Shelf Label profile needs: being able to read the traces
comes before changing anything else.

Patch 1 is a fix for an existing decoder found on the way: the
Connection_Handle returned by the Periodic Advertising Sync Transfer
commands and by LE Remove ISO Data Path was read as one octet.

Patch 2 splits the LE Periodic Advertising Report decoding into
helpers without changing its output, so that patch 4 can share it.

Patch 3 decodes the five commands and patch 4 the six events,
including the [v2] variants of existing events.

Testing: I have no controller with PAwR support at hand yet. The
commands were sent with hcitool to a controller which rejects them, so
that btmon decodes what the host sent, and the events and the
successful command responses were decoded from hand-made btsnoop
traces. The output of the existing LE Periodic Advertising Report
decoder was compared before and after patch 2.

Roland Schober (4):
  monitor: Fix handle decoding of status_handle_rsp
  monitor: Split LE PA Report decoding into helpers
  monitor: Add PAwR HCI commands decoding
  monitor: Add PAwR HCI events decoding

 monitor/analyze.c |   1 +
 monitor/bt.h      | 174 +++++++++++++++++
 monitor/packet.c  | 487 ++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 626 insertions(+), 36 deletions(-)

-- 
2.47.3

