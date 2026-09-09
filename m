Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E8E39DBD0
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788978543; cv=none; b=ofMwLf0TskoOeY04/UsHND2ytf1pnfLRQ6c+urbN38cQ7XoZnoh882QW5CCs1bYWwh4hNHtXLRCoAkm8mb9qE5Fd0B9uZoNMFcnyOYGQBTPJ7xeBQ/cjSDB8tkcxXVgPguGPjVldQSbXbZnfjjPVnj0Sc9EwDUf8FpO70+DzuYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788978543; c=relaxed/simple;
	bh=VI7epsAa9xe69MpL6uXg5tr/6RZpfCP0rADdtfB3m/Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlTXrDCcGF+cA94mh3jtK1pXch55C5hdHyvWdCsIX1eXFGtceQZ026jfdFxdDe0+NTU+bB11rjz0TmLvgGpNQkFJiDuy/dLbWyr3CpdujuN6iGhRLl0BJ59q8k1zjow/ijWx0SO9JgCeGa8p95s8NCzrWGfvUBaBRt0VDjabrpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIY0ekC4; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIY0ekC4"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5c7c25d9f6fso5706562e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 11:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788978540; x=1789583340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=i0lK+rKfqiX0IwieNkuhvGY6zp/zz6aDCaykWpH84D4=;
        b=gIY0ekC4BcvCmlUCQ1acxiLGXNzGLqvuMjgkY424KjwFRsnJPVem4oPEYgqNMos6IU
         Mw6rWLHZxhlQ6bEoU45+jCV4RRP7olwtGaah9+npsTz8tTYrp5DnYUfHCNaFPT8M4AyU
         Qj0+76DfiXyZESPHQo+kd7eBwpswsxl/D53OmqAzBDf5L4z3ZXJtVNkOfE6iSxU5QuJh
         pMD1KY9xrLrVSrgga0opYP9ppi7RtKXOjEFTUpEB9TJ6U/9wrdJJit0Ev6GDrETNRCLK
         298I0V5mtZb1hxt5ysxEakz9Z0ZV81DBnV3mPMiBZqDG0Fx3ntGZIak5TREeGlwRTa2/
         bDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788978540; x=1789583340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=i0lK+rKfqiX0IwieNkuhvGY6zp/zz6aDCaykWpH84D4=;
        b=b+tjC2knjiHD3+tJa7gIUWdLq48z1xsH6UdDHefv7HZOAnjI/J6AStxC0YNf/szwau
         DaOE6K9aDEi1bLNo55qq1EEIt59hm5/yUnPON8bSPMr7XZljGsREB1UqZfzn76d1PIqP
         q4hkamQnScFNxrraaHg+IvHejUU4W3TGB8QtUBL/uxcjISmR10DzqZTQPUBTOcBUd/Vg
         iajtvhXMPUJ6nFqorOmbUUfphYvIwZszKyd7s5gvbKgdTfFfRX9gyECjUUdYv2lDZqvj
         NcPRdils2H+niw0OgsrHDNdM4n3GXnVyYu+vbO9b5PhQKDyd7a04qBDdpDVNvIQyuwi5
         kcsg==
X-Gm-Message-State: AFuF++mr8zlupQ8ZgZ1yEJ5kPzWddjznYBCC9MSqyK2RMW2VV6MIBB1X
	g7/s8xIzjXHmL2YJjSb50M2Pi+jTcPvuwcC8RHKIcz5/B19qzxQOdk4dzML8kBC2
X-Gm-Gg: AYBFou2BhQIf6+tp+9mYloDEixSfwbPWdWP4f0gjt0Kvisn5xTTS3ya0a7YJ+v2R8Lh
	LnusIBg2HUpmetC0oGX5QWpqQG3OfNzcIfB518PI2G1gADBluF1B6HiCmfTZiD7XKeT1mfEJZ1Y
	aEme0vq/2Mh8J9gCVQxBcAtgbHjQfkusgsCYoU9Z8okogIoFwuORXT18Na6GJ4BDgtsFXuNVXh0
	j2/f4H7hTuQ64XHZ98CFF11t/DovsU6C6TB+1kCCxIfsO6nWxEZxmMGz0CRck48S8bNMRd3EGxD
	tjCnjr9pYQ4WFc2jsqAuzZWT/NobwsXH0cxi3U5quUM5/1HkG0ZjJrYjgeDfsoAN3YiMkOH4GBn
	xCFmElZJN4wcNcJN2kZ7cGw+ACStxilFP4WIrpVMxF6QyY+xykpznEgt9AYWA4ON3tlkswIhK9I
	wYfqVgVzPKEREg2Ne3BSEvCV3vyjd2RzVyA1DpcVPyVRcFI9b2TbnKc27aa4yggPorQP7mbTSPG
	0Xtr7uXUsrfp8a9/Bx8Dkb+BpEhNB1z/qxYR6a4Id1l3YJ72uDYywr6l/6J8B2se5H/DAMnbP3l
X-Received: by 2002:a05:6122:e189:b0:5bb:eebe:7ffd with SMTP id 71dfb90a1353d-5c7ed846723mr22547705e0c.8.1788978539468;
        Wed, 09 Sep 2026 11:28:59 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c81c506f31sm5399388e0c.11.2026.09.09.11.28.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:28:58 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 10/10] doc/btmon: Document the protocol request references
Date: Wed,  9 Sep 2026 14:28:40 -0400
Message-ID: <20260909182840.1289776-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909182840.1289776-1-luiz.dentz@gmail.com>
References: <20260909182840.1289776-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Describe the request references shown on L2CAP, ATT, SDP, AVDTP and AVCTP
responses, and what pairs the two halves of a transaction in each of them.

The model drafted the text, which the author reviewed against the actual
output.

Assisted-by: opencode:claude-opus-5
---
 doc/btmon.rst | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index 80c8a8947caf..a08a6afa43f4 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -275,6 +275,53 @@ once and still resolve correctly. A ``Command Status`` reporting an error
 means the completing event will never arrive, and the command is dropped
 rather than left to match a later unrelated event.
 
+Protocols Above HCI
+-------------------
+
+The protocols carried over ACL pair their requests and responses through an
+identifier of their own, and their responses carry the same reference::
+
+    L2CAP: Connection Request (0x02) ident 1 len 4
+    L2CAP: Connection Response (0x03) ident 1 len 8 #2 (1.000 msec)
+    ATT: Read By Group Type Request (0x10) len 6
+    ATT: Error Response (0x01) len 4 #6 (45.500 msec)
+    SDP: Service Search Request (0x02) tid 5 len 8
+    SDP: Service Search Response (0x03) tid 5 len 5 #8 (12.400 msec)
+    AVCTP Control: Command: type 0x00 label 7 PID 0x110e
+    AVCTP Control: Response: type 0x00 label 7 PID 0x110e #12 (23.100 msec)
+
+What pairs the two halves differs by protocol:
+
+.. list-table::
+   :header-rows: 1
+   :widths: 15 20 65
+
+   * - Protocol
+     - Paired by
+     - Notes
+   * - L2CAP
+     - ``ident``
+     - Responses are the request code plus one. A Command Reject
+       may answer any request.
+   * - ATT
+     - Opcode
+     - Responses are the request opcode plus one. Only one request
+       may be outstanding on a bearer. An Error Response names the
+       request it rejects. An indication is paired with its
+       confirmation.
+   * - SDP
+     - ``tid``
+     - Responses are the request PDU plus one. An Error Response
+       may answer any request.
+   * - AVDTP
+     - ``label``
+     - A command is answered by a response accept or reject.
+   * - AVCTP
+     - ``label``
+     - A command is answered by a response.
+
+SMP is not tracked, as its exchange has no transaction identifier.
+
 **LE Meta Events** contain a subevent type::
 
     > HCI Event: LE Meta Event (0x3e) plen 31           #487 [hci0] 12:36:18.974201
-- 
2.55.0

