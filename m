Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C3020A5DA
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 20:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234528; cv=none; b=pjoNI9LuBkvvHf5HsUTzK3V12gzt87Z+DSKafUlsCs9VQBMmoEOpVkxXb/Jv5pynlQTIyAXgTlVkVrKREMCAPEEXqsLU0taL1zQsynYUiNhE3G6swgDhWYyfjZXcRzPK6QxweVsSKsAIhWq86t2AWJwaK3tEJtuCSQr+3sI6+dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234528; c=relaxed/simple;
	bh=d5rzzIIlo2H4jys/utcHUJnDcIPZEARo45UbQ0vgsIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fstbDakqWXgbqzB3hYfe6pyWEwHt4AU97rS2mG4gflwvT/3p8AmiQifMFx53fuUVxbyOSfLqB9EZJHivhO50JJSRT+85Rr3bK8GWydHQNjBjFsNanLw0aDe5C+Sl9YUs96JPYHZUT/zM+rbTIulD1i/tQrJ98IuRYTZ4OW/XPjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoN8i1YD; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoN8i1YD"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fc96f9c41fso2499851fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 13:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730234525; x=1730839325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVSZeYYysDbepb7wiZjEJLSWqjkaEMG4q1LMncROj6s=;
        b=JoN8i1YDxITCTodVPnY6wjKoPG+jIwH2XZ+4D3EMlhuVsicX8DPIjMOGu3V4e2ybm+
         stec9YT6xJxnSiGoB4YezIJY06kVwkww7aAqE0stsognh3oVozWcTOoQeBw0qNhKPvl1
         O2IZ+vW9TIkGsRw7BZR8I6tfPOmbFzY19KzcuMPRYYS+7tCd895I4unjYGeRf6/6jVKb
         3+r8jpQVTVikX4B6XsAYVYSoFjXsHlUj97C+nK/4Lcdh5iPDIZCUEtMQfVabkWJpO8qy
         kiGHp5yCStthkyoMtyB4z0366p/tREb3taCThYGUAJMgBbcUZluqowq9GoyqJBzBzaN4
         Orig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730234525; x=1730839325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVSZeYYysDbepb7wiZjEJLSWqjkaEMG4q1LMncROj6s=;
        b=Cqmw3bMMZw1MTmwNSqvkmc8EdlramCgZqrcHmEv1uC9QUS8Bh+2VOGo0vBjY54u+nI
         NFID+agmhtt8S5tmm+O7ctngIATqqgOQRk4QFNDbIWgtfXe7D3KQO48A6NT5iyHeeNg5
         +dkCRWQdBBtsRSZXCL3HLV2TiYrW2dUfXVROeD57/vl5ycJnLPYDTSKIvqFUCBsWJiJo
         y9K/AMFwqE5sr1YmVWX1RxR6cnTGVB2QtwdjGj/bQs96cTxrP4aSyuqHwWc7aSA7uWyZ
         K6/Cu3rq5rYqtVBLKDVv0ycWAXVycg8W5pJ2moo0ltsWAM3ebDkjCdTd+T/XdVo0nlka
         Noow==
X-Gm-Message-State: AOJu0YzkmaTUwyVMhGRRisQsmMm+XRIPX2ioqVQ/LNPcW15v6cacC+ib
	yKgvAlbrQLPw1KHkR+ACZtLlRjxeuwAsgQ3JSi6MNMN2UxZwgl7Q8wTydg==
X-Google-Smtp-Source: AGHT+IGC7u88ehP/xgUVruy6Qg6+7wW73autOTKXXeKDzTWPa7+/P4MDKh67bvrwvLNer5PApeluow==
X-Received: by 2002:a2e:a989:0:b0:2fb:5dcb:6689 with SMTP id 38308e7fff4ca-2fcdc91f2ffmr12831341fa.6.1730234524428;
        Tue, 29 Oct 2024 13:42:04 -0700 (PDT)
Received: from raspberrypi.home (46.205.194.156.nat.ftth.dynamic.t-mobile.pl. [46.205.194.156])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fd53603415sm435251fa.85.2024.10.29.13.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:42:03 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ v3 3/3] doc/media: Document policy for setting transport delay
Date: Tue, 29 Oct 2024 21:41:32 +0100
Message-Id: <20241029204132.586663-3-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241029204132.586663-1-arkadiusz.bokowy@gmail.com>
References: <CABBYNZJyrKnWGcFb9k2YbucPub0hkhG-OH=RWEhdKPJKLVLfpA@mail.gmail.com>
 <20241029204132.586663-1-arkadiusz.bokowy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 doc/org.bluez.MediaTransport.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index 4838d69d0..78789bc80 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -119,7 +119,8 @@ uint16 Delay [readwrite, optional]
 ``````````````````````````````````
 
 	Transport delay in 1/10 of millisecond, this property is only writeable
-	when the transport was acquired by the sender.
+	when the transport corresponds to a sink endpoint and it was acquired by
+	the sender.
 
 uint16 Volume [readwrite, optional]
 ```````````````````````````````````
-- 
2.39.5

