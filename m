Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472616;
	b=Bg5cnLfRusZExY1Z4sD28LMTJn5EoXlWK2hsyVmEODyQr338kq9F+pxz/s0cyTD4g7EL
	 VC5TH1Pp2bB6N3XvBCobBTwpHDWiPeP6CAdsFYUFfHTXckcInQRcJp+ldsaE2TUenSVNM
	 6NQS4eTSzyMtNsbqZxIBy1TpvU+HnYSUHFXTKBCjLRmnNZ4KtHSJmBwiNeif8dTPnngSw
	 XQmcKTG2zPv8PjlnfZZZDtScH6hgqpX37G8MEWBBqUyRaPFqIaQsgGdJbOdrU13apkkr/
	 FHQe0MbYnh7TdxrAmSFFdYiEgo4BEpm/gcV4ZbPTBr5cIc8RdA9nioStoMBgODulgeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1DIEtRf/JpaQCeC2vD2/ZvWcgo+WI0jopYsB7AGprKk=;
	b=cuClw2YJJ0x0hnJaNDBzoBqi0o8v5tYF0jUiKYh+28XoJCUAexivHcLVnhoOE+sZuopp
	 i5o0k3QQTiy2zrA1M29flOiH254wQOILUG1RuI+irUyUFcMdSTwycMrYOps0i+U/+Scmn
	 MvQM3nBNz0S+wHTa0QZzKRW1cbsw8ju69MC/iERmhGPdsGeTjQZIEdp/VmmxVfvCyl+t1
	 AtTigQIjC8YIUrLoEpY7McCjMBQBIKfd4nMJWrlL2swuIyEZRVU/qLJfAhMYvjs7dYcG1
	 S49P/ub3IgWfW3ml0A+/pPY+i9xeIWmutL7DztNIA4fK74cIgEKORorhWLyQ2O7lVcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cnaZj9Vx;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63546606A326
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 22:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63546606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cnaZj9Vx
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb609d9bf4so8678495e9.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 14:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795472615; x=1796077415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1DIEtRf/JpaQCeC2vD2/ZvWcgo+WI0jopYsB7AGprKk=;
        b=cnaZj9VxukftJv+7dVn15ifaRjCJPdvuXBlWfVJS8HagVSvdtG1Cy3hPbtA+02io09
         aptwjmc2LVRqKFjtC0GkTQGa/pRbcmJNaxvE4B00dqXJUyqxeQWEoVJmhvqo+8SfCDdG
         LwI1ElsHmIOewgXII1Ruxv7GpfwjLqONrPX6ViJwgw9/U5VoSwkICzz0bIbTRR7ThGrS
         YQZMl+athckWgB6T6k8UdZmDXIbIhtiL9aUjmPufpeEX9pzhlN7trIi05HTtr6cebg7h
         JkuL71YQ9TQ/s0QiNGROm09pknbT2rBPvx5VFl2hfozJlqt16mDhB+UTDu7q0o6WUXtr
         dbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795472615; x=1796077415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1DIEtRf/JpaQCeC2vD2/ZvWcgo+WI0jopYsB7AGprKk=;
        b=anxgR+6BXbnrG2LdI77mU+3fwgTixPz6qLvEN2YC+/xgz3mBlYRUmam01ajqWi8Dg4
         FdOHjmNS5sKlsE7UP9OSyg2ubAGbvu+/Cl73Y7fJLec0i2a8JbE0a3nI3cVIsyMXz6yJ
         J/GA2wi8WetM1xjAt16rh663DxfDY3c4780zddc2282MxQu82U9oABQb9zr+D0qSxwW5
         Z50aY+AI7rUulSZsx3sGWlRnJ5FbblZz4+oaENBH1PLIygKkLSeuRQ4XIYqFqS5XULwJ
         hZJf+huRRIyD9SRPXSwzP2+ElpijrrQzMeGINoSaMmoHRTb7cJr7tPBAwp/sv2SE4Nzv
         nNeQ==
X-Gm-Message-State: APuU4Z/GrSrIMxfCsHb1xg4pogsLIyJccL9ZXObEy0fh3Kf3t5KGG4PB
	acdJS7UZ6NEwxUwtdqZKHDSXjs8zx+JEXoNebvu27WhwqX4gvUy1fM+eR9fdnA==
X-Gm-Gg: AZFdTZf2s5G1igZHSD1uQYfqpFy+3LthSff1O/V9I+OqtYfKTY12wjCyRMUdZPBF8X3
	XVmud0h0bA6+IualQYe4/p0Je/LbPwVz9G7Mq/qsG1v2i/7z0WUi3Oq3Rh0b3+I6Erq1V8gVh/J
	tgKB62WxmhncCM9OxL6LEUuNcun7jUqF45Y+66ctO+cv3/AEE6maF6ogfnUdBbXbAXMLqv97+QZ
	kioDbt04piUC4xUOxTv4vIu1Rfob/dz3aoal5BrcGpeUK0fE3BdUCNduiGrA2xdWf/qRjMUTEVC
	4xsUJ2UP83OSVHDnsfHJwf48jTWssLNCvTUGDg7aHoodwqnjx7luHp5Yhen41h6ech0NE4q1fd4
	WFoVJsevTewyrT0nDCnhdV+bwLHpSfz3rQHQ5yqGEb2/ExE/UfDXqtxwuQMzmM1d0XrEI2zt7Vv
	w/3YvLyujymcPA91K3QJduvibUAdU00S//EDsrLmASVF4cvljww481VM5RbyKEI5dkq/vmztLZq
	ZbJgoMmGKg4EQYLnZuZNgI+SHmTkyWzzdHp+sqjojZ9L6cb/zy9ZtDTQhEOTSWR7MQwghrct+fZ
	dP7hEkSROLEEOQgZSYLmfpoDPQl5zbdW9p5KHbVxdDPOiHZkhw==
X-Received: by 2002:a05:600c:8a18:b0:4bb:7ad9:301f with SMTP id 5b1f17b1804b1-4bb88806505mr189861445e9.2.1795472614690;
        Mon, 23 Nov 2026 14:23:34 -0800 (PST)
Received: from schinder.fritz.box ([2001:9e8:b398:6b00:c303:57b6:d70:952e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4abbd84e661sm23019015f8f.18.2026.11.23.14.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:23:34 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v2 5/6] shared/bap: Fix reading beyond the Program Info
Date: Mon, 23 Nov 2026 23:23:14 +0100
Message-ID: <20261123222315.223450-6-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123222315.223450-1-rolandschober1968@gmail.com>
References: <20261123222315.223450-1-rolandschober1968@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Program Info metadata is printed with "%*s", which sets a minimum
field width and not a limit, so the string is read up to the next zero
octet, beyond the metadata and possibly beyond the packet.

Print it with "%.*s" like the Program Info URI.

Fixes: 6d4491649e06 ("shared/bap: Add debug helpers")
Assisted-by: Claude:claude-fable-5-2
---
 src/shared/bap-debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/bap-debug.c b/src/shared/bap-debug.c
index b4352bdd3..772bd0a71 100644
--- a/src/shared/bap-debug.c
+++ b/src/shared/bap-debug.c
@@ -501,7 +501,7 @@ static void ase_debug_program_info(const uint8_t *data, uint8_t len,
 		goto done;
 	}
 
-	util_debug(func, user_data, "Program Info: %*s", len, str);
+	util_debug(func, user_data, "Program Info: %.*s", len, str);
 
 done:
 	if (frame.iov_len)
-- 
2.47.3

