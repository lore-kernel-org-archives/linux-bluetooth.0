Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0306A2AE6D;
	Sun,  8 Jun 2025 22:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749421619; cv=none; b=M36Nhww2geSTDyGKSBTuNmOi/mdKnIeK/hKlkQXDe9YbQp/9DJMx7XwcAhsSSWEC1DkNkyVToL+qjtw5PwVZrNxRiJ/mlR8UUjmnEetcfkredLfzCQ9aH4CnMpip5duA6thVipghKDDhmNkoSsOxbvBsWwNqdZ3yCWoxFjA7C6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749421619; c=relaxed/simple;
	bh=99QltkBjwJVXDBwMloUgVZDk3bb9oijFCuYEbw9jPM4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=XySGKja4ggek6BEebczNZds4E65TH5LdTYbZfhKq1hRe0NSg47CQeCm52oc4CHdI90zIveNxgFCF8N9aQkKWLG80XaFdXMojHKAhM6NfxmczsZNgtlyemvzmT4ZtwcVDPdzgjLywmxNvUJUFrKgcGxRHchiZMHeOjYhZSSAULUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wuw3+Qi2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wuw3+Qi2"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234b9dfb842so32659615ad.1;
        Sun, 08 Jun 2025 15:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749421617; x=1750026417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qcWELW+CYyK2RjYr28SkIkrpdrwGMN7jGRdM3XtdY8=;
        b=Wuw3+Qi2QG0+lp2mnLPbkIipv4ngVN01HKxsUq29x8H+i8aAy4jQFoGSqYgVc5BFf0
         VzoLnWmSL7SRAOgLbXQ4rifad9L/yJ7pl6ntA2/dqYN9CDFS30/xBdKFNkGLPGCAS3MV
         +qQvAjksTTzSvsi5PMRLbuQixKew2ttuKrxX2v1gMYgZTSxtqqOMAhfkcg0Hu8o37hsT
         OQWFF3Lkx/gzzeLSJ9sTPSglZcTqGjnAtDGuUi4xQ2YMdV2XEi4m9ZuGbLtsgK1NrQo2
         y9OIKGo6I+/joofFCOBdkvLwWLKq1ia6EWbehQFX2C+tsbhVOolKovcx6TAvqma3qmx5
         ESiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749421617; x=1750026417;
        h=content-transfer-encoding:in-reply-to:content-language:from:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/qcWELW+CYyK2RjYr28SkIkrpdrwGMN7jGRdM3XtdY8=;
        b=kf4+jdQdlLE1MHGjXXXGtDQ3d89w1Z3Gb/5U9thUxZHvHAChXizyYDSZamExXyIfGi
         UwwZfOikSs70nc1Z5VpfRQ2nYx9BWi78bP5vMX9IaI9YfXHQZ0n4rL2z44C+2VRQhZff
         RlQx5w9jfnvuLDsfdJM6rxQEDpsJs9FeX5IWGmZbxs3PFtn4M2wcArz9K/osDq6vhCKT
         0opBUJe1oGRzHaC/90Z3lO9vZLVGslzxTjRbsY2/yOMD31ldnOrI7RzcbEI2DEJiM+tL
         W5JdUP05kzDm6WRR1UFZjslqk6K7kZ4qKRqPIy3jZkBBsFSKT+6xV0xKdrw+jhRMi/uI
         Kchg==
X-Forwarded-Encrypted: i=1; AJvYcCWb6oW1mZ/yJ+5qGdjf+eJ3a1ikBwNu0/F/84diGg3s1iD2sA0wqXSMdtApFfGHp/wZ4/RD92FlZ+QReyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7za/D+yXbGzPEnHL+NBHBslwqovDYt8Pb7J+fZr6k8XFMiejY
	0EFdSDlGwFCfLxTPjHLCs7ExNBX2nDkreKL9HLYJ4Td5GX6zEWfYXxlA
X-Gm-Gg: ASbGncs5OMbKV9amEo3fuzE2qMZq/a7DHfrKrKwXCfY/wCFexX9Gy2fsEh3EfxuSaZE
	R+XUI8rCUW4DxP+haoZ4O3mHbvlWFJMNok+/x+D2yP4JYTn7WzHvuD4BhNMuEMRng2dZy2/xpsk
	2Ql1ZvH0IFLNnHyrD9NGDlX/4AMkaNltS7rzcTbZqkMOk3DGw0x2XCYlljEhS4lPrdAdrjqb3XL
	IzQbrF82Gfgbw5RpH3MtSYYdcoQHc/autmAwWozmfymKjUiFfTezFEeuN3Qypa58s3XOc0Vg6u4
	FcBN3eli7OHV3IRCr9cLpr+W929bcdgGYg2pakXDxgSKwNDF2xFIYlhHNSpJaYFt9vjtHBXtM5g
	VIlcXAG/jFTg/G1DEnjEGY08GRzVGN+w9ww==
X-Google-Smtp-Source: AGHT+IE+qGmbUaF9BZZRMSPn7PaB3LkmMbyqRFfQJtczQOcnCnuz+sdxlC6eQOGrRzXCYepl6Xyzew==
X-Received: by 2002:a17:902:db03:b0:234:98eb:8eda with SMTP id d9443c01a7336-23601d18766mr149456295ad.28.1749421617154;
        Sun, 08 Jun 2025 15:26:57 -0700 (PDT)
Received: from ?IPV6:2601:646:a000:5fc0:ad4b:6a54:7b3f:eed4? ([2601:646:a000:5fc0:ad4b:6a54:7b3f:eed4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030780ffsm43064475ad.40.2025.06.08.15.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jun 2025 15:26:56 -0700 (PDT)
Message-ID: <0c4d3721-db0d-433a-93c5-1d3247ba41b1@gmail.com>
Date: Sun, 8 Jun 2025 18:26:54 -0400
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <67eaa688.050a0220.1547ec.014a.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: vmalloc-out-of-bounds Read in
 hci_devcd_dump
From: Ivan Pravdin <ipravdin.official@gmail.com>
Content-Language: en-US
In-Reply-To: <67eaa688.050a0220.1547ec.014a.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 59f4d7bdffdc..493d704c0dfb 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -661,6 +661,8 @@ static int vhci_release(struct inode *inode, struct file *file)
 
 	hdev = data->hdev;
 
+	debugfs_remove_recursive(hdev->debugfs);
+
 	if (hdev) {
 		hci_unregister_dev(hdev);
 		hci_free_dev(hdev);
diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
index 819eacb38762..1232c9a94f95 100644
--- a/net/bluetooth/coredump.c
+++ b/net/bluetooth/coredump.c
@@ -243,6 +243,7 @@ static void hci_devcd_handle_pkt_pattern(struct hci_dev *hdev,
 static void hci_devcd_dump(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
+	char *coredump;
 	u32 size;
 
 	bt_dev_dbg(hdev, "state %d", hdev->dump.state);
@@ -250,7 +251,11 @@ static void hci_devcd_dump(struct hci_dev *hdev)
 	size = hdev->dump.tail - hdev->dump.head;
 
 	/* Emit a devcoredump with the available data */
-	dev_coredumpv(&hdev->dev, hdev->dump.head, size, GFP_KERNEL);
+	coredump = vmalloc(size);
+	if (coredump) {
+		memcpy(coredump, hdev->dump.head, size);
+		dev_coredumpv(&hdev->dev, coredump, size, GFP_KERNEL);
+	}
 
 	/* Send a copy to monitor as a diagnostic packet */
 	skb = bt_skb_alloc(size, GFP_ATOMIC);

Ivan Pravdin

