Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44C51F30BB
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Dec 2025 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764612383; cv=none; b=IXbVtuCaFibGShxJdXGlFE8hP+zyczR8iW0sua2SlIpmr2OE7AtwLArODZVa5N7eClPqfEpPSo/554VVSBUZuA/SezwyxjTh8rbwWOXVhupvIT/55Fccjqab2C/b2SRR/7q5N5CARkcfJr4ZROEH327wmYWJdz0UxunRjgAZDiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764612383; c=relaxed/simple;
	bh=OBEuTUZ3wjD/YRo139ZYdsnSeSH+X9cm3Kp6ojSCLHQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pmeWMgNjpoUt+NqsjVN9Nv1ZozUQ5nQqxECcdcIEQYeo6IGuLMLIFUEhK/3oS7qpHnBkylZT1E7TdaShDBXx80MZaRPofobFyg9Ut0m7jZqVgKEV9JGfxinI8H3PTLO1KYM5SN2yY1ostpJL2609Hou8DhhhepxcyMB1uwI5VeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgFtu+su; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgFtu+su"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5dfa9c01c54so2841438137.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Dec 2025 10:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764612380; x=1765217180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=A5W4DL2Wq+yaw0kkTv3oC4G//N2VKtLkX0WBJl5l4nw=;
        b=GgFtu+suhIz+ZXg0NHyN6TKdsN+uOJIsaTePdkOM3nZ5GoUGxYn0oiAYJd0hDyKT6o
         3SmIk0TzbnB8YA5z3W9hVVnc0OllX+P+IqNO+w+Q1YXDPgDvElEEeRkFUqDgcLzlSxyI
         mfbN+82gZYrHYtOXcfmqaBM+YThWw0Eazb2tIVyRc1U/naQsTW0O1HjkEwcaWGjsTkkg
         KIYuDyl1HAW3FY1+zxNy7oIBaOYwttgOZVV27jf39Ejn+e0LCtReSXPSJVJOXy6pbU9m
         6OeMPWijg4/Z58zpg6dGJhujIStf4+cI3L+/FUe0g2/1xSJIGdKwfKAgqloB3kEvjsCc
         WL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764612380; x=1765217180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A5W4DL2Wq+yaw0kkTv3oC4G//N2VKtLkX0WBJl5l4nw=;
        b=mmc+Mkg4yENH62zcu8i1vXlboBJXn9AHIzwD2VGIX+MT+bugwOX/n26SC2XtmJp8pN
         e13GPZ+Uifn76hiDIVKtPE0+4cB6MN6P1go0rCHxv4oVrN1avNfFolDsy74WOjNaGSrd
         +NmGpoiAVnlFZoUD8cM/YHNtWgmS2HLDZdE5gVgSCWx5rBGu/K4XLXcAP5by0ZTYUeeC
         dDg6HlVqIO+nCclp6gWM58SJfgaWOlDt1ZQxBx2MjcSuP2U0YcRNNSyT4sKa1b6LjC+k
         zjyj9xXDDs0TzruapaTX5YTGBo5vxPF8ZGmkCv7y0St9nj2YE8EO3HYlRCOhipACQzSx
         tRpw==
X-Gm-Message-State: AOJu0YyCiNyqwle0UloQc2OcZwj0ZpAhctlOivMnjOuqgSStt0/zdby5
	BhTR/XpgAccov1DK+FEpebHLNstNsJTpLybmzHUYPX0DHPGuWDStcCuSoWXLjg==
X-Gm-Gg: ASbGncsOWF9OvE7fTKv2LUZFPa1BZ9X8NGHyJbiVIgwIfBa2RDo1LiBZtYUd+DI3eJM
	GSZD4Z3R5BMdeAIh13MxlbD2JzGUGvaf2MPohKmJf/nxIOVNMKFxZPcu2ooLkHdFjVPHxoseirg
	MfMa8kefrYENbyr0zBN6D08nwTdyQZkjL7dNKecIQQkzF7HRo9vlQSI9g4YPc1WJ/JtckRncQo/
	EZOjNAwvJco/OhSsi9Igif1ZQpOYZLXyhqBQwmynNdovm8YTlA1J0yKYYfiDwUjyF+wMqAJnYQH
	A6SLkp2nrnfhop9xhBhgas+gdJn2JK3QrfT5+9s5iEF9dC9LpFVcAF8F4EMmXmxUXwHMAZQiQQ8
	69Sk7Nc92nkfcjZWCkFKOkHgGy8NHVWRzSfz9vKxe9W80Fmhfhn3XeAQCCGenEvOFe99R0s2e+N
	uzVttnGuHljyyUPA==
X-Google-Smtp-Source: AGHT+IF7h8MryeSvYs+rXsJUVJsjGwrMqD1ntqGqpqpavHj7KdVjOnBcbz6LsXVcQnsC7z82wQhUMw==
X-Received: by 2002:a05:6102:cd4:b0:5db:242e:71d with SMTP id ada2fe7eead31-5e2243e4a9amr11746083137.37.1764612377779;
        Mon, 01 Dec 2025 10:06:17 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e24d91798csm5128399137.3.2025.12.01.10.06.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 10:06:17 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] client/player: Print MediaEndpoint.SupportedFeatures
Date: Mon,  1 Dec 2025 13:06:08 -0500
Message-ID: <20251201180608.168392-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes command endpoint.show print the MediaEndpoint interface
property SupportedFeatures.
---
 client/player.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/player.c b/client/player.c
index 54fcbb7601c0..121c64f0a8d4 100644
--- a/client/player.c
+++ b/client/player.c
@@ -2937,6 +2937,7 @@ static void print_endpoint_properties(GDBusProxy *proxy)
 	print_property(proxy, "SupportedContext");
 	print_property(proxy, "Context");
 	print_property(proxy, "QoS");
+	print_property(proxy, "SupportedFeatures");
 }
 
 static void print_endpoints(void *data, void *user_data)
-- 
2.51.1

