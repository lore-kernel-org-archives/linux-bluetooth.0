Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795663001;
	b=bfbDv1gePmXiiTIVyh4Eaj5ELiJn3Uxo2FgxKX/6/Lz6OVXkmICUwqkWWGesHFwi7aaB
	 tnPKSxjI2qJGwZg7Pt9Sy8UnWCOjY3jilM4EVJoMiQofOpIwFD7ynZ+RG38VmP3XgE/XQ
	 lMiLus3Ee1tsLne+X7ol06iXnEyScBGOfRIA2zZc9zVIVzNeK1AR/IGqNn7c9ZHDXNeYg
	 Czw86nViuvu4wRmNabuwgP/SO6YYr2WtXD0/upcf4TRQEVV15mc6km7fR85Zm/A4cHdCW
	 4tmA0NMLM0152SxTVG0JYXpWMb0ae2pm2UThCCFWCKDRzkaDc/DjWMefXc4fvPeS/SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795663001;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=I6pOY+Waybxfn4DtoVSm3bQ4AEceLe0b46JGW8J6YGc=;
	b=3R6cL8n8lWwyujwo/Du9V365koyarNLyt4hBJAZjzbYImRdFaIFPBwHcGz6bSYSOYdVd
	 EWeGxuWRRjY9sfShWDLv0JtxV0xoacgssF93o1YihMIArDK7/IcVapUrdSRZW0JvJg7fe
	 n06olGC7P7q9nRYUV1dU6C8xiclAnQU0h6eW/4092DlQmS+xKN42/btUhmingW/klZ8WB
	 QIv8xCcRIsiT3q3aoNSLA6bKQ9jZHYlxD6fpTMsPw+8StthpP55wEX5jEkYklVyVA8sca
	 IbIBxd5jwGQJPBReFKiHfah+K7/Qq3xirWKVrE/xp4Xtw8pkZL+RSGuNrjHgKgVP8gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Iw9hBUqp;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD383606A31E
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 03:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD383606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Iw9hBUqp
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8c70c2ab5a2so2610052b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 19:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795663000; x=1796267800; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I6pOY+Waybxfn4DtoVSm3bQ4AEceLe0b46JGW8J6YGc=;
        b=Iw9hBUqpowR1Bbl/ePTPbA7XCXUI9Jo9k2fws85ZLENCWtlBQdDBA6/aVLCxCNy0WS
         q+/EBBen8NmcHMiWm74w7K/iUE7oZwcX2tLUVN2H/z0i61eOm9qqWA/b5Zy4u9zgQf4M
         rxuwrbCrUuDXeyMWCjjr5dbgnUM2mRrVfDjImRc7BDtfw1UuychbCQlvkcn0pxjad9iw
         n3e8+hxFNkz2G2kj/NmakgCf/lbNiC77yS8jdgaC+LmyP2cRbdNR4HQn6dKoE5TrpGSs
         +9wJcJOxvvq83iq0Hb1PdCA2lveWrTzULYXki5Vos0D1tiibx9JG8amRJ+uDxDvxQdSd
         HHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795663000; x=1796267800;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I6pOY+Waybxfn4DtoVSm3bQ4AEceLe0b46JGW8J6YGc=;
        b=HQrdUYYIe3esE8PggBI4TlGfiV4qSa2cndSwkwjvIJFkwEkD52KqsfVbzd6QVtbD7+
         dHPfSQdc1FeIig5X2IDa6HdpILn+/iRP++d7mvlMym238TZOM3KSkMEChgKGHm1f9zrl
         A6EDEarz0TYsUDV60Pxdyj7fme9rWzjORCkHiKYFYyjyW6qxZI8PcC/hgrMl6mOzmO51
         E40WqumU/0AVCAsSNsH+5gsO1xkCCLiAFMuQcBQdAJHVFQ+KB7c6edsL0aajKDT4HDgs
         UqlDeM4e3yXf5aJE5Ky3DEUJfur5rwCTEgSEIHJczF9I7CzozIKZ7e9BefX7fOy4li57
         J4ww==
X-Gm-Message-State: APuU4Z9MUO80AZ8lr7cwcc27jcdgAkP16WhfEe1Oa1Q+8DNkPJsIA8rA
	UGTJ3Bc5ZebhpkLM/qTXnJtO1jg+aQkQkrRzTTLFaPbgUlvKoraAxuEuo+mehQ==
X-Gm-Gg: AZFdTZeffdh2aYc+WtLo+PiEXv5GiEPx0NPCRbPpQsgYmJIcl7DN7zUpvHwZGzTGB9V
	5Sq9fzXhilkiMSBnk0T1dfDgWVuKN4o9l9sHhTofA288M7As5A/wNxfUf8ngjyuOp7xE+HNNCRD
	LwyRRzboDcfWCYF4cprh7JYDMSF6gOIQYPdvYlIYeHIqHf6djcruNeVjcyCGJZB6Rp+0Kr4ry2V
	HtY9zXhswiRVUN7HIS3m4wqePGJqKpwVqr2gAml1yBcGSEJkEjUyE++9klivPvxIkDBTNRPK4sT
	cHDqD1SKUHGq85joUc8cL3H8wDxzUNwQW0lWhO4nRStqQI84y9Xz+R+gItbHdJgms4UXAwVLHLO
	ghfgnIoDPj/gLq5DzCs96vMZWwKT2rRTziWJRlgLuxHO4sYavwZbVQI2b2teKF8z4L1390m3VK6
	8P3SjBZOjmrIpHYMPnLf8EFkPolAhrzSHu0WhQjVbEZwZbiE+7XghlgFZyrPnA7gkqGI3+kvM6u
	iR/6evHJYHjc24LJMqDQ+AmZzgMBpoIgRR9UoVMWNzKp0KEydwCXvLlHFZ2rA==
X-Received: by 2002:a05:6a00:2d8e:b0:881:e626:74a0 with SMTP id d2e1a72fcca58-8c87d221e1bmr18833734b3a.47.1795662999924;
        Wed, 25 Nov 2026 19:16:39 -0800 (PST)
Received: from [172.17.0.2] ([20.98.117.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077fe3fsm10272155b3a.4.2026.11.25.19.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:16:39 -0800 (PST)
Message-ID: <6b07a497.62581374.3c7a46.4949@mx.google.com>
Date: Wed, 25 Nov 2026 19:16:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1711593245350737035=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dickson.wu@certik.com
Subject: RE: [6.6.y] Bluetooth: hci_uart: clear HCI_UART_SENDING when write_work is canceled
In-Reply-To: <CAFaZ9ep1MzprNHirA++5XpLuQC4PhibJr_FBWHxEt=Exvic1QA@mail.gmail.com>
References: <CAFaZ9ep1MzprNHirA++5XpLuQC4PhibJr_FBWHxEt=Exvic1QA@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1711593245350737035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 39
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1711593245350737035==--
