Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBFE2F7468
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338462; cv=none; b=JC+1BkFc8a9Ux1D4dOqk/K8A8GdV10Z3OYr6GMPikY4g/GO8WN/KQfM3+KIAeTe0BsXp8+pudQTCOyQlTAvqGrXO3wUWPZcKOAPMUfMB/s/FeOUyoUM3LjVLo1/GiOe/d565Uq/ce0rYuGMGkVZ1MnIj3ZAQmwLDsJ9G4nCcm3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338462; c=relaxed/simple;
	bh=llqDBDmOJK/CKIPTIM8yL1+6QhVHbwgrXQi40KhoIpw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8zc8AIorJePrmhGbxdG4id68+SbCsMajEd5Irt13UF3lRYpr26D4rXRG8K4iirsHmJV2mRHLoCCJTsABFLU9iaU97l/ExpGqWiucLZiIWddSl68o4bJsxqegd75YDUWl4sOzeuAK529qJYM9xkROlhGeq+KSe1mctlRD3cWrYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0v2aUgC; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0v2aUgC"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5d6266f1a33so1626165137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 13:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761338459; x=1761943259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UEUdPpa50PFjMbWXhvz0VvuyCuuWRmBGJYgNoclhc68=;
        b=B0v2aUgCs8fcFF3nxJG1u3BHMRnxrIIsCxxWY7APKQFZyRbcR0rcOlaL0JDRRC4Dw7
         S1//Py39PqcZ7tXc6vdOwxFMhvv7/sXQEWwP/nNu4jqaoj2ZiAoUxCiS7k2gTXxwhecl
         xMtc4px55K0HQaYOnVjuPSicVDqfxzbKW0srcSKb80Ns4QSEkMJFS2y4O0Pwn7GIGDI3
         iH5yCzMcH5Fs2P3+QmHH9+Je/wXJXHwM7Csjw/idTi+V8JbWlMRh/JkvRZlNE04cZ++k
         C1AyXcNAbuavCKpJBVHe8qoCJtvMrpmbOsug9mvlyQu76ErCKFkS/wmVItJ7oPYIqO3g
         DrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761338459; x=1761943259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEUdPpa50PFjMbWXhvz0VvuyCuuWRmBGJYgNoclhc68=;
        b=mem4C372f0/qR94Bkl9ZAW+uu83z9WH4xhzpy9sk8xj/MFi5MKinBD9n2WDrnr2t3v
         89nUDmSI0N1Inpct4kjh3f+upZBSDtcZV5pa654qlQYA3rrWihCTrPA7/G6AiAuM/pL5
         ba52Y/MNud8q18fQ5Gmzb0L6w8SAterU9lCs24X+wbJybL995BRskm0yjqd8uwktPRUo
         QlgW5Kj3aQBjqkp66nc6C+ulHhPIR3wztwrkFiQPaXbGuY3YJVWpIGo5XgFn7pUJNA7B
         OTpLBogl4a0bBpuniAOvP6JkvEBRcpItLdLcthGX+FbABsukZRFcNWWCoXuTmAucsXzK
         d00A==
X-Gm-Message-State: AOJu0YxUKcUhO9PIQ0S7zID453caREeJ1848IBr7AWB4h4zQXbLyZEKr
	RBR3GG2DE3O+W78hH20z0HIGOBIX87KMr4vSj3xhx6ekDBDIzYLOtx0pZr07tQ==
X-Gm-Gg: ASbGncsOKxtsUlDRhSIemcbYbd9T9kHjnoFhklLvWfQtTp3OMCmsLNX5hbFqX4+qnnC
	2SscGGwVqADDudu+PrvINGuGfmY4uaLajYdGxg7sbvdU1aH626ZnjIEIUNbzYkGTm/ztoFqpMcZ
	Wi0EJ+d8/+S38leQ5Rb59hUlRQrHEzvUo/lcvbgBnYeemiqI1+CJ8h6RlDPRu3aA/hlPNZFu6dd
	Tb0g/eFBjWQhAZTZbjrv8KcsRJjlxSOu5j2u40OaS0csvlIBaqOpPOCUji82l+DhaXnKYXrV6GQ
	H1ZZhD6rYS8jdRsuaxFMRRHb/iV/rATnjRLyEfwkOb3gLLTkQhxCxA2BthbD6W8hFPC0JGNAkkn
	NojForSX4+ipeJMbJSdHrwlIDg5USHoobMFLBMUuFr/C9zDyJ27UaZUz+xUJMCs1dXvuP0Ax/jk
	A3Z0gLDf/ppWmblg==
X-Google-Smtp-Source: AGHT+IHsimm4Yfn5rpzJHTV0GKy0i3v+tW4CSy6TP7KGcIUyPclJaOdhl5s9GLro0ApqugvyBf5SrA==
X-Received: by 2002:a05:6102:3e8e:b0:5d5:f6ae:38dc with SMTP id ada2fe7eead31-5d7dd6b7f8emr8945689137.39.1761338458774;
        Fri, 24 Oct 2025 13:40:58 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557ddb2f98asm73501e0c.10.2025.10.24.13.40.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:40:57 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 06/12] MediaAssistant: Add Device option to Push
Date: Fri, 24 Oct 2025 16:40:33 -0400
Message-ID: <20251024204039.693918-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024204039.693918-1-luiz.dentz@gmail.com>
References: <20251024204039.693918-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables MediaAssistant.Push to work with local broadcast sources.
---
 doc/org.bluez.MediaAssistant.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/doc/org.bluez.MediaAssistant.rst b/doc/org.bluez.MediaAssistant.rst
index 64e689f8621d..8650d8abb379 100644
--- a/doc/org.bluez.MediaAssistant.rst
+++ b/doc/org.bluez.MediaAssistant.rst
@@ -40,6 +40,11 @@ Values:
 
 		See QoS property.
 
+	:object Device [ISO only, State=local only]:
+
+		Push to a specific device. Device must be connected and with
+		an active BASS session.
+
 Properties
 ----------
 
@@ -52,6 +57,7 @@ Indicates the state of the assistant object. Possible values are:
 :"pending": assistant object was pushed (stream information was sent to the peer)
 :"requesting": remote device requires Broadcast_Code
 :"active": remote device started receiving stream
+:"local": assistant object was created for a local stream
 
 array{byte} Metadata [readwrite, ISO Only, experimental]
 ````````````````````````````````````````````````````````
@@ -59,7 +65,7 @@ array{byte} Metadata [readwrite, ISO Only, experimental]
 Indicates stream Metadata.
 
 dict QoS [readwrite, ISO only, experimental]
-`````````````````````````````````````````````````````
+````````````````````````````````````````````
 
 Indicates stream QoS capabilities.
 
-- 
2.51.0

