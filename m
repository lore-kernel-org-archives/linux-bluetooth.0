Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017564;
	b=CuH6DCCWYlsxeR8/06ENv098YXv36qFWMTTwOhsHSdku39hyK8HbQqbCe/SDPwL4R+g/
	 HHa7GS7URqJjURZe9yo+S95d7nEy8HATOLEWZG3kNLdyvVCDRzXDCNWOtMyb5AEBinCnD
	 YKJZKKVOHw5X2wCwPeASaMpZdgnHh7g1GvS0PSpc+tit2o3I6s/l2EJIKJ7MKMo3+q849
	 FgIpTabW8bdpw8mGeLJGqrF5Luby04t+j2jVYY6JG66Jc96VosX2lM45otUw0O+m5hpLm
	 dsbm2aTlmpzd8VazOjZ8uffquk0A/gCDUfh2GQZQ/OOLgnUyLUaqmmbsDFwzRNymXFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vtxpwpuGtInRr5gt07Rg6EoXYRMP/GTxLvl77pRX2aw=;
	b=NUd+EZvpGa/UD+kXQz8Rq6xIB35Oj6PqZRSMmBP6CGs1jzPgs2lLjwZeXyjWrqB9COh3
	 VMYJo5xhCMQnnLm/MB4Tnkf9GdPTLHVeBEIyOFC6RTAffUEndWwOXb5171Qljgpiwl1/H
	 /v7S669s1WYwpoXn6pohA4jobeck0oPH/FaIJyk8UZsTZh52+MBws0mRNH0DOxa8P2bQF
	 nm2iDYJeJZD8+8OkbOSMKU79o15e+18h4oPdRtBRdvVE+WAsIwj/XmKIkw0DjUKxeoBew
	 IMTNxnBTu7BL8XbYYRGmn21zEloDIIRHJC3+odFQ28PnWFAtiqJnvnx7TZWvrkblZoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0K8smtmI;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8378606A33B
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 15:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8378606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0K8smtmI
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5ee2ad94713so741334e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 07:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795017563; x=1795622363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vtxpwpuGtInRr5gt07Rg6EoXYRMP/GTxLvl77pRX2aw=;
        b=0K8smtmIq9BXTo6/iMGjmADgrCKwnVhDUUWoj+iGGK+4zlfvJKlgIeGx9joYV8t5WU
         xF7ms6ygfI3UM/4ThqiUF02eJMnCJyh5/Is/bNtT2PP1gifKw3WY+ElYRdPfKSs0bHal
         FjMZy5ccrvYlRMsoeapjtnnXnQy16LA6jG2hog2YL2xNaUrPn5S7wzu6m+4QaKATkuP7
         FRK1Xxspt4mAB3YnlP7JmjIFjPl2uuh3u0Dc9giBbDAChgVtE9AJFONM44GCQPS0pBoN
         9H05FgGHj4J3+jmC4L9NmqOSW0H/vAOYBq9QdOJCXDdXGugn3ZumT1X/JyeqNm7xWsuS
         +Q6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017563; x=1795622363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vtxpwpuGtInRr5gt07Rg6EoXYRMP/GTxLvl77pRX2aw=;
        b=cPzSH5eqPWLKF57AotECVCPcLpsfNcrLJBR2oEMkoW4vWHAAoXv5TK939NzIitBLeK
         Yyp3eNL72l0KtnqhhkN+dFkCYJp3nujlHn8BAgCrFcLLLC9e9/M3LURr0t93MtlZ9OyV
         Jv/WP4psvIVJCxamNGJ3NXAmHLpEUCbWAFSS2XRUTWvmBNxVM3Yjcm3X3VybVDcv4Erb
         zkGle2UYCkeqsQAWJzWHC+DmLHJ7aV/S2xZljiIpxyxdkfwFgIrTFIaKWAlb/Degpvhb
         eznZjWH4vZ34YUlSY5sQnHk5jVmV0fhRl4Je4Twcr4Zjxbg3exIWQWsBqsRTeMOu7Glw
         jVkQ==
X-Gm-Message-State: APuU4Z858ReRiC77tJAm9URx10h6V0wRhS7Nk/3wfCJGJNA72SIqut6C
	LkxcgjPRNnEv3T1RjIrhRZrjQeU3Wuyd1ohPsCIl0hPim0NQDyAbk9twBvdxX3XW
X-Gm-Gg: AZFdTZcjHYixcWAFTDPMZK77TzRHNEO2lM5hIo1Df79YYWoBng4T/by+riKedWDCItM
	FNEjA90z46sSyegwb3ZaxcVSpRUOQWhrN26Xx9NlTr3+rgmrZfZ9/lK2x1ci3kLXauk59jQ02ND
	7Nq1gP2MJgk2CTZoN5rcfjxlPTur5U/y1ryMhN1F6WB7qyw7pGjZTM+GVssRngklBesa9d+i9eB
	/bA1qF6I9a4xHdEkucm95UZGA9xsPo03gJG5HvdBI5OzY3+aljKYmMD+tdnWRu7UOfpYumze/DH
	jm9tRb5vdtMQ/FkTfRAL0MLxxmU7W2E9gsNuafW8oiErd1VRrOdp1wsZgjxtmaIkuhHQhUssDvf
	JRPPLofWx8+6h9NWGnJJA1wGItMOEm/AV4I7F4oXM1gVm0Br0XSm4pLgSX4L4vXwIDYuVFMdu4c
	qom1OYupUei5Py5mdSA6pSkOdQP4Kpvt7coOzMHe7LAj94f09c/rqDX7fxga5Uh5UauTFFHYcmB
	62SgMZVWdCXBASAinpbVG//2YRtNpgrZxIAw9jxJkse5VKc4WL43xzNtAsQRTUhQy/FjZgl13EP
	YAsiZLh2cvNtbkRoKxFcfiklNnNI9IREZEpwkrSuafuISF91h+EYDFYK+SsitRwEBqVi4z7bS7l
	hrvd00vD0WWdqmrQ8lakIQNzbaSjREU3cQcSDh8rhYUfGUlyuXA8zD2LJLCVGag6F88vZXN4Dqh
	5NjYU=
X-Received: by 2002:a05:6123:148:b0:5c9:a60b:e5a6 with SMTP id 71dfb90a1353d-5ee6476011fmr1904704e0c.17.1795017562742;
        Wed, 18 Nov 2026 07:59:22 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64e4dfe3sm1919266e0c.5.2026.11.18.07.59.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:59:22 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 08/17] Bluetooth: hci_event: Validate sent command length in LE Set Ext Adv Enable
Date: Wed, 18 Nov 2026 10:59:05 -0500
Message-ID: <20261118155914.178050-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118155914.178050-1-luiz.dentz@gmail.com>
References: <20261118155914.178050-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_cc_le_set_ext_adv_enable() read num_of_sets and the set entries from
the last sent command without checking its length.

Reported-by: sashiko.dev (linux-42bcc244-62e6-4295-802c-f9a512ca49a3)
Fixes: de181e887ac2 ("Bluetooth: Impmlement extended adv enable")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7908d920c67f..ab875b90a143 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1685,14 +1685,16 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
 	struct hci_cp_ext_adv_set *set;
 	struct adv_info *adv = NULL, *n;
 	struct hci_ev_status *rp = data;
+	size_t len;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
 
 	if (rp->status)
 		return rp->status;
 
-	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE);
-	if (!cp)
+	cp = hci_sent_cmd_data_len(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE, &len);
+	if (!cp || len < sizeof(*cp) ||
+	    len < sizeof(*cp) + cp->num_of_sets * sizeof(*set))
 		return rp->status;
 
 	set = (void *)cp->data;
-- 
2.56.0

