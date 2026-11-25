Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620158;
	b=GpQW/Fs6LNGtMfduRx4zFhmHTC1d3mhlgPzMZtjdmlfh6pmAXhZa0Uklo/EBKGmJqpdN
	 uiG2un0Ec9dvrNfOpBAuUWlKL0tGirzxsieBwj4SGHbkNgcALus3FS3z+NJd6AvP0LcIc
	 UuPKrL1JrXF36kA1JW0C1Du3x0eBgUOF6T7XZxXWUftfUpOX2tVXoKzLncYMfbPPJmYHk
	 HnmAGAWx9mDSqkA7eeS2zLhd0x/Of7oohRFdQJp0oA9jGgueyXXiCQ3YevkGfWiYDidxP
	 3f7VOjiYvWthIDb51Z80CXz33FsEVJSjhObIyjnR3oQPq0CzTYPa2n3z6hPSms/DQQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bEF8M/s3yAdvW6UfQALPsy2Yfd220r/9bf/yWk6z0O8=;
	b=jtVcihpKQypubsFkiYopZNe2DYBIZAjiUfGf07MHccu+qW97iyDMYAb774eV+BD+ACIy
	 CIml24ms4u2w5bakHRrt/fWu3R0frmV8MZZPHOMRLRe1cswwYiuL4BBazOgMKwMnpcVEG
	 YYwV0Y/bW+59Ys1Yluhb/TiQK7fL0EGfTbW8AalQkXSDA7RJiCS7+emrAnwbDzpTbF1kt
	 h/9h4rPUdlETazdNpA1FUIYLMKLrYL1lhSzBDqdY3zUsAVU+9yQw744MDc89K/zDjjlcN
	 A7/n5iZlDipXT5C7YTFzrXBDvbSzfYUPihxi7xaOWpO/UFRtknqfVWiBHSkQzG0No1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ShO+44dG;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6636B606A32C
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 15:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6636B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ShO+44dG
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b904d10882so2447929b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 07:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795620158; x=1796224958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bEF8M/s3yAdvW6UfQALPsy2Yfd220r/9bf/yWk6z0O8=;
        b=ShO+44dG0IqJ9GlcQQUQyr5sqsbBZOqrweihS+Lubx454FRXo6ifAMN052TN+6RZkQ
         C/iT2Bkw3SkKdCJSOog+BFVNnWi1PWrKxx88XWByDjB1iZWloDF2DIBuLRWZyqaomLsQ
         gXyc15GKvu1cZuxd89Mqz8oi5C8JW39qsjH6LmuvQsQ4kXMF6Y9y6snP7UgbrY8ZIrQM
         Lx48RmPVjH1c6FORxuOe7zV+55jEL4a6WHAUP/QcY5aKjIEZClaHfp3pIaJz9W5ijhJj
         sGtancB+OMFFChas8fYlEz5E/UEqa1uqpQ+4aoCRHqgXLXRpvpfyPybA7lNbm0CrbsXe
         Fw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620158; x=1796224958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bEF8M/s3yAdvW6UfQALPsy2Yfd220r/9bf/yWk6z0O8=;
        b=GUCUCV9yYZpr+OmyD6zGJKEKwhKcgxjcgUOLbwyrhoCNUG7S3Tobq0e5dHkiwZoeZH
         PXA3cyshIuWqCPszRdJ1yRZO74rHgj4BsZTnclNBt35RWsyy79RAwVNZMwCz5Y3ciMC5
         FtUOwAW9rAU5k3Iy7+Y4j8gmLK7sxMgR7cjyQY50N7QZ2Rnv1Lu+rgAPBL8XUGGKn9wD
         sgZIYMoluJw+g+HCq4sdpmZHDeCUPp8/Pr9u0V3NvdgZ0adJEL6RwYz4rTr/h9Zq6nw/
         RpH5zCdCo/cdGw0EdbDoecckRg6ZTy+Gux730gx8X5bUFmeALm4PO4UBOIPuRJ/zb3tL
         uZkg==
X-Gm-Message-State: APuU4Z9WibvN+Z+91itSyjyPlNsIxuCsJO7UozY4fPHr1nSVmqW6hW1d
	9OFGY1zpAl60kX270sXh3q3jrtpwOMh2TLb0qHECtX+URxgEdj0w4EV2
X-Gm-Gg: AZFdTZdsMUxVtr2GWeO6gF4TD9FTDDdQcLkpMVwJjrUBlMw7A0XZMp+Bv7E5s5K2QOt
	8Cf6ktlxpp0WLmdtiEllLQP/H4m0U5UP0usaThlHlwKf8kzuU2UuLyuA4dUn51xp3hfzQA/yVjb
	m/Lb9oaghkVhwRLAvPmazmFUK8/IPs9W2adxtm6GTrOh6lLwIXU/ntrqvnMQ+/PRlC19UkvphOK
	4/MY9Bs4hYbUkTRVVKZ/LsDHULvcXGKSHApV8FSjnZBaFqiFFmkzd/j3SEl/8m1D3vZ+HRENtb7
	IKATWjHu7LdS3aCl/NMX+c2RU01hMaSm81bEHeCUlDgjsxorGKHSF8ktfIG/EqsgQsc3YgJcer9
	+Cz1Ol/kwLCsEXPHunZPErEPUReG7T0Mt4c1ir0XPnVORqAZcfc2QrnSAOiQKK3syQDWrqxTfHo
	DSijGctYMAl5eSsy/oKorL8CmElg+hF3wnyva/3vX5ViqrB/YLQIP71mIPhpXnB2VVLJp/V7JTj
	uoexSd1m+7ayyebankqwB45Dit7HCrXMraFGiNDXB5o6q9Gf9Xcz9mYvadLBrW/XS+HmM95w5dr
	zNp6fLyftKf4RC3zhxt4GN7O
X-Received: by 2002:a05:6a00:4b0c:b0:89d:5a80:5256 with SMTP id d2e1a72fcca58-8c87bdb6bc8mr17944929b3a.9.1795620157634;
        Wed, 25 Nov 2026 07:22:37 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077a058sm9221775b3a.8.2026.11.25.07.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:22:37 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 2/2] Bluetooth: RFCOMM: Close DLC on TTY registration failure
Date: Wed, 25 Nov 2026 23:22:18 +0800
Message-Id: <pm-bluetooth-objects-candidate-0218-followup-v2-88edfec8c72ed860e626-2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0218-followup-v2-88edfec8c72ed860e626-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0218-followup-v2-88edfec8c72ed860e626-0@gmail.com>
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

The TTY takes ownership of the DLC before tty_port_register_device().
If registration fails, dropping the port references detaches the device
but leaves the DLC open. In the reuse case the original socket is
already BT_CLOSED, so it will not close the DLC on release.

Start DLC teardown while the registration reference still pins the
port and its DLC. Purge any unconsumed receive data when the port is
finally destroyed, after detaching the device as the DLC owner.

Commit 77bc0f253ff9f ("Bluetooth: RFCOMM: serialize RFCOMM_CONNINFO
 dlc->session dereference") moved session reads under rfcomm_mutex.
The handoff therefore no longer needs to wait on the socket lock for
RFCOMM_CONNINFO. Use WRITE_ONCE() to publish BT_CLOSED. The DLC lock
continues to serialize that update with the old socket state callback.

Fixes: 56bc551ef79c ("Bluetooth: RFCOMM: Close the socket before transferring its DLC")
Link: https://lkml.iu.edu/hypermail/linux/kernel/2611.2/24606.html
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
This patch was written with assistance from Codex (OpenAI).

 net/bluetooth/rfcomm/tty.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 745cf1e4bb2c3..43a03837e371b 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -96,6 +96,7 @@ static void rfcomm_dev_destruct(struct tty_port *port)
 	list_del(&dev->list);
 	mutex_unlock(&rfcomm_dev_lock);
 
+	skb_queue_purge(&dev->pending);
 	kfree(dev);
 
 	/* It's safe to call module_put() here because socket still
@@ -293,12 +294,8 @@ static struct rfcomm_dev *__rfcomm_dev_add(struct rfcomm_dev_req *req,
 			atomic_sub(skb->len, &sk->sk_rmem_alloc);
 		}
 
-		/* Finish RFCOMM_CONNINFO before replacing the callback
-		 * which serializes session teardown with the socket.
-		 */
-		lock_sock(sk);
-		sk->sk_state = BT_CLOSED;
-		release_sock(sk);
+		/* Serialize with the DLC state callback. */
+		WRITE_ONCE(sk->sk_state, BT_CLOSED);
 	}
 
 	dlc->data_ready   = rfcomm_dev_data_ready;
@@ -347,6 +344,8 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 			dev->id, NULL);
 	if (IS_ERR(tty)) {
 		err = PTR_ERR(tty);
+		/* Close the DLC while the port still pins it. */
+		rfcomm_dlc_close(dlc, 0);
 		if (!test_and_set_bit(RFCOMM_TTY_OWNED, &dev->status))
 			tty_port_put(&dev->port); /* Drop the initial reference. */
 		tty_port_put(&dev->port); /* Drop the registration reference. */
