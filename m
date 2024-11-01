Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF9C1B4F30
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473973; cv=none; b=q+GAQqZNbLMqlH/sgfJstDQzHP1GOxN3twiyyJCBX24dP74G9lH/yOJwoeoGlK6abQeix18Vn8TBXNAUGKll4IKXHglex43ZZB3kVP8XUZOiiVeP8rrQhbeC073gYgFi2eabKWV780xZCzeVEGC8SwiF8lxxRE41ndgnABItnao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473973; c=relaxed/simple;
	bh=LAVGIz/MWd8yKe9hQ/HGkrnJQKsw//2bcLdVixpg9pU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+JouEhqNt2M5vrf6QQnt3V3dtfDancaCUCAVBAYj2XeyWZW2I871FsIe+gxe0YVYvSZZigpLC7cUwMRFsHhpCPHHt2cE6z/sMqmByMU0U54EGjG+fnEPcQaXfekD903ngE5CWkmDHgigAT1JFejiEifoUXGIxAotT2bG56gP8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcUlfLiX; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcUlfLiX"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so3549612e87.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Nov 2024 08:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730473970; x=1731078770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAVGIz/MWd8yKe9hQ/HGkrnJQKsw//2bcLdVixpg9pU=;
        b=TcUlfLiXQFYxQOWceizcNYHhfhTc7dRZd+gQLjlEhLO24A3QrUgMPDEr4DKOgBr70D
         lnRQlEeJSssUxVUOk0Lvm1vPY9XQEE8SlVsUYh7mHVwtkn6c1kcpD9WH9SsDAx//S5Ax
         MwUD5lFV7a/ML7UyzxilqnDGHolrmhmW3nyVGZuHiJC69XueXXnANchxkKKTelC0qURu
         jC/55YjMulCy3XHsmNe6GOEQTmoCyE2rQYb2EXyBStomcTZ4dBByyZEPIfTPcg4UnMkY
         DO25yT3h2tgsvQHAfXahVjNTz4vM8k3TWaojWRAVH9W+UtmluFSGEIKmdqhEJ2h39ieH
         2BDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730473970; x=1731078770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAVGIz/MWd8yKe9hQ/HGkrnJQKsw//2bcLdVixpg9pU=;
        b=FSLUAORViBCdI8lmSYuNFK4JwFkKkghzaXQcg3Lsd6OYOkj6Y/ULWtegXYhS0/i1oc
         OryD+bWIKFsavXdUGVqvhmYjpGbsr+286vQRP/9gbFsCiysDFyyi5EE7VFQng/m52FCg
         vZRbhQ6xfHbiuquRk3aZxmRzb9U7xD52ef+OyCQoQvWo8jkcZrekhda4HZnutA2P/trU
         cZ3ql0gteJTRt9KSxHnzUKZ/R/aSZwVYpehgDj9Cw1WdyjTk3BOhjtbC8SAxpR99a/yP
         E+hQy1DwnCysRUo1cU/afIdWslujERAnM+6ogjLPoxTrm+RTGQj4MNi1MQ8pfKnKw3yW
         I+Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVV7+dnIKAGDgtBSVDF0OkgY/nwbPYWzEGasKnwxbrCMsaktGQb6eCcaD4ZF2dnR/lETmjwhjLye2cukoBfKOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YysC3j5SG4oFRn/y5m06mbmfeHKlJQdbmnJHeK5ie3mg9NPB5j8
	gnOxqCwUZi3SVdY78yGAC+0gPbGe8u6GbawyXz36Ize6lWK4iPuQGwhq8cXzdogzAvmXLjfXKnT
	swWiEp/Bk2mIVrPmIhuWCSMPI9h0=
X-Google-Smtp-Source: AGHT+IGkhRxB1r8Nnde/PNfnZMLGeGNF1K8bDkSjkuDwkOs8QdsDn9eqvhvbGU+Q2IgjEo0EvNIM9HTRbuMxUBE3D3Y=
X-Received: by 2002:a2e:d12:0:b0:2fa:d978:a6a2 with SMTP id
 38308e7fff4ca-2fd05973ed9mr53849341fa.27.1730473969632; Fri, 01 Nov 2024
 08:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101114410.234311-1-dmantipov@yandex.ru> <CABBYNZK=H9JtzaQudQ1b7TGU5VaJ_qX_bbSJhKSwWKh+5_1uUQ@mail.gmail.com>
 <5cc24ab9-80c0-4280-8c4c-d8b052524e1d@yandex.ru>
In-Reply-To: <5cc24ab9-80c0-4280-8c4c-d8b052524e1d@yandex.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 1 Nov 2024 11:12:36 -0400
Message-ID: <CABBYNZKvP3u+7juqNNUHOS0PTb=QVzxob+rC3PVq-XXu9vGU+A@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: fix use-after-free in device_for_each_child()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, lvc-project@linuxtesting.org, 
	syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Fri, Nov 1, 2024 at 11:06=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.ru=
> wrote:
>
> On 11/1/24 6:01 PM, Luiz Augusto von Dentz wrote:
>
> > #syz test
>
> Please see at https://syzkaller.appspot.com/bug?extid=3D6cf5652d3df49fae2=
e3f just as usual.

There is no Tested-by thus why I assumed it wasn't tested by syzbot yet.

> Dmitry
>


--=20
Luiz Augusto von Dentz
