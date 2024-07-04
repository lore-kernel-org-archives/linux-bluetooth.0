Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E281A0730
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720087891; cv=none; b=jboeiZxBvXRZwnrOt/dlmF7P9IJXs9iWJcdjHI31aF/67MLjNvR935dkOsecsDBtxKgwEP1aTxvZS7KN+cX+lOd28nJ1B7sD+JXIpaqRzaxA6EJfqC1fpJLhRZ1RNHFo25/Q2ligZYzfbGDyZzn0RqR6c13E4JsKVYGrEmkXSbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720087891; c=relaxed/simple;
	bh=gEbJpxEAAy8O7wfmh1T49uNOnom85d2TFIgq6jTlmoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=grV7L00lt55yWYHgXCmAAhKHqLNlZR9PyLvsnWTORYrPMZtp61J7QDcfJgeWPPKLJhT40lX/25wutIKhH7fMTdzZa3W/G8SAFe+wj+dy+haYr240AV1Ie6zHI2Weq6D2/aBUzLX+oTC7TfSnlxldsgwpWnqN1iPoZq8sIZMT7NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ij5dZAWU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ij5dZAWU"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4256aee6e4dso3030585e9.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jul 2024 03:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720087888; x=1720692688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kQigH3UDhNKUsGfgMZJV8PcxBpj0XpNgw819wyJeGhc=;
        b=ij5dZAWU5UX9BPOlr9RTF/TqyLoqaHdAQcxYOjNBL9hIrz4Ms98RIcuaM7HX6jAfAp
         Je0eEBXGwPevPvK6e/6cfQ++Gb82/w7Mr+KsEcRB8zB7eL/t3rZtyBDaVmtjA2Un2pO3
         +izutRuaEeQ0IcGJT+YXJS8ywpWvtj5tsaz67VE53Q4qHmahoTFvJVwDWlP2d4kdlTEE
         IMnJQNU7EAe6Oij/HgaI2ahQCnW9NxQOATBOEe/cURXawYdetTg2vujhBlKdg2egse/f
         dj1tvu6R8gQFQrd7X6DdgUfQe2JKA2fWQahYos3n3MhiZBE7lSltlZxwAJySzDO6aFko
         lzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720087888; x=1720692688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQigH3UDhNKUsGfgMZJV8PcxBpj0XpNgw819wyJeGhc=;
        b=FaRuVFOC/97aT+8iLMcPIFOXftIyIPxlA1FRJJbfZHHc42yXBJ/MgYbhvxDbgk+5F/
         FAcFQG83+Ovi/Mw1njE7MVddEBKBiieABE4jaYfatlpfX4lN2nMd8SIvZXXbpvwjCgk1
         G+9w/cybDUiAAT2jLw4HLuS4FEqvg8tWsF9qQpFZlSy4YjRC9FW/3LZNZgndW/Ga6mA+
         FhmLlM23aVkmAvIRvZRcKRndLnUmuUzQG/mAKToBZHkUbokuIq5JsuCZ/aJhmmRlT169
         VBgLa++fhLmb+N8NTf3kmHiB2gaWsIv9ANlTR9DReBZrv6QGAB4VRCvD/NR1CiIRhVPC
         NfOw==
X-Gm-Message-State: AOJu0Yxx9s62RblB/NbB/LUry5Mbw5bGGcvfNq33ed6f6Tf0ESkiMYTt
	y3RNl69Wp9jOfatbMmqWJKbvKVIS9XfoMHD299lu44rzQzDj69XmldoLUQ==
X-Google-Smtp-Source: AGHT+IFbVx7MQWQXOpzOY3fVgAcHYC2g2k75A1QkqpG1gwOed42Jwz9LcMyrJdQjYTiID/Lfjiyirg==
X-Received: by 2002:a05:600c:2210:b0:425:624e:d80a with SMTP id 5b1f17b1804b1-4264a3e1ceamr9489155e9.24.1720087888239;
        Thu, 04 Jul 2024 03:11:28 -0700 (PDT)
Received: from localhost.localdomain (cm-93-156-196-56.telecable.es. [93.156.196.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a21d2basm17763505e9.28.2024.07.04.03.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 03:11:27 -0700 (PDT)
From: =?UTF-8?q?Antonio=20V=C3=A1zquez=20Blanco?= <antoniovazquezblanco@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Antonio=20V=C3=A1zquez=20Blanco?= <antoniovazquezblanco@gmail.com>
Subject: [PATCH BlueZ 0/1] Add Cypress support for bdaddr
Date: Thu,  4 Jul 2024 12:11:22 +0200
Message-ID: <20240704101123.51164-1-antoniovazquezblanco@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Cypress Bluetooth controllers seem to either use Broadcom chipsets or
to be based on Broadcom designs and share many of their vendor commands
with Broadcom chipsets.

Particularly, the patch has been tested on a CYW920819EVB-02 board.

Antonio Vázquez Blanco (1):
  bdaddr: Add cypress manufacturer support

 tools/bdaddr.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.45.2

