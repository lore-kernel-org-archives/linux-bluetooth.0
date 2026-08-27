Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAA4486640
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787849619; cv=none; b=NihphbMmV5YUB0u2AB0ip1l3rBjNjp8hthN9PMEQFmmlfjhuKSGizPQdU8ywMJZr/BELuzx/AK4jdBUCbkX/YXzfk0I7wquDwGl6bSYhra6p7l1LU7CHOE3HZUoluMbcKEYRyCu/UGwdorqPJRnV9RIA9NQCPST5nugzLsLKEjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787849619; c=relaxed/simple;
	bh=z82cIRBmQTaqnUGLLkrA6p3YFdErrM7O8ACqFuAwIb0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwx4i4QbB7YdY3cetjPKq2xtcq+ja9jOlaA68VHyla/wbhWJuc8KtcosdxXBW2UzUASPRoi253R3IJtnSFyQU3DqP57fw+SdjFFvvWgiZqXBsSzVTNeXY/j332rD8QvEfCalv07SGmXAbbJu++xKqFIHUrTmQdPLF4kLZeDtfns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/kDir2Z; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/kDir2Z"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5bfc5b77c02so96391e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 09:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787849617; x=1788454417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KR+H+EuFUPcLAsV3dbGRys8/ip/T+LwoaH7ZTJse+5U=;
        b=H/kDir2ZaRFM8XZcN6Q72d6Fq7Rubid2LzsWc7mXqtskk2yFo4rsnB8oab0ouBVLkC
         vWHtcVhmmUd9Lo7Yw3jhluoy1Y2tMkMZ15sB2/6cpLDN2Olrnj/e1ZBVQBrULrXGOq+T
         2woQ+X7VCws63BxN7N8pNM9m3If+2BMf51j/fhJAq2VjavHZ/ChntfNXMTG6X9a6QyYk
         ydIEEee8tiAdhAy+0K8O/k0fpB5K2UWGJ6zG3Ol1AaqcX7AoCpUo58iPf99EHW28Sy8d
         MPAII5hsON5Q6XWe/pCOrkF1VIJqk6gMGTlLuByFq2TAtEMnXzC1m5jh+lO7XLbB8rmt
         IjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787849617; x=1788454417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KR+H+EuFUPcLAsV3dbGRys8/ip/T+LwoaH7ZTJse+5U=;
        b=Qpg393U/G2mxQ6TsWfrqnkrkDEHd2eu68D8ci88zmrtyRl5jIqBgWMEHDNRV2oWZyG
         toc06NuSAHjHqii5pK9a9N1nEtCMap/4625yInmlAkkbw8/ROWrSBiCax7zkty3qp61B
         Cufg3D5tuTycUcQjyTJ1C4HAoGl4qgnIga0ZozGGaFkl4jctXLKcrfNgk1wgDvcmc+Fo
         TyQBn5noJ5WSuVO59y6NfKTn7F17WXDWmNhAC47J1Qf+vwEjdv03Vetx5xZy9RoCWvXi
         Zi2LSvMjB0+iuMtn4dvK2mlHl8RDI9K5zt/tTAsrmP2kaooVPV9AQMVJPCXhSXuX5GIM
         6u1g==
X-Gm-Message-State: AFuF++lQr0DLexPyXbC+yIsmwAtEHwnPRYnOUQs6RgQ14JAfilJJxJJ1
	z1JeffYNk8Hu8u9RvpzQRvB6QTRwg1Q/jnDlG/Qd9f6c/OJ1DNdhNEVBKP2H7bzW
X-Gm-Gg: AR+sD10kdKwA0KMkktRXeYmsRp1dAA8khr6a3KWL5o6ddtf+3bmK4bzelNZx/qlzrYB
	bdRqzk1FhahAr7+Ep+5B+JRCOitYUNRBNrKUvX50kYX5tpVbKY/WSNEZGwQxBGpyyBJzysC5BDT
	gF0ksB22hy9pOBKeX39DiDyYjsv0zlAW1pzMWwjgPqYSdZVT01WkfsTA4Imt5O/zNPZqWoTM0lf
	iCsdOYTbd6n9rWxTMgHGAHJds30U8LKfjsk/YJCRxnpKRpwM4ivBHJ7zxJjRGlicBZfcyghvGLG
	+40Vi5WehPGf+z2P45yweKwmWwcYpgcs1EBDUhEs55b+dIx96NcUhpM05MVFDIBPLjNEKF4ey+c
	VfflsPQWGzLBnkGPgZIZajd2PYcLpfJXDEN1ab6jTb2QEjRtYs2BQQv0xH1620iF1YygX9vF9Y8
	+XdtIqWMqYb65JkNwfkGiwwai2ALzesxorj70tBiJ4GEp03XaAsc6spNoMbGIJd5u31HsGwNae7
	X9MkR3SaQWbSuxnn2j1NBc9RNhZa+dg45DkDBHob4qmLEsTgJn2+LyQePWeqNGYHQ==
X-Received: by 2002:a05:6122:2194:b0:5bb:d233:70bd with SMTP id 71dfb90a1353d-5c680ff3ad3mr219211e0c.2.1787849616889;
        Thu, 27 Aug 2026 09:53:36 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c6600aeabcsm4155489e0c.17.2026.08.27.09.53.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:53:36 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ vRFC 4/4] doc/btmon: Document the deviation and loss counters
Date: Thu, 27 Aug 2026 12:53:26 -0400
Message-ID: <20260827165326.350079-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827165326.350079-1-luiz.dentz@gmail.com>
References: <20260827165326.350079-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Describe how to read the latency standard deviation and each of the ISO
packet loss counters, and correct the description of the moving average,
which was documented as a median even though it has always been computed
as a moving average.

The model drafted the text, which the author reviewed against the actual
output.

Assisted-by: opencode:claude-opus-5
---
 doc/btmon.rst | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index f701454e598e..adb2c9881f97 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -561,9 +561,11 @@ Analyze mode reports, for each controller found in the trace:
   - Connection type (BR-ACL, LE-ACL, BR-SCO, BR-ESCO, LE-ISO)
   - Device address
   - TX and RX packet counts and completion counts
-  - Latency statistics (min, max, median) in milliseconds
+  - Latency statistics (min, max, moving average and standard
+    deviation) in milliseconds
   - Packet size statistics (min, max, average) in octets
   - Throughput estimate in Kb/s
+  - Packet loss statistics, for isochronous connections
 
 - **Per-channel statistics**: For each L2CAP channel within a
   connection, the same packet/latency/size statistics.
@@ -571,6 +573,54 @@ Analyze mode reports, for each controller found in the trace:
 - **Latency plots**: If ``gnuplot`` is installed, ASCII-art latency
    distribution plots are rendered in the terminal.
 
+Latency Standard Deviation
+--------------------------
+
+Latency is reported as::
+
+   TX Latency: 5-300 msec (~91 msec +/- 104 msec)
+
+The range is the minimum and maximum observed latency, ``~`` is a
+moving average and ``+/-`` is the standard deviation over all samples.
+
+The standard deviation is what distinguishes a link that is merely slow
+from one that is unstable. A high average with a low deviation means
+consistent latency, which is usually a scheduling or interval
+configuration issue. A low average with a high deviation means most
+packets are fast but some are heavily delayed, which typically points at
+interference, retransmissions or controller buffer stalls. Comparing the
+maximum against ``average + deviation`` shows whether the worst case is
+representative or a one-off outlier.
+
+Packet Loss
+-----------
+
+Packet loss is tracked for isochronous (CIS/BIS) connections, where the
+ISO data packet header carries an SDU sequence number and a packet
+status flag. It is reported as::
+
+   RX loss: 13/21 (61.90%) dropped 1 invalid 1
+
+The counters are:
+
+- **loss**: SDUs missing from the received sequence, derived from gaps
+  in the sequence number. The denominator is the number of SDUs that
+  should have been received, that is the ones actually seen plus the
+  ones detected as missing.
+
+- **dropped**: SDUs the controller delivered with a packet status flag
+  of ``2`` (lost data), meaning the controller knows the payload did not
+  arrive.
+
+- **invalid**: SDUs delivered with a packet status flag of ``1``
+  (possibly invalid), meaning the payload arrived but may be corrupt.
+
+Duplicate and reordered sequence numbers are not counted as loss.
+
+Loss counters are also shown during live decoding, on the ISO data
+packet where a discontinuity is detected. The line is only emitted once
+a loss has occurred, so a clean stream produces no extra output.
+
 PROTOCOL ERROR CODES
 =====================
 
-- 
2.54.0

