Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C56C2F7446
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764708497; cv=pass; b=PSXgU2XdgJSolqEUrIBuDSw2zc8JqqKznEWoyWWaNlv1tdthpmJlBD8nVrRBQuwANvecPp5b/JWgiGbaZR8CGLSTCgZ1MyvmfuNAHK9u8A0DtTiDt869oB//BTk4syjRHF3MtrjYZw+4ws8K3DxvpWye+ZNhvxUOMDE9+QJGoak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764708497; c=relaxed/simple;
	bh=R49BFfWwS0xcJ8dj4iVDAaWNzXNluVBMfSp4NCQQQ/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FABaFQJvx8S3jYZ6mTlz7Uc0gPVWTdxHDJIg2ltJvzVNtlxHbYGSj5gQ0DabP06w+hDBhjWePFlRm7dkVNSsp5DuXiljYSnIvHbM+yvHmFu8FThmZzOWnCgAqfOTieas39EFIufKTtjLt5uHtqEi1IdZN4WS2CQUDScfLTpaheE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=lvD10C5l; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Juyjcjqi; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="lvD10C5l";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Juyjcjqi"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4dLXsZ1FY4z49PwQ
	for <linux-bluetooth@vger.kernel.org>; Tue, 02 Dec 2025 22:48:02 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1764708482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vfojInN8c9GJ9kMi6pGUatebpzZiW+nY/HNNHWrJMnA=;
	b=lvD10C5lb23ZfS/xYrtvZNVYDUdBamcErGh6RsCc438QYuPPnL1x0XgltHJQCUfQO5EOAJ
	S9qp3rV+4Ij4+vmman0CXxbUAcfI2YTy9L1UHlibCFeaz/fi0eEu3ujBLLs3algUs4gLfK
	5Do48Z0fymolnMNQfzVEI/WXvyt4+Crzi5yZoByQAI/cPB/Xkrvm1Ad4F0X3uJoVswaX20
	gxJ7ophUJUw/whdrCacIxGkD7QVmwvPaqAOkZ4uwoUEtv7pI/CEEkkxP2gF5m5N2ShFRKh
	J12qkI8SpGCazrDv731qtbAebOxWSFC5u1ricGrKgBOZ0x4hbPwZWcnLt96SRA==
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dLXsQ0Lp9zyQn;
	Tue,  2 Dec 2025 22:47:53 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1764708474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vfojInN8c9GJ9kMi6pGUatebpzZiW+nY/HNNHWrJMnA=;
	b=JuyjcjqipBRtA7/d85JjVtxN+jW+Gr6X6B8g2IHy+M8vURmSZ4RMxEjvPkSBqIAxTVClMv
	vUjLqOEf16vQrSG5wvUfgdTWcjFLUFPJI7cXlkul7h6N9HCeKyN9tmMU9JL8u0WShO8UfJ
	XDH6YM3YPIl6FQOAtC2dk0bOVwjIZh4=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1764708474;
	b=PFzhq/2KQ0LkSHPpH3fA/rooU+yZSvEVFaJiUx71nevcxLVEUkYuPBLSNBAFvWhGXGdP1i
	9o7XE6lN0hISwWaxAKDAU63SAZn0wUdj95j8nmauTHlbchvJyw+snzG2s7+wxzeMOhhjMz
	xol9weuW528Drs41MkT36yvknWP6gKU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1764708474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vfojInN8c9GJ9kMi6pGUatebpzZiW+nY/HNNHWrJMnA=;
	b=J+YIKbdACKD1X82NO8s0m2joVu0sr99d5P/u9GGaobMG11vi6Pi2NiVA/Je4sOwUf2QVmg
	zobY7xsmmYLO4Q20IZ8xytlNy2LvDXY5PNlBFzKGgvicKJXKtl1RkDNlxysoEF9rLyyE0H
	Z7F6ouhTMcfOsn/yJUzwzZrLAtPxEPs=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 0/7] Add TMAP & GMAP information services
Date: Tue,  2 Dec 2025 22:47:45 +0200
Message-ID: <cover.1764708372.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for TMAP and GMAP services. They contain only device
audio capability bitmasks.

v3:
- rename after_uuids -> after_services + make it a struct
- add tests for btd_profile_sort_list()
- leave it as the GSList version for now, tests use queue
- add commits to mark VCP connected only after its attach has finished

v2:
- Rework the service wait to be general mechanism that also determines
  the service autoconnect order.

  This is now slightly more involved, but this sort of "soft" ordering
  dependency must know which services the autoconnect mechanism is going
  to start.

  Sorting autoconnect services is one of the ways to do it, probably
  makes sense also otherwise, and we could insert service conflict
  handling at the same place.

- Make org.bluez.MediaEndpoint::SupportedFeatures per-uuid dict

---

Expose the values from remote devices in
org.bluez.MediaEndpoint->SupportedFeatures

This maybe could also be org.bluez.Device->SupportedFeatures instead,
but MediaEndpoint looks OK too.

Sound server can use theses to determine which mandatory capabilities
devices have.

TODO (maybe later): add way to configure advertised local service
values, e.g.  via config file.

Pauli Virtanen (7):
  profile: add after_services for ordering profile startup
  test-profile: add tests for profile sorting
  device: use after_services in service autoconnect and sort also GATT
  service: implement btd_profile::after_services callback
  bap: have unicast client wait for VCS & TMAS & GMAP
  shared/vcp: add ready callback to bt_vcp_attach()
  vcp: wait until client ready before marking profile connected

 .gitignore           |   1 +
 Makefile.am          |  22 ++-
 profiles/audio/bap.c |  36 ++++-
 profiles/audio/vcp.c |  11 +-
 src/device.c         |  74 ++++++++--
 src/profile.c        |  90 +++++++++++
 src/profile.h        |  26 ++++
 src/service.c        | 106 +++++++++++++
 src/shared/vcp.c     |  29 +++-
 src/shared/vcp.h     |   3 +-
 unit/btd.c           |  41 ++++++
 unit/test-profile.c  | 344 +++++++++++++++++++++++++++++++++++++++++++
 12 files changed, 758 insertions(+), 25 deletions(-)
 create mode 100644 unit/btd.c
 create mode 100644 unit/test-profile.c

-- 
2.51.1

