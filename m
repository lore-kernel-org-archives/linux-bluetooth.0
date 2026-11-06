Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793952332;
	b=aDVfq03pOmXYVgNSF8Cj1NR4ANYpuoZa/ccXiLCSh09cOF6tATjX9EGb2oolZiOgga8C
	 Yb9VK4ws1baoIjeam/KWyJnydfDSn0PGJA+uQEmdM9V23bGJutZmAkth9ldHxLA9pnnb5
	 MQX7cXVHmWoIGNMFyY0AGfvRxZvaOFtmKe64dhYD+j/YZaQbQ36f1Td3mblaWGLj/VJtV
	 XYGHpJ6+Kaeixg01hLwkxOn5oH9nk9lyY1YbMwrBfXh5Lwo8Uvogd2hSrYyysHGRtCf53
	 d4eOgEDqzoumKj2KxJM7JA0GNu/hVhb2q1QZH36D95xEvREXWKafB0joQkWALL+qqtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793952332;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ujUkFLWJnc9if42dmvemE3cvcif0nsffpzm4OuUqz1M=;
	b=dvYlwJtuujS+CzxfMJFdkZy04XjjF1F0Wh1GZ+fEYsDSm2bCP326SyEk4V9vYj7Q/0Cb
	 oajSdb0zeWo3OGgdAOP2eiP+miIrCDYmjIwEzEy6D+ugLMWlxqnNasc6LRrCM4NnNydm/
	 2gCBWAp+yTguyv9stJIW+7m/UOsWqNUNgqEk1WjGSSoFwerTz7pfHLgExQIKqWIbmPVv4
	 CTcEs73fWHrSroBOW9h2P7v5PGPYQu8anzA2e748CQWiicLMQX/gRpQlgwBFd1QurWOSK
	 1sCoxRML+OI5PEXBl2tNkm7zigXr8j74+JOhUjuRRlFEB443sRQxEyGKFJd0QrPliig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=LkY12RAt;
	arc=none smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85C9606A329
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 08:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A85C9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=LkY12RAt
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5906F3F9B0
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 08:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1793952323;
	bh=ujUkFLWJnc9if42dmvemE3cvcif0nsffpzm4OuUqz1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=LkY12RAtFTVYIFVPbtsYTKg1nkB7ecEvFCsM4JdsrZwTnODzHY/LFKG3qqnheHfSc
	 6AfAEvq0RgP1QpgaHQKtSE90rRS5894NQBsAuZD+hzeXnXuG1Rk+XBRzjMFZME91G1
	 AVncLoeADFT4ZKhhPJ+0zoZvRGm2vH7z8XB8zL4F1LnFUcY3ox2jxJ+GZC/tf59F9I
	 BOs78iUQuko9ZHTBmyN61Oq+TS7W1E0tW0TV+BEgL1l83flW5J9FcHBgxzQedykH0t
	 PlXX1BneMQ2RATOueT/EqM+U7ROIqbBpW0WN8yxbKKjIwMgxvCA2T8AtIa1zKgXFJd
	 GYtDGRjw1KpR4BtKnokM7BbKH+ynbS1Di8E3Rjr6zI8+fxX37aAONFZ6YVVlPqzo/+
	 8WOOUWQl03fhYwgZcP0qGFOgBnKs48fK305VB3EwOkT23lMFkAUU9whpuYFnaV6fZ1
	 cgd66dGA/RXivYZhpWiilEBB6r1NGUkEIOSV1QhuWzM3pzVz5IaaH0dgn0vRNt6N2c
	 wxdYDrHXEzC+gNupISEehWpEc1kzU5VN5VUnmC0Z0K/3aoeXV7/Tzm/yjE5sXZgJ/Y
	 rpGJ+D4vlGlwBs5kw9AL45gRF4mKqT9Z98w5NF6G/+OZ3MTmC/uC9tjCYgiyH2Bche
	 6aUTRPp07GWqcaYWlTidm6yc=
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd6969473a4so299891a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 00:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793952322; x=1794557122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ujUkFLWJnc9if42dmvemE3cvcif0nsffpzm4OuUqz1M=;
        b=Mv6vXJtv/7Ly3va3MJjAmCGLnFMslabpM3X4EKAeuYj501pniPanhiTCimazar6SGI
         DmeKsEm5z5IEymJN/o/TvphyzXQP6gdvx6SEvqbul8r5YqP4GUoFrnO26tKtLG8B8cRI
         g6vNbWHsUqQzk/XKnQ9F+UUFqq1gklZhYVGdvxNBED5YbO4ORd5KfWb9qktmkoSZr1kF
         Ij5AnvEaxOZ16tlSxMASj1q6hK0XQE0CPaAxLn1cawmOfChOMKG2VnTebEWJHLAGDLSs
         39yA3k3qELaXlDYMBWsgWZ2aUZFH13X3e+Agfwf+Wf4ysibPk4vb9fMuNbhHJPtkmRXt
         wfCA==
X-Gm-Message-State: APuU4Z8Fq7RJY6VyT8x6/kEsgdtpGQ+SEv8BR8I7NBJcJTaxkr/VD1hO
	ytDBYMxqi9PgsjqU1wEcVaEcLfop6tKDcpz/6Q74SnZzulKnzTyyMy3nKa9Bc4xhuzVSD93slz0
	lnpIZVV2jdcdJEtzzfsPimTD2qwZV2m5HmI4aF1XxZGYGXcL847q2J2PHA56WZBw0cHUox0JRH1
	mCaXtgFBR/SQ2fhkcmN7U6
X-Gm-Gg: AYBFou0gkQq7/2PGi4tP9CjhfhTE1f4CK+fbn/LA6KhNc/RIk+9TQcfChZQY4llOxCC
	5tcsZjZbYoMwJgmomyHb2OsuaA70yNuV47JfP0QefiSh6rFTo13Z0OZbr3ZQaPEB0h4wZJKzh8e
	g6ATrhpWXj9+mcEVqPTEZgrLDksA17jv+G2EDdUQ6ZuAzMTaDdaJA6jSFdTAGdb9D/2TW9dCm+I
	ahjyT/cCgAIb9Ptp2Mj0brURCsdTjBufmRygOUVoyiG7QIx6sQg+B41rtsDH2Irmk96MDkNFUMd
	P4r4qo0tkxE/aOtzGRUFRB1D1dzLu7og78euKuK5IkLE5YqRFpIgwik259WElF2wrDRrp0kc5gD
	CIZ4bVrMONZEcCc+kz4d+BsXAsUYlHgZBQ0hSbOKVmllo/bVa35WrfD1K6ZEZYBgn46UiCxrU7j
	VHKUbTkD990PXgtwh6VAK/45qyOQ==
X-Received: by 2002:a05:6a21:6456:b0:3dd:85a8:cac8 with SMTP id adf61e73a8af0-3ebb298bbc8mr1935331637.31.1793952321559;
        Fri, 06 Nov 2026 00:05:21 -0800 (PST)
X-Received: by 2002:a05:6a21:6456:b0:3dd:85a8:cac8 with SMTP id adf61e73a8af0-3ebb298bbc8mr1935311637.31.1793952321119;
        Fri, 06 Nov 2026 00:05:21 -0800 (PST)
Received: from 170a83c21f5f.. (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb766b156csm6022a12.6.2026.11.06.00.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 00:05:20 -0800 (PST)
From: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ 0/1] mpris-proxy: Fix possible crash on OBEX transfer
Date: Fri,  6 Nov 2026 08:05:14 +0000
Message-ID: <20261106080515.2296-1-kaichuan.hsieh@canonical.com>
X-Mailer: git-send-email 2.43.0
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

This fixes a mpris-proxy crash (NULL dereference) that triggers on every
OBEX transfer, most visibly when a remote peer pushes a file to the host
over Bluetooth OBEX Object Push.

find_player_by_obex() is called from obex_property_changed() on every
Status change of any org.bluez.obex.Transfer1 object. Since the OBEX
g_dbus_client_new() client is rooted at "/", mpris-proxy proxies all of
obexd's objects, including the server-side transfer objects obexd
registers for an incoming push. Those never belong to a player, so the
list walk dereferences a NULL player->obex / session->obex and crashes.
A second, narrower crash exists in obex_get_image() when a failed
CreateSession leaves the inner proxy NULL and a Track change carries an
ImgHandle.

The affected code path (BIP cover art / find_player_by_obex) was
introduced between 5.77 and 5.80 and is still present in 5.88/master.

This change consolidates two earlier fixes that were proposed but never
merged, because the project moved off GitHub pull requests:

  - PR #2098 (Bastien Nocera, "mpris-proxy: Fix possible crash"),
    https://github.com/bluez/bluez/pull/2098 -- passed CI, auto-closed.
  - issue #2569 / PR #2631, the additional inner-proxy (session->obex)
    guard for the failed-CreateSession case,
    https://github.com/bluez/bluez/issues/2569
    https://github.com/bluez/bluez/pull/2631

Resending here on linux-bluetooth so it can land for the next release.
The change is confined to tools/mpris-proxy.c and only adds NULL / early-
return guards before existing dereferences, plus a g_clear_pointer()
when releasing session->obex; it adds no new dereferences.

Downstream bug report (reproducer and SRU analysis):
https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/2172906


Kai-Chuan Hsieh (1):
  mpris-proxy: Fix possible crash on OBEX transfer

 tools/mpris-proxy.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

-- 
2.43.0

