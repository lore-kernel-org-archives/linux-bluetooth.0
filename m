Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCAA47F3A0
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791498402; cv=none; b=TzflQV/Fzth0at3PlnaVq9LZCY6nedpscVJ4D04JBbeS0Fvs6caWsH3HTJ25i3ejMg0EOlt1zcqOcXk0CXO7SAgAFTZ1QS6NX6IaluNxwAvZL32U6tZoEu1rRlkwLAGmHoEfGxRjgJO8wRZzScz58Fze8oVXfxqvDZ63+7oK1hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791498402; c=relaxed/simple;
	bh=Grq1cf76duT5Sv8IY1PufaVJuK39bLhql94COC5gLlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dl9qK+41Ih72ypAzU6bilOR4iEvKOqdVWmjwbncVr4MvbfphpltLpEZbXL/80QWEY7QAOtggJyeyqzhzzmeI0Dbnhs0HgPLHl/U+07jCvnf5Rg5iHHrb2TV3crEa5LjHOJ6hEzstktqlaqGTlQMItymW93W/1g0Bf97srNnS/sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=orQ8NncH; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orQ8NncH"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33bb5afa736so199432eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791498400; x=1792103200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uB+YPN8HTh2NianqtkumiyEzPDaNytolJ+7cLsxqxCY=;
        b=orQ8NncHzXbqJyxT2VOY5SSmAF+iVa17WHuQ1OZuusG73uZ8EfVDgfWJ/XECMNROaZ
         4MWOrgXf+RHBnvUAUQU57fsUbHZ5RCmOhW830ypOJMQBU+1uWavu1JixmNXmoscF6Qii
         3/KEc/TgdKwG9syLR5pEQlVlNp0vJSXlFz8hYC+1WR6Y11fvvKr7ZYfA5bqX0xIX5XWi
         ZENX5dkE7q2fz2kOuo4dA7PcdH1J9VXesuwk47Jh2ueyF7g0vmcaYuAp99wyT1bp+lYh
         RB0HZmIslYboD0LTM9tBzTgNYQcTwau1quJ6CSfyJyjUSnaXYrsJV2knspj8lYYopdL6
         zXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791498400; x=1792103200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uB+YPN8HTh2NianqtkumiyEzPDaNytolJ+7cLsxqxCY=;
        b=akRM/+wHytR8qJ4BHCi8Zi+g89QaDngX1Sd8pikL0Q7jaZIy5JqTfjw1Nyj+JrNzO0
         1T+3QKSQ7sg73+1gSOTJBCrheyUdPPiTtaAg4VszFes+59x/Jfp4eN5sz11r24o3XErd
         Ezf2Xdgc6G26buAAhJnC6S5o6Q071s5eh9BH9J2vCGk0g7uTZAhBfDUXOfcQXoT1p+/W
         xDI5+EJ/Z/3M+mWFZvV8GsU1pPDxUKo7xWDOBKxKQoekGPI4SFaWq1kJjiOzOyvf2i4r
         Z04QR0h+weZZ+YJdh0f4D1RGY7h2RsdfgNiirosr8+orc1fmamuPAYc/otw31+dQeq64
         Mqbg==
X-Gm-Message-State: AFq9FYL5IMW2RRjrVAnVvSzpF6hoxU0/tvo0d7GjGKvO8QQaFPuzremW
	gySM7t0YUlIWkNP19YaXcvwQPMpmosFwlQUoT5ug0S9m4aZRnKcDjBsjteaAPlt8BFs=
X-Gm-Gg: AYBFou1mwFZhGi7e6qOnQ2dteRWXlbr+LR/r9/dWkOqBqM09AaozguNKHZIlO3JoI9Y
	FixpE0XYa8R1/uKG8c9y1W9w4ZUCkqcU6AVZ8Va4hUWA8dtqVwZkEZGdDJrrwqg8ImyXK+pIesT
	yUqfksihxu8yV69cn1GyjoBInXyuxbtVwYaBLjjxwfvsx3IF+iHTwG6Oy+fpDpv5MYRtNI2AeaZ
	C8lBR36ZbiHobOVTEk1EF6Q4njkyA/jplPeOlw9AxZ7himeRE8wApuxL96QPdxPBVT83cKk7E8h
	McFtnxExayZ9e3WCZdgjDslUmc/AzNMC1cJmCUxnI/MMBMSn1P9+Gbsrf9yXSAGuv5ZVo2RuKw2
	oVnZg4HLIOgNnm9TqEd3NNNbZKPDTni5pbxQb5hLrg2n+OyCaR1ctZofgHayw6hsxmm18BncDb6
	yd0b/y10daxvnV069h86H766cLc44T10cHIYhaV3CfEMWkTCl0s7UXrUWra3gNKxH25PRCY4JQT
	5Ekczn59IxgGWleiLBjc4p3bB10pH9bkNiywmHW
X-Received: by 2002:a05:7300:ea0e:b0:351:6d7f:e2bc with SMTP id 5a478bee46e88-3537e04ce24mr478585eec.2.1791498399999;
        Thu, 08 Oct 2026 15:26:39 -0700 (PDT)
Received: from hitalo (208-33-161-131.in-addr.arpa.host.souuni.com. [131.161.33.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb1d6e6sm985148eec.24.2026.10.08.15.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 15:26:39 -0700 (PDT)
From: Hitalo Souza <enghitalo@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Hitalo Souza <enghitalo@gmail.com>
Subject: [PATCH v3 5/6] Bluetooth: hci_event: Disconnect an ACL link that completes after its abort
Date: Thu,  8 Oct 2026 18:26:15 -0400
Message-ID: <20261008222616.2780570-6-enghitalo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008222616.2780570-1-enghitalo@gmail.com>
References: <20261008222616.2780570-1-enghitalo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for
aborting connections"), aborting an ACL connection in BT_CONNECT sends
Create Connection Cancel and deletes the connection. For an incoming
connection that was accepted, e.g. one that MGMT_OP_DISCONNECT aborts
before it completes, the cancel fails at once as the device was never
paged, and the Connection Complete that follows finds no connection and
is ignored. The link then stays up in the controller with nothing to
disconnect it. The same happens with controllers older than 1.2, where
no cancel is sent at all.

Disconnect an ACL link that completes with no connection to take it,
unless an accept list entry makes it an auto-connection, which is
handled as before.

Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting connections")
Assisted-by: LLM
Signed-off-by: Hitalo Souza <enghitalo@gmail.com>
---
 net/bluetooth/hci_event.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c825a99db..14270711c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3301,8 +3301,15 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 				goto unlock;
 			}
 		} else {
-			if (ev->link_type != SCO_LINK)
+			if (ev->link_type != SCO_LINK) {
+				/* No connection takes this link, e.g. an
+				 * incoming one aborted after it was accepted
+				 */
+				hci_disconnect_unused(hdev,
+						      __le16_to_cpu(ev->handle),
+						      HCI_ERROR_REMOTE_USER_TERM);
 				goto unlock;
+			}
 
 			conn = hci_conn_hash_lookup_ba(hdev, ESCO_LINK,
 						       &ev->bdaddr);
-- 
2.55.0

