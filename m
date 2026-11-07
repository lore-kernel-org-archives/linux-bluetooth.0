Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794016615;
	b=xzq0Ld9tdSIpDhwpKNsqflfI2Q3d2iY2QeHUjr9MmR3Z8gjsuRj4NcIR/h1/yVgKG0Yo
	 5fWmR9MyMBtoLu+/hteMz3bOGkliG3zoVJDhmq3JFGftaIjx27JSAJWnygR1ZcfL8O0Cj
	 h7xzs01m2sSrzmXVj3W7LnYrCxp6uqQrN2g8CGXaVfSHZv3TowllKnJXsxjbAaMeYbXEy
	 sS4XHCzmvYRPDY5oqB1BP1SxlO1LOIAn/zuuamYahC6w+GGzkXNeSNGSUJ6bWK75OV98P
	 /HWE+sDz9DW3HeHoaegCewPGbPAdk43JdXY3FwNL3f3NvfHDe6OrC6qDmG25Qjy61XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794016615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YVYC3iptg43wPhJ1sfqvNFuV6lIk+3V7yiLWS2UB2s4=;
	b=mtZBNCYz7zPL8p9IvNilnBtPrpKZuazj/lhlq3RbMJ+8w9Nz9G5DX3NI3eyXy0HvBD7X
	 YEOsv+MbDiLPJsCor8n7XbTD7XPFrhZjMVASfUCPz4sS5arAjqBN+48KfWdyg+BnhszZ9
	 E3/guvA5Z9CJ70UW2ez3UXFQxqe9Zk4YUeZH6UcK38zqUm8nmHbU0O4jPt26TaEixr6+j
	 ChBHx5yny6mQUVqlksWB7v8HoEXEajdu3EYihufC9Gs5dU5K5GqGQ1dTa39oZNJ8DHelx
	 wyFFn4neSWYq0NDWXei4Qe8k36t9wqmRnKQ6PmoMnswKVxaBcVmZMQYlhhwnVnJ6G/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b="Y8/hEAcM";
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BEE606A333
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 01:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83BEE606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=Y8/hEAcM
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36cad25b8b0so2001149eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 17:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794016614; x=1794621414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YVYC3iptg43wPhJ1sfqvNFuV6lIk+3V7yiLWS2UB2s4=;
        b=Y8/hEAcMkrO/beOGTJsN+DUR9f9z8BENLYn36dLRoapm24xBiiJXaLXbnMoJ1hH+yM
         UB+MOzKLabdf4Ts6WKn1juVGcAr7VB3T4nfZrStPdGWn5Wb+b/FZYR+7mpTnKygycAq/
         5eY+zg810oDZO07qxw3On1QYAfV38YcHKvQsQj1lzYWhQJJe6pqePOQwfYuzSZ6KthwB
         dyeBSJovt4Ss+SoG+1kKkG/6f4RORd9hVtYRpcZHnh9cOs/9yuoz4WW+x9U5MxzbaGab
         CcX3Pn5hDR3PSmo+X18YxIesDTk8nhY4kjb7cWtR5tyGv5SclP0tVPyj8c7JT9+MJrR6
         b+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794016614; x=1794621414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YVYC3iptg43wPhJ1sfqvNFuV6lIk+3V7yiLWS2UB2s4=;
        b=GNIMjDns+4VnqX9GLvjMQRnbJri4r6eI3A2XuDVeRmTOTmkQg0P2l4TiyqahuCDlA1
         J5b2uokczCkppsAQ36GMVygF7AFEGeL3hDiYTNR0+hicIgPMnL06LDNkv9sjZKXsUVJ0
         +a0RJj8DghQu3MVlJnaA90KsPEsdzEVCT6WVOw30xFsWIy0FoJw/h2J/tEuavRTJBQqn
         EmvKPE/EgxeJR7vimYmgKQ2vyLTAxf5xg7Q4KB06TiDTt8rElj96tFrh56GoYUkwTail
         aEaGD3x2EP+O7Hc6OIJ5RLP32UK8i8vSjnEMG1Akn+k8j9kYXjfvdaeSFMw5Ib9ucNSq
         3Ylw==
X-Gm-Message-State: APuU4Z/VrTHflCheenVPGPS/r24eNKpAlbdlp430BArLQn6RhsCPRLTc
	+BWokP7TYzXtu7tphs52jA/wp/8hFuoq24v4EWHIrO6H0BZrwFa8exqnmJAaBHlWrtEieYa+fkC
	g8cvfmu4=
X-Gm-Gg: AYBFou3FYz6VwAo/cBwD1XCS5leDw/CLydyIl4Cf5YbxiGqvwsjE6U/tOowsy37uGl1
	B63d35OWELSKMtZ4vPtwM6RTlP/FW3I8LH5PaxC/CXtFTJGFWkzDwGNQAuzDM0c1KsG3k/SEojv
	78hSBWbXqPHqiEmSCumN3jm/0wGVLbSz4co2V+eUC9DyWpX1iIcLYeV4+zltbi/0cFHt17I549Z
	NiPEcF1FbrDZDujlK9t5SXkyj6k+reESgQYGUvELuCpW81jKjYdvMGum3mvQrrj/3FUKYEhES7Y
	Mn6aofPG2uHqNeMIyK0nrPAmELdKv/ycxHjmibqJPhw7L0hmtMhk7btA+irFd7+YNABHf65J5t1
	gwTThyxzYxIjCJAfAIV1/UntFpAsjhPMOsfzaec6RQz/2u8YnZSYkz5Gpo0WOl9HydWPAWxfzCf
	7fmao4+ssE2RVDHopc93fV9JK9Fr9+q4K3DuaI2rzzABJfAUB9s6OSV8FaFCg3dwaizKdF9D8GU
	Fr0NeURL7Vp9D9b150S4+qFaDpN4m/0s37t95vG5uh5d0A17SRnIEhEfsPrccX+CRgXllaQYoCW
	LTs11W3vgV5EdB5UfxCsuvYdmjf+GWPGNrHolB9z7KGYkfG+eeIuRDmXMqj/MWCB2KcQJbZN22X
	z5UH1oRkdOAvbznUnt/HyoEPRx33o7sLPtylbwW9qRpC4Qg5ozMqic4bZmtkR/Y0r7+C4yL0=
X-Received: by 2002:a05:7301:6486:b0:36e:97b4:1071 with SMTP id 5a478bee46e88-36f75b1f828mr5256326eec.14.1794016614411;
        Fri, 06 Nov 2026 17:56:54 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa651e6b1sm22977994eec.3.2026.11.06.17.56.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 17:56:54 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 2/2] bearer: Fix LE Connect and Disconnect ignoring auto-connect
Date: Fri,  6 Nov 2026 17:56:49 -0800
Message-ID: <20261107015649.84892-3-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107015649.84892-1-kevin@simpleble.org>
References: <20261107015649.84892-1-kevin@simpleble.org>
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

Bearer.LE1.Disconnect is documented to disable incoming connections of
a device that is not trusted until Connect is called again, as
Device1.Disconnect does, but it left the device in the auto-connect
list. A device that keeps advertising, such as a HID device, was then
connected back right after the disconnection.

Bearer.LE1.Connect did not put a device back in the auto-connect list
either, unlike Device1.Connect. A device taken out of it by
Device1.Disconnect, or left out of it because it was temporary when its
profiles were probed, was then not reconnected after losing the
connection.

Fix it by pausing and resuming auto-connect as Device1 does.

Fixes: 4e21ebcaa5d0 ("bearer: Implement Connect/Disconnect methods")
Assisted-by: Claude:claude-opus-5.5
---
 src/bearer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/bearer.c b/src/bearer.c
index 5285e0274..e11a844d8 100644
--- a/src/bearer.c
+++ b/src/bearer.c
@@ -153,6 +153,7 @@ static DBusMessage *bearer_connect(DBusConnection *conn, DBusMessage *msg,
 								msg, NULL);
 	else {
 		btd_device_set_temporary(device, false);
+		device_resume_auto_connect(device);
 		err = device_connect_le(device);
 		if (err < 0)
 			return btd_error_failed(msg, strerror(-err));
@@ -183,6 +184,10 @@ static DBusMessage *bearer_disconnect(DBusConnection *conn, DBusMessage *msg,
 		return NULL;
 	}
 
+	/* Auto-connect is only done over LE */
+	if (bearer->type != BDADDR_BREDR)
+		device_pause_auto_connect(device);
+
 	if (msg)
 		queue_push_tail(bearer->disconnects, dbus_message_ref(msg));
 
-- 
2.54.0 (Apple Git-157)

