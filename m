Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF8A2080C1
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776870568; cv=pass; b=BAsIJyF9Ijj21f4k70JlL+xDvxoN+eXN3AyAIfmO1QQQ5YzoQu9zvnvQZ+fixneV4qiqQeZ2sYg4mcrMpemBZFQZrtXOeK8xz4RYqfdgvOkuNjCfYGYwGcnpRKXugrczFKWwbzPVCuBpU93h7vMWK0GCk4qMK6zwtG0TBppmVZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776870568; c=relaxed/simple;
	bh=yB8B77JLIfj5PBVja9oB5jjN3JjIN0aTgqeadBN/H9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVOuz6h+rxTtinfeA7hhtFLJ2niksjeCTgDi2mdYK4E9QT2yxUJlsN943ZTTsjQAe9Ri6fz2ZFAXOdtbY8qsu/zaj9z+sCZKXbClV4Axas6w4taWlib1UVeBnIkLW+LWsdya4D7bKRmFU5sTCba0gX3F5UOCHEV4q+R1gDZuVn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVwVF4DM; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVwVF4DM"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6530dd51ccaso5278550d50.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 08:09:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776870567; cv=none;
        d=google.com; s=arc-20240605;
        b=DkQeb5xPpqjE3q0PXMjShp9OgiAQ+3SuaWOt2jt/vzMCJzrMInxmzzkL+sGubaoHQa
         ukdkzXf6geToIgqHavpMcYH7Laj1TcAv45luRtUNnJeB49jdlkqLZYn1FJ1aMk4SMxI/
         DBu3Z9+1+sJXP/RkpAF//rwEYHkLOeVLdi4z02JmS05MyrA8rToihXIm/7x34PtxYt1i
         wlWuvo/EwjZcrY7bLEXRP52z4qduPwfoLyAV8URBLPmGJ1f/5Y/JWy/J5GylHkjZQiPc
         utna0XggyujkkVD4rL0mJbLmkWfN27GZoF9Jtuno/1QwG27olu5rgdeW9DnfRyn86rfo
         O7rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1ncIyEFzhwxY5D0p2No600gLoVMdCZ6F3j3pxn6/wiE=;
        fh=4gZH1K6USBhp96eKRMVgfotQ3wofoiG+k+IqgYLsR4k=;
        b=Uiy532we9XSTqWiY0Ytll5zTzlBg2Eeqdsv/ocHdqFZTV1naw3YtK51VU4c6jqxXVH
         VXC1mj4XypWMEfwKzzFI88YSzavgauOuHrdWsUKOJXu2KpOZI1eTO5N5hpZ9AHGvCeJr
         VbSs0vS/lmhhfNCnGMgEj4gRqlCWvSAXxureIwT/jK5LoBMdqXdRx3i4QPSZCgalyrvj
         y7Q4g0a97iPKV2F3LiLUZGVz8VT20oNBedsVeM9zSTN5w1IdIMm0SYHcuvFwC4P87IzX
         JVx3wT3SJUOOmLo5DIn0JdPKcSUi1ojqWdaGdHsVWYZ4qJuFeElIFYzpRGoift/dFcBW
         YNyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776870567; x=1777475367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ncIyEFzhwxY5D0p2No600gLoVMdCZ6F3j3pxn6/wiE=;
        b=dVwVF4DMVmdARBZ5TVbjkXD4b0PVttGn7x//YLgqiRQ4y0T9o6qerxpSyyuiFzmlRI
         dJyOBeDck3YdiITZSxXOkAAVwYUVjr/nprh45IuSovCapbbkxBWopSU9ESICXLIG+12q
         aIWu0vayCugOTWHOa85xaCR7NSB8Im/Aa8sxdjXTDnYv09kjcSBUCQ1rGhj0F/SfoU7p
         BW40P1+vhqC7rokfSgPwHNdY9jrRl4JT8UYG9V4tGYHhfhXa4yGHB3nQNyw76dyYzdqR
         q6RhSixptW+LJub2V4rublBRsAdtnH+yJtjSd9mIpIWDmNXXQHb7rzb2FWxZxIlmHC9i
         eWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776870567; x=1777475367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1ncIyEFzhwxY5D0p2No600gLoVMdCZ6F3j3pxn6/wiE=;
        b=f4fwipw1Dcf9Shf6F4bBmPqMIBx9PpiizZGW/v7BS2/D7zxlESt0cZen/eEfm64NKl
         MWvnTNrd3SsjlwRau0CIYrfNo7qQF4lLmOm4/UwWjtN1+guVaxNQV6HdYkiuZl8WNvPO
         7DC+crXR//V0yDhZcvor2XkaWhyzgVOxHL5FvtJ8xEmtliYdTs/SYG27xvQbJThIXHj7
         YuO6OF1vI6hxkML1HYiDPFfdtYjaAMsME7CEpSs4z1xRmhATrPnCw4yDm1XL+0tgoKbz
         i5GEWHvrK9D0ShND2MGqnFVQyxd/Z74I7jSxFqQZMjr/e98M+hvTnZnqw6F45dXzvk49
         XG9w==
X-Forwarded-Encrypted: i=1; AFNElJ+EVGPFTQZuumtywN7ZnrUrGWgKc5BvXGjUKvxftXcJsoAGxydqBODaSx3n8x6pwpWcyaB0Bur/1yQl1ZF0DP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvqmro7EUegCOEj3QVk1t+tiRi30sAJllPDiZrZaWuEI8os/+X
	waWJ2fB0UAlJFCh5txawuVpycBGATFfFNN2bO2tAVxjH5jZfPbeDrnxbyBk7YOmrqzVuP4LsK6k
	u4V4s0FBYarFBheZ8I3DBVC1lG59u5aBxRilWAW4=
X-Gm-Gg: AeBDieumvo04iHk9I7nMb+4ca6RR9JL/1f78ywl6tzTI8Eynp6qkELyzcioaYCc8o0J
	+uDDFPwNISMKt269QvE2uX7UH7iTQQhMfVa4NHPniCKkBcDKBY8XU80H+VdyRkvyT+eX2WuE8Fv
	rOZbeJjCmR6jLv9hPyF8mGAZpbgt9Av9MYmWI9IecLEXvKHdBL1aBZuEX1pfCDs3pUNP4A3IUVZ
	A3D2Rnndl6iMyE8U7rpsRbILwO5z77e6duslyE8Ag8jT1VfFDxFuTJUFqsGR28Zqvy31In0lzd3
	vAciDlqGBvkAdrouWl9prYxXbLbzUyVv9lDdg3CMSrScqdE=
X-Received: by 2002:a53:d00a:0:b0:651:8d82:acc2 with SMTP id
 956f58d0204a3-65310b02511mr18571133d50.63.1776870566728; Wed, 22 Apr 2026
 08:09:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306023155.554597-1-luiz.dentz@gmail.com> <20260422011437.176643-1-michael.bommarito@gmail.com>
 <CABBYNZJu6bGZadWc10g=ZJPHoDZ_RKDosCgasow3oRpQchYZvw@mail.gmail.com>
In-Reply-To: <CABBYNZJu6bGZadWc10g=ZJPHoDZ_RKDosCgasow3oRpQchYZvw@mail.gmail.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 22 Apr 2026 11:09:14 -0400
X-Gm-Features: AQROBzDrbkjHyt7fOvnIsInnH-MjovyQ96sTAaD5siup0JuZWEjXzu_C073t0Bs
Message-ID: <CAJJ9bXxCMVzVASz64obn78Ob2CDKBZX3r4B5iE_=+hbnwXDirQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: HIDP: guard session->conn in hidp_connection_del
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 10:55=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> We might need a lock in order to access the session->conn:

This one is a little easier than the other txwin_size issue in terms
of blast radius.

What pattern would you prefer here?

Option 1, smaller but ordering questions: hold the semaphore across
check and use like this:

down_read(&hidp_session_sem);
if (session->conn)
    l2cap_unregister_user(session->conn, &session->user);
up_read(&hidp_session_sem)


Option 2, more correct but more cycles: snapshot the conn and use outside

down_read(&hidp_session_sem);
conn =3D session->conn;
if (conn)
    l2cap_conn_get(conn);
up_read(&hidp_session_sem);
if (conn) {
    l2cap_unregister_user(conn, &session->user);
    l2cap_conn_put(conn);
}

Thanks,
Mike Bommarito
