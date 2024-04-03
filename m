Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB5713A88B
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162765; cv=pass; b=jHUrAUkDIXPRMDloH38jw2cxHzvaifVecJZkDccGwROhOw0vvfPS0a2KuzfI6vQQ4VDaOJ66Mb+zHOUmNnNw7/kxTO23+iwxJ9L34vq6bJsS/hBH16x4WHWa9ujJIDHCgr6F3x8oGP9enakGBnbr/ZSulDFZk272I/Fr/ZYagNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162765; c=relaxed/simple;
	bh=Rbylmd5Rutq4+i7hfKxure17mD3Xd1qpj1qB5aB12wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/GAIPJjNBEhLto33EfqKfe7AxMl9DrmsmoQ3dnjj82cEP0oH5Uz/6AOjyhgUK9lmHCUnSx0HiIM/k7t8Dpp8duLll5jTJHCVGP9Lr/yo9WSH3HfnkZTGAhf2l3Zqnez2cB+YRqWzw5h3zLiURdo7o/l7qb75+Zw7hS76T5+Qmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=j84FpjV3; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="j84FpjV3"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V8rGx4Jmbz49Q32;
	Wed,  3 Apr 2024 19:46:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712162761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQHBUQvSEBJ4gmBHTLJ902z3SIHMiTvD4BQrU7DmKLU=;
	b=j84FpjV323eQ6hCs0/xAOoUYqROzJBp2ngj4aRXEaO6OmL5oFBBD+5Go907XGt9Cas6zyV
	rbHuEKqF7lVnccG6CtRGdOhk1kJMt0DYrc9SWBKQDcrVC+MOxbU3uJLkRKCmejuhIFX7NT
	70SaFmxkHxqmmfZFKCtKoq85+SSHtEi6F620XFF1c13Ofno+fhMQJ+Kd11lfEHUfGcoYY5
	bRWYuoDB1knHiGFxkIc3Xo3Vy/lQOW5JUR66v42Zw9xfaWRcv6wvhBUZYfmvO36tDn0BMp
	43O+e0nJj/q6OFc7ZHyAQzT5CVXoX31Oqb7G8bT5J0Vh5UdEJPfaCYlE1cPHvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712162761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQHBUQvSEBJ4gmBHTLJ902z3SIHMiTvD4BQrU7DmKLU=;
	b=EmQNzLwEXdVpor9Oa9tTgHkT1n5iw3eV+eKhqP5KTXMUAyinhNr+I9CeEKuzReYYF53x9i
	xeiqfnUY4AFu0xP/QSeohXSeVO3uGKquavVym+ymcJj0IY4M53kw35wGvNnn11r2TRYDE/
	as12ZXzB9jg3xAA/OXq0Y0d/XhymyFBtGctCLAvcllv6gUzUU2SXWwW/wGER8aBsIH8rod
	CmjsHkYFO6HyZoyWA1yv9aiG/SjG7T6npxt4CnI9CDBURLDbD4ZyzSUqaik52qQu7mDKKn
	l9UT1WDvJtJWlo4QjVTnazx9s+h6HObGfktsH0SABccR4ctkcXRlJJQbVXQCoQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712162761; a=rsa-sha256;
	cv=none;
	b=TNlbmdAaT7I3LTbXJ4jxvSO2nP0zD9K2PTSFpoIj0ZH513GBE83xrOfJNNT1abY6xfpr23
	iOnzBgO9RlkUpD56CPKAyHeby6VasH774QQKrwUbsbm2u+CrISJssD6oj/877gCBroRFMT
	940cg4st02IxZsmJjaXuL7SS/PBPcgqxr7n84mCF2VEpjlITdkX7hTnFkO/M/+BfQvtTpO
	01E8D4fSrjbJT9SkBOZ990iIxPDoPXKFD3pdw3k0Kse60hfm792/wXCN9GPAeP9U7QG6JZ
	bkApNRlNCCFi71JQmNR2+UJExDdpzKOBxeHHeAppQx1YCP1B9kL8ExhKMUytLQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v5 1/7] lib: add BT_SCM_ERROR
Date: Wed,  3 Apr 2024 19:43:20 +0300
Message-ID: <1fd56079e4aa89aa1056a3cf185610a683ee02ba.1712161649.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712161649.git.pav@iki.fi>
References: <cover.1712161649.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new CMSG type used in new kernel TX timestamping support.
---
 lib/bluetooth.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 75dc960c8..a4ed65d0b 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -141,6 +141,7 @@ struct bt_voice {
 #define BT_PKT_STATUS		16
 
 #define BT_SCM_PKT_STATUS	0x03
+#define BT_SCM_ERROR		0x04
 
 #define BT_ISO_QOS		17
 
-- 
2.44.0

