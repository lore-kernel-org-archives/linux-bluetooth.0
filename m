Received: from tabos.org (krueger-it.net [145.239.1.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9F83A0E97
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Aug 2026 20:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.1.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787507; cv=none; b=H+zfFB8zh4uR44P75XuNwF2ZNpz56YVSVb1AYzzcsZ4PCyK8FIflMI0rLEhCthdv6Wl8E2myhWYTGAgA2RpxHTJtx0a46jELclNENlAKhgz+2MR+ioT6vm7kqN2wMc6SLRjl8jC8SPAzXfmYS77mOWXkuuysTMb3U26jtFLaeng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787507; c=relaxed/simple;
	bh=8svHitbqj/6xnwlQCCKenV1LnbBPiDfrQMLIptUtErE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O3JLscj8Bl0/kWoEg9J/I3CMrhnj+3OxVkJkOOQ+iRXv0DtD2BGr+UsvMgPqFqYYiFFLtOwFRo3X0DBHMlXVYGuoOZQa8DQyQmVfFx4XJ1DBi2ASvbaRXUz79bamxf3XE2P8mxbEiPE3bHnFKzsdvlFP4KNGZER68tNkQyN/+tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tabos.org; spf=pass smtp.mailfrom=tabos.org; dkim=pass (2048-bit key) header.d=tabos.org header.i=@tabos.org header.b=l5rbpRGf; arc=none smtp.client-ip=145.239.1.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tabos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tabos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tabos.org header.i=@tabos.org header.b="l5rbpRGf"
Received: from c0d1ngstat1on.fritz.box (unknown [94.31.74.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by dserver.krueger-it.net (Postfix) with ESMTPSA id 53F3F62E1020;
	Mon,  3 Aug 2026 21:56:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tabos.org;
	s=default; t=1785786996;
	bh=IBSgEgQxkvV8R6wl1BgHuJRhQIkP/6c/cIJWKATYfso=; h=From:To:Subject;
	b=l5rbpRGfqWzb9BIaqfrPLlAPZP41f3dP6IaBExodwepQ4SbObQnG6gW17O87/lzNp
	 48rcJTKmXk5OxasO43JqB7UB2ZtlDpCqrh3lBUWwm6FZkcYJDQVVlpTT3N3nAkTyg4
	 hTS9Vb1KQuvBPlLEUsdREL5wqF/sb9jI85H9/j+wzYngDGZhWy7sCPUY5gYXsVMJBp
	 lnt3a3cu0BPvjjUNpcE5MIBuWO4MQsqJEtRrTmJKvJ4DWek13zL9FV4cMnxSnXPB5Y
	 P/R2p2FaA1+XjjjQVWYkYvgYDNLntb2tjU86Wh6ToN6GSHMtNqiOFz6D6PCiV51IZ7
	 2Mwxc60ufItEg==
Authentication-Results: dserver.krueger-it.net;
        spf=pass (sender IP is 94.31.74.100) smtp.mailfrom=jan.brummer@tabos.org smtp.helo=c0d1ngstat1on.fritz.box
Received-SPF: pass (dserver.krueger-it.net: connection is authenticated)
From: Jan-Michael <jan.brummer@tabos.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jan-Michael <jan.brummer@tabos.org>
Subject: [PATCH BlueZ 0/1] Add cover art support
Date: Mon,  3 Aug 2026 21:55:00 +0200
Message-ID: <20260803195620.255866-1-jan.brummer@tabos.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BlueZ wasn't able to display cover art in car's headunits due to missing
cover art support. Add missing pieces to allow sending cover arts:

 - Add AVRCP BIP Cover Art Responder
 - Advertise Cover Art Support
 - Update bluetooth service to have at least read only access to home directories (where cover images are located)

Tested on a Fairphone 5 and OnePlus 6T with a VW head unit.

Jan-Michael Brummer (1):
  Add cover art support

 Makefile.plugins           |   4 +-
 profiles/audio/avrcp-bip.c | 562 +++++++++++++++++++++++++++++++++++++
 profiles/audio/avrcp-bip.h |  31 ++
 profiles/audio/avrcp.c     |  84 +++++-
 profiles/audio/media.c     |  77 +++++
 src/bluetooth.service.in   |   7 +-
 6 files changed, 757 insertions(+), 8 deletions(-)
 create mode 100644 profiles/audio/avrcp-bip.c
 create mode 100644 profiles/audio/avrcp-bip.h

-- 
2.55.0

