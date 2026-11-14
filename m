Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681661;
	b=Gpike2eGGDkeVdCXwOlBJcbyvDrxTgdBYCOnLjS219kg39/E0Gt9AXDNIQqBr/EXbsOw
	 YrsXKN4pQPAGGb2s1NzmyiWR1AOuyuqHtWJcOxzp8cyFG/OssQBA4kvB0K9xeJ1C4coNc
	 M04wCY7icUYg9+YeYS2v4Pa9wgYKGBvPxxDH3KyY8ZmKJu6uu0rLo1U2yqeU7+xCSe2eN
	 oJy8AwGDCRdxsT44UkDSgFOOoZSCfSyte0jsgViJWsMHszKVfmwi8TtI3nFd2YixsoQru
	 SUnsX5dKm46Tq6OdUHGZmQbwAoMRGVJsFRCkX/OcX8yOt+WfBr4C6ptapHdiWAcvHZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681661;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Date:
	 Message-ID:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kPkeXR075x9JQnW1QfJNooYVjuEjjQPWWpIRMg/+OhM=;
	b=3KdP8g18au8sMyWcgSVUBGz6Iid+iycCQuE/ZwLNhTZtKAFEH5wndxkxeakvg16YHa7n
	 t18jKbqBaeWzrw29GWnJHN3OAAMXMyMnkHZna7cPQRlKIBGitf0OwJIL0Zf2m/yrKHkmC
	 qY6dLBEUl22aTW+V/Ey1Bh/Cb1YFSLO39gQRY2F8/t4Q1QyUXs2VvgTyAUcXg6eotJNd8
	 W8SRcU4wT9W+9xwwAIwTp/Fz7ieh3setLPuBQoVAoEEacJLwWsKzXoXLecT63YdA6xpsE
	 GfZEF5eT/H1QYCCuf/9aFsGRaU8ASkm6jg/65RTcRzKmwJi0K7i5t6YEGRHQSsN5CSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=michaelmcallister.org;
	spf=pass smtp.mailfrom=michaelmcallister.org;
	dkim=pass header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=PAeqxxvp;
	arc=none smtp.remote-ip=109.224.244.108
Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C0E606A32D
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 18:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2C0E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=PAeqxxvp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=michaelmcallister.org; s=protonmail2; t=1794681657; x=1794940857;
	bh=kPkeXR075x9JQnW1QfJNooYVjuEjjQPWWpIRMg/+OhM=;
	h=From:To:Cc:Date:Message-ID:Subject:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=PAeqxxvpI6ounTM0oyMrvUHjCiCBjvA6belAD9VGQAYzrVUs5LBNrK36gK+TbFaBF
	 2eSXpJ3U7CccY7uz5x7iekcDaUZO64gZt5p7JlHf5lzPLC2YV+nKm+uUBZ93Nep9gT
	 gm9+gexMXXc0IBfifRpcQWEABLrJWLqVdkwEHC2GLoWPHojJZNs+rT6JZ/lblk1DgU
	 anSWEPEXHAvrCCDuvaMaDilvVifd0wSeOWB3aJP9cZpc2DDBh2zhBf58xUS8Rdk1o6
	 v04jZCtmPJvcjlAtwX2hjTBN40mdmAxo3BQzgpYKHtheB41P1B6+pR4PL1eBgRpbRK
	 oOzw6Cx5knEfA==
X-Pm-Submission-Id: 4jRjcj6rG9z1DF5G
From: Michael McAllister <me@michaelmcallister.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: brgl@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_bgodavar@quicinc.com, lumag@kernel.org, mka@chromium.org,
 me@michaelmcallister.org, markus.probst@posteo.de,
 shuai.zhang@oss.qualcomm.com
Date: Sat, 14 Nov 2026 18:39:54 -0000
Message-ID: <179468159400.2456.8302096233933976388.wcn3950-poweroff-v2-0@michaelmcallister.org>
Subject: [PATCH v2 0/4] Bluetooth: qca: Power off WCN3950
In-Reply-To: <179322687810.94538.4628148055419456389.wcn3950-poweroff-v1-0@michaelmcallister.org>
References: <179322687810.94538.4628148055419456389.wcn3950-poweroff-v1-0@michaelmcallister.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Thanks for the review. I've split this into four patches, with the
Marvell fix kept separate. I've tested a backport on my Moto G10,
including power cycling and unbind/rebind with Bluetooth both on and
off.

Thanks,
Michael

---
base-commit: da3cc02587c629420603df4395179ec82955c941
prerequisite-patch-id: 517b9cfef6a60777b0869a8f46d4c07be7f77c13
