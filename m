Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADD62BE63A
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272265; cv=none; b=bNf1Qg+evSxPwf4H1xM2hCatDhqgbR27wH4iaFvprXS0Bq0JKPLJhk6dgd5p8688R+lucuN8nP5jlb3tuT/AdHfRrbN7VX/gvim3Hk+ySU1XdzKhTkNbkSVD/EVvavWI67T+Ik8+YPsOXMWgzLnavMhq8Nnk1gtfdDdJ8upAnNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272265; c=relaxed/simple;
	bh=JZ8ALzi4l89b67PM7h3d2OpqJrjHcj142Sm+/TmRQXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4Rk+xpwX16nGVcQsv/fwbXwrpZdMOcvBPLmdkCfq0sNmtUHYLbumEAKYj02PHzPbBd4JzmpShP84sjYY87PsflveE8fB3LhgGCyyM48O/j6PSXgtYIJWGzDsswpuf6vPOUlNRQ0KgCicvgAftu1zNI9U2hFIf+NNOFAeu1Q0nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wf0DDs2u; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wf0DDs2u"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b5516ee0b0bso557352a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 01:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758272263; x=1758877063; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IVX4Bv4ex+uyVv1pbESwXdzZsofD0/jfymFeQrylr4k=;
        b=Wf0DDs2uizMTfq3zfvBcKXu5ATpz+VEOd8RMG064DgUkkDalD60y+yLLeBEiWtKQHy
         ClYMfxp3q3aQUl6fh6aLBhPK6SjnL6vo0imXY3afGA9TmkfaDjaJ1ttGhFe3PhFfg1/u
         mD4paJW5zfBi5T6W4B57CTwrG+wb9HSJwtYzKQtBp6+/BkN8clV72/fN6ASniYsiHh1l
         nn3ZBwGpcfOUFi+PA80U7f7sC5BIKplCLKTBU0pVMHtF3QyDEf4OqLDfCL6yfNiLEEup
         c2ULObJPLklcWFN+v8ERY88+k2l3lmrcLrOFEM8KP+YZOjtJKIuuzcdx1pV2D7SecLA0
         KXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758272263; x=1758877063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVX4Bv4ex+uyVv1pbESwXdzZsofD0/jfymFeQrylr4k=;
        b=iZQJH6Yma1My2+f4N+jSZl+epC9hvCtnowZDNCLZuETKLA3DH3g7kAOZNPE7ISs9zS
         I0tPIeX+lEQBeDrqVg5GzLQmDNCBzbhL7LxiRP7i9lJmHrQZrymsBOTntaPOpzDBo3hq
         k3vxf+u4L9CPrMUETlKTW5GgQnd5Lu8b6XF6/24ztdpy8Ig3QPZIhiCp0RqUM9ddpkFg
         mfPCoP7XA2WxQSn5rgZiZdkVxygGGpPNrUtDtdD2e/EMV5cYeHRQilsiw2121avUO03V
         9p8P1E7OEqP/grcHsyiW25Ap4NOFFHW4CTFv6XAW9VX9z0XWmpFMXwi0nzAgE7EBH6Ex
         xCVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX83TI2fj4EBkqMo8eoQzolYdcQsb1gpEo65dxRjGSM3UD84hMHtVH5JjlhYqWEv14IZ8vO4LTx/RIP7eqydZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrOZucbcLGRC31dP47QFAYU7cHsO7Z7yPzVPoBDGVueYwfwWEt
	i74D6V6p/Ud9g14NmcXpsjGgh0thHHWFH0lMI0DOEkccg7+6i8zHeefbqSl5foY8No3Sw9xaqGD
	qZNtlnEid+IlbT0soFop4DLyT9/kxa0Y=
X-Gm-Gg: ASbGncuHcdYab8WU+p4VaEioHrlk9tP7HMmpZ3P43X3ZQ3l3wahOOqAoyDhgwMbJAgc
	g9wof5dqTCQei6PPs4f0uey0b5FfmGR6dLYAFala/jNlaPif0N72uo1wgjBqSQp7lgsT2XxCbOT
	xzS1888mWVLgPTwOlADskFgDMhExgJaoY8kAYB002fvTpEqZqq6nvBbYsD3pBKmnpcwasaNUQ/C
	zUALaBxVG5ydgTfuReW
X-Google-Smtp-Source: AGHT+IHUvEeTq8dbZhTVSYIaod2IJCP9IAd80QKZqmcoGD/pxowUWYdmJQVUNvAlNGoK2mzZTyBH/w0E0uCfSxtDO4k=
X-Received: by 2002:a17:903:2f08:b0:267:a231:34d0 with SMTP id
 d9443c01a7336-269ba527e91mr32353655ad.42.1758272263501; Fri, 19 Sep 2025
 01:57:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFRLqsWnWnDaY2a23HctbxLKquvw7Ax30YB-tdBmS59RtQ4JBw@mail.gmail.com>
In-Reply-To: <CAFRLqsWnWnDaY2a23HctbxLKquvw7Ax30YB-tdBmS59RtQ4JBw@mail.gmail.com>
From: haoran zheng <zhenghaoran154@gmail.com>
Date: Fri, 19 Sep 2025 16:57:34 +0800
X-Gm-Features: AS18NWC4ROcPlc2EncCLRhcJUzB7R-S8-CSg44ldda1VIZQG8MqmarJKmJUInTc
Message-ID: <CAKa5YKgAP5L+uBr3R0Au_n_s4N73y0NPFVh0y1XYPaAJyuCB5w@mail.gmail.com>
Subject: Re: [BUG]: slab-use-after-free Write in sco_conn_put
To: cen zhang <zzzccc427@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, johan.hedberg@gmail.com, marcel@holtmann.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, r33s3n6@gmail.com, 
	linux-bluetooth@vger.kernel.org, "gality369@gmail.com" <gality369@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> RACE CONDITION SEQUENCE:
>    a) Task 31374 releases socket, eventually leading to sco_conn_free()
>    b) sco_conn_free() sets hcon->sco_data = NULL and calls kfree(conn)
>    c) Task 352 (workqueue) executes hci_conn_failed() -> sco_connect_cfm()
>    d) sco_connect_cfm() calls sco_conn_del(hcon, bt_to_errno(status))
>    e) sco_conn_del() attempts to access already-freed sco_conn via
> hcon->sco_data

I think this vulnerability should be located at sco_pi(conn->sk)->conn = NULL;

Specifically, when sco_sock_release is called in the Free Path,
conn->sk is set to NULL under the protection of sco_conn_lock(conn),
and the TOCTOU problem occurs at line 87 of sco.c. When performing the
if (conn->sk) judgment, conn->sk has not been free yet. However, when
sco_sock_release is called After the judgment is executed, resulting
in conn->sk being free, it causes Use After Free.
