Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528A820ADCA
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 19:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744744284; cv=none; b=s4SoDU4XbR5HamUefBOdH+5vyIlVczzknxPznYoiwi/noUw46MtlApGxBr0z1321lv8QOFVudOtkPFL5rRrWLtOHsj+9BhADO5GiBoJwDibbKTMa8hVPads/ZcClBU/MVAoWcvsCquADTKNpmETG7AoYP13HdueYEUWNfE3Unzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744744284; c=relaxed/simple;
	bh=DRTdheUhfNqNatqo9I1/rCU0t0H6NBw6fhgkCldTYTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QiN3XLflU+xCzjiwVajAV79ovSBb5rXNFfcHCeScsUQhEDYXQG8UYJJ19RntE/GT5vlwLDNFUIGZpulMZZBQcUlflgrm6M8Lu8uy4Z7hJEoBqVryww7yI4gyMYfrB+9Ehen/9lPF1ZfFjmPwkV9LVaIgFfcKE+kEbgp4dm3SPwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fl2LUMJu; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fl2LUMJu"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54acc04516cso1217924e87.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 12:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744744278; x=1745349078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wTE8RqMwQPwtq6JHIUIGC/Hbl49GQrdO1+ZRD/YkAU=;
        b=fl2LUMJu7fIogMVy4ruCxR9Vx32wxxWtMRQ38yESRdDt22Iqo85dAeJV1sOgadSvTl
         21u/qtlfH3zsPvwV7SMrAlcJ+7H8O1k+BbbBq4jkOUkx6M6vFMM9Bp5f0EEglwUDuBJ8
         JNH/3GB2whP7vljHEdGKLY8JncHOBODkcAX0aiegDpDgEoZzP7N5zrGJ7srUE4MK3WtA
         E62s9lxOMfyu+GlM1E0d8fhhEfvXhwsH7oGBXEo6J7OP3T5KksfmBNvNuL3BKsDgKUMt
         gIPWjHgqa/txollp75HqkK/kXoBLA3CMuYwm0I8tswlqLKuihvZeEEIncLIs8nhW6e5s
         oC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744744278; x=1745349078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wTE8RqMwQPwtq6JHIUIGC/Hbl49GQrdO1+ZRD/YkAU=;
        b=aBao9ISYiRZb1UPnwA2aTgTLEvMz/T1MNp/svoPkNhkO1P+vP3Uag4KzgUAp0/5XXg
         Q5LW3fW3KAk+L03dLruDtCxzDCY7V3p228bqtob70HC/iTtiz6MIhZuC52nQKzV5A/69
         oa1r8fdB4fYSzTNWHWOi8+QOJubYHvzHyofSd9+8LLYYqU0kKh4Mv+F1UFy5D9ewZ3JC
         dF1jcb9JnKXSvMLNHNmwiHV1NnQE837E4vWFMlLcpa3QQKmOmnR5RcQLnEV4b8Evv9bo
         A8HHwed2Xi1scGW7o85/uEmkAHpglcI8yda+UJHkqpb6Ngmbbqh4EGuKMGRDfyIgbi6i
         tdaQ==
X-Gm-Message-State: AOJu0Yzb26eVCrotSRfIZnKS9VlElUbKsQEksVakWpcipfNqzAirtATu
	snKw0kHTDXP8bLnkaYxEeuyZUEjdE5tdMi7VMpkvcZ60xReEg2qmK0dGJqFBEVG2bw3uVrr+bjF
	Cw7J2BQYtKlic/GyvGPo1Y5+iRWAXQpXWzJk=
X-Gm-Gg: ASbGncunrH9d+iYgnLEcDaKsy7dxmlzGZ3YJ7mhxZqQkY4EMzVbs0/zBnRaQq5TN5qK
	TH3jR9w0xg2kjhPqUFSU8ZhRQ/i1XIPRf6SDNrwg0nt5h+qjkm+CN+HO8rlcZJV+Aj4igqhNCh2
	5knF0uWyM5LQoZzE/vs6cCs+ihVzlgwCc=
X-Google-Smtp-Source: AGHT+IEbTOSd83bpK7Q3FJA/hrChsTIB+9Rr+iSrfhT2ze/OMeccDb/0nhgWwwBBNp8dQDjR/74aoj81tMScZ0dQ8W0=
X-Received: by 2002:a05:6512:2308:b0:545:576:cbd2 with SMTP id
 2adb3069b0e04-54d604d03c0mr46242e87.10.1744744278230; Tue, 15 Apr 2025
 12:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415161518.work.889-kees@kernel.org> <67fe9189.050a0220.3238e4.a78d@mx.google.com>
 <202504151015.2774F67C@keescook>
In-Reply-To: <202504151015.2774F67C@keescook>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 15 Apr 2025 15:11:05 -0400
X-Gm-Features: ATxdqUElVUxh9KR9ViSOgQw_W20qkAM4dLCxZ-xUDpioE_lWXz1oR5X4fH_BBE8
Message-ID: <CABBYNZK2sM+-SQ=7C3VOVL40z-tsfrxmHmwWdxnuN7oZse42GQ@mail.gmail.com>
Subject: Re: Bluetooth: vhci: Avoid needless snprintf() calls
To: Kees Cook <kees@kernel.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On Tue, Apr 15, 2025 at 1:16=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Apr 15, 2025 at 10:04:09AM -0700, bluez.test.bot@gmail.com wrote:
> > TestRunner_mgmt-tester        FAIL      120.00 seconds
>
> This test looks to be broken? Or the existing tree is broken? It fails
> with other unrelated patches too, e.g.:
>
> https://patchwork.kernel.org/project/bluetooth/patch/20250411165608.87108=
9-2-luiz.dentz@gmail.com/

Probably some false positive, running locally seems to pass so it is
most likely something not quite right with github environment.

> --
> Kees Cook
>


--=20
Luiz Augusto von Dentz
