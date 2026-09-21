Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25E8501F2E
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790016585; cv=none; b=LKew7mQEvwxDGTL774r7B9POsT4gTmrElQB+10pEODXTHs93Ks9EBeE4Ta72d2NxLUHQ1nQd8tdwpxWxLGeQK/BKCaAwArZoio38Y17x2/xApGsiMNXE8rAidQFxvWABJTrKzjurkb46IPfeH6tSUSlgmqm/caNbguR5JchUh/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790016585; c=relaxed/simple;
	bh=134q4aKFWgoH1bQZHl9AfNC0aGNRNIz7ATzP6dmdw7g=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=iHe3xP985iN9ARaNEcBUm9WQB0RbC8zO/1OjSJW9llbdt+/yYl+PAPx40v9kUN8NNwlCu5TkLix8sWc/dcjb3AFH+ywChxz5/uG7McWjc5FAmZvfi+Qe+deAnvytldoXR7DDxzT9v7CQju8yO2ZMlkUvPPKJmREr3wqxT5aWM+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqsJYMIz; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqsJYMIz"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398a147688bso3461666a91.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 11:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790016583; x=1790621383; darn=vger.kernel.org;
        h=message-id:date:content-transfer-encoding:content-type:mime-version
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pHfUx0fBFDWTOucwTjvxZx9DnzRVb6yi77TYD1yp/sk=;
        b=CqsJYMIznOGsR10TfxHswecDnroR0aUhOab/zDCgOnoPq9SjGbh9iQMWpOD5Ng7X/E
         ZfkGaRQKR/E9uXvnS8T2KuCUOWUSdD2CXRN/IK3GVt+RGIux8ts9Y9ASOawbTcQLvF+8
         PHMOHYq1fW/YRLWViIFzzoFgtC0cvpkCCgsB2J40QAtJ04grf6bmC/wRhU6SX9dAb0rO
         Pi85q1dDwhNvWgxd3BG6nBqPBatHZHVzmJ9POX8EHpj9dQpvjdhqWu1hOWUIim8IlQ21
         11jy4WGQRzhq6jLxY+QkAni6CVROHXbcD+luOoT6NvzJfo29ep1WME5aLlfYoINuMnbB
         uOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790016583; x=1790621383;
        h=message-id:date:content-transfer-encoding:content-type:mime-version
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pHfUx0fBFDWTOucwTjvxZx9DnzRVb6yi77TYD1yp/sk=;
        b=mJqOWMFKrAe4tcl2s1L0vKkIV23alel9slZY8m8bIOvp8HXbIVLZoq3GKVCefRJ/yK
         Yjpya+1XsPomZF6y0kHoAZ4IcDn8wSEd3Nufb7JR5J34s8B/2J4l9FBm1U8B8GRnb5cW
         woVr22oVAYZsVlHSI44Uq6leVT0HWXuhQwkiFIdOdxMO+VJQJoQciZ/wxRLn4P/0sVXR
         //9+fxuXDuaswIXvemNCV0VZNL9WoJtyMnHmYAlvVdiL+kJtB+FuOoj5T8a5aJvaLDKy
         lQa3NMMkJUrAa7oJsL+cQJojnBGwCWPslOy1kH2/KVWJIhqZno8AcUVKJLWtZW7IWxm9
         WfrQ==
X-Gm-Message-State: AFuF++nlzgxau6miSXaK272DWi5WT4VWV75L5iMCaLl5E2rCrbFNByc6
	h0q2jrOlF7t5+s1ThqQg4fxv7E2w1Ei/VvZi/BEsChGiExPlqA7mMwwK
X-Gm-Gg: AYBFou3O+/439omyFdc/jUKFcIVy3pShs3L0n4F4jV5tsHAYghvEBI2B00dosbiZBY6
	qcDXSKsrQIdoUU1KsD91kmpr+riLhDlEfguM4q3Z4xYUs47ZxbI5qhYWI+ZUI3RHTiQqpNl0aZe
	9hnVb0nFw2cnSZQtPIzdNBFLQbaySBalZSgXnbnNdFNzyja4aS0EwBkmKdI8CXIgNCPy71UFMR4
	xTO8UA0fzO29MHeL+IKV1NczPE7uS/Gm+vbS+92xhYFgLukipbcMzIVB/lgRMwB+KYMQiPaU9EM
	JYmIT4vru950ZidxIpxHmDhsf0tWW4VRsFNCudxpAbvVAgUuUSXDIZugrJTUpe72NKk2ZiTF4dI
	tLoSGkDupvmHCOYAVr1/EsSQbTqCa1nUVegGFWGdvObhU0cHgel8VaxyERAj9Huv82Veir8POoC
	SRXtzDZDBfylOBj85OnQtLiYGh5GyUn0Of6vSXN8BcUfvcxU/1BgD1wQN8d5wyR0GtVczAr/OIA
	YA2hxmrSdP56fuC2cFjHrQ=
X-Received: by 2002:a17:90b:164a:b0:39e:4d7b:b247 with SMTP id 98e67ed59e1d1-39e54ea66cbmr18001611a91.19.1790016582782;
        Mon, 21 Sep 2026 11:49:42 -0700 (PDT)
Received: from SANGHOON. ([1.220.132.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e52d5adc1sm8579800a91.0.2026.09.21.11.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:49:40 -0700 (PDT)
From: Sang-Hoon Choi <csh0052@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
    Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
    Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH] Bluetooth: hci_core: free the HCI ID if naming fails
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Sep 2026 03:49:28 +0900
Message-ID: <179001656830.91284.12508704070539939097.idr-bug-55@gmail.com>

hci_register_dev() allocates an ID before calling dev_set_name().
If naming fails, it returns without releasing that ID. The device has
not been registered and hdev->id has not been assigned, so the normal
unregister path cannot release it.

Free the allocated ID before returning the naming error.

Fixes: dcda165706b9 ("Bluetooth: hci_core: Fix build warnings")
Reported-by: Changyul Lee <lcy8047@gmail.com>
Assisted-by: LLM
Signed-off-by: Sang-Hoon Choi <csh0052@gmail.com>
---
Found during source review at mainline
5dd1818b15d98d4a20806cd00b1b40320b06004f. The affected source is unchanged
at f0100363d8c374bd8e9ea7c9ba02744f0b802ca4.

The modified hci_core.o compiled with x86 allmodconfig and W=1.
I have not exercised the dev_set_name() failure path at runtime.

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d183efaf9..bbe391525 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2557,8 +2557,10 @@ int hci_register_dev(struct hci_dev *hdev)
 		return id;
 
 	error = dev_set_name(&hdev->dev, "hci%u", id);
-	if (error)
+	if (error) {
+		ida_free(&hci_index_ida, id);
 		return error;
+	}
 
 	hdev->name = dev_name(&hdev->dev);
 	hdev->id = id;
