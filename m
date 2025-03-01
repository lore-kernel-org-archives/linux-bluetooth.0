Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E230C1E2007
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Mar 2025 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740844676; cv=pass; b=Y7bqeCfQ7LNfSNbbLVBQgoPAqnflGklbrSwBCSMEYXPYOWkUh1lBJQFJdyiXeBVVbn2F6UMwtIleuqB+aT09HRoSfF5iGWQVajy4pPbX8gMRj5KWbaIXGrMSJPwB767NRI1E5QvdTeOmmAUurNNxo24EM3hfsdBtxmtq+u5WHAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740844676; c=relaxed/simple;
	bh=QvI7jU4op5vHM6i5iuHrvEYAFLWTu37iE+HLzAmTdH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UFlub3Ji3UEkg5b/Qn1qpIf7K9zSAQEMOgjktIPSNbozD8h2CuNgfm1dWTfIYusGY7kuyiaiiHR5D2dHd02wS71/mn3dNxQOX4c0H5ZtXPSNlLBDlYM2hwRauSbNSD+omH4LnwMGrkPDLgY/m8BXg6NaB9mFcj/TvFh+BWBqj0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=sqmV1rp0; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="sqmV1rp0"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z4qV13DzTz4BKDw;
	Sat,  1 Mar 2025 17:57:45 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1740844666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Yw8OTZo8SrWMJzblr8EKvwIg1TEfIzFbwSELZ14d2to=;
	b=sqmV1rp0JswQZY/XJX8TuPax6JFYV3toiUPGlXIv7R2VqZ6cxnYVRodVLzrbFf17Z1/dJ4
	en1h/p1ss9TrdXTL6TCITK62IXscf+1sG9aLPExmdmUnaFUvJxiqaLr0dpa+Hu2vKYUMB1
	79jU32Vp5vg2QrlazlbiNwLDZoKcp3rj7X67lhzzEr+VIvLSlCS9hUNzUFyDCRfyfpjpaN
	hqaA5f1KAUELKgDoKsJFGo4RmeS5g4Bvk+O9innganajwbU0zVC52CwFyETURA+xKyRpMG
	+y82r1Cs4lIyx5vi1LVuXl9QCNBjrK6LpSMgweoyfhk4PaipWDoYY8Ny8Lnm1Q==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1740844666; a=rsa-sha256;
	cv=none;
	b=UUa7O8OKZWjTJZ+oU5Mq6A/YLUNuXw5+2Ohi/qy/R2I1M/TleAXcpNq3Iqa4CniQB+HvAE
	hpNXjFyAvdBR5uTAtoJdLxKuSNHE43U3h4VxY2yRR64Yy/p0cOcwzFvkvslRfgUtnH3ASW
	whGfSK/dOKAHfGO5xecOYs/yQmPe/plcMCzIyUw1zfPDoe3IzHO1jmv36Fz8GeN4O7kwgB
	8P++y8YSPNehQZpDP0w3xCK2YHZ5oHfXgQd03YaalVoPZd6wsThQ9VpTr2RwcUUDJ9Tc3Q
	IreWBEes1O4eZq26TVj38FKp7wRjOKzJrWGSGIhJ19cWg3YSr9M7b+rnImXB3g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1740844665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Yw8OTZo8SrWMJzblr8EKvwIg1TEfIzFbwSELZ14d2to=;
	b=F/tkMJA6DL2oijyfzUgKx+DB8DgAz+Q84A6WL+Q7Vc5K1t2mD3ZFfDozezw3twpecgTx5C
	maUYG1euFlw6xfZ76HKtp9Y9vf6+4MFzYpXU+U86z8GMV4ZZ1UPfPF95lGVnQUCmRfaRTK
	goZP7EaQ19OJRHXi6+Jrpb4RUyZvzzjKrKPF4bqMGsjWr8Z/hOdEQ4j0XQwgi9XQaujs9c
	1o50zjvaYIxlqzY9jekbCINbZMfKYer9xpaDBmhCde06lPCXQzNguYsiHuanT8Tjx8QmXZ
	B8FwwUikcEf7G29uL24QymzdZlu7q0yo+JtImkVDxp9ZvXgz/3Wo4wiZRb4NBg==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH BlueZ 0/9] BAP stream reconfiguration
Date: Sat,  1 Mar 2025 17:57:31 +0200
Message-ID: <cover.1740844616.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Proposed DBus API extension is:

- org.bluez.MediaEndpoint.ClearConfiguration(transport_path):

  Destroy stream associated with transport

- org.bluez.MediaEndpoint.ClearConfiguration(remote_endpoint_path):

  Destroy all streams associated with endpoint

- org.bluez.MediaEndpoint.SelectProperties(remote_endpoint_path):

  Destroy streams of endpoint, and re-run same unicast configuration as
  on initial connect, which invokes SelectProperties() callbacks on
  sound server and it can return new configuration it wants.

For future:

- org.bluez.MediaEndpoint.SetConfiguration(...):

  I think how this already works for broadcast is good: one call creates
  one new stream. Unicast should be changed to work exactly the same
  way.

  This allows for more detailed control of the configuration than
  SelectProperties(), and sound server can use it if it wants to deal
  with the different ASE configurations by itself.

- We will need to figure out how to handle devices rejecting ASE
  configurations on Config Codec or Enable.

  Whose responsibility is it to try a different configuration, if the
  current configuration is rejected by device?

  Example: Sony Linkbuds S has 48kHz sink & 48kHz source PACs.  However,
  it does not support the duplx configuration with both 48kHz sink and
  48kHz source ASE -- it rejects that in Enable.  It does support 32 kHz
  sink + 32kHz source duplex configuration.  AFAICS it is not possible
  to know which combinations of sinks & sources are possible, except
  trying them one by one. How do we handle this?

Unicast works with this Pipewire branch (can reconfigure to
sink/source/duplex):
https://gitlab.freedesktop.org/pvir/pipewire/-/tree/bap-codec-switch-select

(With device sets, each device needs to be switched separately.  Some
more work is needed to make reconfiguration while CIG is active to work
correctly, sound server must release transports before reconfiguring.)

Broadcast has not been tested at all.

Pauli Virtanen (9):
  org.bluez.MediaEndpoint: removing BAP streams with ClearConfiguration
  org.bluez.MediaEndpoint: add client role SelectProperties
  bap: add and use chainable future abstraction
  bap: use futures for select operation
  shared/bap: bap_abort_stream_req() should cancel also current req
  shared/bap: make sure ucast client stream is destroyed after releasing
  bap: support removing streams with ClearConfiguration()
  bap: do not try QoS before links are updated & io created
  bap: implement client role SelectProperties()

 doc/org.bluez.MediaEndpoint.rst |  27 ++
 profiles/audio/bap.c            | 533 ++++++++++++++++++++++++++------
 profiles/audio/transport.c      |  17 +
 profiles/audio/transport.h      |   1 +
 src/shared/bap.c                |  39 ++-
 5 files changed, 522 insertions(+), 95 deletions(-)

-- 
2.48.1

