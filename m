Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A311F3BA3;
	Mon,  3 Mar 2025 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013853; cv=none; b=tDvB+vAEWD98Mc1GFJxQGjxPIGNkCHh81vb+kCVHn7ieRARgAT8H6W1MBjSzYa4Gr4d6oAMA+r07xil+Fu4Stt9NM/mDXG0KX1evx2SsvTvSXt1dk/IGtpWsS0yNtQiEqrYCopq9vSVQ85oJvHDZ0hmAqxe3ZzN/N3Y16WDtxBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013853; c=relaxed/simple;
	bh=D7qcfcr0SCkAu+oO0/nxNDyf3AHLL8DCn/WP4PwPlUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtENDEQOKE6Soc3zok9+1DOZ0NXHP7TrsDF8fXyVx/j7oMmaflJK8MkXxg+SodLQ++Dh9Y+ZaMaGT751eOefxZiss+Y5wq1oaz3jBakFKJaP5bRWq8hvCVAQE8jgIAky7kBFwxf03KsSf/nIA2f0T/3wv3bDOSvXInkrdlQ2PIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDe1YV6P; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDe1YV6P"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30761be8fcfso48440241fa.0;
        Mon, 03 Mar 2025 06:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741013849; x=1741618649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KThmRys+NHUCVCdpws0Gc3jfo7DfXAQV85XyFxt6xY=;
        b=gDe1YV6P+gDwqQvRKMZ4zeLdnsiRH/Y6rqXeHHGJfdYeW9UuHKNpFBc/cfk0V80YGz
         OsnOrRT51Skr5a71qwxn9fLerYPxe3ga1yWc8TXexs2xxd83dEF2RHbFZCQKH9cUrTDl
         qe5jnePLb1rDupFONZTHWnXp2y1RFXBZT0ojtbE/hLHTcW7dJr7+yO4O3aYMOIHmRJI9
         rWR9e5b1ZOEB0RiNiBkSC7nloyb57kwehGNscP2eVH3alqdVT8F2ETR48Iy64lxUWM2x
         HHhws2B3gc9FlZAWgNBu3ZgFgYxJ0g7DdZJuDEP5VHDUaJZpOgDrDx/ZIqBYwOZ3YdNE
         OYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741013849; x=1741618649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KThmRys+NHUCVCdpws0Gc3jfo7DfXAQV85XyFxt6xY=;
        b=E/PQ/uhWrR8dhcAyj8MQfejAOY6/Qc858vtmGu/UyslrU0FtrgEuzVQ5aYlXHReT+D
         YY3BhYbAkU27XZUu6SKKu/oIZAglSwaybjGGHSW92gWNSqBVWFrliBJQWsSnw/+Aygop
         FutbohHG2o6xlB7TyHcuIgu1IwD3/G2Kw/z6LYYK5kL3vqdxKrJOf2eJJXgRjgnW9eMX
         M02/ybm/09g2qr/GUcwoW4M2laHCwcwYY0ivWwmitUOIBL0EWyqd/+dKN0xNEEEQimnp
         goo1E1QUWtFl+vJYqd4jACjcJFRTt8Z/nSgy5CtgD2tFzf/3sECNbd0+S+wGFLIJO882
         muWw==
X-Forwarded-Encrypted: i=1; AJvYcCUqQtsFdLIDi8bgkFLo1zkHni+Uqa/zVIp5W3N6IbeSfxa/7h5YaSszxv4Dky1GQ9n3Pj8liqjVc4wx+hmU@vger.kernel.org, AJvYcCVdumwE/naMCs/0meu9DGX149Ux00ZVw7stvHLCGRQaL4EZ/xrEcvQk83UpxciFMg1Qv/Fnph1QqdrxBzaMzqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS3MfWETiKOLTpTmFWDbQJweyx0r8nKfG10xmabIp/cUpmzCL9
	PNvjOh5Mq/QxI3gufCoS8j5tLaFsHq6mYMF40+p7g/jaIVeBD51lFho0KuoSvrOt6KfIvnsodkW
	d/1N4JEHxxwfAY9foohX2eu/RcfuVHdFsa/Y=
X-Gm-Gg: ASbGncsKczrhFdD1FdpJOro8Jq6gq4+ovw8WEyTbGciRDBYirgAv/B0B40itUio4Gup
	k7rvSsbVh7XJok6OJpqwhXYl9vewQyCw3eRmZ5a+SuCSwEXqgEIysq4x1yoFTYyjKQzkdkJjc9B
	5zAhNJgCWn4N8NmnvRuza9NkF+
X-Google-Smtp-Source: AGHT+IHdAlfCebOeONmZoZLy+K7mjtkrozwQxes2PzJx5JK2LqgvVwnakCzjTNw1nl3uDo3ggmjb3disuHMLwBfJ9LY=
X-Received: by 2002:a2e:a99b:0:b0:30b:751f:dd7 with SMTP id
 38308e7fff4ca-30b9321a9e4mr59389661fa.9.1741013849149; Mon, 03 Mar 2025
 06:57:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87a5a3ah2y.wl-tiwai@suse.de>
In-Reply-To: <87a5a3ah2y.wl-tiwai@suse.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 3 Mar 2025 19:57:16 +0500
X-Gm-Features: AQ5f1JpSOcYxe-GIV2cMJp2lB1i45Q992KrdpcSPNi7YXDEJbuQ127EuLNOICnI
Message-ID: <CABBYNZJOW-YSOLS0tBdUQmxqbOmgT2n2jVheyxbvWbYmBicqyg@mail.gmail.com>
Subject: Re: Is commit 4d94f0555827 safe?
To: Takashi Iwai <tiwai@suse.de>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

Well the assumption was that because we are doing a copy of the struct
being unregistered/freed would never cause any errors, so to trigger
something like UAF like the comment was suggesting the function
callback would need to be unmapped so even if the likes of iso_exit is
called it function (e.g. iso_connect_cfm) remains in memory.

You can find the previous version here:

https://syzkaller.appspot.com/text?tag=3DPatch&x=3D100c0de8580000

Problem with it was that it is invalid to unlock and relock like that.

On Sun, Mar 2, 2025 at 4:59=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wrote:
>
> [ I posted without the subject line mistakenly, so resent again;
>   sorry if you have seen already read it ]
>
> Hi Luiz,
>
> due to the CVE assignment, I stumbled on the recent fix for BT
> hci_core, the commit 4d94f0555827 ("Bluetooth: hci_core: Fix sleeping
> function called from invalid context"), and wonder whether it's really
> safe.
>
> As already asked question at the patch review:
>   https://patchwork.kernel.org/comment/26147087/
> the code allows the callbacks to be called even after
> hci_unregister_cb() returns.
>
> Your assumption was that it's never called without the module removal,
> but isn't hci_unregister_cb() also called from iso_exit() which can be
> triggered via set_iso_socket_func() in mgmt.c?  Also, any 3rd party
> module could call hci_unregister_cb() in a wild way, too -- even if
> the function still remains, it doesn't mean that you can call it
> safely if the caller already assumes it being unregistered.
>
> In addition to that, I feel what the patch does as a bit too
> heavy-lifting: it does kmalloc() and copy the whole hci_cb object,
> which isn't quite small for each.  If the callback is still safe to
> call after RCU protection, you may just keep the hci_cb pointer
> instead of copying the whole content, too?
>
> I couldn't find v1 patch in the patchwork, so not sure whether this
> has been already discussed.  If so, let me know.
>
>
> Thanks!
>
> Takashi
>


--=20
Luiz Augusto von Dentz
