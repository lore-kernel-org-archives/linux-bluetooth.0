Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622874;
	b=rzLtpUHAjOiJgYOwtZZ8c+SPSHTU0Pr9hs6ozbYSq/gVRcdz2GgLdfwdt7psGv4Z+WX7
	 xeEF38h1tuvFHn54ioMewGXowfQYRj8vjXhowZy3xYLuM4Zrp8oa+VPM67r/G9zAypZ8w
	 ZTXkOvG/+zyjIPsA/4WfU3gdCfihXmnRv8SPSQZE/NDnTTN2vIqfdp2mcOwgk/J2IDyVW
	 P1AmXtayvWzDJfNYzacDeZx73TxGpKcNYKg5BGfVAQ/84CZLzJHkzUulZHGc1EZD8/24P
	 +GkFJpTmOxJujc+LFJRgZdIH6L4EzmwkPH1q/ps9l33ryWJOgPyJcK1XlEON3Rgz97A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8WgZokOso5GKBkB6b1tRUojAeIrmq+wx4vK3BoCOZdA=;
	b=ctfOyJl+dDyJ8ikwJ+D+KbHcyGgbKptexs8qAugCGS66p4nAjZbD0CJP7A6k8PGnqmlM
	 w+X12cgbOY5bWYvp2lVqxCufwclugOp+jbCZHqexKT1A5frbNbnBQKJgWX+d0EYmJ6e1T
	 8Wp2IBrezhTS8eeBnU2cUL7sMakhHGAaZXPDbEhqs30OeWl5PEq7Jukuo3S0nsV+rGiPa
	 s46+c5mXz6VLP7JqUoh2rddxLX6BSHaLrRgUTtOw790j0CzMEePi26kyS6FXxWRSA0w0H
	 UDJusEi+Dl2Nd5UGS7+6bRatChkqNCYdmdG50wP/CnyTefSKWk9OZNhAZ43lToaALGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=Mgit0CiU;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA106606A32E
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 12:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA106606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=Mgit0CiU
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso430288066b.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 04:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1793622872; x=1794227672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8WgZokOso5GKBkB6b1tRUojAeIrmq+wx4vK3BoCOZdA=;
        b=Mgit0CiUXJF476mkGjG/UtMwaxX5JUjdiFfVeAGAOLUguFT72B03MvLcGth7CIhu60
         V4Gn27EVgzsiGSRLwcwuLr1xO05TwrG2o987Da+SFncL2BQDYpeZGNQVgeNR1PYu7zb7
         xmyAE1d2jGl9WxYLW1E8o/ueQpm9/V2tbgo7/DgQYrhqs/rZBM938LeGunPsi9MW+3We
         avvT78CrOOo5XxKUKkTOm9FZdaRutToVtKMLD1rwLue/8dh6peQYMz6HKDbS9PkyKCL+
         6iZbJNoPvr8JVnMWPUPn4X2cx8DuGaqWqtmObQdVTsPeHz5l2eNZukYD1bDpIhKmrSLR
         oB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793622872; x=1794227672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8WgZokOso5GKBkB6b1tRUojAeIrmq+wx4vK3BoCOZdA=;
        b=sehWEBYmgYbGcyk9a2JrQIOWFyuguo41UMxhl8dX2dUZsXaoJbeIEycSjC4a4GRQD4
         bmQqgIBCmzAwwFkN8CMEkEkTTV54g5L6bcpCEqXmbelSaklBCTAOPLqWAxSSvnFY1StL
         TbZYTBg/NqQXVqpSZ/ElZXHqWPfbk8l4G6y1KK/0ZBqFAt4NgqUblMRWJ1yosWBhQQb+
         lGvZq24eLcHVZ1vipcbuXF7rHlDh/0NmH3eeoQA+30vWa3bSza/CtAEwrXi8AMwvkF60
         v3/R6Z7cQ2XpOswB1Us17/CW5b3GiywWQR8oukT+mKvyTTnxWklrx2t57W3+uSpbgPOE
         0KkQ==
X-Forwarded-Encrypted: i=1; AKwUvBwAsl+gbgVDoNvHUuT9Z6DYdjWnh0eeoJ0WLt5yuj5XNJdfQzhozxaQPxB0MvlNf7mia+sNVzVYLwUM57svl9U=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7Ggu45arnTjteHK6ijpBJikGuVkcKUY5luPu7ihm+NLb4Akt7
	AEh5aFTI8QgxWaQ22mYFzT+C5Xlap86yCiI+m3SBs0sT48kLIFOiD/aU9aWqzPs4flI=
X-Gm-Gg: AYBFou2xAp4Rguph3xP9AZX2ZGu4D6iwky9b5wa4NABG3qzId+63SKZTXOK/OmrJHjh
	Ae0kmi+1HBk2iPN+7/8neUZUYi37Igdi7IpMewrD88sNBXQHibsF48dFFIdNH5jP7Htz7kHTq3a
	Ib8LC+arkC9G45VWcH5HYgXxuBNSNddLda83lXOUuPGSsPFYzUSo4Ow9NFiKdIjMzqAESdQX5Eb
	GRRnMJp9P4npaaL9h/lfd1RQrqV+qtNRUy140LiOvMaHwo/rG85bf6a8SwyPajSP3Ykm0wuf5De
	23W9vSGB2J4Kq2+laBeqH0XsW5L18TtnkSaUvOEvvV1Bpd74y/V6ZeMz/kDJsZD/XO8uu2D5xj+
	iBr0xJNm4BXVXKlJPeU44WbBJ7FJ4Xz/x5i+uXFLipHfC0bofPyjvnKhG5Zuzz9Jy3Tlg0OMT1x
	dujK5IpH2felD1k9VVutA6RJC/In9PfjBJMyTWZ/6gQIBPE/oO2MR5uGIy2HoZexQFncyO13Flf
	f8tGURn9NFVqTQpnZ6POkPRrxQVcQoPKeXmmM7+NJXYX9WwFwAYWwW9tiAo0SMrBnjaeGkB1puH
	B/TXpCywhw==
X-Received: by 2002:a17:907:868a:b0:c2e:2baa:a642 with SMTP id a640c23a62f3a-c4ca7a820acmr832014066b.30.1793622872158;
        Mon, 02 Nov 2026 04:34:32 -0800 (PST)
Received: from dev1.kernelcare.com ([2a01:4f8:172:1c85::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe4aa07sm396884866b.63.2026.11.02.04.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:34:30 -0800 (PST)
From: Andrey Misiurov <amisiurov@cloudlinux.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	luiz.dentz@gmail.com,
	luiz.von.dentz@intel.com,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	2122295973@qq.com,
	Andrey Misiurov <amisiurov@cloudlinux.com>
Subject: [PATCH 6.1.y] Bluetooth: ISO: drop unbalanced sock_put() in iso_conn_ready()
Date: Mon,  2 Nov 2026 13:34:18 +0100
Message-ID: <20261102123418.363320-1-amisiurov@cloudlinux.com>
X-Mailer: git-send-email 2.43.7
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

Commit 1702f12cf59a ("Bluetooth: ISO: fix use-after-free of listener
socket in iso_conn_ready"), the 6.1.y backport of upstream 560bef609fa5,
puts the listener when it is no longer listening. Upstream that put
balances the reference taken by iso_get_sock(). On 6.1.y
iso_get_sock_listen() takes no reference (it got one only in v6.8 with
fa224d0c094a), and no other exit of iso_conn_ready() puts the parent.

No race is needed to hit it: shutdown() of a bound socket sets
SOCK_ZAPPED and keeps BT_BOUND, so listen() still succeeds and the
listener stays BT_LISTEN with SOCK_ZAPPED. Every incoming connection
then takes the new branch, and the second one frees the listener while
it is still on iso_sk_list and attached to its file.

Drop the put.

Found while reviewing a backport of this fix; not reproduced at
runtime.

Fixes: 1702f12cf59a ("Bluetooth: ISO: fix use-after-free of listener socket in iso_conn_ready")
Signed-off-by: Andrey Misiurov <amisiurov@cloudlinux.com>
---
6.1.y only: 6.6.y and later have the reference-taking lookup.

The closed-listener race that 560bef609fa5 fixes does not free the
listener on 6.1.y: iso_sock_release() calls sock_orphan() before
iso_sock_kill(), which then returns early on SOCK_DEAD, so a released
ISO socket is never freed (fixed upstream by ce57442a3792 "Bluetooth:
ISO: fix leaking sk after socket release", not in 6.1.y). If that
commit is backported, iso_get_sock_listen() needs to take a reference
as upstream does.

 net/bluetooth/iso.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1536,7 +1536,6 @@ static void iso_conn_ready(struct iso_conn *conn)
 		if (parent->sk_state != BT_LISTEN ||
 		    sock_flag(parent, SOCK_ZAPPED)) {
 			release_sock(parent);
-			sock_put(parent);
 			return;
 		}

