Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9532557C
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368376; cv=none; b=M18I9MDAwBar71qv8RNBY53nSA58X7WfMokxAwKzIqfOv2LV/TO5e0cbwqyAG250obXIanJN6EnptEBSMzH/Bk5MNyJYm7QdNRQ0OVcE+ttau7Pax4S66LYJ+pr+6BDbMiPrT7WLLemXEod8fYcxrDOV7XcgJvLJX/eMtk/lESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368376; c=relaxed/simple;
	bh=JYH+lQmcYlhd0HJTX7ATIrNPwCFIMRx/Vb8zPfOVevQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cF94yE0IxqpuhRMT0N57mUuGRhl5/dlykr2MwuIZs3KS47YqRoXZyS2Bp3X8XmLX8l6oGAGSrzCYxCOknSpy3/Dt+9Pyn8DUpuGuvwuz685lbXppU1lUJKKctTJ3y3jkIHCTUmhsoyHQHLkGymMORQ/t3ppX1tXdZtj05o3WiWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXVh3otT; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXVh3otT"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so995921166b.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 05:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739368372; x=1739973172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80VizGpb4sfwA3diabh5+C6N3XovCJ2VIUH3URVV6Og=;
        b=IXVh3otT9zNE5o7cKE2gY1eTiR9+CuQldh8rQlyZ9ea9tiSPdq4+L53Z6L4JzWRPn9
         Np2hUOO93iODvQ30+PyevrGdpLptijbIHhFkTyzeO/mlOQW3/W9VnedVpr9VJeV03EIU
         bV3aHjM2YSdt/2i6U5jW4G0rYu6YqvyKfaJAaqkrWEuNn3ufZjPqpxnmQ8Yc/3cH7z7K
         JKc0QQDgBh5SkQLsp8UWxPWRUt9USgJyvqDjUDfk3RJ7afHm1+iBd8iqFM68ZoNfCt+q
         EbOvHi6VnldtvuUrDxzNiMjxMfb/SVA3I2BEsO5LG0Z5GxffbYQIpTP3uOfASxbRhUv0
         N3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739368372; x=1739973172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80VizGpb4sfwA3diabh5+C6N3XovCJ2VIUH3URVV6Og=;
        b=GNKCR5VzVYNEaCovgOfl1a2uJ4r10AirPm3rBgOD5n/k8MG5dLdGMfxyWZkaJRKLl7
         /RQ9PAc1NakLnfjjgXQ/6QhS6iKcdS77UtbHMsGwzcHcQhY9lW1GeaS8HafJdPnlQqfE
         z/iPkTE2y8PfxQbSQs+8MeNZnYdS7O+KQXudtQfZoi4WpLEn6d6tkqP0zonTG+o4ejeX
         WNBq/0WhJ0Jw1D/RdfyWOHyfnZ1F6UkamUTSnint/HnawjQsqaOqkn/SUbSmbhv0DdCC
         D6oSXKXvKGVZEcy7sB4gBZZM4DeBOQmIrz+Im8AgDS5zHcOyH2JBRzJcJdbqxJLLCCSj
         04dA==
X-Gm-Message-State: AOJu0YzKqYQYVZhBcahGKIjQE0WMDZkRm+1/PamVkE4shvvb2YZ8HJwZ
	zhTeqEqhTzN4JV7gHCp81CzVhfM8S6kAyYR59op6bwzVxvwK3ruSgjEiDkmL
X-Gm-Gg: ASbGncuQTKT6cZ2Tk9QEugfg2hauFHGggWI2EVyF8T252xwBIQi7stOEvwnqD3C47uS
	RhTh+wuV7ZQbI70hwWkA0X97OCEfYa/ehBIq537Mh1mjElrOTilCBU6E0Re4ZewpywZauTv4QT+
	+ATKXqtANzjIe0Ix+NKN8Wiu2alxdXPvpnxYfAl6fAJdUgRNkx2T7iq8C0lh9By2ZdW7ype6eIQ
	zwgaIfRW3dKrjAI1XNRy+btr+mm8DZRT6f00V5VeCrLBIR6ZnZTcA8N8Ekqyvyl5VUvOvJ57q4x
	s20TcUwJ6JcIm89vki6bfO/AJQnH4gxl1PSR9rMVcYc9gVIEz29PaTgn8+s5LdtqfEhwGCrZCYM
	/7Q9IqLpjqiI=
X-Google-Smtp-Source: AGHT+IHL3Pj6K7j+LrGl2bcPpdD5y1fpOXEwL+eAYoMfNujn83mZxw1HJ/3xovXjvfEACm6bysnQHA==
X-Received: by 2002:a17:907:1909:b0:ab3:ed0:8d7 with SMTP id a640c23a62f3a-ab7f339d423mr309883766b.23.1739368371965;
        Wed, 12 Feb 2025 05:52:51 -0800 (PST)
Received: from localhost.localdomain (46.205.193.135.nat.ftth.dynamic.t-mobile.pl. [46.205.193.135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab786aa2c60sm1169870166b.102.2025.02.12.05.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 05:52:51 -0800 (PST)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@bokowy.com>
Subject: [PATCH 3/4] test-runner: Do not use short-form of readonly option
Date: Wed, 12 Feb 2025 14:52:08 +0100
Message-Id: <20250212135209.129361-3-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250212135209.129361-1-arkadiusz.bokowy@gmail.com>
References: <20250212135209.129361-1-arkadiusz.bokowy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arkadiusz Bokowy <arkadiusz.bokowy@bokowy.com>

qemu-system-x86_64: warning: short-form boolean option 'readonly' deprecated
Please use readonly=on instead
---
 tools/test-runner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 13a5de465..1fc95d33f 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -214,7 +214,7 @@ static char *const qemu_argv[] = {
 	"-m", "256M",
 	"-net", "none",
 	"-no-reboot",
-	"-fsdev", "local,id=fsdev-root,path=/,readonly,security_model=none,"
+	"-fsdev", "local,id=fsdev-root,path=/,readonly=on,security_model=none,"
 	"multidevs=remap",
 	"-device", "virtio-9p-pci,fsdev=fsdev-root,mount_tag=/dev/root",
 	"-chardev", "stdio,id=con,mux=on",
-- 
2.43.0

