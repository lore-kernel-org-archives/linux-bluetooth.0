Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B3E1B86EF
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738083269; cv=none; b=GlUPNVCqd0h50mbQnjnpW/fxSQmLZdnOMGHmkapyxEZ9bbzO2fMrK1gHFyap3juv+1gY2CHAMdBiw2BGvQVK/rLAYQk13jruIkRVxY1Cq44jGn8sr8XtXLjy5835f38bT9Yanh8nD+DCzvFu9OpwoKeHcKfPxlD+KHQs6eZckjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738083269; c=relaxed/simple;
	bh=GHC7nNaM9Ja2GBOeHZTrfLxLzxfxx5uGHOBruMND45k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Oz7a8PR7W8tffRnW/5JL+cktJKisq7Q5VkcH3mX6FjK22bskPBEmnc1kQmmGwrum3PPYG6wS8f+UJTz0X5Cfdjvi/z3ZKa8lgVCLDl7sNiAsQBYtsA7ASHqNDey3PnjxYIJFsAuCLP1QCxTiCFnsjJi5iDT5xfKOmgf74YSyGjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRugxrHD; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRugxrHD"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4b6398d477fso1739781137.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 08:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738083266; x=1738688066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=m5z1vuIlLSpz5GZoP3gLiDPSVcxkxUP8tVeGSspK174=;
        b=PRugxrHDRrVjjLp6957n2iNUeBiUHQ5Qv9MmD1eZuiXJZdJW3alsEjg32kQe+AVuEs
         cxNgXHl6XOY9edyfoX8cmP0n3tUhbnyG1q9UuP90iC41imUXvSG4CBefyZo2XHOGJQwt
         2mplz40+Z9tnCdVJjZBIiU4iuQF7HHI4fUFHsK0Q6QvrgDTEZl2OAORJPrL35JFpBM/e
         fOzlVmbrLXAtntzwFmAacvCwpbzcljIqJyPzyFFCT1b9Q2/9iHMAKlbaFjMfz2HJWdjr
         AV94VsWM6nHfLtHxvFwrC0hxp3NUeQ8sbrDtOdIzYurbQsd7Er7WW/EG8O/zeS+FUXtr
         JcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738083266; x=1738688066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5z1vuIlLSpz5GZoP3gLiDPSVcxkxUP8tVeGSspK174=;
        b=xHC7uLEhOOg4nhl/YqyI4Rq0FBd+z85bHV53T/KLWWD0vZe2bxP4YhDTJ4KmSodPrM
         ycrs33rpk03DWLM0GcLD2Q+9OBMdOdI4iRBYE/dLipTw7JW6a7vZ33sMK7qtkByDWGSw
         sPhwCaptwkNc0ulKztQBExTiPJ56Udu+aNXuH+DieQIxUxO2+5bet5z47I9TLYLc1x83
         tF9Vq+aRZfx48PbZIQFLMddGp5XK6qBCuoQr18mZRMuVj97c/KPobdnpJIvH7Kaj7j57
         mIjCK1nb0BSKaV9yUz7EnjLXWpuLJgqZMxs2oSF+l+zHnodPq/7Zj98PO4tNQpc4ucYe
         1Mig==
X-Gm-Message-State: AOJu0YyNMe2S9/v6YPimNVWPjTXVRkcCnlOTBCYB4uA90udKbFpitxuE
	9kvMg/73HcJHI+2vHENWajXfBq2Gu7zUo/i54pmBSe5JDlK9RvRmKg/zMw==
X-Gm-Gg: ASbGncsXFNubQsfqhVsbvRDc9ssmrNSQVJiP+2eJIZ94KXOX6Eg3EiWN0j1KJhL+1D1
	1tbsqkDsDsqWCKdpQ5VQKC5lK0EWAjPEWVF87kLZyxjUno3kgWf7Q4TH+ixupCvX9fx0z5tGWB9
	ZILdnF5Hi6XUmzfmH5mtY+77oQd0OWXEhr8W0HLj4pcNqEaWq9S75c+bYePLlthYT7+vwHagsgM
	FwLO+EfwyeGcKZY8z2aJvcjaoO9tNOfQkbFiW3+ZkfmzcaO6VQThvHpowP090ZwyylXtn1rCFDN
	m7Z+vUDb7XUk6VDc5SOckp7lMd/2dGmcM4qAn1WbgF1EXjTFxu2OdEuduP115ehcLGWAkRf+vQ=
	=
X-Google-Smtp-Source: AGHT+IEvWZ1kzsUl7aGUT6S5WA/5SYM8vKchYeXpxqJVEwcflY/BFaGbt/NR7A8Ua3Xzo4pf5XWZIQ==
X-Received: by 2002:a05:6102:2d0d:b0:4b6:44ff:414e with SMTP id ada2fe7eead31-4b690ce4767mr44363556137.17.1738083266275;
        Tue, 28 Jan 2025 08:54:26 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-864a9c40d58sm2575254241.32.2025.01.28.08.54.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 08:54:25 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] org.bluez.GattCharacteristic: Add confirmation support to AcquireNotify
Date: Tue, 28 Jan 2025 11:54:22 -0500
Message-ID: <20250128165424.1044479-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds confirmation support for AcquireNotify when indication
procedure is used, also document the behavior of clients vs servers.
---
 doc/org.bluez.GattCharacteristic.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/org.bluez.GattCharacteristic.rst b/doc/org.bluez.GattCharacteristic.rst
index 784445234fe5..7b1b3fbb5446 100644
--- a/doc/org.bluez.GattCharacteristic.rst
+++ b/doc/org.bluez.GattCharacteristic.rst
@@ -212,6 +212,11 @@ fd, uint16 AcquireNotify(dict options) [optional]
 	To release the lock the client shall close the file descriptor, a HUP is
 	generated in case the device is disconnected.
 
+	As a client if indication procedure is used the confirmation is
+	generated automatically once received, for a server if the file
+	descriptor is writable (POLLOUT) then upon receiving a confirmation from
+	the client one byte (0x01) is written to the file descriptor.
+
 	Note: the MTU can only be negotiated once and is symmetric therefore
 	this method may be delayed in order to have the exchange MTU completed,
 	because of that the file descriptor is closed during reconnections as
-- 
2.48.1

