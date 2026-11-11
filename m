Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794359635;
	b=DaqvhoPk5lt3+Q2ImQ8ImYUKEhN6g8wUEbsJihKDuAj20XtKYIGKu0qoWao22VzZNKp3
	 9Ndsc95bRTG9umnv7QLiPbQAlrOAT98gYhNWYL95NpKMrspH8BymBXBL9vvefPaE8bHOz
	 S/FvgMANQLNYxNeIB5Er2x+mgUcbgFLiOsFdVINrdX0nCN/TOqqSHmkhTGenUWnC6NlNc
	 SYI8lJMl5V77pCQWCSlamA2FqplzDzz7zR6x071+czz5a79E2YuIB28O7RvuafoIVl544
	 UtKaYHcWHo7mmSctmh81Isfx2sdZpird1PktJaEkRvRLv4EHBqfIWDxc3GTsAtNC+Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794359635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0RCMeh5RkDcTLkWTQxLL02nIskvBKMN/nivYW0pWPfg=;
	b=2uKau6xtMFkDGtMFI4vM5nEzGsv57vj0fgtlgrRYKBXGAAeac/4HtOGuba089OT0ei/l
	 jpZcjCIYdn6DOHPJ3srE+X4ik/lBcCmA2JbrjzydzXQUAbqSjx86Oa902yk3q5esBNDG0
	 gPTqv7ugZrfz+r4TWPziW2qpUeKjsakp7OF6C61ADt7CScx7Uk9EzjY7MUdqDq3MQb6hU
	 FPTOIPzCPTkoWZPYh7EIgQqjK8BdqEezEr9xKkIBrpmIVQRWhlNNbznF4d85I+kASn04W
	 GBQTMGGNwsLXDcvpYuEZ51zAR85mOTjUVqDUSxuQtQ4che4ZH1s8QdFMcI14aaRsI2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ub10aDMF;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9F4606A33E
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 01:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB9F4606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ub10aDMF
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3720addb068so4802558eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 17:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794359634; x=1794964434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0RCMeh5RkDcTLkWTQxLL02nIskvBKMN/nivYW0pWPfg=;
        b=Ub10aDMFWXaKg4DURzcYet5y5RX4HvdUg0oSJmB92y0SALShSn4naGkd8wpd+NEGCw
         0FjGQ+KsX57m459gfD/k9XbBk1ApDqmowBd3PQrhUB1F/lx4WvtTJxdV1WZSoshBoWaY
         6z+Eo3dt/YnWlEVtGCbZaeRjtXr9EabxhGYda/SCsqlPpASbdyD9so8kfQtQ5HW79Ltn
         jR1jAT7kMjW2wev9mGh1+1iV+suRDVvu8S0vf7yqzvzG8J2xULwSzQyWlJlb+XrIQoLt
         IZTXkFuV5uQ2T2Wu0rh4lKkq6QpokY02yQI0VQ0kVV3tOHZOFBVsMNTCiXnfPDrc0ApB
         6g1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794359634; x=1794964434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0RCMeh5RkDcTLkWTQxLL02nIskvBKMN/nivYW0pWPfg=;
        b=TsSCQ58kU93+N0yhKd/rgFtcfTRH4P8wEoZDcfa78PAP/gjo4e/zLHd18T1RmX9zHT
         cTC5VE4NJXKakY82GVSSDW0hzpLk8UH0vCwqwle5Y+oEwkOBycpE72qwBeeQMpgCfsfV
         5bLbBbRwacyhcCkzj2LWZZ7pzhsP0sZov3XUJBtOjcExJT8R2JyABF3KSg3+ngYhUxWb
         Ai3EWuB7Z3I3t/TuOuqFA6NMSqyVmBpWoPBTKf4MHqQvg9EMNUskqtWrEZGwBlEfu+hS
         EnWmLpEPmVwd0zMBHzWrKCSNeGMAs+aXekZSNFgu4WRXcYNj0SkeCIFOkoNXjhlHpUiH
         eOcQ==
X-Gm-Message-State: APuU4Z883jbfjO4T00v/F5GUPxEZMikL5iX60O8t4rTpE9wtPtfTflf4
	zt8EX0AH+vg/HJuAa8kksFRnwKNCvexEXnGyThxhjLeeqOA12JuC4enE
X-Gm-Gg: AYBFou1QEa3QCBMddfzN8rVc+lHUJiFt+yATi2SmOjv9NzZjJZpKqwGoZbNnh/KBTi+
	80yQeDEkfUB2P7FAq9ppKETIHznCkF+cxiFKxgwkf0+r5EqccLQD8Q9LKk8qNiHeV7UjAWMmWMR
	u/25+jGAA1hYAOUfy03ohOFpTnwDMJ7QUKp2tqAn9lD6QyHxEGtWdL2lubju4XEjKPtMhk8YOkb
	euGLonlqHfL3pLdCKMrLd6UK1DdxXyfFYAJhJ2M12/9voy4FCHISdwx/4vQRt2VCPwC2dd1RcK+
	JCHlJsnyDC1yzFK6Eq6tpPyLbTb46lUuy0wy6ibaXlQJ8PmAHMvktMdj1lvYE4qeTjYDA1Yl8Pc
	1oefgUPZHWMjfgxf7WR7IUFuPp58JjSxP//lTCBSTFp4CM9Ht7Erx7DupgCEW7Y5jDz/yeGsF8s
	lMX+UcrkbbM9mFXs/VTgsPnDkRneFexdw7ZdVzV+EH/FRv3ouVjtet+4kqzjvh4DvmVSRJWDdHI
	NoPcqUgQp2rPvumVEH2Jyra9oFw1vqQXK5Rsjx2nSG6Qtuu1QJ66vcEyQeEKsNoOYJskagJnOiK
	V151uuP2vRhPUABmDs1+rJe93mXa62WyDH23TrvZQZnD0zqTOho/wlbwaBRLSnpMhqDiQ7fioIg
	=
X-Received: by 2002:a05:693c:69c8:b0:369:fe81:a575 with SMTP id 5a478bee46e88-37686756684mr1215850eec.35.1794359633847;
        Tue, 10 Nov 2026 17:13:53 -0800 (PST)
Received: from localhost.localdomain ([96.44.128.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375215d8889sm11262949eec.27.2026.11.10.17.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 17:13:53 -0800 (PST)
From: Weihong Guan <weihong.guan@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Weihong Guan <weihong.guan@gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Use the advertising set handle, not the instance
Date: Wed, 11 Nov 2026 01:13:50 +0000
Message-ID: <20261111011350.728642-1-weihong.guan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CABBYNZ+h_7fpuKT1aa0EOEEzsJbNDRxgW5nBuWV33u+8F-bfAA@mail.gmail.com>
References: <CABBYNZ+h_7fpuKT1aa0EOEEzsJbNDRxgW5nBuWV33u+8F-bfAA@mail.gmail.com>
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

Hi Luiz,

On Tue, Nov 10, 2026 at 4:02 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Looks like the following comments haven't been addressed:
> https://sashiko.dev/#/patchset/20261023132421.1889022-1-weihong.guan%40gmail.com

Sorry, I hadn't seen that review. All four points held up, and v2
addresses them, with a third patch for the Advertising Set Terminated
event, where the responder address comes from:

https://lore.kernel.org/linux-bluetooth/20261111010940.728149-1-weihong.guan@gmail.com/

Thanks,
Weihong
