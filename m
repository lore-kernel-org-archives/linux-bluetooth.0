Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A1A2FF66A
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801997; cv=none; b=s2gRl3x//LZX37xber5QV1mor0F3dOW4H52JrBr4JRZGsEbNOtNnQ9eFxBoPXmPBsFJ/Wt0M8/NHWO6yqfwfP2dRuahN9jUyIkrYkpjaYkAIeK5APptazkMj2Z8c9mywhVoTSwls/3rdPJWtEfuQS+xuBzNkFaRX/I/3MF0zBFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801997; c=relaxed/simple;
	bh=4CrCTU9Asb+/uv4BtZ6hxlCRJ1Byhi6n6RLn+bqTloM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/11LFkVMV4Y10ZqpTStqIZUztpSoKLuN9yJCP8I3SXM0xr0Tc2Ml3zOdpV0rasSXEiYY8mD8N5662KXFvQ5A99zuucWoOgUkT4VoHwxqEkPtEjuNWku30HCPW3af97RR/pI35r+M5z0mZuX2MhYdk/5pp7HKPuytVIceUYDbH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fg+L7T1t; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fg+L7T1t"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56624fea96fso2344088e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801995; x=1770406795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHkCC8ImeBxrSn5BwUxhqLd2lT5BpRUu7cjnP3Jt9Ag=;
        b=fg+L7T1tbaOVxhoEnlLF8SzfB7VA3xZ1zY0q/LIMR5ODRRspIQbGpVkaru54kwQOAh
         pyb1d7AIe2MZL5mXR7ZPsWAJNQpGnyUqlck155kmlwXlc1S+C+2wBltZl+saWMQf72ni
         0aFLFTUDu+64y/etZi1pQ1c1c+iR4j9ekkUHZubwFgL9VnjTnV/neIteiyVQk1AGnD6Z
         Hd4j9TTQ+k0d4mq8WjgViQLdOWx1PM0HJRpdnr7P44IrJ07R4OMkvw5CDZ3wDSf6Ye/t
         xiXeaiJDfTzQVJoWWSNLIHGbe0pS8wByK3vM/RJX/G1qCeEmQxOleb0q/WiRioYQYyRS
         ttwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801995; x=1770406795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oHkCC8ImeBxrSn5BwUxhqLd2lT5BpRUu7cjnP3Jt9Ag=;
        b=hmhx3AH58KAqvHNEMLkaJ+gCJXOC45EWXEMV+DixxIS/v9r75HrwQ5fbShfG5DSc6B
         6JIqIjzCAUNHJ2doIIIj2hu6iHMjDcr2EE1vKYDPmYK0IkxlkwnMxtk40N1fD8V1+q5h
         SvH++xuoL9yq9Tz1kNh8DAoTpJbeDTYhAyrH6LsKducYRlpcLrAj3rtIVInN5W4E3o4z
         lL4+bYIIUtEYht7ABNc0G7Euw1la9jk2EtSuMW4nlKj/ayDp5xFJA0tLUIoIp9HGQs6v
         dYNSukThQr6/6mBPbkln/ZcdY/pn0GX/vvQlNOrEBdrsUeflyyYdaiHpO3G8Jtx260PK
         PQ/Q==
X-Gm-Message-State: AOJu0YyhgjLvDBWqw7z80D2euZNju6wz+h7SyXP9pb4ZkoJhhvdpVnGP
	28cruUuGnhecraJZCHBZ2jOYebfgCJAZi3HkWzbAuDmZ94h1j+jtWT4nl/s44A==
X-Gm-Gg: AZuq6aJfQLcC+HREEYTplOcXU9DTGDXOkblbRJHNCbUivx+M4VKKzVYLtaED4iIkSEH
	LWUgGj+ZMGwtQjoN1TndI6tcSevrMDL1+WgBiHf1uz9z1OwuVt+vecQVqJZ8YgsNropFZJP6aRO
	6heVHBgLLleEk4MIyzlxK2MF2/0r4rPUuKOrp8RERQMdDLWzW3gOyKMZzEhnxLlyw2viVJc4eDe
	UCfY+SLAeAGvqJ6ZfI0r1JRWzw4MwbwvwR5aPnGOI3bkaeImyOWG8++gMSaAyQo5c64CXLKCMVX
	YxGUL3ZnSgjszR8L6uZ7uXwIGS9cT2jQL9/dVp2gUWwdeJgu7wB3vH6QyXqKQv0FVxntSpmOueA
	i2aqyXW9Dmh1vB8d1OO2mc3HpErGl4o96CZyVCU497HqcG9KFu3BMVIezzWSNyvtpAMK0ymVwnY
	ucT8LGQMQi3ALOpCGZgZniWKQBv3bphfbeIRFQ6Fn8XmwIaMTZHhifoZfFNALk/dqcNArNWUJEY
	xoBhw==
X-Received: by 2002:a05:6122:3b0a:b0:559:6788:7b55 with SMTP id 71dfb90a1353d-566a178398fmr1030721e0c.3.1769801994749;
        Fri, 30 Jan 2026 11:39:54 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:54 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 25/35] doc/org.bluez.GattDescriptor: Add Used by reference
Date: Fri, 30 Jan 2026 14:39:07 -0500
Message-ID: <20260130193921.1273263-26-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130193921.1273263-1-luiz.dentz@gmail.com>
References: <20260130193921.1273263-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add :Used by: field linking to bluetoothctl-gatt for this interface
used by GATT descriptor operations.
---
 doc/org.bluez.GattDescriptor.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/org.bluez.GattDescriptor.rst b/doc/org.bluez.GattDescriptor.rst
index 76d274464f51..969976d1fc2b 100644
--- a/doc/org.bluez.GattDescriptor.rst
+++ b/doc/org.bluez.GattDescriptor.rst
@@ -31,6 +31,7 @@ Client
 :Service:	org.bluez
 :Interface:	org.bluez.GattDescriptor1
 :Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}/service#/char#/descriptor#
+:Used by:	**bluetoothctl-gatt(1)**
 
 Server
 ------
-- 
2.52.0

