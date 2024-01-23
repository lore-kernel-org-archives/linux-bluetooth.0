Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC698F5A
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020322; cv=none; b=TTbPX4OHMkmOmpaNaSxPFed0076ZfeI7AgHmlF0jGRkGRqU23WQeX/UK8xdlmHU1ntY2jq/CxHgkwRr6Wb3GCkZmE07cB+HXI5F0OrcQvUviaxcLT494rZSbpS5JKmrkFihtEv0KTQD8H5LWKxbNzYBwndPVxZrmDvUeUI2hkK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020322; c=relaxed/simple;
	bh=48n4TOmUxHv4DEtygMfhfB98NekYFJSJN+vvWEFBFt8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Type; b=ZJoWIKlJmwIHfDAvYEHEGyhh9mfZFfEZlk7qRXiKDXtr7KvXiHHFgVKdK3FsSYUGpIREEyOVKfa/kpKcS9csdoEoZEq729riUK+mEQo6gcTukJxgEMiaONmCfXkYKl8HHKzhuQRoordW1gN8Jwbnxx74iCay0V1s3CVybQ5ep4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=D0nI1fWC; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="D0nI1fWC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706020318;
	bh=48n4TOmUxHv4DEtygMfhfB98NekYFJSJN+vvWEFBFt8=;
	h=From:To:Subject:Date:From;
	b=D0nI1fWCfPkwgX7ri/z7XoXj/XpuA/2KjwYG2bLcOB0eYUd23qICFPnOl6eA6LOob
	 GsH/q3V7ummPQIeoxZ/tgLDTlflzuRoPFBrjXH1STDY6xZI532JzRJCWsFk1qVRjyR
	 wegJi1DHjHapfH3Z8ZePqsr28orhp9Chp2ZBuse3Qtukr5QadwcBKjh5+hCviS1H9y
	 sMKByp1dTkfPWn6WsDVMrOd4Z9/0C4n9Qw0h5tkq9Zqzes72wtVE8zGrRqYJAwUROX
	 bFKHIqX2j+H/8aucif/adPh5yixYJCCtpxXDpKbd6QTPdh0FoeOJ3LM+BH7dlv/aEK
	 nEpEH53ozQCLQ==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EBC8C378047F
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 14:31:57 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/4] Enhance GATT to pass PTS tests
Date: Tue, 23 Jan 2024 15:31:47 +0100
Message-Id: <20240123143151.541787-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The first patch allow to prevent automatic security level change to
allow to display the security error when running GATT/CL/GAR/BI-04-C
using btgatt-client.

The other patches add commands to be able to call GATT discovery
functions from btgatt-client and get their results.

v1 -> v2: Re-use att_send_op->retry and make it possible to prevent
            security upgrade on a per operation basis
          Remove "btgatt-client: Add function to search descriptors"
            as GATT/CL/GAD/BV-06-C test is optional
          Fix command arguments check in btgatt-client

Frédéric Danis (4):
  gatt: Prevent security level change for PTS GATT tests
  btgatt-client: Add function to search service based on UUID
  btgatt-client: Add function to search characteristics
  btgatt-client: Add function to search all primary services

 src/shared/att.c         |  26 ++++
 src/shared/att.h         |   1 +
 src/shared/gatt-client.c |  19 +++
 src/shared/gatt-client.h |   3 +
 tools/btgatt-client.c    | 251 +++++++++++++++++++++++++++++++++++++--
 5 files changed, 288 insertions(+), 12 deletions(-)

-- 
2.34.1

