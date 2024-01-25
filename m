Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142241F60A
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706209697; cv=none; b=fP2I70wTPL6vuYJThLbgyRokC4aQbDl26Q0O853hx+sKKRIXUm2UkE7DV/GDEHw6fW98dKt0OoWbIXS5H9daWe7rO4f7V16sxV5/NkJx8OmK4aXQBstCRcZfks1Cv0d/tZRhT8qMAnETycvN9VWFKEF/OwaKwYtOcqxAmpjs8P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706209697; c=relaxed/simple;
	bh=XcuCeY+R6cGqBDbu7H/pt4K3m18XxEYeiFZqLzCvnq0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Type; b=ugyFTEk7lKNnctcgvtu8LoIuJ+FMVLT/fxzNXA1uzGF+vOB2DF4b4mFg5fRI+eOAe4tSV19r3almuCziHl1l9jZhXbS85muaG2b8L9N1/Gqphshs4w/QtKQZwERCLjKHBhoBF1q9/Ac9f+5pRn1ABIucsG2kBeDbZXqeSJhXFHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bP3ZIMe4; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bP3ZIMe4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706209694;
	bh=XcuCeY+R6cGqBDbu7H/pt4K3m18XxEYeiFZqLzCvnq0=;
	h=From:To:Subject:Date:From;
	b=bP3ZIMe4H7ZV/Ewum+0aq+uo+nsVtOWpLPixhrDKQbBWKAS4MAFMa2Z1QW5MVsgoP
	 Qk6Ccc0cv7ZfipI8GmpPMvH4ya5sRkcG6ZbB9SeEAKdLptPyJw6fPUwjwaA8hSYH0S
	 uwKjyAIr1yEcTfdYeD4ddFBVJlSQQtRG05Qi4TB33GHvT4x1s+ggXKoLbKz6q7L6LR
	 el6nb6561M/wFdkKocuHin7UAicknfO8OgmGJvp5SoTJNcfroszzqTdEH9uDnp1Hvv
	 OBDs1rnHp4ZsIw3t1Q1TmAQ59OlTVLSYH8h4d9IrAV8QUPQPmNC8oBi/t+C3SNZsrt
	 rrdDNQCdvdciw==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 041FF378042B
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 19:08:13 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 0/5] Enhance GATT to pass PTS tests
Date: Thu, 25 Jan 2024 20:08:00 +0100
Message-Id: <20240125190805.1244787-1-frederic.danis@collabora.com>
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

The two first patches  allow to prevent automatic security level change
to allow to display the security error when running GATT/CL/GAR/BI-04-C
using btgatt-client.

The other patches add commands to be able to call GATT discovery
functions from btgatt-client and get their results.

v1 -> v2: Re-use att_send_op->retry and make it possible to prevent
            security upgrade on a per operation basis
          Remove "btgatt-client: Add function to search descriptors"
            as GATT/CL/GAD/BV-06-C test is optional
          Fix command arguments check in btgatt-client
v2 -> v3: Split first commit in two, one for src/shared and the other
            for tools directories

Frédéric Danis (5):
  shared/gatt: Prevent security level change for PTS GATT tests
  btgatt-client: Add command to prevent security level change
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

