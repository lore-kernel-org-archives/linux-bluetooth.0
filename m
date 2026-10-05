Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719F24D9561
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 20:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791230403; cv=none; b=ALqmEy1Ff47Jw5SxWgw494J+RzfJhrviK/O6CIdeWLYymjDoRqB2HUqlurM266MfzUPfIoX57jmLjTQh1zbLnkMF58uvKRgrLYuXx+8VvvOpHBQZ2ly3fXf1Zr5KiiuoDZhu4Y9JlSMPuce15G78Ra7JFB7ljSmnyYVYNBK8zEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791230403; c=relaxed/simple;
	bh=173lNItfpjMro4Gvtkkqy/SPRw/DA6J+B3UiFChl/Po=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqlSV+djYApsO8lddIYtIzwykvrw02b2fi7iy0kIZHrVE6Z+4T2aybbz4zr2yPip+jGcJLL8lKCw4FRZhho9bKmDKJS6AZUhyx+jkDnYxFY2L9ef9Xnvd4NHtnijP6wdB6pUyOrsYXCoAbV2YNPQwoHD6DJ1KUDVxYCq5OhiOig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgQ6pwEu; arc=none smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgQ6pwEu"
Received: by mail-vs2-f40.google.com with SMTP id ada2fe7eead31-7ac5b4011a4so1343676137.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 13:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791230401; x=1791835201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nbqgG7/uPM5UUmCmj1jybH+69pmIAI/9F5gKi5QPagc=;
        b=YgQ6pwEuTVMi7I5ODBO8QWUtxIdCvKTXoyZRNuuv1De5CzbNi2ekUtdtG4108ChiTf
         yXObLuE6WPGKAa/FxXY7kD2olDX+Tqus46UuRc6xavMUVxHwfocYvMqG4YzlzctGqpC7
         +7j9uAhntD6KbstaRe4pyKO33DOTOqXHWVewcP/m2pV4N5bNo9wpPitxFbwnZIFGfZJi
         VhSwS/qVgDAxr0MSOUrMyl8WX2cPkCxwE/fxrlOAI2u/Ee9JY3ScG8EeylweZdAWL23V
         a1XJqTjr5f6F4Mhz2KTmafOBywwOks8lIRoRBxnUjWtmsqgCp0BMcjdneA0LAhQzPQ7F
         55GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791230401; x=1791835201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nbqgG7/uPM5UUmCmj1jybH+69pmIAI/9F5gKi5QPagc=;
        b=2VB39t4rdjyq5v5TeXLxXeN69WZVCGmP0JtifQQGnOLztQlTWlmrXqOZ03feYHQZ8d
         DCZDmKoHoVhlZT0cb4JXWCs8z+8EccWIRkVI9S7R+/z5ouEm0YZt8kQHgHVKW/w59o53
         YGwkgUybDcS3cV2svMAtabYeUWYDa9Z8K2fp7rgA4Pvm6DyrCrSuU66/jR/TK4k7gVWN
         Xqe9WaShSaTeHEsRGvLN/NpxQf/qBzDgaRAScVMag9lTEu7g5Rm/4emNPxcrJbC+uGe/
         Qzvgt5u7fSf75TCLlYiEfZ4iTvXkZsEkf7lVdoD5BD0p33Z13Q/HoMD034rTWjasaMRi
         cUTg==
X-Gm-Message-State: AFq9FYLXRSYvV3gCBSekUtTUVajxCJftxcCv6FkBw/mOyXVBrT0vgPHo
	NTVxlklhreq+19C+a5jCmqQLfzPH/wjoxO7CxqyJHWIYfIWCsv0Cfkn6J3AQs1o5
X-Gm-Gg: AYBFou2WNrC9CpF/OY65wufn8leW/2ynx+PwXgyV3pqlW9mYWXQVxYxUcYB4NyH2Boi
	YMz0lPpYOyB1S7q/rpCnAHK9UEvAlNZ2WFu7MXKz1xdQMyMGcmjiHUehF14RRTbk8FOsd7WMZEu
	MLbOJm7Gq8Z52qFZGR/3hsh9+FNwS9piG6j5TjpE0pE59c7tMdBnXd8I4yUKkdeetez0VgzMf6B
	GvSWZ6G2jKfdBIADcRZFmUMiVROfnjbUKn9j+n3ouQfFwWoep1DnvUTZ98+6ks41Go+Uu5WPClg
	D0PgNQoln24zhuUu/9nVAtrmJV4/pa4XlIdM4nI3thSSMLXCLz/bmPVwKNb1LRgcNfKuPMH6sN5
	IsgVXUDEPTHS714JQac3jTKB4GQqksdXJv/QtzF2kZZdMU+cCRY8NqoRI/8nvVCu28VRNLEXOIG
	Qp+lk9ShZPyd85JmjGJwB7IEWAs3id2xbleNOtZfLz0/MnqrmtQ25lmE9PXyD/Ov41pJo0mcvEB
	7U3gjPWRmviouFGU0NGIb5KuP05O00FxkubgZQzwnR6v2OD6KlCCcIiz2Cy+ERf1aHimtGqBG4=
X-Received: by 2002:a05:6102:f9e:b0:7c3:3f26:8785 with SMTP id ada2fe7eead31-7c33f26bd2bmr2185600137.7.1791230401297;
        Mon, 05 Oct 2026 13:00:01 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7c0ffaeb6d0sm11197180137.6.2026.10.05.13.00.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:00:00 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/4] Bluetooth: MGMT: Fix leaking instance on Add Extended Advertising Parameters
Date: Mon,  5 Oct 2026 15:59:48 -0400
Message-ID: <20261005195948.3616794-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005195948.3616794-1-luiz.dentz@gmail.com>
References: <20261005195948.3616794-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If queueing the command fails the newly added instance is never removed,
so remove it as it is done when allocating the pending command fails,
but only if the instance has just been added rather than updated.

Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
Assisted-by: OpenCode:claude-opus-5.5
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 93872a5fc39c..34de73aaf90f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9361,14 +9361,15 @@ static int add_ext_adv_params(struct sock *sk, struct hci_dev *hdev,
 				       data, data_len);
 		if (!cmd) {
 			err = -ENOMEM;
-			hci_remove_adv_instance(hdev, cp->instance);
-			goto unlock;
+			goto remove;
 		}
 
 		err = hci_cmd_sync_queue(hdev, add_ext_adv_params_sync, cmd,
 					 add_ext_adv_params_complete);
-		if (err < 0)
+		if (err < 0) {
 			mgmt_pending_free(cmd);
+			goto remove;
+		}
 	} else {
 		rp.instance = cp->instance;
 		rp.tx_power = HCI_ADV_TX_POWER_NO_PREFERENCE;
@@ -9379,6 +9380,13 @@ static int add_ext_adv_params(struct sock *sk, struct hci_dev *hdev,
 					MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
 	}
 
+	goto unlock;
+
+remove:
+	/* Only remove the instance if it has just been added */
+	if (adv->pending)
+		hci_remove_adv_instance(hdev, cp->instance);
+
 unlock:
 	hci_dev_unlock(hdev);
 
-- 
2.55.0

