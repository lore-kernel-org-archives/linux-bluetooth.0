Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87C120DD7F
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373555; cv=none; b=a9rAQk1UEdgxVVh9xY1CVA0pFEnmk49yjefNdh6+o4TaJ1iihq3Y+ld1IosdPlomVOFy/Unbipe+WZChOI7Oot+6apCSxk9Djj6Oa212GDZKi8PEd6o5M1ly8miDxi0/lWA07mCUNa4b0sNe1A1Ybd1CxOo/npq06s9d9zDIRaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373555; c=relaxed/simple;
	bh=9ttZewlov5GiUJNx42xZ/V73kXpJCFTg18wip9eYyVY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KZx/IknoP7JOfHSQuoRe2m6NTeIp4uSDPYx3vsQr3BAJveAvZxXyZJhZhzx7Q8RtTRHIVTulXx2Cuz+zYjQDVDVWo7wWck4QD6fZ0L+HJfNFqE88tonCDdfsVsbwjaCONpNgRQdtiplJ16k1Q7grJszq2rQYbtW2SQtz67eXdsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jkLbUSd+; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jkLbUSd+"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so1291276366b.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 07:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739373552; x=1739978352; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ScVgMitwZ57Yn8XrG/PxvlECZuTNQICzbbZ2gpuU4Dw=;
        b=jkLbUSd+vLa2DtSr3Nkd9o8cdgR+gcAlrm4loWAqSEficXwZU3PxvgR62Ns2G7o5oK
         Xrq+DzMO027hygzWBCS5+FcotnvCHH7AuYw/UZRpM4+yqxvX9+qYbVbq/uHE2r5dQh5Z
         a+9EPdfebmtbvYV77Yplxnv7b+kIHhValhDXDsNlO17HlmuCbEczYmDoG0TrHIBSuUPZ
         dF3JYGQLOQrUlofuEnrAxyCLuJ3HKhbSqZ4hOk24iQ0Zt15ugHl+Veor+6APVuDmtDkq
         u9ZbIkb11D1nU1tkYnhAp5ZvepRid1GnfGLfKfaGfnoKwIh+01fL7IponnsdOOCiKPWN
         /ZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739373552; x=1739978352;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScVgMitwZ57Yn8XrG/PxvlECZuTNQICzbbZ2gpuU4Dw=;
        b=E2e39iBDH6jlPJrsOuKqXlW4cVU1ezHo+Ufoz4LrvMtMV895CljZDuWpM/Nz/MD7jA
         nD2NgmIR2dkyc+lYZYDgog1NrcnHi664u9GnkRYCAZ6IxazbTXto0By+K0TzvEYnHQmm
         Wia0h0jTTc3l1mJp+7+UrZ/GHdqujCMV5kxxPX1C7kwBZH+Wbu4fH0CevsySOWyFzRXo
         nAfbp3VLNIrnWAvP6AqkT7TM6BRKbQOpGl6s4/Mb+vO8iJRTX9h1qzk2GvfHI1Qy4Yyp
         C5JZ1PlGuHfl3BdqSyFAsru7gArGE6Td4Da/Tt1MLsngG37fzWrkMGIDzjFB+Yq/QfBs
         oDyQ==
X-Gm-Message-State: AOJu0YzRANyd7vBhYwBb7inUcwVLmT/B7nzjMvEGbxidXsyWi2jSeucZ
	N3pMKIuH0G4j9J300Jw5BjZdcZymfNm5b76CnIkp72SaUImdl+8Z/HKgER7MChY=
X-Gm-Gg: ASbGncsGqknBYzZCQ6i55m3c8P0ToPXjuPJjhEGiFJ6Kb79RgevbyM+i1xcrj4KoUxV
	BXaLU4ft35TX/lJ4f/r/Ak34ZQW+cXxfFYv/Rist2jR4aWsnqT209ywUi6FgWCNJK9SF6nNZxgR
	l/TQi2k+LB8FMpJhKuhulJriKOxjxRC1vdfnWZRFYFztQNOXN2jsySLEnMJMkEciyTedlST+hit
	tqke2IFp7BU+5vwDvZ7tQ8Zm5nnXRA/Yd5somGjal+rfw+DQtVVzpALXkDC7BxI81Bx5EypyXgJ
	KiRwGbUCWv9PUCZiMBYF
X-Google-Smtp-Source: AGHT+IHy0mscs+M5JMQk6GINFjY1XsmLBr3EExOW0ZXgS/wVmMaV6oMZfxvZoYVRI+eePS/G/NrXjA==
X-Received: by 2002:a17:906:ee87:b0:ab6:d59b:614d with SMTP id a640c23a62f3a-ab7f33814aemr326572266b.23.1739373551740;
        Wed, 12 Feb 2025 07:19:11 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab7c5dd464asm581555866b.185.2025.02.12.07.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 07:19:11 -0800 (PST)
Date: Wed, 12 Feb 2025 18:19:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bug report] Bluetooth: L2CAP: Fix corrupted list in hci_chan_del
Message-ID: <4d3fd31a-7289-44d1-919d-92f1da4355ca@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Luiz Augusto von Dentz,

Commit dd6367916d2d ("Bluetooth: L2CAP: Fix corrupted list in
hci_chan_del") from Feb 6, 2025 (linux-next), leads to the following
Smatch static checker warning:

	net/bluetooth/l2cap_core.c:7555 l2cap_recv_acldata()
	error: we previously assumed 'conn' could be null (see line 7459)

net/bluetooth/l2cap_core.c
    7442 void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
    7443 {
    7444         struct l2cap_conn *conn;
    7445         int len;
    7446 
    7447         /* Lock hdev to access l2cap_data to avoid race with l2cap_conn_del */
    7448         hci_dev_lock(hcon->hdev);
    7449 
    7450         conn = hcon->l2cap_data;
    7451 
    7452         if (!conn)
    7453                 conn = l2cap_conn_add(hcon);
    7454 
    7455         conn = l2cap_conn_hold_unless_zero(conn);
    7456 
    7457         hci_dev_unlock(hcon->hdev);
    7458 
    7459         if (!conn)
    7460                 goto drop;

Do you want to move drop after the unlock: or do you want to make this
a direct return?  Choices, choices...

	if (!conn) {
		kfree_skb(skb);
		return;
	}

    7461 
    7462         BT_DBG("conn %p len %u flags 0x%x", conn, skb->len, flags);
    7463 
    7464         mutex_lock(&conn->lock);
    7465 
    7466         switch (flags) {
    7467         case ACL_START:
    7468         case ACL_START_NO_FLUSH:
    7469         case ACL_COMPLETE:
    7470                 if (conn->rx_skb) {
    7471                         BT_ERR("Unexpected start frame (len %d)", skb->len);
    7472                         l2cap_recv_reset(conn);
    7473                         l2cap_conn_unreliable(conn, ECOMM);
    7474                 }
    7475 
    7476                 /* Start fragment may not contain the L2CAP length so just
    7477                  * copy the initial byte when that happens and use conn->mtu as
    7478                  * expected length.
    7479                  */
    7480                 if (skb->len < L2CAP_LEN_SIZE) {
    7481                         l2cap_recv_frag(conn, skb, conn->mtu);
    7482                         break;
    7483                 }
    7484 
    7485                 len = get_unaligned_le16(skb->data) + L2CAP_HDR_SIZE;
    7486 
    7487                 if (len == skb->len) {
    7488                         /* Complete frame received */
    7489                         l2cap_recv_frame(conn, skb);
    7490                         goto unlock;
    7491                 }
    7492 
    7493                 BT_DBG("Start: total len %d, frag len %u", len, skb->len);
    7494 
    7495                 if (skb->len > len) {
    7496                         BT_ERR("Frame is too long (len %u, expected len %d)",
    7497                                skb->len, len);
    7498                         l2cap_conn_unreliable(conn, ECOMM);
    7499                         goto drop;
    7500                 }
    7501 
    7502                 /* Append fragment into frame (with header) */
    7503                 if (l2cap_recv_frag(conn, skb, len) < 0)
    7504                         goto drop;
    7505 
    7506                 break;
    7507 
    7508         case ACL_CONT:
    7509                 BT_DBG("Cont: frag len %u (expecting %u)", skb->len, conn->rx_len);
    7510 
    7511                 if (!conn->rx_skb) {
    7512                         BT_ERR("Unexpected continuation frame (len %d)", skb->len);
    7513                         l2cap_conn_unreliable(conn, ECOMM);
    7514                         goto drop;
    7515                 }
    7516 
    7517                 /* Complete the L2CAP length if it has not been read */
    7518                 if (conn->rx_skb->len < L2CAP_LEN_SIZE) {
    7519                         if (l2cap_recv_len(conn, skb) < 0) {
    7520                                 l2cap_conn_unreliable(conn, ECOMM);
    7521                                 goto drop;
    7522                         }
    7523 
    7524                         /* Header still could not be read just continue */
    7525                         if (conn->rx_skb->len < L2CAP_LEN_SIZE)
    7526                                 break;
    7527                 }
    7528 
    7529                 if (skb->len > conn->rx_len) {
    7530                         BT_ERR("Fragment is too long (len %u, expected %u)",
    7531                                skb->len, conn->rx_len);
    7532                         l2cap_recv_reset(conn);
    7533                         l2cap_conn_unreliable(conn, ECOMM);
    7534                         goto drop;
    7535                 }
    7536 
    7537                 /* Append fragment into frame (with header) */
    7538                 l2cap_recv_frag(conn, skb, skb->len);
    7539 
    7540                 if (!conn->rx_len) {
    7541                         /* Complete frame received. l2cap_recv_frame
    7542                          * takes ownership of the skb so set the global
    7543                          * rx_skb pointer to NULL first.
    7544                          */
    7545                         struct sk_buff *rx_skb = conn->rx_skb;
    7546                         conn->rx_skb = NULL;
    7547                         l2cap_recv_frame(conn, rx_skb);
    7548                 }
    7549                 break;
    7550         }
    7551 
    7552 drop:
    7553         kfree_skb(skb);
    7554 unlock:
--> 7555         mutex_unlock(&conn->lock);
    7556         l2cap_conn_put(conn);
    7557 }

regards,
dan carpenter
