Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532D2EC5
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 06:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716446860; cv=none; b=baxzqes9zsZazM4dNQK4v6ofDvCN4ZS1QphZ1IVBR9UkyxWxXRYj81eqrckIductreLaX3HhVqkBkbWNY5nVl4u0MBrItWaw/Xr5txDNmzJNoeEvQIV/bggQbhE7FQfIMHC8qMPwrRQFO6qlC8g70aJdms2TObuqPR+pbzup/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716446860; c=relaxed/simple;
	bh=UQWqc1Klr6h7jVTl0nun0UfUHaes9v4JWDXYXkpJqk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jY5RxKBPqLP0/Q94oe/g9MCNFN/jXQt/Os3R3x9DfyFdpE/GuN7uu30CkZNqN7JWUXi2Sc+nKRMP3IvycLUXkU0YR3qDtsHzWwoPr8NwyjBVIgbUdSY/zyXloJndEKovnaBxp4S1XX9U06tRxETO2bYi1nyMLDplvtrKmRWKARM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=HZYcJO3H; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HZYcJO3H"
Received: from 0xff07.. (unknown [10.102.136.211])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3F9683F3BD;
	Thu, 23 May 2024 06:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716446856;
	bh=2TOdKWJbhB8342cTih0zby2alMuJaJVHr29/3xXnmzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=HZYcJO3HRsD+RDoWOif6QUm7LzjJHnQXZ3fPHMzpoYbSu6ZkHsAMd6G74+zFFnxyW
	 X9mApuoWE936vXSlKnQhVrKVhA8Jbg04jbJ3QlSp96bMcl7nLDs6uvXhQpAg/T3w5h
	 n/4UvaIZq/hdNAtuCIHPZ9+46Jri3hiwK1BBrZUd8zFyOOkkY1xcQdyHzVcD83U3+b
	 ji7N9O9C7wuqDm9RYuQHoPpZgCo1W0nWJcvESPvH/0F5lUwvglRMnwoTb5BTIIQQl0
	 rjdoMQhur2WwLt9Eg+IbwVCKRL+DgnLhuoHO/bknKVWie5FEXgJaavaLRV+axUsive
	 ILgAp7K+/SV2Q==
From: "Yo-Jung (Leo) Lin" <leo.lin@canonical.com>
To: luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	kai.heng.feng@canonical.com,
	0xff07@gmail.com,
	Yo-Jung Lin <leo.lin@canonical.com>
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Fix rejecting L2CAP_CONN_PARAM_UPDATE_REQ
Date: Thu, 23 May 2024 14:45:08 +0800
Message-Id: <20240523064508.6293-1-leo.lin@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521143521.1568672-1-luiz.dentz@gmail.com>
References: <20240521143521.1568672-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I tested it using the bluetooth-next, with HEAD at 
a3975db95fcd8e304f1ee4b0be1895038942a8ef. It rejects the connection
parameter update request at least for the case where the min > max,
which is one of the failed conditions for the hci_check_conn_params()

Note that TSPX_iut_invalid_connection_interval_{min, max} in the IXIT
can be used to create faulty connection parameters.

The specific test steps are:

1. Set TSPX_iut_invalid_connection_interval_min to a value larger
   than TSPX_iut_invalid_connection_interval_max, e.g. 0xAB and 0xAA
   respectively.

2. Start the GAP/CONN/CPUP/BV-05-C case on PTS.

3. Enter bluetoothctl. Use "scan on" to find the address of PTS dongle.

4. Meanwhile, PTS will ask for connect request. Connect to it by
   running "connect $PTS_ADDR" in bluetoothctl.

5. At this point the PTS would send the parameter update request with
   faulty parameters set in the IXIT. Kernel will reject this request.

6. PST will then ask to send a disconnect request. Run "disconnect"
   in bluetoothctl. The test case should pass after disconnection.

Tested-by: Yo-Jung (Leo) Lin <leo.lin@canonical.com>
