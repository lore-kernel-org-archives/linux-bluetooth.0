Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181B71BD9DD
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547309; cv=none; b=S4EzBrBM+NL5A+SfnX7HGYrAgyYoktGgU+mP+zacEfkKeFgWNA9FgeAbZTu3IEHSmcIszeFdmczxJVeGE78yGLhTrN6GHc22A2zRu3capMnDM8aT/EBGmNaD9FkThiVMafZxj4vj/aH/6OS4DqR7qH3WAd1NoM0rXWzms+v9NDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547309; c=relaxed/simple;
	bh=wqYlmQ3vIbwpJIvc42Jl5fDnFb6nIXOby17SkH5rxlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KBq//dsh04Vw9FOYPgJS3ySHQYRe+GB+v15hLYtG2i6A8MxkoPadrbBWQkuos6d2lcNRsQHu32WXqYxTN8gv9JUnsZPZqvyAulkWURzTOd4mW+VPKKNh+SO2AX+4FQZbO/ek3oPB1w594DapCDxg0GHwcnPVmHaxUFSJg9imkaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay4-d.mail.gandi.net (unknown [217.70.183.196])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 02ADDC2E6C
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 11:31:15 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E7AB9E000B;
	Wed, 22 Jan 2025 11:31:07 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v2 0/2] device: Better "Connect" debug
Date: Wed, 22 Jan 2025 12:30:39 +0100
Message-ID: <20250122113103.1106793-1-hadess@hadess.net>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

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

