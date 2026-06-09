Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084C93F4DCE
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000778; cv=none; b=q4TWN/2R+DBPeVltTftYPZ89PbdfiRWDUxOmC0szI2CdmCvM6zaH20akbenRp5V9qeIFh4r8n8m7HLCqVX0gc0Wsr133UQVILXn7iEBoI5IxRuM0k+qYG5+1OIvs+HejlNWcpM8eTAbYi4RpL7v65F5GzpXFvlq1izPqMuhql90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000778; c=relaxed/simple;
	bh=imOK3RHteOkVhvGc+nPq00sHP8Vj6E9XG24DLqXgMFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hM2G30nox1bs4+wcA+rJ/wRCq1SuL/YhH5Q1MUzO+lZYVtAAKYpDFyBuXRKHGL3lK29FKG31J9jC+WqQe0+tab39HfmldVhRtIxUS1cmuGXnP0ieTOvbn1Ictlt1tTJ9RU3G7qmA9MrkDzK7FkNyUpBe5Ms+phmO7W+OSTpsHs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QP4CX+lq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QP4CX+lq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1781000768;
	bh=imOK3RHteOkVhvGc+nPq00sHP8Vj6E9XG24DLqXgMFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QP4CX+lq/NQfy92ssZV6UsXOBp8Bvoc/xKKIZGj68/kW3pJxiysrjUVc/AsACrUWP
	 0jECurli1kdEGcVM4Qb2iQCDE6YAdwxHLckobUAku3lgYzK7oztOKTBXPBOQFax/1s
	 zgwgHkYt4ziEDxaXfg1UGdsRJ2qTTKOEwiQ1QAPPucRde76X8nByz0QN5KdEZZAuH4
	 rcz7of2sW9uQ5DMm6vyONkDc548ZdegSvVZRBmsv1yp3NUwDErLRu3iHJGNrOR2+Bo
	 4lSdalfJ2+wHkDDfPyjNaiM+BBaPJ9doQe9uApUnB4U0BMUh9JMDrlXe3JYCNS0buJ
	 BtXLJ4nR2Vbkw==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C004117E03C6;
	Tue,  9 Jun 2026 12:26:07 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghu447 <raghavendra.rao@collabora.com>
Subject: [BlueZ PATCH v3 0/2] shared/bap: add ASE Control Point error responses
Date: Tue,  9 Jun 2026 15:55:46 +0530
Message-ID: <20260609102548.6887-1-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABBYNZKQuFeXvtEE3d3nOUbkKZTAFsfB=1=NDFp48CFEg2e-=Q@mail.gmail.com>
References: <CABBYNZKQuFeXvtEE3d3nOUbkKZTAFsfB=1=NDFp48CFEg2e-=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added bap unit tests in a seperate patch.
These changes are required to Pass BAP/USR/SPE/BI-01[5]-C tests.

raghu447 (2):
  shared/bap: add ASE Control Point error responses
  unit/bap: add SPE tests

 src/shared/bap.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++--
 unit/test-bap.c  | 64 ++++++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+), 2 deletions(-)

