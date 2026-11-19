Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795076199;
	b=IX9tHS9h+p/WVIun0ZN93UwhNqcF6QRr2imY/5/Z43AN6l8qmJXf8OBglGLSZtbd7gPa
	 9sMRddsD7e7Qa5C+T/BMNDlYhwi6vSASptZYptUpDmFInAgaOBDC55E8TYy8T3yR8EliG
	 jcFOVAfQej/lPZTW3RiqqDLHmZ581cvWQpU3HQgmDTvpPXLqbh3e7GjVYBoCq06hB/BMk
	 Qs3hFbd14FA6rm+/4tRz+EXh19PLHOhjpLMahs1mpR5hmIzBPfg9AO3hif00jqtOcR1dZ
	 I02zKqGvHTFOSb7nh4nhT/TO6ay7K8frXZ13m6j0+uHZbbYD+okXHgWyKzmkWKRRiRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RXq6V4AmqAw6WdX3F6dIQSuYwYTqRtdpZ41EEu9f+9k=;
	b=Nrq/wFl3DbHTiJ/zOW6MOsD6f0dERbHdUdk7mYQLQS8OBT8oubCEYwXOQtxIJhn5auUk
	 890vc+c199upeJ+rsYbZHoLJOwNM2EacT74oo5injrCE3Ylfehw0n/qsf1An0mnZI8dAw
	 eVeGFRrJZPmfIF+/FSCiHaj0Rkeby/fVYFs04ftSykuvAiJbUAttguYfPIdDGsLCIWSh5
	 3y59A3FpjNVyg7wzcvhs0SExl0xeAcMLckrQRaumvXXvv49SZrf9eqiJ/4sfUVRcfFsFC
	 6eofkdgYvZnJ6bw9gEKglWADrZozgru3ZbqHQt02l+ZSwGUqcym8Nawhs8fil51UOKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uRFVjX3s;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B19B606A802
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 08:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B19B606A802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uRFVjX3s
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b87040a20bso203278a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 00:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795076197; x=1795680997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RXq6V4AmqAw6WdX3F6dIQSuYwYTqRtdpZ41EEu9f+9k=;
        b=uRFVjX3sCmxdwEwp5rlNZcpZsJ2Q/M5z6UdSOcnRfsNH8U1vM/fXhiobwZJ4+iWcfi
         uqbnP736K21l2HjepFS0NLXxF1ed+9UAhgW3DiqoMwilTpRFSjivlE2GlyRrDR29p0lb
         Pvd7OvZrACsthKjkPDD+YIVFKim2Q6aPP3TxqqrtHaK8Vz0iBtx53wBJBJzW5NaGpf7O
         6GHaNkg4uLWUE/erJL/sxHTPfO1LlIL75I79IGxZKulPeKkrPHUEmQgjYfdre233Zr77
         QVzg6OvS50bvBW+OvifAWKGE28JVAiyuzw7QVQOV3kXq2F32nIw1S84WpRq7V/cWvEbI
         TlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795076197; x=1795680997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RXq6V4AmqAw6WdX3F6dIQSuYwYTqRtdpZ41EEu9f+9k=;
        b=vdDbI0JCcIAIHYwge3prDliARSgHRqFOBHtCzjFJZBaS05Go21lmEOL6TpsmiLrdrZ
         vBj6upVAyRnrN/3dSO100vcSgV2EDeU+WJ+N0J1nGNkkpbVmGoYEzrbUB6Yobgv2N5DY
         LhYEBhk2Egtmapwp4dPzr/qXHoIlWXSm46aJIwQMrAcFmwOcHfCI+XrV+seivvPZl1DZ
         snVEcpdNonSkPhGIkA0STZZMj6FMUcYZreKybUmL9PROkYf4x0+fZRhMQubdWW+A1VF7
         s8x2PHKrD7za58WqUuIOw9W1wAi4OmPItFgD+JqmhxG6WbZGHoz25tKQCJxE+I4RNOGp
         z7GQ==
X-Gm-Message-State: APuU4Z8VXn6RGpgM9uPMI2rD/CLWCd5hp5xU+jpLfcoeVN7arLs4y3ui
	2M660FT5+6HiybmYNRXfT4ZhmGg+rCabtvpuZ6DFDEoXtbHbJfumYEwQhUxJKG6N
X-Gm-Gg: AYBFou3B85/aJN07OVd4oKrSAZUAsOLGJaItfNjMfvk/pQgbBLo3GiATJIfdB2nuwdK
	QJgVkNHnlYeVCEfDNzljG1hngKK0JtljZpM3kBP9jzLmnOyAvf6XPxQyj+19963buCYUSc4Fs0b
	FEzGmSFR72C9waGlXDsX2O7oadEx1JVvyAYJSR3yq8QSSynxXQEH6/MDe5QEn+xxnHu9XENA5hb
	Dy6K1Cv5R6BHXHr/6qPMfZHOlwOUj73deliIASFFCV99Ma0dYyF1GX4LdQAbWqBodlKLv1s7htd
	QoAV8x/Me8H9U9Rs0GEc5U2RGXg5VRLTV46l8yyyIUzW6uvSvgHwa3UZry/F0iWVOpya3fj2wKj
	czAgqevp8jrpfYGdndB0o51Gs3Zo1xG1FpeA54BeKCOlKMHbYaKULLlgP/voFAljZWq7lcYHe1z
	ROKsjgA+JeQ1OynAdNTyJHfR1EjgCJJA6wSgsuKoESZ0EJCdiUQwbN+nQyj9iBIhIcNxdhrYAtK
	YEIv1/Hogzm6v4f3MsKGF2r73k0c9Y1D47QT5y4BkK5WkRV9Vz4aSzNplN9oECKagak7epTIOix
	v3SS/E4kr3LVEr7n6wKkY4PV1aaVTpqVja0=
X-Received: by 2002:aa7:da4c:0:b0:6b5:7cfd:824d with SMTP id 4fb4d7f45d1cf-6b887e88ddbmr4477452a12.3.1795076196865;
        Thu, 19 Nov 2026 00:16:36 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b88a22e143sm2229580a12.29.2026.11.19.00.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 00:16:36 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v3 2/9] monitor: Fix data length of LE PA Report decoding
Date: Thu, 19 Nov 2026 09:16:14 +0100
Message-ID: <20261119081621.112623-3-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119081621.112623-1-rolandschober1968@gmail.com>
References: <20261119081621.112623-1-rolandschober1968@gmail.com>
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

The LE Periodic Advertising Report decoder passes Data_Length from the
event to the advertising data decoder without checking it against the
size of the event, so a truncated event makes it decode octets which
are not part of it, and octets beyond Data_Length are dropped silently:

> HCI Event: LE Meta Event (0x3e) plen 8
      LE Periodic Advertising Report (0x0f)
        ...
        Data length: 1
        Data[1]:
        00                                               .

Report a length which does not match the event as invalid and dump
the remaining octets instead:

        Data length: 1
        invalid data length

Fixes: 5441a5b91a08 ("monitor: Decode LE Periodic Advertising Report Event")
Assisted-by: Claude:claude-opus-5-5
---
 monitor/packet.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 4ff24092e..0e40300fd 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -13957,6 +13957,13 @@ static void le_pa_report_evt(struct timeval *tv, uint16_t index,
 
 	print_field("Data status: %s%s%s", color_on, str, COLOR_OFF);
 	print_field("Data length: %u", evt->data_len);
+
+	if (evt->data_len != size - sizeof(*evt)) {
+		print_text(COLOR_ERROR, "invalid data length");
+		packet_hexdump(evt->data, size - sizeof(*evt));
+		return;
+	}
+
 	print_eir("Data", evt->data, evt->data_len, true);
 }
 
-- 
2.47.3

