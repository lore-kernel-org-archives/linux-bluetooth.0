Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794933632;
	b=2EJkJUbUpkd5FgNK2jUYbnSQinJclkFxcTC4ZCPmamlTyIHtWiR3CVoWCv1arjCFtXje
	 iYiwmEHIztacWStxPM1xiSR0T+aq8qURN0xvddyMsuIuZTrSWhqjVz+SqrWEWKfz+fuZR
	 3FACN17j6X+5nG598f8zAGfUMJiXG+E2VYMgjAMhK7RZuC1KO8HTtPtqDBpKcuLKbSm6H
	 8mOORfXW4KYimm/Gwx7YZEJf1buxUlL5pN3jlNR4ujzQY5YpRmRvkMi2qDCgs8KDVaAJO
	 yxHtwRAcYszd2Bya8zulIhfzDuS1uXxmkEzixXuqpuLBZ6mPoZNOX2i+1KeTJn+adig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=zX+sTk20592JcV7Ih2skVzcwt+S+S2YJyNxH7CbstzQ=;
	b=b9Du5Gui4gXPgbGIpsSkvc/QJY12s/UDdelboCS08HAgKOXRNAoW3CfkAb6kGqEWmET6
	 omPS8DIUDvPB3FhnE8UqIlIcUvP61TnC8NdUZxB7F2xByfq4sB12QHUAqIMxw7rTpgAcL
	 eFeVy4n/cAcsPf689mJ7faW+7uyVIhDRffcRAH7GTTSCFTBkr0rmExw1SqypnCZQqas03
	 gc02cfW9bAl8jIZkAA/1gRyLkW5sC3gdvffOnEZvUEe+fQ/lfoqVj+h33Be7e0dguClhP
	 Ddkw6v5hSXKr+u3SLgjvPoV1SlKd2vFtERK0d0XZQaK2lhb41pDO3SNJOLfDLCVVw3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KqJatoca;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D2A606A331
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 16:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46D2A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KqJatoca
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-67be1e468a8so3860373d50.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 08:40:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794933631; cv=none;
        d=google.com; s=arc-20260327;
        b=sM23a8L4Ohsbsu015eludAuJwRlhIJnJNaAkau5yKjuIey3ziTOk2/pSbzsKMVwGDj
         aUTRFTW9Qdt0juivvdWU/GsPy3vTuM7E/fx4sgjDGcoVDclUKWjuS8ygkxWxsY6VpUFs
         E7cI39qszWxnmjd8FBz3RcnZmEXPnSa09Akmrj9fhJ04N6e/Xo2hM86TW7cXvaJCtY7+
         HqRy4el34EgaECWfi9WRpdORVhVLVBbniqwE0YKKBd9o556m579gewf7ds8kwmbk1r7I
         A5lX0M7rNMERNX82Em+ysW75ER45zE/1Z2CFlcWY5YPjP+q3Y041HSCF9WFssMI5viU2
         IuSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zX+sTk20592JcV7Ih2skVzcwt+S+S2YJyNxH7CbstzQ=;
        fh=dss+mvtVWWcCKjYBBjtoOwyfdbc8Dj1NBkicxxfSm3A=;
        b=DfDlGHkadqiuJTqhB9gTLE3kbbcDKDVS85uNFNyhGCzZu4N5fvT3XYtGBzG2wQy0dC
         /+ZfMO20wocoe2u6psQzsQf082ShrelydpCnV10WH14BUr8SlTn3WpWYmuw7vMldX/jD
         o65lkNhO0Z6a2lOEYVLB5pm/lZPCNQKU6ggFBHjxjKTxmExuEtOptN9i3HSmpSN342ww
         ejA1mWwBHGER7teeAmaM0qREOB68YAptA7MCpvYdz7uF9IlZH14wR7Byc9NqSh/vd/30
         /9/LOW4RZIlo7O8TGMFEa0wgYiBW7kLxN1WGLHMR/ao/z4/hWYL3XMnA7Mx1JwfBJpan
         aDtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794933631; x=1795538431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zX+sTk20592JcV7Ih2skVzcwt+S+S2YJyNxH7CbstzQ=;
        b=KqJatoca5emQgN5dqhcvWRJEI883Do7dwWYKJY84LaYr2qbm4u9tnnAeOly+sUoF9R
         3epyTOVUstRMmdWicrSSXOQK2uNklBK2k96pB9FiqHtu+Azf/486WnC9Iulh2UaDtg7D
         9Y+FeieqPCOI/fxrJedb4KFGjiPs2V0Hg9Er/JHjiccQnb46FAyGo81OcboZxb1k2MLd
         5ycK+fnRSsxFfPUglfisw/JG/B1eDuRp8ulikDBI9rbAp8IDQi3uXlGB3KStKd4si5ae
         YmVktpD7MocokVHUiRMNQzRR4in21WBWrhUAhh42gfsBG19TRVJ8Q3ETTzYNeWkwO7Lo
         Osgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794933631; x=1795538431;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zX+sTk20592JcV7Ih2skVzcwt+S+S2YJyNxH7CbstzQ=;
        b=l27i+e5fDkgT1nn0b9vkacASf6HN3dWkbceppDAXayxckNaTfbgyBTUcSFqudAUMdl
         AD5E1+0vHcZctaNZDngaATi4tNN3qrlKDV0+gccieAk+sVhE+ZQO3bVMaAlnCROwbVcv
         oYCXvvHzmxoCgVKoPzMW7lqqxyYuiiMofNRidnWzF1vhaAmmHc0gjp+w/eaT8TX/rKR4
         ek86Y9qLKMfRGgBdebEulZC2PUz05eKvVFY6k41drXGLwNqKy4IV3gZlvAmNyDM72mPY
         /9k17D7vBUfaNhsDUlGlQrsvyevC3pA4/PwWmQKe5fRN4tujXBHFBt/I6Ze+KgCQv3Lb
         G0yQ==
X-Gm-Message-State: APuU4Z+6P/r/s/zAqkDlsEIwE62qAwIF8flzuSmsIIGKZ/ouNwSMVzJm
	hDHqxlHK8J+wdQxB3xXKGk09/Z32mQjWnS1dLxBrY3xVBp4Wr3qOXJ8P54pFq2c0aYH/5G69OkJ
	zl4Z2wcAzwMkC2TmWCh+zPXwsTP9ytfqWPz1b
X-Gm-Gg: AZFdTZcVo2gvKd8XPGM7l+OgQnGKF/w6nk6pmGFW/v+TklN2N9FC3arYKvOtZ2lDTNh
	QjKTQ9xRBTzTZLLOGc4v01CAPTiwY2T9REHvyiJ7vE/dpm3iXaY1BnUvK/PeUpOIiliHPV+IN7z
	mMahLCy9wDumW9Sug21I9eG1UJxr1MCyhS3TT3zmJ0xqC6Rwv89RcxeboexUvRF9LaokZjK7W5s
	Y8qF70egakwTUr2KBvxuYRQkA5z0qFRGAqexbVbDOWLvAC5SuVBQfR5JzvUOj89WzIpbS92M2Lo
	iECUymKtX4sIx5baBR5QnC7tmNEcvwFKx9MnCHknjZFbQq60Qg0Myaq+oedvavhHumD1/TacQNa
	Qw1J5XcuseW91Sqt8RpK4dZuqQxPx41G999Q7p8h9Ra3r0ZKshPgHkdWqSd6430lMdzRooC1RkR
	c7pxsCDMZ5816oTr+qMZU9GMBxsjMvFuTeS8G3rScGz4odyUYioZ7PhSBXt9p1bYgigGDGPUP0k
	cY+Nw==
X-Received: by 2002:a05:690e:e8c:b0:679:c0f6:2c59 with SMTP id
 956f58d0204a3-67dd401ca45mr37826d50.79.1794933631198; Tue, 17 Nov 2026
 08:40:31 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113172339.54683-1-kevin@simpleble.org>
In-Reply-To: <20261113172339.54683-1-kevin@simpleble.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 17 Nov 2026 11:40:19 -0500
X-Gm-Features: AclHuK_9QODLdg1gmQDsf0Qs8j1K8bEB60BKed4xguwam8_Aozgwqi8SCnwXbfU
Message-ID: <CABBYNZK7TnbEnf1N9Kd6+a-9F3PK22CKQcUQQuOySNQtBz8oSQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 0/4] Bearer.LE1: Add ReadRSSI
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

On Fri, Nov 13, 2026 at 12:23=E2=80=AFPM Kevin Dewald <kevin@simpleble.org>=
 wrote:
>
> This adds ReadRSSI to Bearer.LE1 as a testing method, for diagnostics
> and production testing, as discussed on v1 [1]. It is only available
> when D-Bus testing interfaces are enabled, with bluetoothd -T or
> Testing =3D true in main.conf.
>
> Each call sends Get Connection Information, which the kernel answers
> from the controller or with the value it read in the last 1 to 3
> seconds. A call made right after Connect returns fails with NotReady
> until the kernel has read the remote features.
>
> Changes in v3, from the review of v2 [2]:
> - Retry ReadRSSI in the functional test while it fails with NotReady.
> - Check that the RSSI is between -127 and 20 dBm instead of the -1 dBm
>   of the emulated controller, so the test also passes with real
>   controllers.
>
> Changes in v2:
> - Make ReadRSSI a testing method and mark it [testing] in the
>   documentation.
> - Enable testing interfaces on one host in the functional test, and
>   check that the other host does not export ReadRSSI.
> - Rebase on master.
>
> Tested with the functional test on bluetooth-next 3f425f95ba39, also
> with a bluetoothd that answers NotReady to the first two reads, and on
> an RTL8761BU connected to an nRF52840. With -T, ReadRSSI returned
> -48 dBm; without it, the method was not exported.
>
> [1] https://lore.kernel.org/linux-bluetooth/20261112032250.37687-1-kevin@=
simpleble.org/
> [2] https://lore.kernel.org/linux-bluetooth/20261113051438.75230-1-kevin@=
simpleble.org/
>
> Kevin Dewald (4):
>   org.bluez.Bearer: Add ReadRSSI method
>   adapter: Add btd_adapter_get_conn_info
>   bearer: Add ReadRSSI method
>   test: functional: add bearer ReadRSSI test
>
>  doc/org.bluez.Bearer.LE.rst    |  19 ++++++
>  src/adapter.c                  |  22 +++++++
>  src/adapter.h                  |   7 +++
>  src/bearer.c                   | 111 ++++++++++++++++++++++++++++++++-
>  test/functional/test_bearer.py |  58 +++++++++++++++++
>  5 files changed, 215 insertions(+), 2 deletions(-)
>
>
> base-commit: 20ffd285b58facfd1f2478d159a5f941b09d5be1
> --
> 2.54.0 (Apple Git-157)

Copilot flagged one more problem:
https://github.com/bluez/bluez/pull/2832#pullrequestreview-5942461297

--=20
Luiz Augusto von Dentz
