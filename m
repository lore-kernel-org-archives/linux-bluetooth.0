Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AE02D23A5
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 04:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773032359; cv=none; b=ixpgMn7iplrCTNFCp+O1W3E26jKRYU2XQn9ur/XSmNtXTH96YXvQAHlcDYxIo4u7Ww5Sww7ue1MBbWRrueXNBUJ0zr8X0UQjXSB8QqTgp7RbDyLRTqIP1pvrxZk/O181woBojuw1KBDJ3bIFMJaF3AxHLBpFwN/1fCA21j3msLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773032359; c=relaxed/simple;
	bh=22xB8360zBv4DnJYnbflxn7P6ozhfJ0ELc84fTTXDao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f7ugQVWu7RGHbDEcmzIPjHcbYdqGcUuUw5RP56RwLS5tIVFRx2vD2y4NYRI0Ux19ZT39fuaVGFg5Zyz5vnB30yyg00CBtWV2dmJbJT2G+M9T5gm9sjYHN4cKsYnUDIUIkEUpDLkwcWJyYqQ5X9nAvTtR4aBF2RExjkGPTzOZaK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJsj3KEm; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJsj3KEm"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-899d6b7b073so123680386d6.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Mar 2026 21:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773032356; x=1773637156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Utln3Z4FwTf+rPTDC0JLaRf8hnmpHANspbq5gC7qq6g=;
        b=GJsj3KEmsYWchaa5ftnVrmFrizvjJhYCZXoXJqMYMCUo3qh8WjgY06Qx0ck8JMHSnn
         gE9Rs7/yAaxrecIkkKIo077g0wgvv3b8HfQVTJxChYnedT6SDeJPVPGfu1CsgPvImgYe
         nbCp4YKs3l5nL22pVrRNom0RVA9fmZyjPAu6Xo5D5fawkcvue1oDeqRzzH5vdOfKzK4u
         00TVilct8tpzXtd3m8Fq8ocWSgZuxH3IuwuxnueaU9plmhVwZ+VEjvM8OwsEMbna7ok0
         4nwyuhXxffPU+ZVoiU/2w6yC4onbU2CGEc7oVr1UHOwc+SWmyQH436w5JIPDYqtYuZTL
         cD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773032356; x=1773637156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Utln3Z4FwTf+rPTDC0JLaRf8hnmpHANspbq5gC7qq6g=;
        b=Np6hBiIiKpRNn+UqbQtUfqDCC+oCO+PC10XapjoXK5n3NBbk6+MYpZG6brXBlrYoEC
         BK2oP+l5ErtljHUwoY0RIT3kc0og8k6kvID53gT3v1XVymv39WAyxJ0r5K7riITvTQQi
         moSn1izaGRwQDLIfnYO1C33xTghQ3yO9Gag7itnx2GcrPohXuuoGuMbTyYuETGSGCLkf
         MyPkOzArztyNu/icWLKTXH1jO1+uyxMSRajzY28tXibJIVQ3bBvlLMiLDeoBM3ALbOMM
         zdpY79TU8b+Y8T318MkM+UkanJ7unq4/kaR7Ga9GW7VSDU/SQzOGIu2gxaRbSmaluK1w
         BWtw==
X-Gm-Message-State: AOJu0YxrrSnKsZQ6UFGBA7mGSTvmH9pesUjN6GN30Tr/PYjCUorUX8s3
	vhzlclvVrO6bxml9LZWUUNumiuQe5Ql4hPNu6TYDxBy4tFiN6tC+w1lQ/ibQxMvLYrM=
X-Gm-Gg: ATEYQzy+mv2u/snvgqEVfPAj7AZGH2FK8tEpRJHUv+7f6qXB/oldGSN9KS75XLe8DjT
	K99nYW8vIkhJ5BdBRTXaby3BFv5z5REjAeFsBcMuNuG3EuvzWcYPpA0ovTT7RZQfReBjhXJjJtP
	wQ1VVxOkewEUUpl5NTmgj6CoEOA6SZzwXku8SQKi4AL2b9c20Te5u9ZygxvmhePu84h6+vcLGom
	EvkK4Ui1mJkjMyGYzWp1U0AbSZWfyVjBYKcgFsX6ZsGEUNBVIUX7VqSoVqnTsbWxOqx4Pxfsa0Y
	a1hu+ZQWXuwvX7I1SVsjUIQhyQ7LdcLizd+O0eIB0iSBuiUSWKTGrkbNdav2z5ZOgXdLSd8di1m
	jOSzXdqk13ofEOzrWOgV/teQojuPaNLW3hdj2YfIiz0c01tGE5N5yp+EHI05jm0NUr3utA+30sC
	TxDLSpM2yYiuO+J4NL/8T9JT7yrJbpymTu+PP9
X-Received: by 2002:ad4:5769:0:b0:89a:2fe7:91d2 with SMTP id 6a1803df08f44-89a30af1d8amr154969896d6.57.1773032356508;
        Sun, 08 Mar 2026 21:59:16 -0700 (PDT)
Received: from gabes-pc ([184.145.175.55])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a4df6eb9fsm13499086d6.5.2026.03.08.21.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 21:59:16 -0700 (PDT)
From: Gabriel Woloz <wolozgabriel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gabriel Woloz <wolozgabriel@gmail.com>
Subject: [PATCH BlueZ 0/2] lib/bluetooth/mgmt: Add missing mgmt_op entry for HCI_CMD_SYNC
Date: Mon,  9 Mar 2026 00:59:01 -0400
Message-ID: <20260309045902.2354-1-wolozgabriel@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MGMT_OP_HCI_CMD_SYNC (0x005B) is missing from the mgmt_op[] array in lib/bluetooth/mgmt.h. The array terminates prematurely at 0x005A. Add the missing entry under the name "HCI Cmd Sync".

Gabriel Woloz (1):
  lib/bluetooth/mgmt: Added missing command "HCI Cmd Sync" to mgmt_op

 lib/bluetooth/mgmt.h | 1 +
 1 file changed, 1 insertion(+)

-- 
2.53.0.windows.1

