Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792683501;
	b=xphqYxDs+HBOPdSTc56oT/WaCpHcVyWc+vVX0Fqi6F1mmAtiNYpdgW9UqN5ixBgueIxn
	 ozjgwo9lfWl6V4c2R+5jZN1g+mLnzW2qoBhK6uWAfEAC8GRcD5ALuY5pHTy+SL7lPRcQ7
	 56LQUf4jdKpdbLPIEqYqDIk//sMbGPWmKhoBstNSVpc0rRkX1NyrSUerSAOxj7JC0niqg
	 0OdBy/TsSmjE8AoRZYEorNPtoS0sqIleiW731FCuv11JvMjWSFCB34Y1XkD9MHXz7Z1U5
	 nCOsBpt+3IE7M4Trqeyd5MikwZVXPfRVTwc7X0yUmECKvqfzYD9xNlXwwYrhMXMhtfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683501;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=am6bUwTFl5dI3z4kAL5lsdvsU6q8fwpiKH4lHfohTvE=;
	b=jmDgth8Ilv+N3rpd0gw+UUVK8VQnMT9ycotl/zc6I0XUyYl4NSI2FCiimlins51buhF1
	 ZCE8PoYUcT48/OUGTgHxdlUUQqFTuMlgHoVjSOTJQDjItrK3DkNbP7XNgbx5fIbRHzrFj
	 WU1AoLaTwZtRuk1yz5YoyYNlIEphzQK9DF36yW/xRheFVxOe5oMx5W/HMWnNvDM6zwkON
	 TDJVutwlDOJfzJgKGA/Fh/ikGPe+eYqolBxiEfUlRiFyao58qSoA8HY+o4F9/vlbLaVC4
	 6m7Ar2h6COSOcWLAxKtChbB7n/Er19z26eXttfL7qvgtXv6sj50fOvFXC3JBsCR/mQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DFp0A6Jj;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49C3606A319
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B49C3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DFp0A6Jj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792683499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=am6bUwTFl5dI3z4kAL5lsdvsU6q8fwpiKH4lHfohTvE=;
	b=DFp0A6JjdIkQ3IWRa1S2FH5xWi7Z8H4eIQ3Wqo7TQNJcyfkOyo7HGNo/SZnqlp0hiZghcN
	EN4UxnxyeDnqmKeTN3MywIgJlQh5GrlalFfQJhVz+RYNSPvGNa+GUBaHBvtg/MAPX+OC2u
	9Ra4s5ZXTQePEI0/SiMSy7OeG+OAzZY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-0alGndIDPyqanwoj-xusvA-1; Thu,
 22 Oct 2026 11:38:15 -0400
X-MC-Unique: 0alGndIDPyqanwoj-xusvA-1
X-Mimecast-MFC-AGG-ID: 0alGndIDPyqanwoj-xusvA_1792683494
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E517F1955DAC;
	Thu, 22 Oct 2026 15:38:13 +0000 (UTC)
Received: from pabeni-thinkpadp1gen8.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 90FAC472;
	Thu, 22 Oct 2026 15:38:12 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next] Bluetooth: btusb: disable by default Qualcomm multi-subsystem
Date: Thu, 22 Oct 2026 17:38:06 +0200
Message-ID: <50f92fe870de717fca6368e750e0a6cbc8f46597.1792683340.git.pabeni@redhat.com>
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
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

New knobs should default to 'n'. The mentioned one depends on
BT_HCIBTUSB, but the latter is enabled on most systems.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
this is a last minute fixlet to avoid breaking expectation for the
upcoming net-next PR. I'll merge it in a matter of minutes unless
someone scream very loudly very soon!
---
 drivers/bluetooth/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index db0189ca3cbe..0dca5e43edc5 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -96,13 +96,12 @@ config BT_HCIBTUSB_QCOM
 	select FW_LOADER
 	select GPIOLIB
 	select WANT_DEV_COREDUMP
-	default y
+	default n
 	help
 	  Enables various required support, such as configuration, firmware
 	  download, and error recovery, for Qualcomm Bluetooth controllers.
 
 	  Say Y here to compile support for Qualcomm protocol.
-	  If unsure, say Y.
 
 config BT_HCIBTSDIO
 	tristate "HCI SDIO driver"
-- 
2.56.0

