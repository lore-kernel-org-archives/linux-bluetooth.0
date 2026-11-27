Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769741;
	b=3kCQWVwa5oQaI5QskTd4aIygHGuvojvl8v5XnGMZUXt7RTQWS7lu9rjidx0XEWozzKAq
	 ZBVHcXnidmlc/HXXCOraBhcdadkgdPu1w6C8OGdBMYaiQENt6G9oq5V3BpkCb6jnDAIJv
	 7qUlXkQzykh7KSqk1gP2jRptF3G6abj42SL0XZXP+W+qy0AMkc523GvHVqz2a5h/lyiDE
	 jMM5yuB//Ja7vJne4nsLtQTG/InOqinwFdCAlEkLNLx1OnU0EShsRfEO8leNsHV/OPr7R
	 C4G+TS4VDGjybgdSaREU7VCOMTqxGuAfL4Aohn1usBf5yUSlPi+O3wPtJlqH2x40aeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769741;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uNIuRXET+QvWe2pMI9FJ3659vtLtl9nPkdXQZGBzIak=;
	b=36GLfRnHo5NVfxabATcT1FuCXQl3fZhJad2nQlXm79cFsEsPkuuBG6s1INkwZIzo8oBt
	 hCQlcLuLhuDob6cBO7xI3zDd/t8rxjmzvgBGGrwB9ifWzEBK3FASqwe3nrIyjxl+2TO23
	 BgggK+WlGwAMm5PyBpYqz6YI0pvOGzRw0z0zz7Lg9Vk1zjBBBlylpodDyPGXJQL5sopw5
	 VJakz73/mLi/Rf9V25fK8TfvHnL4/aZaK0iSRzXcbhXDwuyvsaUKfdZZt8g3QXKxgfJA5
	 p5Pe2b0lIITFSAPjyu1cNPamvfqP6Qu6H8KrfI5HM4kiabuOfzU1YDNXBGs+xLliUsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yNRZ8nKJ;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F9F606A32A
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 08:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37F9F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yNRZ8nKJ
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb8ecdcbb8so5699965e9.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 00:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769739; x=1796374539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uNIuRXET+QvWe2pMI9FJ3659vtLtl9nPkdXQZGBzIak=;
        b=yNRZ8nKJA4B9V1q0EFaw2BTH23ud26YPdM0ya+uQu6sXTxLt4T6qUIZyd6IJt17+ea
         2kGH2svE6HIgl2pXMLwLhprC9X+UQ8ab/oH3CSRxowS01MRC9FobxnN+sKrTMQZOX4Ek
         d1FyH9aH2KvcVYOnnkJ6KBUKWtXjN9PdM47cyww1eNpeyPC49AFOlPAk2Gq1zXPRc7dZ
         PVm8en4ljVws8BQ9zolwOJv0KlU2voZr9/f511DukL05RfRm3InoaGAiGjnO54+2uk8V
         sPOXe217djy+F9f+b2Ux35zjFG9k34pogEWnMP5SPIyZos6lRSgeE69fCSXP9GWkWcYC
         MVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769740; x=1796374540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uNIuRXET+QvWe2pMI9FJ3659vtLtl9nPkdXQZGBzIak=;
        b=iRMmW+ZAwjB7FZEVFSyc1+/N7j39cpbBWM7lnqhbJvNT846i+2KtnWrgcmYeyLZcRj
         vE+9q0pRDM9PL/6PDwHMtw61/IVHmUFbZF6oyX65D7ORFmH6hQf9FHfy7e8zOaYsPEc4
         r43iiOfI9vZlflXUWFXaBy2ZvP6u3AR9gKic4nHo7uY4NaL1RORzkNKxgKzKACUptlG2
         PzoJGryuWTe/7apZc67jc2ceUcAe3au5g4snlDzRzqYDdlonPC+GLmqxsdurL4B/bHeI
         1s/SnTB0N9UIN8E8Tft8INCzsFlV6/eIWxpn9accOsr3NGLLowAs+K4oxpC1+o45pqCT
         TG7w==
X-Gm-Message-State: APuU4Z8JvIHzoAi1DcTI/6BMJ4kZXv3oNT8EMbpIyU9AvYaK+bL/DO+I
	2AIk2yzFXP/YJEvN81vmlQm8xdUFV4dIYfRnIYAtzJakuDQBZadj19RY02dhFtxs
X-Gm-Gg: AZFdTZcgvUjRb6bMJAuNswoNt3H1RvgbhBiNQW10Yo1KyCHumCPVDFTulMquQhnmdWX
	wHxL8ZEsu9nahcTP9AXWYX2D2kJBQzG1lSOkdU0LPnorJd1A2C2b5PsuMPCpruapL+fzNN9yZ9Q
	XfbQ/vekrKEHZEkSSZ205Z2wXNYYPeSW46Me0AsxpYMjz7wtTuqqWrIGg0KALSMdql7KmojLDws
	48FqZ3uoNOi9/KwMO9nHWTUg2+Sy+ONj+LHt4IHfKpqhHy39GYZ+jD6dfKjXuwS85wEMZVJpWh8
	vo4vjzuUjwOqO/mhFXvoRZEbI/dQCS5QfDa+pGLF5vF5hDhAOWmY7MDpBthDuNH7/rvOZ3y0Y3Y
	B+FHDm2bvug1tnQIhZQNe7xpaDd54zgYKiR1+L1nf0Wm0yRisivy5jlG17Vg8NuFh5st3MfanN9
	ztSYL8CWNf0b7UCl6/erGWLJyDrG9MautTHcsyItMFh8kzE2Rcj+ap4ZkWOwsQxTVpinWTPZqsN
	nN3iybi0YN4eqfeUe/nqDcPEem9wgoLwkmCWJHy9qpVG194bk+h/aJfU6MJ9kcUXS7e69JzTsle
	Phe4jUt1oq7U4lXrCdGZtVbzVBrXHJDirpJLKYWyZ0wg5gLkJ9tCLXIA
X-Received: by 2002:a05:600c:8a18:b0:4bb:7ad9:301f with SMTP id 5b1f17b1804b1-4bb88806505mr352544665e9.2.1795769739567;
        Fri, 27 Nov 2026 00:55:39 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853c9170sm739587505e9.14.2026.11.27.00.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:55:39 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Roland Schober <rolandschober1968@gmail.com>
Subject: [RFC PATCH BlueZ 6/9] monitor: Add Too Late and Too Early error code definitions
Date: Fri, 27 Nov 2026 09:55:22 +0100
Message-ID: <20261127085525.264299-7-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127085525.264299-1-rolandschober1968@gmail.com>
References: <20261127085525.264299-1-rolandschober1968@gmail.com>
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

The emulator answers LE Set Periodic Advertising Subevent Data with
them.

Assisted-by: Claude:claude-fable-5-2
---
 monitor/bt.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index 1231f3e84..46cb39826 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -4798,6 +4798,8 @@ struct bt_hci_evt_le_big_complete_v2 {
 #define BT_HCI_ERR_CONN_FAILED_TO_ESTABLISH	0x3e
 #define BT_HCI_ERR_UNKNOWN_ADVERTISING_ID	0x42
 #define BT_HCI_ERR_CANCELLED			0x44
+#define BT_HCI_ERR_TOO_LATE			0x46
+#define BT_HCI_ERR_TOO_EARLY			0x47
 #define BT_HCI_ERR_ENC_MODE_NOT_ACCEPTABLE	0x25
 
 struct bt_l2cap_hdr {
-- 
2.47.3

