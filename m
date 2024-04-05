Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63456174EDF
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 20:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712349668; cv=none; b=ZlZQTx0T0tXP/+v/Mmed5pxKVJOmK3WBQc2ePNYluS+wAYPQlAmvpCLnHKH1qvPizva4EQZ84O1Apf2WV6fjkZLybkL0Rb9UN7UxP/nuSU/m1Tif1Y5QHRvBzF3vDAA8rTNQAh8HOOaOTPE0zk/comLYAq5/gEQaPd2eZBVCGGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712349668; c=relaxed/simple;
	bh=iXNizauSXh66GDHlq1xzX42c+ElqefZx2lOfRicB8yQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZ8hOwXAMejWToWQLEe1YDBPYioivjesoJZKspCHP1u6LMnQCJHra9L5+qrD8tpLw7rWArrOQNDOgwwMQBlnbpeAz/F8VYNZQOoIT88L+ymJU2Oecu5yYrgjYV8xdEUpSaZXB3jjrcYalFUR/koRxHnyqpUv3BnvDXbDgikvpIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sjfgo+aD; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sjfgo+aD"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4dacb2ad01dso21646e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 13:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712349664; x=1712954464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUCzNWsmkKyWSoZrbs7OPkZEkFyQh9bUXtmeEbSQTqg=;
        b=Sjfgo+aDp5640BTpbNK+txKQdz6EU3Tvs7UjeQcWxNPCRicAedVW7sjIlaJkmaEErO
         fOOruO8879JFaRGI0NfO7KAjbZuPF59ji+dbUMWrO6MfTss458lTduSAti74TUFWUSS4
         GuQTtnKW7MPWZHPtRgYWB/4KMP8QNy2WB+wt0hrPPuHGFtXajLb9cfO/iiz0GN3tB1ZU
         skorQj1A+ARYhoh05HN71IenwF0COT4x1HqtmsH1K/pIkGMMeU3yiyRVrUJDgp9QK3c7
         kwW5Q2x/Ul8ZJVn6eW8TlHwIbMOTfXdzKZdM9iaVVoOiPcT8iCOI1svSpKHEFVYLAeSB
         F6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712349664; x=1712954464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUCzNWsmkKyWSoZrbs7OPkZEkFyQh9bUXtmeEbSQTqg=;
        b=IdbNnJ0zQ/xUX+d6hA0CECet25FVjdY5tG8i2EGunRch6PyC9iuKEGdJ5j0DsiJmS+
         Wq5pHq5eyxkR2hkGFqKyZk8O0FsoK8cIoBDQOSd/qFt3WZZD2RdGJA9JjQG4uXykoK5Z
         BMF6lDW1aq/XSVEpMUZprTGp1t1OK1StgDuwMkxUiRCyhclF40mckjij5itsNjNIvT84
         Q7NbhPyUxrud4A5wPVYKAcsEa6Sf3CH9q/gIQwLUSyZy+0pZoXFJYkkQ/ACTBSNUmdna
         uW+61e4RetVp/uk1tWdsOW1oTHhsnC+TeEj0s5P53M9vdCBe3Q9HqmxjYF/c6j5qIrQE
         yDzA==
X-Gm-Message-State: AOJu0YwhMisZEnS8IKJtuaZTYFzSqDSQfjlkBpT8xHMtjcWWJt7ApOA5
	5tiLCpg9mfZHmy3KyV6cNpGPxsaoSg2l6hRkwPtiIuplgRz3OB2YIONmLloB
X-Google-Smtp-Source: AGHT+IE/EjOvYLRMeRzjRKFUPUFYo0S31SB6gQiewFstmHSRh6dgpfPbFABwn0890UTJ1BOVKQK6VA==
X-Received: by 2002:a05:6122:1792:b0:4d3:3846:73bb with SMTP id o18-20020a056122179200b004d3384673bbmr3309449vkf.7.1712349662306;
        Fri, 05 Apr 2024 13:41:02 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id l76-20020a1ffe4f000000b004d89b77e45asm326510vki.51.2024.04.05.13.41.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 13:41:01 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 3/4] Bluetooth: L2CAP: Fix not validating setsockopt user input
Date: Fri,  5 Apr 2024 16:40:55 -0400
Message-ID: <20240405204056.3451243-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405204056.3451243-1-luiz.dentz@gmail.com>
References: <20240405204056.3451243-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Check user input length before copying data.

Fixes: 33575df7be67 ("Bluetooth: move l2cap_sock_setsockopt() to l2cap_sock.c")
Fixes: 3ee7b7cd8390 ("Bluetooth: Add BT_MODE socket option")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_sock.c | 52 +++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 7846a068bf60..b8913fbd77ce 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -728,7 +728,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 	struct sock *sk = sock->sk;
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	struct l2cap_options opts;
-	int len, err = 0;
+	int err = 0;
 	u32 opt;
 
 	BT_DBG("sk %p", sk);
@@ -755,11 +755,9 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 		opts.max_tx   = chan->max_tx;
 		opts.txwin_size = chan->tx_win;
 
-		len = min_t(unsigned int, sizeof(opts), optlen);
-		if (copy_from_sockptr(&opts, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opts, sizeof(opts), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opts.txwin_size > L2CAP_DEFAULT_EXT_WINDOW) {
 			err = -EINVAL;
@@ -802,10 +800,9 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 		break;
 
 	case L2CAP_LM:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt & L2CAP_LM_FIPS) {
 			err = -EINVAL;
@@ -886,7 +883,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 	struct bt_security sec;
 	struct bt_power pwr;
 	struct l2cap_conn *conn;
-	int len, err = 0;
+	int err = 0;
 	u32 opt;
 	u16 mtu;
 	u8 mode;
@@ -912,11 +909,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		sec.level = BT_SECURITY_LOW;
 
-		len = min_t(unsigned int, sizeof(sec), optlen);
-		if (copy_from_sockptr(&sec, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&sec, sizeof(sec), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (sec.level < BT_SECURITY_LOW ||
 		    sec.level > BT_SECURITY_FIPS) {
@@ -961,10 +956,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt) {
 			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
@@ -976,10 +970,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_FLUSHABLE:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt > BT_FLUSHABLE_ON) {
 			err = -EINVAL;
@@ -1011,11 +1004,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		pwr.force_active = BT_POWER_FORCE_ACTIVE_ON;
 
-		len = min_t(unsigned int, sizeof(pwr), optlen);
-		if (copy_from_sockptr(&pwr, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&pwr, sizeof(pwr), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (pwr.force_active)
 			set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
@@ -1024,10 +1015,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_CHANNEL_POLICY:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		err = -EOPNOTSUPP;
 		break;
@@ -1056,10 +1046,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&mtu, optval, sizeof(u16))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&mtu, sizeof(mtu), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (chan->mode == L2CAP_MODE_EXT_FLOWCTL &&
 		    sk->sk_state == BT_CONNECTED)
@@ -1087,10 +1076,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&mode, optval, sizeof(u8))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&mode, sizeof(mode), optval, optlen);
+		if (err)
 			break;
-		}
 
 		BT_DBG("mode %u", mode);
 
-- 
2.44.0

