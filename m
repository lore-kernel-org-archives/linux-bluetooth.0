Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8FB38C2A7
	for <linux-bluetooth@vger.kernel.org>; Sat,  5 Sep 2026 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788619783; cv=none; b=WKcDuAi9l/h8d2vVRWDKfAMIigeo7iSwq8+Ou7Wmnv41ADvrHqNHMzn5YekQS2OQQJfyL9inCck2W3jWK7Se3yomOeHzzPLLzYWWfsZX91I1KZd8NSUPVnirCr566UmqoSM+hnBxjTAy1iUZf3CtKatnFIdP9B8JcWLhFcKzHt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788619783; c=relaxed/simple;
	bh=Gmf7D0qS8G2FOvMspyTs/cOGQiBbPJsJo7SJw4pbTv8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QPE21cNvWg0UzVwefAbDYvZ56+Z84Mnn9ZRHI7Ofp0L9XbDz6lx/sXBDq3k5lxpn93jZ2E5c4oG8UFgWzpow6mPZymcg1SU9dziTQvIfFI6z8qaHac2BIENrh9okDTpXYimgRuqDTCrl6VaDzDCYuaZYSCCdauRH9TUzpJmDXUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYhStb5a; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYhStb5a"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b4ae0b3308so1399934e87.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 05 Sep 2026 07:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788619779; x=1789224579; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8cakwzZHMNMTtyZNxIH87ia2yTJpQtOjQ/rJADukBKU=;
        b=XYhStb5aRPbbL9zo4f5fOjOMPIu13ktezHOgCriHgEG5VVGYQGWb5Rd3twD/+bEiq3
         Z2mMAo9YrA/DfSp+BP6oFBybYCo0ZO/XdPs85sBi8sHgR9aPzzUyEecqxbHjnzNUBwD9
         XKtqGoDecDpSCx8KSkKbPHpf351U1XgFZ5Fuly3JAf5ATFQM+u+3NhmGZ/+hzJE1Ujud
         T3OCRJYi8G3U1RabKv9/WJoE3AgVnAJsGbr8Hc94jQFijDAtUz9d08crvNazIyahnXJ7
         OJWkoSa7uZoEoMS0Bthj8MNpmbZt3NbDPPGNmJb3Yr8L4oHSyfiktuYoRHLTOEIomm0c
         MsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788619779; x=1789224579;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8cakwzZHMNMTtyZNxIH87ia2yTJpQtOjQ/rJADukBKU=;
        b=Nw7yjROfkKU1FmfZw8nvSLB21NuWcfiCkJfwRoVwhOtW4/yDpj7YmAB+lgOyOd4xMA
         2MCgt0ncAgsngj9D2+HCtANQpDLKehWwkcsPnaq/ygPLTdlFySWEKm0xzloqFcWP4ezu
         oh4GExIcJSrw15yI37r0ljekc6YYnYu9pv/25H+wY57SgEYVjANWpZnuWXegqtu1/1U2
         eVG0kApuSYCjWZJwLoOKmkqOC8ms6kJCuYMlOQwwU1rgVkeOkuLYIz79qI+zDG2KOBDA
         vTIkDrgacQ8f796GrrLmqOf8JbM5Khef/DBkYo6OOG8G1h7p/JCghmy+xQXgAJGqvsCd
         tXzA==
X-Forwarded-Encrypted: i=1; AKwUvBx3pyxfeeZE9TwqO8B6Y/+9u85cX2XDAcRKoMIrMNJag8jZ09VLO+fNd5cFvjX1kMURsDxzeN6foAcI1pTRlQc=@vger.kernel.org
X-Gm-Message-State: AFuF++nzhOGgnEw/ojM8MXxWkot1wSijTlVztJCTW+xBlujlcmcHtzJf
	n5E7SOudVxgSaJWk860t5kiFQx4iagpSkH2oNyRaVb0eJfcSSVtkF5OG
X-Gm-Gg: AYBFou3GIgFgCOWYluE/vsV6WW2wiPAaeggrjnSH7KYKEVfv5wXqaK8NpSi9Y8nDs5K
	17B6vO1jYSKLiL5Pqmw3ZGBMY9ZwTNUsKPeE1cko3NaQ+8mrILw4UCM7XjgtpQwvfTqUlH1fiLF
	oZ4pTxtrrNFTUIvO0Up94xkEwhqkMj2GQD5RXpaYz0TjQ6pPwAR+fRkqMHby6SlebB5UPa/t5LI
	662w452XchJ5ylOy3TZJtP4U/GOMLqu0yTU13XpZ7XgroUFpafSKhoxK+Lu1U5IBbljGRk+MNq/
	OhhDu1ADoOyG5ZTGmwBKwr3SWAxKrZaHTfSvGSh/R9Wif+sCeHxDXcchQcjHmk4oNF3WwtNgZjM
	YkNdk5uZksoRYwBQ1wmzZUius9OspB+hBJnF1xwvjhq/XRRUCX/hosJfYEtGrhPafSEBPfgZ1uI
	c9iHxwS3jxu1pBcAviRql77kNR9KCl8wY6MuRBP2U9cnIY/4ZQ7MgtsK4aEyxN9SbbLUK8qhZry
	anuy4/Bi1wJHzMKhvByuFyu9icxG4gEImV8oHd8NBq04ntoBUg44q94eZhpqk6DnGhKL9UMjlUN
	dgsc
X-Received: by 2002:a05:6512:3d24:b0:5b2:a600:e496 with SMTP id 2adb3069b0e04-5b616f4d466mr2304223e87.24.1788619779218;
        Sat, 05 Sep 2026 07:49:39 -0700 (PDT)
Received: from primary-ws.local ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b6166f8eecsm1135582e87.40.2026.09.05.07.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 07:49:37 -0700 (PDT)
Message-ID: <1ce72e4f26b5c35940a160d121cb479203e5d565.camel@gmail.com>
Subject: Re: [PATCH v2] Bluetooth: RFCOMM: defer security confirmation to
 krfcommd
From: "mikhail.v.gavrilov@gmail.com" <mikhail.v.gavrilov@gmail.com>
To: Pauli Virtanen <pav@iki.fi>, marcel@holtmann.org, luiz.dentz@gmail.com
Cc: nicoyip.dev@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+74071deb72339c215b2e@syzkaller.appspotmail.com
Date: Sat, 05 Sep 2026 19:49:35 +0500
In-Reply-To: <e316af2c02709047ae4982a72d92bebc7feb81e3.camel@iki.fi>
References: <20260902235132.453044-1-mikhail.v.gavrilov@gmail.com>
			 <20260904012028.77590-1-mikhail.v.gavrilov@gmail.com>
	 <e316af2c02709047ae4982a72d92bebc7feb81e3.camel@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.61.2 (3.61.2-1.fc45) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Pauli,

thanks for running the checker, and for looking at this again.

> This v2 checks session hci_conn is the same as original, however it
is
> unclear if delayed processing of confirmation on the same hci_conn,
can
> result to wrong outcomes.
>
> What makes it not introduce new race conditions?

Only two values cross the window: status and encrypt.  Everything else
is read when the confirmation is applied - the session lookup, the DLC
list, d->state, d->sec_level, and conn->sec_level in
hci_conn_check_secure(), the last one under hdev->lock as before.

Confirmations are queued and drained FIFO, and krfcommd drains the
whole queue in one pass before rfcomm_process_sessions(), so none is
dropped or reordered.  Two encryption changes in the same window are
applied in the order they arrived, and the last one wins, same as
without the queue.

That leaves stale status/encrypt applied to a DLC list that may have
changed meanwhile, and every path they feed fails closed:

  - RFCOMM_SEC_PENDING with stale status or encrypt =3D=3D 0 sets
    RFCOMM_ENC_DROP, which drops the DLC;
  - a stale success does not clear anything the next confirmation would
    have acted on: if encryption really went away, that event is queued
    too and reaches step two, which re-arms SEC_PENDING for
    BT_SECURITY_MEDIUM and sets ENC_DROP for HIGH/FIPS;
  - RFCOMM_AUTH_PENDING is answered with
    !status && hci_conn_check_secure(conn, d->sec_level), and that
    function reads the live conn->sec_level.  A stale failure can only
    reject.  An accept still requires the link to be secure enough at
    the time the decision is made.

So a stale confirmation can close a DLC that would have survived; it
cannot accept one that the current state of the link does not justify.
A confirmation that cannot be allocated has the same effect - the DLC
closes on its auth timeout.

> GPT-5.6 produced report of pre-existing race condition where
> security_cfm() races with DLC open and results to intermittent wrong
> security level, but I didn't verify this was not nonsense.

There is such a window and it is older than this patch.
__rfcomm_dlc_open() sets RFCOMM_AUTH_PENDING on a new DLC when
rfcomm_check_security() finds the request still in flight, and the next
confirmation for that link clears the bit and answers with the status
of whatever event it came from, which is not necessarily the request
that DLC is waiting for.  Before this patch the callback took
rfcomm_mutex and hit exactly the same DLC as soon as the opener
released it.  The queue makes the window longer, it does not add a case
that was not reachable.  Untangling that needs per-request state on the
DLC and looks like separate work to me.

> I wonder if the kernel_connect() could be moved out from under
> rfcomm_mutex, since the RFCOMM channels should already have to handle
> transition to CONNECTED state and possible failures there, and the
lock
> cycle solved from the other side.

I agree that is the better place to fix it - it removes the inversion
for any future callback that needs rfcomm_mutex, and it leaves the
security confirmation synchronous, so none of the above has to be
reasoned about at all.  Luiz suggested the same direction on the
original thread.

It is a rework of the connect path rather than a regression fix,
though: rfcomm_session_create() would have to build and connect the
socket outside the lock, and __rfcomm_dlc_open() would have to look the
session up again after re-acquiring rfcomm_mutex and drop the socket it
just made if another thread won the race.

Luiz, which one do you want?  759c185d0bbd is in v7.3-rc1 and marked
for stable, so the inversion is in a released tree and heading for the
stable trees.  If you would rather have the small fix now and the
connect-side rework in -next, v2 is here; if you want the connect side
instead, I will write it - I would just rather not write it twice.

--=20
Thanks,
Mikhail
