Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4106221FDC
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744800805; cv=none; b=k2K6YzgLdw8v0BO8fqGEkkRNZ1cPWkhiYGTfoZkdIjfmOfDsdLivN0yoQNLvrNxuIiNVl2mmcKJi+1vxO+yvdXvKnozGW3i17RNpvrXGJFkj2uR82uty++6LRpusOiWQAKo7rggF4NcT6hbrhnkt4iWLrj17ig6bkFqdlyrc1hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744800805; c=relaxed/simple;
	bh=PfSGBvUWhc3EPcezZl8kyNlFmcffBx2UoWqgxQejhN8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MZVN/kbwAxCaQ1vhU7E7cv9FvY79zBLakke0KWAom+4LIIQuoGhPnTj87nVUs/llGrVo3D2GnS+mdDdo/CvhH/BWrpqAi7J/ZVqS+S5TQ5B1S5iaR+dFEgZq5Ww115Lo7QdbSl2ERHF/sF4BvYpq/Qn1nxDthXlZIwKxmN8olvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gqYnwFi8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gqYnwFi8"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso65115925e9.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 03:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744800802; x=1745405602; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYeqNCxuchI4k9TsclsT/9N8Dbton6CL1KBWTHEeMVE=;
        b=gqYnwFi8NKiBqpYxljYAMEybEAxE5IYi1JXy75cmv3ZFhAeF02PaK5d7gECGUPTzaL
         /HLRYSaWjpi/Nlig9B04qFmJ9KwN2uVzyjD9NbvwC9NrnBhICwcA8Q4i4lTQW6C/FqXY
         nifOJWAWvFhHpFGF0fSqfoicseWha8wSZOU1dqkmLW4oPe6UoN/0rfYCbU09ZzavgdRE
         V4RVyTuize+sbcCedjBLocUgN/g9o/6rbSn5hExy1zs4/qA7Mh3btH2z7ealiMh4QV1b
         +1353M5FUHUE7fxRIXFzChjlzXKlOQE9ZwUVNyHsB4PrZIUQtO2zlpbqG0MXXYr+Y0Jv
         wDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744800802; x=1745405602;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYeqNCxuchI4k9TsclsT/9N8Dbton6CL1KBWTHEeMVE=;
        b=TX1vKMPAUC6Vkn47XlPTHXgY68qgnmN/zkfwirLSf46P8SbRrh68P3aejTaegGbqXL
         B5Z4s1ctDs47CYe9Xb5MJT0e/jRYxhTOY8mYMQuaIISckkm9kvvKfYvN13qiHDi5aK32
         fuqK6EoO1n9O0lmNwZBhkpwZCKihJPCDG4ODz8nec7TzH9FEafSuER53DWGpb7OTWlTX
         L9vJHNSnan8sHiqIQ7H3xIUDC6dbCsKtRrdmeUHTmOcDH5Hr9JF1a4zjTZiuxNpD+iHO
         sGQ++EZMvGtxgpPTwxHg0JQlIu2nzrhte+A9cZRJAqz2KoPfI25VTpKHZAv9QGcOo9XT
         oHSw==
X-Gm-Message-State: AOJu0Yz/pUgjLhGq92rA2mufRVOB+GnweNsPQHF6sZZKOtesFdFC0CQH
	ZlAt0i7Un8I9CVZuz6d56SAqwqPG6GdspUxBwXCJXKt7wMviV+4tDWVdSm9dtX6Zk9O3MDfhHdD
	S
X-Gm-Gg: ASbGnctA3GhTG60MB+DA0qSb230++68elyamLg3bjT9dfa+jXsoAnTILyUf9kmhQNI2
	XtyEL1LoaxmNnr5cPEsBH28dXmUjF8bh/E3RGrFEy7zj0ooMooCpMa3fXJt+s2eG1AkMLLf/cTH
	14JE4pfyOBRssi5JEhIfk0r3Uatci6IRCLmrT4lkt9xUJ4grsGW/ZxNBrYcJtiShvxVMlsN7rc0
	rF7kg3hMKYUV8AerqVlIRvkvu9Ah5nB8ziOGib4Ko2PXSxo40OpHXjjrgzfE92Zy8Y7qf3KoYkg
	Co75/lCQlflL92m0RyY6xq3rMJ4xvv9SVAbDuo56GH0o0w==
X-Google-Smtp-Source: AGHT+IHFVaW93q+iQ9sb3mV+SYDaRm+1oNSiMrMhclDsdPF4hD7RCgZYd4ahqU+UsFLHbSj1XWRUiw==
X-Received: by 2002:a05:600c:a41:b0:43c:fe15:41c9 with SMTP id 5b1f17b1804b1-4405d6250c5mr14098195e9.9.1744800801839;
        Wed, 16 Apr 2025 03:53:21 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4404451c67dsm22530995e9.3.2025.04.16.03.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 03:53:21 -0700 (PDT)
Date: Wed, 16 Apr 2025 13:53:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bug report] Bluetooth: l2cap: Process valid commands in too long
 frame
Message-ID: <Z_-MHr5yIFm8kNym@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello Frédéric Danis,

Commit ad5747d4eed1 ("Bluetooth: l2cap: Process valid commands in too
long frame") from Apr 14, 2025 (linux-next), leads to the following
Smatch static checker warning:

	net/bluetooth/l2cap_core.c:7613 l2cap_recv_acldata()
	error: double free of 'skb' (line 7557)

net/bluetooth/l2cap_core.c
    7484 void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
    7485 {
    7486         struct l2cap_conn *conn;
    7487         int len;
    7488 
    7489         /* Lock hdev to access l2cap_data to avoid race with l2cap_conn_del */
    7490         hci_dev_lock(hcon->hdev);
    7491 
    7492         conn = hcon->l2cap_data;
    7493 
    7494         if (!conn)
    7495                 conn = l2cap_conn_add(hcon);
    7496 
    7497         conn = l2cap_conn_hold_unless_zero(conn);
    7498 
    7499         hci_dev_unlock(hcon->hdev);
    7500 
    7501         if (!conn) {
    7502                 kfree_skb(skb);
    7503                 return;
    7504         }
    7505 
    7506         BT_DBG("conn %p len %u flags 0x%x", conn, skb->len, flags);
    7507 
    7508         mutex_lock(&conn->lock);
    7509 
    7510         switch (flags) {
    7511         case ACL_START:
    7512         case ACL_START_NO_FLUSH:
    7513         case ACL_COMPLETE:
    7514                 if (conn->rx_skb) {
    7515                         BT_ERR("Unexpected start frame (len %d)", skb->len);
    7516                         l2cap_recv_reset(conn);
    7517                         l2cap_conn_unreliable(conn, ECOMM);
    7518                 }
    7519 
    7520                 /* Start fragment may not contain the L2CAP length so just
    7521                  * copy the initial byte when that happens and use conn->mtu as
    7522                  * expected length.
    7523                  */
    7524                 if (skb->len < L2CAP_LEN_SIZE) {
    7525                         l2cap_recv_frag(conn, skb, conn->mtu);
    7526                         break;
    7527                 }
    7528 
    7529                 len = get_unaligned_le16(skb->data) + L2CAP_HDR_SIZE;
    7530 
    7531                 if (len == skb->len) {
    7532                         /* Complete frame received */
    7533                         l2cap_recv_frame(conn, skb);
    7534                         goto unlock;
    7535                 }
    7536 
    7537                 BT_DBG("Start: total len %d, frag len %u", len, skb->len);
    7538 
    7539                 if (skb->len > len) {
    7540                         BT_ERR("Frame is too long (len %u, expected len %d)",
    7541                                skb->len, len);
    7542                         /* PTS test cases L2CAP/COS/CED/BI-14-C and BI-15-C
    7543                          * (Multiple Signaling Command in one PDU, Data
    7544                          * Truncated, BR/EDR) send a C-frame to the IUT with
    7545                          * PDU Length set to 8 and Channel ID set to the
    7546                          * correct signaling channel for the logical link.
    7547                          * The Information payload contains one L2CAP_ECHO_REQ
    7548                          * packet with Data Length set to 0 with 0 octets of
    7549                          * echo data and one invalid command packet due to
    7550                          * data truncated in PDU but present in HCI packet.
    7551                          *
    7552                          * Shorter the socket buffer to the PDU length to
    7553                          * allow to process valid commands from the PDU before
    7554                          * setting the socket unreliable.
    7555                          */
    7556                         skb->len = len;
    7557                         l2cap_recv_frame(conn, skb);
                                                        ^^^
Freed

    7558                         l2cap_conn_unreliable(conn, ECOMM);
    7559                         goto drop;
                                 ^^^^^^^^^

    7560                 }
    7561 
    7562                 /* Append fragment into frame (with header) */
    7563                 if (l2cap_recv_frag(conn, skb, len) < 0)
    7564                         goto drop;
    7565 
    7566                 break;
    7567 
    7568         case ACL_CONT:
    7569                 BT_DBG("Cont: frag len %u (expecting %u)", skb->len, conn->rx_len);
    7570 
    7571                 if (!conn->rx_skb) {
    7572                         BT_ERR("Unexpected continuation frame (len %d)", skb->len);
    7573                         l2cap_conn_unreliable(conn, ECOMM);
    7574                         goto drop;
    7575                 }
    7576 
    7577                 /* Complete the L2CAP length if it has not been read */
    7578                 if (conn->rx_skb->len < L2CAP_LEN_SIZE) {
    7579                         if (l2cap_recv_len(conn, skb) < 0) {
    7580                                 l2cap_conn_unreliable(conn, ECOMM);
    7581                                 goto drop;
    7582                         }
    7583 
    7584                         /* Header still could not be read just continue */
    7585                         if (conn->rx_skb->len < L2CAP_LEN_SIZE)
    7586                                 break;
    7587                 }
    7588 
    7589                 if (skb->len > conn->rx_len) {
    7590                         BT_ERR("Fragment is too long (len %u, expected %u)",
    7591                                skb->len, conn->rx_len);
    7592                         l2cap_recv_reset(conn);
    7593                         l2cap_conn_unreliable(conn, ECOMM);
    7594                         goto drop;
    7595                 }
    7596 
    7597                 /* Append fragment into frame (with header) */
    7598                 l2cap_recv_frag(conn, skb, skb->len);
    7599 
    7600                 if (!conn->rx_len) {
    7601                         /* Complete frame received. l2cap_recv_frame
    7602                          * takes ownership of the skb so set the global
    7603                          * rx_skb pointer to NULL first.
    7604                          */
    7605                         struct sk_buff *rx_skb = conn->rx_skb;
    7606                         conn->rx_skb = NULL;
    7607                         l2cap_recv_frame(conn, rx_skb);
    7608                 }
    7609                 break;
    7610         }
    7611 
    7612 drop:
--> 7613         kfree_skb(skb);

double freed.

    7614 unlock:
    7615         mutex_unlock(&conn->lock);
    7616         l2cap_conn_put(conn);
    7617 }

regards,
dan carpenter
