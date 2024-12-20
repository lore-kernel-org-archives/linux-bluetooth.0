Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E577E374CC
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734706871; cv=none; b=TUP7YFQLZSMfnLEoA/lLplLzT36EtRkQdv+RMuTfvRwp/6Ra2/mrAPUzWNV6Z5EuOYeJVnqSfogqKcncOZgyjKL3kX2lqdZiw4c8V2wj+ReFyupj7gdWg1zfkdAY0yXdgFsgJgKPe/8Xyj6wOeBowZ5PTL5b/kOsfGP9OCs//XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734706871; c=relaxed/simple;
	bh=jR32CqntLHRBx0H4jaeGOLZHaZOIhbtaDxMKGM9EN3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhbElV0UU5veEngWwv4XgxDcrnigM6FKDYyoMS6BUW9hSbdfK7MrFrWnbFQxPv1fRv7By6voSfPV3ML2/VhwNiO12j9QjFwO+XoTNajuSf3COqKn2A9zUfcGOAYtiS5yh+sczbDRjNXeIdHn4AWk/FU6ELRTNcuSvxDOOkIun6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAI3ajTn; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAI3ajTn"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54026562221so1926701e87.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 07:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734706867; x=1735311667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQio5ZoRnKe0VFNo0RdJ+ODzh/OnfgbUGj5YShVXvKE=;
        b=CAI3ajTn3emhHHNglmSs4am0OUmmXqoB+wJld/ddrdyM7c+wF92L0NhucFlTIVasND
         dEACXrFfKrAXhjeT/kzd9X7ryz7xkZCtonkJkflZRfSNL5fjkL5NTcVtJLINA9nh6yGV
         MiHSIWTYXTZ1ad5qre/cayVPsLiNy/ijaEO4XhFnmjw2Uyf92c+ItgKrbP4fhwkyO0r3
         GzEtIB9gF0gvLs0pjbufHtolyU9z559wpyiDLYWvlFY0zcoEVjsQe5irPw5CD98jwExS
         9+KaUD39YMGSnY5ZZEYPXhlkHi+YF6peOAwKTdSnp1eBz6FKLUFWkcpdpD0cyiBsq0TP
         Ti0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734706867; x=1735311667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQio5ZoRnKe0VFNo0RdJ+ODzh/OnfgbUGj5YShVXvKE=;
        b=sJ36tZA5o81/zRG515N3B2rU20w3YZOiEbOFOcayNBv7Q2ezMJMpCgn5wu6OHXn848
         Fdyusk3kbdwAmpyuHujQ8YASIvz3iPUQsu9QnmBSgh4DKwF/jb6dG7JdfMcCFnuJWCWS
         xh8WXgz8KjkFm2EfpGEdXnoPdENeWA4J3voDCSZSS/9XPCF3M6UZ6kr3ly43j+jSYu8B
         4C1X57wy3J1GaPswRrN4buw/Z2jyaSYBc6x1ApyTua6L/O5pWV0WvkEqs8Gw8id0at1f
         qpdlFlcZamVCPb44ZGzJGHjJ041mRrzUZoVLKoNuoYoikW/oOM68vIJ9/He4A7Ox2ezk
         /4ZQ==
X-Gm-Message-State: AOJu0YzlUFKRRMx6hzuPHBhwGB9JP/Ed5yJCnmfArbCBVmJUf94yqyne
	wzWHHcKiSNVP4dKza8+sARkeBkTJHgLIbfZNYHcJtnGowUi4b1r5PS7SeWlRVUNwPRr/diEjYAE
	w7XieHfNEIuzllGPYHVUCxflgBaUqrA==
X-Gm-Gg: ASbGncvdAdf6zACv4t47+4EOpMka8yWmACX02+4iNS+0uKOtrIZkcu5BdzkFDzvBkBP
	6IbtewIza7VR4xJt/CmfJxHzcsX403UsLtWTb768=
X-Google-Smtp-Source: AGHT+IFbNoeiquIBH76kD5kAw8JNoI/IK6jUxbehZAthjojVN3+HkVObLYtUy4bqm5ef1xNW91NnnX0ZGOfma3uUim0=
X-Received: by 2002:a05:6512:e83:b0:542:2240:8c0 with SMTP id
 2adb3069b0e04-542295224fdmr788999e87.12.1734706866558; Fri, 20 Dec 2024
 07:01:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220125927.84698-1-quic_amisjain@quicinc.com>
In-Reply-To: <20241220125927.84698-1-quic_amisjain@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 20 Dec 2024 10:00:54 -0500
Message-ID: <CABBYNZKm6jJCNnxDcX7TPEuG=UzKnzGEKKNyemefgKrwgYT8uA@mail.gmail.com>
Subject: Re: [PATCH v1] Doc: Obex Implement support for message listing format
 version 1.1
To: Amisha Jain <quic_amisjain@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amisha,

On Fri, Dec 20, 2024 at 7:59=E2=80=AFAM Amisha Jain <quic_amisjain@quicinc.=
com> wrote:
>
> Add the documentation for the =E2=80=98Messages-Listing Format Version 1.=
1=E2=80=99
> feature for MCE.
>
> ---
>  doc/org.bluez.obex.Message.rst | 39 ++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/doc/org.bluez.obex.Message.rst b/doc/org.bluez.obex.Message.=
rst
> index 082f87271..260445970 100644
> --- a/doc/org.bluez.obex.Message.rst
> +++ b/doc/org.bluez.obex.Message.rst
> @@ -137,3 +137,42 @@ boolean Protected [readonly]
>  ````````````````````````````
>
>         Message protected flag
> +
> +string DeliveryStatus [readonly]
> +````````````````````````````````

This probably needs to be marked as optional since not all protocols
may have a delivery status, also I don't think you have marked the
entire label with '`' so rst2man will probably fail to parse it.

> +
> +       Message delivery status
> +
> +       Possible values:
> +
> +       :"delivered":
> +       :"sent":
> +       :"unknown":
> +
> +uint64 ConversationId [readonly]
> +````````````````````````````````
> +
> +       Message conversation id
> +       Identification of the conversation

This is a server side ID, is it unique or per folder?

> +
> +string ConversationName [readonly]
> +````````````````````````````````
> +
> +       Human readable name of the conversation
> +
> +string Direction [readonly]
> +````````````````````````````````
> +
> +       Indicate the direction of the message
> +
> +       Possible values:
> +
> +       :"incoming":
> +       :"outgoing":
> +       :"outgoingdraft":
> +       :"outgoingpending":

The last 2 I would just enumerate as "draft" and "pending".

> +
> +string AttachmentMimeTypes [readonly]
> +````````````````````````````````
> +
> +       MIME type of the attachment
> \ No newline at end of file
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
