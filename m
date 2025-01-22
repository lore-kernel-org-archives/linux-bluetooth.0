Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805182101AD
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737545586; cv=none; b=U6m+hdD/eA7SX4SMtrcyuOapteTfT03NAtzF5GDewcxDFBVarYy7f1mP7gW7s7lzx9tjmoIwsFSZMIRajB7rwt6DuE8X5nezTzoYLvP8E38czlYygjo4cLGJwiqXo25BzC1hgkXBf5VX/V0zJvxW+EPEFvZjydVTo5sGYCOx9Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737545586; c=relaxed/simple;
	bh=UNhTxNSGzQdRT5ni8XSaFyYyCFJJNnnktd/fYEV2E7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M0d8/EwZa+sMeUL4ke+D5Z5J4YrvFSh96asxeEpIdmaKJanlYsSXd2L+tYnp5UYSwxsr8c1D5tkqzCe1TxGmSsCEFbdwW7wr55CXOeULX2omZtpsbQaNZfgrD8/j+LfQ5G8kRL0rsRa8jOhQUY7vSSLLtksu67mUQDxbLQgOrao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id B732C1BF206;
	Wed, 22 Jan 2025 11:32:56 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ v2 0/2] device: Better "Connect" debug
Date: Wed, 22 Jan 2025 12:31:56 +0100
Message-ID: <20250122113256.1107629-1-hadess@hadess.net>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Re-sent with the correct prefix...

Changes since v1:
- Add client-side error decoding

Bastien Nocera (2):
  client: Add client-side error decoding
  device: Better "Connect" debug

 Makefile.tools |  2 ++
 client/error.c | 37 +++++++++++++++++++++++++++++++++++++
 client/error.h | 11 +++++++++++
 client/main.c  |  5 +++--
 src/device.c   | 36 +++++++++++++++++++++++++++++-------
 5 files changed, 82 insertions(+), 9 deletions(-)
 create mode 100644 client/error.c
 create mode 100644 client/error.h

-- 
2.47.1

