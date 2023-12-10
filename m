Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vt-edu.20230601.gappssmtp.com header.i=@vt-edu.20230601.gappssmtp.com header.b="JbTauu1E"
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB385D6
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Dec 2023 06:44:13 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-425c3d91b2eso164611cf.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 Dec 2023 06:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20230601.gappssmtp.com; s=20230601; t=1702219453; x=1702824253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2yhLjKRdhlPCyI4UzU8N7sENwdLV3EQcEaIJqeWEYbc=;
        b=JbTauu1EbLjOVxa1Ox4hfgEvxkPZy/vbWWGLf3q7LKaV74dPgfoKQlt3k/N/KnHBfD
         uX9EP/pd8RaFhqtQQo/JXkZQv3F6r/rfpCj691t3Kwy5mX3PzX8yNryixck9pA7vRuP3
         3wUM/W13YfeP0CF29zKVKsrjtBNIUSdOEpk+zOJV8Cw8sztuOA+AuJOCBP3wd/4cym+M
         anBd2g+HS/1V3+oWy3lfDeDE6uTtduBaPVdj6xRy/wTcIdra7qWxGEPb1BnJMbC6DtHH
         UjCb+K7V4fUeXikdV/fQg/hS6oB6YG8Z9swUw1kF8DDv7mNd/XH6/GeB7IEW0zjJ1Et0
         FivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702219453; x=1702824253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2yhLjKRdhlPCyI4UzU8N7sENwdLV3EQcEaIJqeWEYbc=;
        b=h5udTd9ynbKDJpyCf9YIa/8YDXCVZnYCdoFu/41LrxlWe3c17xIbYZFHBoqzLglVmV
         TCpOJp6GryoKFZFKR0k56V2aifEVC5y6ownmxZqX6CLgdXWh9TvOAUgtbJ7C226kcQxP
         B5BSX9jZAdduf2aEDE/1sDBVbB078cdVqeFLJFj+L7gh9/ZJA2WGGZDnqNicpliCYtyF
         wCoI7eV7IAhLiqN2LXkyG7kkjnYG+eEKC4umQrKaQMs9pFRctq5LryeOdblzD4DERQDy
         nkojmSu/eh7iMo2YI1ckbZzmYjJA5a6Z60PL60fFRm01izOGK+qOvIMyqfoLm067vsQC
         ffGQ==
X-Gm-Message-State: AOJu0YyTePMM78dwQD9XCdf9rNIFLTt5rdMPosnjG12V/NTIrFrqyG2A
	08QQaUkphW9XozsEJ7ViGw0AcxJFvRHIx3GmvSKhMFy01SzW2HVdnKXxfRhUyCbpD/dmiprF7wZ
	RN8BAvcEqW9tyoANZcFF5PghNUtRPWVmTMWr9KQaOrPuXlvvSAp+6hIimpRwgKSSyKjvzfkhJsM
	lb
X-Google-Smtp-Source: AGHT+IEdNcuWam+f1RGJIaU6Ga1n8Lf/UTRbI4aFcyfOk3QnKSfXoR6Vs50Bkgns3RXE/kYOwFaa0w==
X-Received: by 2002:a0c:f982:0:b0:67a:b233:4f11 with SMTP id t2-20020a0cf982000000b0067ab2334f11mr5100019qvn.4.1702219452689;
        Sun, 10 Dec 2023 06:44:12 -0800 (PST)
Received: from debian.localdomain (c-73-177-243-39.hsd1.va.comcast.net. [73.177.243.39])
        by smtp.gmail.com with ESMTPSA id j11-20020a0ceb0b000000b0067ae405e0a8sm2482151qvp.57.2023.12.10.06.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 06:44:12 -0800 (PST)
From: Paul Otto <potto@vt.edu>
To: linux-bluetooth@vger.kernel.org
Cc: Paul Otto <potto@vt.edu>
Subject: [PATCH BlueZ 0/1] bluetoothctl add main documentation page
Date: Sun, 10 Dec 2023 09:43:31 -0500
Message-Id: <20231210144332.15040-1-potto@vt.edu>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the main documentation page for bluetoothctl which I forgot to include in the previous documentation update.

Paul Otto (1):
  update inital page of bluetoothctl to improve the documentation. This
    page was accidently not added in the recent documentation update

 client/bluetoothctl.rst | 366 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 366 insertions(+)
 create mode 100644 client/bluetoothctl.rst

-- 
2.30.2

