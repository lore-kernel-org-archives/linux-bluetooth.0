Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com [209.85.221.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698B235EDB6
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771608699; cv=none; b=VG0RxXMaHpk8ofSgsmANjufgrOma2B6jCUaykBdzFN6UKI7hYVFgNBi/R2Ef2r8ca2BzRGKZ4joSYiL4DhHvtSkgt6XiFsPvzbsrdxfISrjWuNdPiJo7anP4lJWYxMlCAoMOzpPlsMmhfVJQsBBOFdmUveq3/0q+zHIwSKwBBT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771608699; c=relaxed/simple;
	bh=JkYZP3JBz/ovYOwOjixhYUqk5jXGuD6SzRtYtu34UuM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjfNG3FOzO1wB++ezB8P99NIHJP+u/w5EovuJcsTnsHtewFNX+wL3JhLagKgkD8ecu0MwuMAOHyLHvbRLjmrLofvRQuz6IqXC4z3LEx69z4lPPwGgWWSllhcB5O2NEFAXVkNEfISbJDc0xGjs7bdUGN3Lu2KlAwq56oDip2niXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJPjHgj0; arc=none smtp.client-ip=209.85.221.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJPjHgj0"
Received: by mail-vk1-f195.google.com with SMTP id 71dfb90a1353d-5663601fe8bso2120323e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 09:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771608696; x=1772213496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2cJPOPF6syakadFoXXTnrP9LMIdS/ULz4KbpOEDK3w=;
        b=iJPjHgj05tQzZoWGjfo5P2iVuJdZ694Ic1bS53jkGf+ZONdG7h8RyDgHqZuN5AhXWe
         kmf85woRvTVhokfAR5qf6Pav+xNc9bOIk1EwCmTQAKjNd+tCm9fyydikj8BG9TgrIVZI
         3o0tT+iXIURY39kpe0RC+/FASgzeFeAqcqicf16/ZdYq8Nc9j8Y3UtrBr611ifuMJkbz
         kTCPmxiryXuJco/6q9lIFqvjfGPp17ac9bOMKDT83f/YT8VmxBhm8LEyTtpf2kmDY9M2
         5oF9oYyWEYqPTnqHq4tgXMrbwcJnbPhaFqRpZgMEye1Yd+OLk8teuZTZ6oHPgeX85Kll
         aYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771608696; x=1772213496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U2cJPOPF6syakadFoXXTnrP9LMIdS/ULz4KbpOEDK3w=;
        b=LlCytU5Ae7nvgauN+sKVYDJMgGid+cTNw7rIgasfOhLuy8myjVjedjz/4VKXRP+6rV
         Ay/4KlOHYABEKqfFM7LFE5mGjhB76N0DPiKwGuKRr9ZBF84PlGHJZ1/Ivqjybvums0IL
         Jb9lOrHD0R11wnEvQ2xuTFaSg7NUdeM+nUeOAiZOJqlQK9CmRu94gvjv1QsccxlR8NfD
         csHy3l8X+7LEtHF6wHsF7VCZPTr8/YQJ8gQrn8X71AC2Wqr0XBm0cLXZ+LjgO1TwfqMt
         1NA66FHDEx7O8WhidTGKbU21HGj43FXsal6Xy12U7jc38N91scD3PvGST1L5f+28Gniw
         RhWw==
X-Gm-Message-State: AOJu0YyKzg+EnUIoSPRZyJyDNW69jBTw4IcRANYcol+msv2NWS2ZXAn4
	2jf92oaLTCzZlU0pM/G1WzoMZUmvTh4DQzWGEnttyzoXMoXdVPaUU28Lxk2tHSvy
X-Gm-Gg: AZuq6aIhR04fQ5fq3IspXoGTIjlWwHU6RUKCmO0+g6whn6BFmFaiB0xvd26AtJtpgV5
	jtlFN13Gs15QC4RfvIB5CNx1RPOWCRxfnoEur+RdUqtyufK1sRzAybhVtgvQyi9ai5KquPZnnbT
	vDqmeVSmrDlaXqNwAJuehOOLeh90tLBWLBX7j8llBdH9qG28LK3VrTZ2hv3T5i8bzXc8/6Vn+9d
	kz9jIHaxnd4xizjnUkQNJgglyMOytIPZPCv5d6ZbiggWo+2F7vaPmGJO61NJ2+kJKBejjfUBb9F
	eTgnk4dvfNrhkF5o/jk5BSBl4V6WEq0l8Prsdii8CAHkAkdoU8krleBYV4aLlp/3jmBEjfirkj8
	EDXq7SlCrKo/+7jZ9N05XnIH+ApIzcFPPthdgxQBf496YVpW6Wc9fV+8dW9Gxd6V2x/73Wnzk7J
	g8zi7IL8abTlsHO2btXgv6UmHSGoLQXZMH/w2l0QehiRjCjMCSkcYQsJcRNM7O0M+KQcZJ6b8dS
	a99FX8QngbtZwkWcWpauEsLdfnM
X-Received: by 2002:a05:6122:1809:b0:567:2326:30a9 with SMTP id 71dfb90a1353d-568e4791932mr286288e0c.6.1771608694216;
        Fri, 20 Feb 2026 09:31:34 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94da8b3eefdsm77864241.9.2026.02.20.09.31.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 09:31:33 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 05/12] doc/btmon: Add a section for automated trace analysis
Date: Fri, 20 Feb 2026 12:31:09 -0500
Message-ID: <20260220173120.3418666-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220173120.3418666-1-luiz.dentz@gmail.com>
References: <20260220173120.3418666-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a section dedicated for automated trace analysis which can be
used for analysing traces programmatically or with use of AI assistance.
---
 doc/btmon.rst | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index 66a97859a49e..70cdb90e37ab 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -740,6 +740,81 @@ Open the trace file with full date and time
 
    $ btmon -T -r hcidump.log
 
+AUTOMATED TRACE ANALYSIS
+=========================
+
+This section provides guidance for analyzing btmon traces
+programmatically or with AI assistance.
+
+Recommended Workflow
+--------------------
+
+1. **Get an overview**: Start with ``btmon -a <file>`` to see packet
+   counts, connection handles, device addresses, and traffic volumes.
+
+2. **Decode with timestamps**: Use ``btmon -t -r <file> > output.txt``
+   to produce a text file with wall-clock timestamps for analysis.
+
+3. **Identify connections**: Search for connection establishment events
+   to build a handle-to-address mapping::
+
+       grep -n "Connection Complete\|Enhanced Connection Complete\|CIS Established" output.txt
+
+4. **Track disconnections**: Search for disconnect events and their
+   reasons::
+
+       grep -n "Disconnect Complete" output.txt
+
+   Then examine the lines following each match for the ``Reason:``
+   field.
+
+5. **Identify LE Audio**: Search for ASCS and CIS activity::
+
+       grep -n "ASE Control Point\|CIG Parameters\|Create Connected Isochronous\|CIS Established\|Setup ISO Data Path" output.txt
+
+6. **Check for errors**: Search for non-success status codes::
+
+       grep -n "Status:" output.txt | grep -v "Success"
+
+Key Patterns for Connection Lifecycle
+-------------------------------------
+
+A complete connection lifecycle for an LE ACL connection follows this
+pattern in the trace:
+
+1. ``LE Enhanced Connection Complete`` -- connection established,
+   note the Handle and Peer address
+2. ``LE Connection Update Complete`` -- connection parameters changed
+   (may occur zero or more times)
+3. ``Encryption Change`` -- link encrypted (may show encryption
+   algorithm)
+4. ACL Data with ATT/SMP/L2CAP -- service discovery and data exchange
+5. ``Disconnect Complete`` -- connection ended, check Reason field
+
+For LE Audio connections, additional steps appear between 3 and 5:
+
+- ATT operations on PACS/ASCS characteristics (codec negotiation)
+- ``LE Set CIG Parameters`` command and response
+- ``LE Create CIS`` command
+- ``LE CIS Established`` event (note the CIS handle)
+- ``LE Setup ISO Data Path`` command
+- ISO Data TX/RX (audio streaming)
+- ``Disconnect Complete`` on CIS handle (stream ended)
+- ``LE Remove CIG`` (group removed)
+
+Vendor-Specific Events
+----------------------
+
+Vendor-specific HCI events (event code 0xFF) contain
+controller-manufacturer diagnostic data. btmon decodes some vendor
+events for known manufacturers (Intel, Broadcom, etc.) but many
+sub-events show as ``Unknown`` with raw hex data. These are expected
+and generally not actionable without vendor documentation.
+
+Intel controllers emit extended telemetry events (subevent 0x8780)
+that include connection quality metrics, error counters, and firmware
+state. Partial decoding is available in ``monitor/intel.c``.
+
 RESOURCES
 =========
 
-- 
2.52.0

