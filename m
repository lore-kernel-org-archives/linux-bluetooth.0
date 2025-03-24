Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAC213C3F6
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823680; cv=none; b=iU3sN0AZjn48N3MZMYNQuvhMSjoGqZ3n7rEd0aoxCQHEvsZWjUT0WKtrZvnxPLn1D+oUUk+Mz38IB9u/Ci0cZ9OG4mdzSOD/JLN0uajbWFHRoMUK/3bNi8dAr9cXVROGedhQCLnD4QiWRO3YawxWm+3bZBW3Fid6AbLcWh5QRMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823680; c=relaxed/simple;
	bh=USJvLpemHmBWdpM+Yu/IlUrbuNGcOT0su0cG3RU6qOA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aWOIlwo2cUBGmjFqxIYZm9krgIVP42OQdMQ/TYCE9n5gAm5/2G9wmfAx4J/j9WP5UbWIx6mYcxWoWv8PMl9Y/C+6GBY260GkVAJZ2bNo5EmKdK+1QWZl34ns4e2SQyGgp//t6d4Lh5UKMu6kzSL83F1TqAwb092/7va1Z/456tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ny2gyLHZ; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ny2gyLHZ"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86715793b1fso1858644241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 06:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742823677; x=1743428477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sY3VK+k9fQlOzDn+gms0VEXawpB0JCEdap4mn3LAEDA=;
        b=Ny2gyLHZMI5Uzd09dOcxKY84rsBbfyEmNUVZVsLLsl/8jl7mly4cCDcO5VDksAYBJ3
         l4B4yeke0a1F89oRc/sI6CcYAWAMwRbedTWqv5mr8eKMqvRpADcE/o2NY6nkN3GItjrt
         8eBjKrfT7iT4BiSdz2TzVdyE6XSEtUlqbcfn/JZCzxfNX9KJi0+vSAUsZzjVZ8Wez17h
         O/u9vXAOcMdp/Tq6qL/Q6+odrqiAn1+u4a3nDgYAt+wgeAUo2CsFf3rXse10QVGxdYKr
         mz9vEZw/UuWv0b58kfflHQWeEph6DD5yH7+3bXSwHy0dQxBMGmXntXKvdvhGjOhPohbR
         mTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742823677; x=1743428477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sY3VK+k9fQlOzDn+gms0VEXawpB0JCEdap4mn3LAEDA=;
        b=jnb9TB8M8Ms5S/ZLDVuJoiWxMj+Fhi7uirTkHbYNu3d9DK2AvmjlpR67nxN3H5jGx/
         pIotjJgMl9n2g0hmgWvnyt2kjggXiCwZED8afNdI2CddFTD18nSq6lsWp2gxUUhVp8S9
         ym9gl6gnQ0ScVjS1BFU/dHurAi50ecu3AoMNvyp8JdVKeDKudPSdssnuDkjkw2x/GKvk
         pebmyLh4fSAYSfz7LVCkY7ZuZFM9N4HVxj9qtjM1d+MNOxt2V1rQNiBUeAlTMFAmUQd6
         om6pl+iL6r3gQzhcSMb8l2pxiCQBSiwjK6TVZNa+UufLEOeA5o8Z2vOtdwYRFL+qtcgh
         T24A==
X-Gm-Message-State: AOJu0YzfkIftdA987QLxau3Zbc2oxJR16eiw7X5LRk7a70nFpD17rLPZ
	XfgUcr6qm13L6TmbLFUhG4FkDMhI3W0RaZ47w16qKFkwkJEOdZ4bQ6kFDNPm
X-Gm-Gg: ASbGnct/qSah5oeKRb0js9LRix9xl73Cl/YCchCopsbC/Zq8mQOEKwiYLrKHaPVpDCZ
	Rem8HdhGfO2zRT58XZxnt03Q2CpVMP1nKO3Gy+xhvLn/+glue3+e675S/kNTsYuPiOosGwmuEwd
	mvTh1VD9dbG9EmgFhkeEZ2f9zs2x1bl22UgC4j2nNq3hoAWb2HuQxoBbuTteaBxrDGr9jxW4V98
	dQpzHydoWSvwZlIJYT9ZLq83MUXfBQcoMqLsuMblt0HIhFlmKN0dcGz/8HpTOM4iD6VjTgR6HIP
	NsyS5w1Im+Sw/+amSnp0Sq1r9EttKwhbQCxfgyM/ju0RHIyWPT6a50S87YtECmzbIOiDA5ZGpVP
	ywXz+3Hc6mkf9Bhgl9OEW0Sei
X-Google-Smtp-Source: AGHT+IH+D57YaHZUhI19P88+03qQcnifVe8bSHefSkjtwfdY4u+sh+vZ8ku3ugnqvLBsFMByxd9/qQ==
X-Received: by 2002:a05:6102:3e14:b0:4c3:6393:8448 with SMTP id ada2fe7eead31-4c50d49588amr9022224137.1.1742823676910;
        Mon, 24 Mar 2025 06:41:16 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c50bc11d7asm1564850137.12.2025.03.24.06.41.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 06:41:15 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/5] mgmt-api: Add missing Device Flag
Date: Mon, 24 Mar 2025 09:41:08 -0400
Message-ID: <20250324134112.2108216-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the missing Device Flag - Address Resolution = bit(2)
---
 doc/mgmt-api.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index b4a5776574f7..3181607d94fa 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3429,6 +3429,7 @@ Get Device Flags Command
 
 		0	Remote Wakeup enabled
 		1	Device Privacy Mode enabled
+		2	Address Resolution enabled
 
 	This command generates a Command Complete event on success
 	or a Command Status event on failure.
-- 
2.48.1

