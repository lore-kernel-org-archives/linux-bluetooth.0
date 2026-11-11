Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429481;
	b=h67790OkWYa0DzrRe+pbVI9g1m+piiS9xYC1EB/Z8o6I8SZZg28pbSwQgvLYb1Yup4BG
	 c8YA8ZAh+gqKCW/12jzFjPrKXXZ2rcHBtYrFRyaTdIVGjrCTppQCL4PbgRjs/YCCz5dVw
	 bQGdi8STTtGVZ8SjllW7gSCh9h304NjMQzN8f4uhJMmu5W3Aa2H2KRcJ4YfiPZVxPc9z7
	 2hWaS8tvpcARnYkMEjz7CPM0TfElcWuse5/G6Ci+v7M7ckD2dXUqg6o5fQSgetHtemI+r
	 2ImrojmFCaboSR3pn7F/vR53CtaerPdW+/zCcDIJzVkFwbmTVq5SVY8nSq8UXOaT+4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5G0OZe/COckikq1cRWzRYvZuJoayYuCuBgN6RFphmw4=;
	b=MDhFe3FF5AdfMWvW7m43N7apd7o+jNZI7V7blEXZMAwanAp15a/lGLszYkUNHSSTuHuK
	 SbtWkgSRotjU+Z9uUu1wUfezNj9+s5qGUkre9MBJ7y5bk171tZc0abL/SlqlAliR1xY5U
	 qEm9IOWCJwgUx9JGTHd/15eWtVYuQ8TlHGwNwrlw09+go/e4t+klXqgKIHXsxHgP2yVRN
	 4DnsxDvcVyEnXc7y51XQaWhTeZ2swjy+om0kywamMo3t8HPg5TpYX2n7Mb0YYDJGH44zU
	 99jqJv3M5DzwOpJKRzjQU38gdHBA26tSNiW1kcmXR6dgM1IjCOt4ZMHHGLFXj+y555g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=moKjPB5h;
	arc=none smtp.remote-ip=209.85.217.49
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBB460A2639
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFBB460A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=moKjPB5h
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-78fb1fb9508so167548137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429480; x=1795034280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5G0OZe/COckikq1cRWzRYvZuJoayYuCuBgN6RFphmw4=;
        b=moKjPB5hsqFuVXgNoXQclBpKhKQ6ZhtkOY8pnoCNqbQo4S/PriGlrZ6Hl6IbBY8OMu
         7tqy5JuyTyREa4ToCcnQYPWu/LHM8A81zDVWVnndUPXIVu/B5s9HXDzwwCcM8YrgK0V9
         +OTkadGdPo/7jHT88iVmhDsdozy6w75rPrb+0FHHOlj732tSwiBqY3xcYsKiusZELfjo
         wQmA4f+2f/3ogRU+wnF2PYgNcAfO+Aq0+QU6Qq92RXZs/lR9WQNtHaMdPLWY8OTI/LNo
         YITMEtf9EhH7OrCgrlSbxSFj+zDHDKtGxTS2QDJ39VyxohG1NixrMgWxxXBpWaQ1VS7i
         W2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429480; x=1795034280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5G0OZe/COckikq1cRWzRYvZuJoayYuCuBgN6RFphmw4=;
        b=EWi5vYZBz67qz1zew92H4wjFWrAZjHS02/6mgdhrbmIsynMKSloa5Mrb0DkdlHHUrE
         aNIyf2H9QGo9QdYdEjL42/TRuNogpDJXLk1pntTblAUsR7v2Pk7b5TBNyWAbaF7XNsA3
         pb7nJzNCbz2FzQ7BpeOP7E7NuJZMfUM6mZju0QyKVcn/0P40WfJTUcItiI1eWSPsd6gJ
         QW4ZLL440tw0F8cwWfvPyI/5biIuOp2ZVbim27ySMUA3VzSU/osPIKbyc5hOueOXk0n9
         F2Lul8hqIz6rojy3xGocMniU23CWFt+RfEwkHmdBYAQ88XMo3FXGtvEs7iisBQ40COka
         xQAQ==
X-Gm-Message-State: APuU4Z9u99f7AJqUA4Pl+0qGo3MqP0r7X+jzf4x4Znv08zrv2C7cA0ho
	FN0BqS7Z+xEB6W4vDEfttfotPHgQzm2PoZkSRNCgOAGiHvXXRg5g3wyvEtW3Tw==
X-Gm-Gg: AYBFou3Ntrjq/5PSiwGGgRAMjj9uK9wcZBjtJoDI0HVONZpuBxkQfAuaBxCIiCPOFlF
	Q0abcPk6JZa4LInLGKg3QaoBd97a3YYVk76TedySwFPZl+zG3WAHR5SwkSGdyNkTJCTqnYrK/QZ
	87wWSlieA17nJVHcl/H9CWVXCBFTPQojieT9tYpuQnj7dOUcCtyFoMW+dNkpLW9hPPFhXwjFy9+
	9e+SjSdkdU1x/qtQ11wGTdz3uBaY2ySlOXgYa4sG783C9sGtwYsR1MaBOmLjxJD2gCqWb93GnCQ
	PzxQ4SY0cm/K10RCxj5mO4NEWw1m4MsJrPc1xMNi7ImJrFcfvOBW1ovuneOSKFHO5fDtn4gZJ+X
	xpb22y4t2wCMPi1bRZ6wHSx46ziUgYMbKJNY0864DeW33d/rPyyfnrbns3rrvLfA1FBys4aieHq
	D0ZDXzPW0k9lB9GAXltQ9cUJELVSUYRypSNY0S29OLXPEe2W7HBy0XloEsrBcnp9+VtjBvZyvaV
	GHCzvCBHdvNBCjp09LZGlIgHq8X28KcsQVCP8Ps9/FEwgxHS508MGu51H9GmdwOHgwiQHvp77vk
	vDZsBM4xNegeQ0BgjR7bBgimxZTnsp5tN9rm8PhG3XtKsYFNJZ0NaJe6vayhubijbyhnfE/qDIO
	/CG4Xp9D1mzUfaYQKzCHYT5+Q20T2p0pT8m9On5b9IZDdNeR43TwWHqIBYmLyv2g5NzchwDqcRk
	X0MDk=
X-Received: by 2002:a05:6102:4415:b0:7a5:673f:9a37 with SMTP id ada2fe7eead31-7d6316cdc29mr239356137.15.1794429479834;
        Wed, 11 Nov 2026 12:37:59 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302359221sm4762571137.6.2026.11.11.12.37.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:37:59 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/8] transport: Clear the owner of desynchronized links when removing it
Date: Wed, 11 Nov 2026 15:37:37 -0500
Message-ID: <b6c8409cc2aee6fdc413f2e4f4ef617297b8f97e.1794428234.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794428234.git.luiz.von.dentz@intel.com>
References: <cover.1794428234.git.luiz.von.dentz@intel.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The links of a transport are given its owner when it is acquired while
synchronized, but removing the owner only cleared them if the transport
was still synchronized. Setting Desynchronized in between left the links
with a pointer to the owner that was freed, which is used when the link
is freed in turn:

  media_request_reply() transport.c:282
  media_transport_remove_owner() transport.c:389
  media_transport_free() transport.c:1854

Clear the links that share the owner being removed regardless of
Desynchronized, as linked_transport_remove_owner() only does it for the
ones that actually have it.

Fixes: 1db06505df5a ("audio: Add ability to desynchronized linked transport")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/transport.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 279e378135ca..41aa8b78e3f3 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -370,7 +370,11 @@ static void transport_bap_remove_owner(struct media_transport *transport,
 {
 	struct bap_transport *bap = transport->data;
 
-	if (bap && bap->linked && !bap->desync)
+	/*
+	 * Also when desynchronized, as the links may have been given the owner
+	 * before, and the owner is about to be freed.
+	 */
+	if (bap && bap->linked)
 		queue_foreach(bt_bap_stream_io_get_links(bap->stream),
 				linked_transport_remove_owner, owner);
 }
-- 
2.56.0

