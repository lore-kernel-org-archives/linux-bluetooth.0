Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BD9189906
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Jun 2025 21:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749418357; cv=pass; b=PHV/DkOdSeTq8z8zbShONQTGGO/krpDRXaEk3LHcwfiuPN4uhOS5tCS7BVYFhPlPCKkueq7xo6VBXNj/ptYdmYnuuBCZXoGcdghdtOz8R7ZPi0nlWfPQZ0CPwX2utrQ2314l77ALOrR1ziGiXv2hcSdjgVVAi5stJvNrqE+N8Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749418357; c=relaxed/simple;
	bh=QpKSYYPbAmNPMu9bXzOQSW8Na8sVw12k//9QlO8qKDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e/Vye8DMyP50FmCRiHfPTD7cUlw11Jp8+M++qXLqGriPuHhsUk84zRTd/biF6zkVxERCi8NaXAUJyu2ZgxHc3QD307KWxb2P+red8cVoMyptYaYBZL6wteD1mYyxOzvdinA4M8ao7gqHAhg1762QerZykokA47vaw9JvgX0ykL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=iwSbnmu2; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="iwSbnmu2"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bFpDW14Cxz49PyQ;
	Mon,  9 Jun 2025 00:32:27 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1749418348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f7l1gQKMloFMPPR0jaZvdjX9udtjt7i5Bo2BNWwVc7Q=;
	b=iwSbnmu2GC8UYONX3nX5OvkfJiLY31Sp+AyV+ZFzgwZG6F4QexzJS6kFFNx85sUsjid7Jh
	ChDzlcitS8hoet5R2QlbeI+GItt9gJC5XGOi20+p+39plDZz1YIHhe+ZF8Ek1Z5milYTYN
	8pixLRHS9sG40OEppNwZsmWbzQdJrEHRxC4oaXwb0PG2eIbX7F6Nody/FLEapyB6wqRvAi
	sAUol/gZOi4306n6PtJDd11VcVPFHBHUWYjJnRLT8xj4P0OqfffrRaqHu4dTPWaP476QbW
	35bhsGW/TFLwftk43PB42KFaakN1Se8y6wVNR/6t78ZE+i7HegdmwvNaAn/hqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1749418348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f7l1gQKMloFMPPR0jaZvdjX9udtjt7i5Bo2BNWwVc7Q=;
	b=BGUQLqhh8/7I3ntdbJXwWLoatJgsAhiQJmDceG86LjcENGpUL+ZiMGxQunJodtEVSO2oMI
	mn+RrnIMQKwkvfoj9Ve8YM5h1+UmyS22IQr+ibBszrPsNCD/ZlxS8TxPe0H3FkmAfpuqC5
	jrbbyxsbAwhYKdfg3drkCiZjHsDtM/p/ENDkf0Qb6vugzrtyTKORGtfrjnIhJNORyyOD+Y
	AUPcVivS16DtH/y9TggLv+mhbE2k3XYorT/F+Tv5KtzaIam3ezN3Z3lMhREKOLpWjfHpuy
	lisF1i7KckvxAMddxvgp8W7IKEoeSb6UQkRW81vv31aTcwk1TyI751MONKe5jA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1749418348; a=rsa-sha256;
	cv=none;
	b=lSrbIQUxyOVPDRvTVh7SCZEYlEW7/Qk4xKq0BXXfw+SNCC/PUpX2fDjTZ6bSv86Y4z+8si
	uN0wdz6Ucams2gjm2KJTS/lOTRU3G0l8SLQO3yy9yknSaJXpjbcnQ541uZT+NVFVqbRhJ8
	DvivQadz11/MrvIy/5uYtbpshWhBt/goWsmnjmjDvemqzbIMfcdDjaMXso3DDsM1kLwGhz
	YZX5PYlgEVIDgdIKTi1vmFPuyKWlnfZQrOcUrT5XakhoTjLtj5MTFLB+JqjZ3LmrpLCvqo
	JeeOIZjmirH25Gw+B2V8D6mjVLBs7+dwN6lalYKUYxaonjt9/075rEtnmVe8fA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 00/10] BAP stream reconfiguration
Date: Mon,  9 Jun 2025 00:32:12 +0300
Message-ID: <cover.1749418319.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement ClearConfiguration() and Reconfigure() for BAP unicast
MediaEndpoints.

v3:

- Add bt_bap_stream_lock(), instead of bt_bap_stream_discard()

- Separate commit for "detach on RELEASING"

- Move "bap: do not try QoS before links are updated" first,
  as it makes sense standalone

- Add "bap: don't show error when releasing stream"

- Add "bap: delay QoS & IO creation if CIG is busy or setups configuring"

  This reworks the unicast stream creation/QoS/CIG activation logic, to
  avoid doing operations that are impossible due to CIG state machine
  rules, or lead to ID conflicts.

Unicast tested manually on:

- Sony Linkbuds S: switching between AC 6(ii), 8(ii), 11(ii)
- Earfun Air Pro 3: switching between AC 6(i), 11(i)

with corresponding Pipewire branch
https://gitlab.freedesktop.org/pvir/pipewire/-/commits/bap-codec-switch-select

Some more testing is probably warranted.

Broadcast has not been tested.

Pauli Virtanen (10):
  bap: do not try QoS before links are updated & io created
  shared/bap: detach ucast io on RELEASING and unlink streams
  shared/bap: add client ASE reuse and upper level stream locking
  bap: lock streams when used
  bap: add ready callback for setup configuration
  bap: support removing streams with ClearConfiguration()
  bap: add callback at the end of ucast client select/config
  bap: implement Reconfigure()
  bap: don't show error when releasing stream
  bap: delay QoS & IO creation if CIG is busy or setups configuring

 profiles/audio/bap.c       | 1085 ++++++++++++++++++++++++++++--------
 profiles/audio/transport.c |   20 +-
 profiles/audio/transport.h |    1 +
 src/shared/bap.c           |  168 ++++--
 src/shared/bap.h           |    3 +
 5 files changed, 1005 insertions(+), 272 deletions(-)

-- 
2.49.0

