Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBB61D0940
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Oct 2024 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883644; cv=none; b=j2d7t+js5+B82LXzVi8DEe8M9qiewXf+JFI1zQHb7sihapzPMijLAi7925LcXyGyhPhOWqXadfQYf+FlS8lzNNbvWpvXVTUCp7FfWHdgpiNDwWFlX5hBFk2OuC0aMHpj++r+IcQ20DdCYMZrpkKFAGvgDorSP/e2Xa5MDiXXGCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883644; c=relaxed/simple;
	bh=I/DmEgor91qQ8k0FOwY3AxszqV9xi86BcDyrwsxXZSA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtDrASV9bYF0zDjJxja55ByW1ZKKXgyqYF5xT6H8LRQapz6wa+KQ+cUlA06gfD54RKr5VzZukrf+aVS8EwMpyxEsuMjnm8W3zlk7iFO5bn0LaUVHM6PgmRPXGUCpj8+K0bu0kch9VNGsFlwrVszWRFKmhBrJu6vgNKWQsXP7aFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHQjhogW; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHQjhogW"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-509fc9d2074so1198117e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Oct 2024 08:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727883641; x=1728488441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kX7FPSHVAkZb51kCiSp6DOpib9SVJciWWLswedmah7Y=;
        b=aHQjhogWDnYbxi2PXMZKseNkm3O3SSp7o7wp2YFDu0SjdOkpeh+z5637tYg3oLeGXj
         MnTAqJWCOj2lW3w4sUpC1sP8kUlFShlPNJM83iWbFp8nPUUYw9UlqV12qNc/EhW6a6LH
         hcqfUwM+MW3ufnsplTLF1i5z59VkrZE6me88PutlBhMku7DWlGfGeHV3BaOTW64AXvOd
         Yk1TdZvwp9Zfa4sHfa6yygR/8LpFnliexPuPsnmyuvLp2z9FNSIGxPA92ZNRo/yX9ChF
         0iPP8HQHGjMwFGRf+K7FwBPO0qkp/QZxZI0zanL/MCUDDeKoCtLnLArslEQI5yUKs/hY
         SoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727883641; x=1728488441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kX7FPSHVAkZb51kCiSp6DOpib9SVJciWWLswedmah7Y=;
        b=iGtSwNhmHV02FI5azN6j7miGmwm9jofmhoh9Bj7Oo0kG11FpIqlQt3BfdHht8jF931
         8Wt953QWUPRlMjw+LPj0xSTuitZwj/nMGFLAcy+JJjwQPKFWEwcBxuDz6Zg7ktgXo9jE
         wOXofVW8cKiQQLvZsc8XzVZ8gw5EW7SGdjhQfEqq8c6rm/3mqbdvPoyeIA5Iq0c7JRjZ
         g0uzpWXQr/+bwXUU1LBoGLQ/NF/Sp6ChDDpUwf4mDC7whGgzjmhOyFdY1bzVYugl0n5j
         HqysSvIquaLteH6Dktnm5i4j8eHWAssDzCYGMkluHS+MpawdAmrKOABJn5mGIsdIz5rO
         +Yog==
X-Gm-Message-State: AOJu0YxR1QtUppY14UpCNKcoK7IRCgJsDDQC+GO0kDFtPq6tjonx/a7d
	9HlQPz/BUNjbAuYa96AoZlKzKuxpWTWI+VhVD/VumJX+cJ6BLFGcJl3rLA==
X-Google-Smtp-Source: AGHT+IFgpO13eotuS57n2y3fZW1i6KBvjTbEd+IWgiUok4wlkguQu1Ai+sO6cXkr41NnjRM6ktpL4g==
X-Received: by 2002:a05:6122:c99:b0:4f5:abe4:50e2 with SMTP id 71dfb90a1353d-50c58140156mr3166584e0c.6.1727883641202;
        Wed, 02 Oct 2024 08:40:41 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50ac01cb31fsm708464e0c.14.2024.10.02.08.40.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 08:40:39 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: SCO: Use disable_delayed_work_sync
Date: Wed,  2 Oct 2024 11:40:34 -0400
Message-ID: <20241002154034.3359675-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241002154034.3359675-1-luiz.dentz@gmail.com>
References: <20241002154034.3359675-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of disable_delayed_work_sync instead
cancel_delayed_work_sync as it not only cancel the ongoing work but also
disables new submit which is disarable since the object holding the work
is about to be freed.

In addition to it remove call to sco_sock_set_timer on __sco_sock_close
since at that point it is useless to set a timer as the sk will be freed
there is nothing to be done in sco_sock_timeout.

Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with delayed_work")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/sco.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index a5ac160c592e..8dfb53dabbd7 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -208,7 +208,7 @@ static void sco_conn_del(struct hci_conn *hcon, int err)
 	}
 
 	/* Ensure no more work items will run before freeing conn. */
-	cancel_delayed_work_sync(&conn->timeout_work);
+	disable_delayed_work_sync(&conn->timeout_work);
 
 	hcon->sco_data = NULL;
 	kfree(conn);
@@ -444,7 +444,6 @@ static void __sco_sock_close(struct sock *sk)
 	case BT_CONFIG:
 		if (sco_pi(sk)->conn->hcon) {
 			sk->sk_state = BT_DISCONN;
-			sco_sock_set_timer(sk, SCO_DISCONN_TIMEOUT);
 			sco_conn_lock(sco_pi(sk)->conn);
 			hci_conn_drop(sco_pi(sk)->conn->hcon);
 			sco_pi(sk)->conn->hcon = NULL;
-- 
2.46.1

