Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792963825;
	b=XptHPMMDONXnzsYE9Cxhz0Kc4/34EapbUJd2PHAv3qDVdH+sXcSr54BehILJlVI6Rh9k
	 xNJNO1WH+FhUihbxwzTap+MCvnl+MuvY9pL08oYbvwsLKrTSlV74S8FxmyCssE7QMvDDc
	 067r5rGKeojZz8uiHFNp0Xv0hcdYUru6DRgWa8wc1kE1HyW5LZUMA8daT2tnSmdm7HVtb
	 RLegWzxzrI+8wj+5yw/jl7RWAXqTNj8a2vK7+uBKPugA1UExtHMmn3JzoqPbQgKLHavns
	 jTBUu7widlWvk4HQjtvL5u6LGkllMw0JaIgBYn56Y8CJcfKSloLcaekiVmAIM9JnmXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792963825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xSo6YJyFeQ1zMbTyziwWYIcuPb7sycKW/4CokJbJ79A=;
	b=Z8S2CxgflS7hU3ojKL7lIxPDz4DWY9Rmvl5eIpLJxDug3+zNn/U86KS/WrfxEpHVko/+
	 pmQemWF+/TK8s8h2JtCO+fcznIYrjQJcXzOottH5gPfULsJI4ythUrhopgE+1P5mT3q1J
	 lva9QRQSiY2sIYDuDIfG/mBt/pM0xWzCGg7/2Q1mdn/DmEJLLXuoUJ0PJREXypCS70BzG
	 3nxQ8WXuKH7KaPik/8Mo4Yf7sO+AubpflG7fY9OCqH9SpAQU2Nz2PgqRyaOhrLvM+gI8P
	 CMLfym7XC2S9nWHHEdnkK71xf/UQvg1Izp+OUVmdt9GKew45VFnI403M2eNbXsUUZKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JZIdBnWy;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FE7606A31B
	for <linux-bluetooth@vger.kernel.org>; Sun, 25 Oct 2026 21:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4FE7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JZIdBnWy
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c40e02b2ebaso369124466b.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Oct 2026 14:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792963823; x=1793568623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xSo6YJyFeQ1zMbTyziwWYIcuPb7sycKW/4CokJbJ79A=;
        b=JZIdBnWyoWNxwt0dJMClhHkij7U/cXI8BSQM3pCxVUOjKg5NdEIVx9wZf7hJIG//cY
         vRlT8JSCdS9ZVgqp1fmrr/6FQILnYuQR1v3KovBDPUN9nu7SwE2NGCiMfd5KRTjGudQH
         dxo1SpIygBmtfPsfwDxzaK80fWhWKQcQhZ/1ix3Zqou77fhKBHQCT2uv+5HxGUW2ULxg
         MOqQo1sJc2Gp4ZpUhTFGjsWObTH8safBwhtbtDvTGG9T8FOpG719OPd8znP8Ge8SM7LP
         +hvXvrupHKzBNXKVFE6OvpvnS/pKolFe5fM8MtseMOYdKDb7YSUiQBdmuzFUlwvWOFwg
         HDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792963823; x=1793568623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xSo6YJyFeQ1zMbTyziwWYIcuPb7sycKW/4CokJbJ79A=;
        b=jSyUOgmEoUSB7lJmcCMLAXTJkNivuMcrq5i/Hs4XBtFYV6JjSjmxTfcjiCs9su/C+C
         tamsQo5AYIRKwSCBAT4P3gVrae6ykrTe5LWEGdMaNC6dCZ8JKRlzUlawZ6LTyUPKhEvM
         r9VyzslVmn5l4XxLxke1Gp7VtYIATsQfmiSutD641OI54kEuxWz90HgietWSFpVbScFU
         VsOj7QGUTHMGTe1ky4zfI373zdrIE8bAuAvnJQ4YW0c6+j5qhdbNy0uplHgT8po/wr50
         jrl3yMalZ8Lc63Gm8Uf5/aDDSKIzsLFQaaMwtw3+7TqHRnoP5QanUZhdJkR/pDDCWvy2
         RbeA==
X-Forwarded-Encrypted: i=1; AKwUvBw4ftvZ9fKvNFMrrjQdgWybKBlpmFpoioxuH8rYpuQGIZT+iZvxdzWQo9Qyx5+lwc1xUtWAB0M+1qzQCxAQfCA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYBgYfMd11eO4RWMnMfE4mtySOe3pZEtYuzFDSemPoTS9iJrKi
	d8JNlWN5MS8AgxkvdaPf2DrHFFZpD6J/5FFo3ijoIIzTn2xo5fHj6dyC
X-Gm-Gg: AYBFou2IV0v5mkQpFNkkVf1g9DqECf28y93+1pt3FRYoQofGt2YU3Jala6taWDDg/vZ
	Hzv/KPwkQKfobIknU72cTNXgEPTNpzdBn3jWLps7WH2DLahsI5JrfmdVVQ3Z0l+OOIOJcLumIAa
	U7Ow3sEBxwFuicKBHO7DGllvrCkk5XPUx38uV6jOSYlxTifwnR8zVuPZs5Yd5H/TNCD37jX8Mcn
	qnxD1790zpTSA9LcB55junAxLH2rRHKAZH1TUDVXoCzEf9jnTZYlQe0B7+o6K3GrYzI9jnoDlKy
	heV+tPzsUotUzxH62GVRfceT6GiABb5oM9trgDUSJe6hl/1OZkhfRZfJLa6yL9FMvYEeVCxQgeq
	MUSgvRdfvR8t7Ig4JVoEAc2CFDW9FY618EfTdAd+44vIfp9+ib9qyXQ3cy+XEjIuBLeWKyEzNGS
	xFJrc963Nn2udmkK6ERzoxa6ZaNBIFrJlIWopUzNDDRmadmfXkL5mUQwRh5yghDFbpw9YIely7k
	UtHJh2G5UF0X7NnU+Lz1W5VITQpHITwAXxybINAquXZcKHhf8fBUapQtyL7jjw=
X-Received: by 2002:a17:907:2d92:b0:c40:f9ea:7375 with SMTP id a640c23a62f3a-c46bddaed7cmr675175366b.15.1792963822908;
        Sun, 25 Oct 2026 14:30:22 -0700 (PDT)
Received: from nb-xps.ts.zxczxc.org ([78.56.243.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd79eb05sm244744266b.79.2026.10.25.14.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 14:30:22 -0700 (PDT)
From: Nikolay Bryskin <nbryskin@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	linux-bluetooth@vger.kernel.org,
	Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rocky Liao <quic_rjliao@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_qca: Reprobe QCA6390 after hibernation
Date: Sun, 25 Oct 2026 23:30:13 +0200
Message-ID: <20261025213013.12956-1-nbryskin@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <atXiYxot6UZ3MDrp@makrotopia.org>
References: <20261017174310.22484-1-nbryskin@gmail.com> <atXiYxot6UZ3MDrp@makrotopia.org>
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

Hi Daniel,

On Mon, Oct 19, 2026 at 09:30:06AM +0000, Daniel Golle wrote:
> Would you be fine basing your patch on it once it has landed?

Yes, thanks for the review. I'll send v2 on top of
device_schedule_reprobe() once it has landed, with qca_restore() as
you suggest.

I tried the combination in the meantime: v4 1/4 plus hci_qca converted
as above, on 7.2.11 on a Dell XPS 13 9310 (QCA6390 on UART, no BT_EN
GPIO). After resume from hibernation the reprobe ran, the firmware was
downloaded again and Bluetooth worked; s2idle suspend did not trigger
a reprobe. I've replied to 1/4 with a Tested-by.

Nikolay
