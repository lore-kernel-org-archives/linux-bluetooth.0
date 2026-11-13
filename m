Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590626;
	b=vudPmy0BoxzyCubEob4Q3R0xY7CruBh1XI6Gpz49NLndmC2XlwcAsUHUf5s6QRqPb2yB
	 NBuJ+HaEo13glChT09TK/tgIB+Tlx0Xk/SRrUobqRrIniA/7p8k2UhAYAIkigiRm6t9kP
	 HVYptSLEKKJ+39yxVOINUXvMjgmBqqLxHLkKOg3s1k+/DN8CD0+65pz/upUtSTlN4id1j
	 RDXUMFjbSZQ0uB6TDnUFQsY3f+4VHgTcgyN+C2yLCTDsxMTyCu9iwFuc8vMbvZtpfJjly
	 IuyAYRGVuh09LHSxCLItykJ2XfqRtcuQaGMFiTQ453N4QRT2B34wNajE1Njyc4qsBoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590626;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lv3Z2W4kuPmcTI91pdO/2Gi5/UuEkGZSmgSM8GZaGkY=;
	b=LrG69tOBxyEXA8fPtYlqZegCh6uAD+JWjNqjyIaV5jFajE9TqRysd8ZVP0A+joxrygOM
	 PZtoi5BcCz/dodPAVQ39EvsNDPm9O/CLlMtUaGFYEdmUZ7ednPzBiJOPKt/agv++vVXLW
	 IqpKVAMMafEIJUAp/+wauAh7FQcg4E+xfuT2VSkjVZbOawYIMz2uAkf8HKH+6kKELFHMJ
	 XCrjVk16XVH8S0r84x7ThG/1Ssk+/bGBsd5opu3Y/RsOMRhyUL4IcYt040c77KgZlBowx
	 Hqb/DDqJ82nqjRJ7BLfHVaDfGcAVl5SccsFEOFso269bVM3M4rEs0bN9yh6Xzx0hyyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=SDjC8jAC;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9156075E0B
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 17:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA9156075E0B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=SDjC8jAC
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a2af4c8d00so2377699c88.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 09:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794590625; x=1795195425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lv3Z2W4kuPmcTI91pdO/2Gi5/UuEkGZSmgSM8GZaGkY=;
        b=SDjC8jACqHDVm8hPGuFSfeDUzwHcUcvJzRBQg9yaBFCP7ndWauy1UfL7mw0UvLm4b7
         Blzi0+rdGag2OX8wj5F+bzFuo+OmRfb4/oeSDu76wqnDrAXuCR/JtMzb8gt8VEhKuHte
         H9AnotgMe4JXlSgsMYFuS9xMsjqkhQQKKB1bTWojcOf+j/nCcMv8vZTM8e96T6ofuY93
         JW7oyFshnYMHx+fQDhEXZvdtokh97eyjQ3enxaSddR+0Y2/lHlDCSq/lXRC8J98SuPat
         hwryDUBNAC/n5wAWXh0iXxQF27Vi5uKE/+5a9xAJ86kWGVpE54vTAOUwwLRghWjPxKLB
         Nexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590625; x=1795195425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lv3Z2W4kuPmcTI91pdO/2Gi5/UuEkGZSmgSM8GZaGkY=;
        b=fDgiRNWFkPS4Ih5Ow4nRXxIK4S4LhFKiP1s7COtE/K3L0kz0rdBwu+9g7NalIVsJTf
         6IcnKXm8zN/0KaYjIu4sP/9B7d3tfvObhsSnrSP+1QpNCvnC/hW0TnfNJLwMrecYQ0s4
         rbSCNs82PLv9xrBRADge7wth/eHh8C3sUswBtLMYt/83YDRrgxH2yvnjwEXgMJ0R6ymZ
         wCknxo2Wx9iluoiHH/jsm69NjhTnCSEdJEcbkXF4Cdfzggxa8MkZm3cGSPVc+am79weU
         nhjlyGh1h5EQ+iCOAy4j2DeOX1wdpoxgp3ZXuVEdLTaTmye/mP6mb+SsBHyNdBtVVtD8
         r47A==
X-Gm-Message-State: APuU4Z/Ca7a10fwCUCnQWHn78/VUOmygdTwU5aZ7ubp5oKfoaOKtU7XU
	VkQHXOE20ZDXEmcwGyMr4/ISMLpaJ7byqJO+t0mkVMNjszPCQFPT7RzfN/gXfDcHhwQ27KvmM+d
	1iwRApxCpJQ==
X-Gm-Gg: AYBFou3MmCkKE1sl5ixSlhyyYSJcB16d2kFQe62RGhOg7ZA83V0Sz4SkFkRH/gaL7Jn
	JtPtWmCpj0Sekcngvof1NpXNia3DWD0xWYk5W3C0Q5cXEqtbs/zI11jYe/ZF+ql5bEkuaCFDv3P
	37jwnhpbSWlz0nJHR/0yeZQDs5eckqQjTR6xPBkeZ+l5qcCMXh1/gjpWd/gcCuJQMXagh7XJusR
	x9ulCYg3yslFvtd0nNfCDkTw2Qe8R8mBWcflpp/SvGfCWA3qSYUGkYz2tBtebJEq9aKX6aXVFHk
	grLpQVTS0w0IE83S2HGkDxNUkfTzyCW0N3Fz1KPGJrhZftCoC30Ts1eyL8nRxxCcl6CLpz5oVaF
	L1ixVAvyjMyW9lKejZz2QK9ye9c8XwCywxexXoVyJQAcWSIwrpp6fCZrmJHRghlt72PWN7RyhPs
	oSrhw0bK7spQFMHyeIIcqealQN+3skJXbSTCwdxT9rYo7e0ydIqrABEYVsHAUflVNoz55paIwja
	7EF7Xaf2fjyYN6bHdbVcz/DT8+kTPfHCrBWXAjOIr/wJqDQAtItG1VDMXYbY0nASHyp3QibY8YK
	Gf2YPf+GRmDkAKJKTgrdoG14jNw/T1Rb5Q6N4JyqRdvH0FY4t45u269+xH9iApEcPODm/I+5kdZ
	Ve40OeL3BTRZr+IczmppxkjS7xwv5VK8RLSzHsP0b7Zwx0QlE5RwgPdKzoxEP6DCV2OqCWEg=
X-Received: by 2002:a05:701b:450d:20b0:181:ccdd:ed2a with SMTP id a92af1059eb24-1b50315f88bmr2783694c88.43.1794590624795;
        Fri, 13 Nov 2026 09:23:44 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316e008sm8151800c88.6.2026.11.13.09.23.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 09:23:44 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v3 1/4] org.bluez.Bearer: Add ReadRSSI method
Date: Fri, 13 Nov 2026 09:23:36 -0800
Message-ID: <20261113172339.54683-2-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113172339.54683-1-kevin@simpleble.org>
References: <20261113172339.54683-1-kevin@simpleble.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a testing method to read the RSSI of the current connection on LE
bearer, for diagnostics and production testing. It is only available
when D-Bus testing interfaces are enabled.

Assisted-by: Claude:claude-opus-5.5
---
 doc/org.bluez.Bearer.LE.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/doc/org.bluez.Bearer.LE.rst b/doc/org.bluez.Bearer.LE.rst
index 3db5237b4..803adb401 100644
--- a/doc/org.bluez.Bearer.LE.rst
+++ b/doc/org.bluez.Bearer.LE.rst
@@ -57,6 +57,25 @@ Possible errors:
 
 :org.bluez.Error.NotConnected:
 
+int16 ReadRSSI() [testing]
+``````````````````````````
+
+Reads the Received Signal Strength Indicator of the current connection on LE
+bearer from the controller, in dBm, for diagnostics and production testing.
+
+Available only when D-Bus testing interfaces are enabled.
+
+The kernel caches the value for a few seconds, so calls made in quick succession
+may return the same value. Right after the connection is established, while it
+is still being set up, the method fails with org.bluez.Error.NotReady.
+
+Possible errors:
+
+:org.bluez.Error.NotConnected:
+:org.bluez.Error.NotReady:
+:org.bluez.Error.NotAvailable:
+:org.bluez.Error.Failed:
+
 Signals
 -------
 
-- 
2.54.0 (Apple Git-157)

