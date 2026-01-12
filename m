Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2E92E265A
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jan 2026 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235973; cv=none; b=TVzeYlmFPkYf4UPfTV0hgSzhBiZDimTJqUVNsmEho5OzX6IXHDNhDntDudArFbGih2wDuMHGl+0x222JHELVIl40vHXk5M7x5FBzUfETA0B32uo32FWBdMDjNkc/Hue2VQ9e4Uk9hAZpgj/YybYq7V51uRaCoKSrmOCXOyuxg90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235973; c=relaxed/simple;
	bh=8AGbsg0vnhJ/oAVXXMtbOjUAUxQCh1X602TaOx6x7BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/9h9bIUVBgr+SNLn7L+CToJaqvBeCsxPdbmXaOfxRhuwLCW8tmGRmmNJSbPb7SrMePd4CTe8G4VKzRNcg6BkIIeDW4kUzYjd7f5l0HKLTgXr0aZ2qvx/+JHdSEziuAF6pqbAmd+h5z5tLNW6VpKDJIqnnc+RICil3Pvjl9NKC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/c+bD/C; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/c+bD/C"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6446d7a8eadso5877560d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jan 2026 08:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768235971; x=1768840771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqdVzEPYnRnIl6GYs+maD4WQ9RVyHlMeLrRVPR2sDxI=;
        b=O/c+bD/CC6fDFtN8pG5XqVZ8W20kgVTVGbdMVAGY0V2UWV1tSStBeDqTxLDegH753I
         q8Pb8pbrSLkUmemhRqixvke16+s2O8jl7d5YXzQedIMupIvl86f9WPZ12VcmO4vyME6U
         vP8I/LEY9b3E61Wdpuln9q7RQpr3yuPo0eI2ibY60aPvaMvVpy0mSI7pY5IXi0+R8ocM
         Lc9Mc9BcyoMrAtvUer3PCuQo6O8oEl8Ld5C6F4QAIAZVGpb1lAsX8IIdUTqLLZp3oADl
         5EDvTET8+UHQX5PKc96xP+Ii4raA9XQU2G8KP/QrRHzmq7U1UeZrowqFUdZIDS7B5W/3
         JFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768235971; x=1768840771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AqdVzEPYnRnIl6GYs+maD4WQ9RVyHlMeLrRVPR2sDxI=;
        b=F2HaSag4E+3vjiCzB97zP2mGXqStS+cj1n1x+uTTuZ1cZoWEIBRFbDU26FRGVxXqlk
         JX2apSksuAZph+mF3idyF4r9yNez0ebZFGehF+iL1gJ9uHu1EBXawclO3zsSCRPZ4xQy
         vkfwOqZSmtmME8Yly/rVRS0QpBN4BlWR2JUS6KHiVWWUzaDc3/2tb15U6KMP1+FzkSI5
         Svtt5ct2AAahB9PJBvUj7Fc26baommyDeiRe5cvSF/BErPIsMQIooCUiMUJ99i0sLuIZ
         y+2pVaixRM/Dkbj2ydhZ3LLOPL10TAj1YCqxJVORUSiMBKV2DsMkzNn3VtkzmwxlS4N7
         LDdg==
X-Forwarded-Encrypted: i=1; AJvYcCWmWBTNalKTO+cdfboOAAvIi89f2OZl8+Hd63ndq/vnH4Z+U4+CAAnvZWwmLElTqmC5got08eMibr9I9pPDf5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEwqgNqV6YEugrXsgpnMuBfV5vFKLBqIZP2bhWEQmUx63WWce+
	OqerX6HSXfFZBawSL+y9yvh12AJC23iWaj4tJbmAyY0vp0S39oW/Nz/fR6W4ReSGQjag1Wy/AZb
	1goohjrKuaJOxKqYsD0EP/aNqAsA/vPg=
X-Gm-Gg: AY/fxX7CQaNaq1zLNTKipep32PCbjIXANlSANdfaKR2FgQ5GhLlKaEyo7iNjaY9llER
	4/eo30S5Id3HqtIWkp6GzlFAZWtkdl/Qders2E8cgBcW1nLzkjwXueSfpNL7HfsmGDDmNAC+Id5
	oN3IjJoIlXp89yG+0U/qnZeXoaUYzLAUBaTpA+1vSWcp5XXCPCqldkkKX1/9+FmTQErGD0taqmX
	U3hpmLdFC6dQC2Zg27+u9DZYAaRs9VGkELJXhlfZps4mB5y6vB18Z4yZWJ1jfqdVWJgp/o8hkCo
	XYGf30JZXJUEe9GtWBeJfXcytMysHXmFyG8upXDkI/Y8ZR11UVKZYaM=
X-Google-Smtp-Source: AGHT+IH2QBsqE9vgWnD+6OTXPtBJh46Hw8c4lbxUNab+T7tuWjxaS4kJ0So8fxukziSFSqgrX8HWf5+3+DPJefESM3I=
X-Received: by 2002:a05:690e:140b:b0:646:c661:8f98 with SMTP id
 956f58d0204a3-64716bb9b79mr15001831d50.40.1768235970693; Mon, 12 Jan 2026
 08:39:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_2FAB909645504A5E0FDC88F125E139242C05@qq.com>
In-Reply-To: <tencent_2FAB909645504A5E0FDC88F125E139242C05@qq.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 12 Jan 2026 11:39:18 -0500
X-Gm-Features: AZwV_QhlM5oO126AHcNDDpkB6HWVq5_O7legyRFi5b8QtaJsCFQrKng60k_qxrg
Message-ID: <CABBYNZJ+brhf-h7HU63vRah9uBNx3UT=kxTQjr74vuJRG+3B0g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Perform careful capability checks in hci_sock_bind()
To: Jerry Wu <w.7erry@foxmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jerry,

On Thu, Jan 8, 2026 at 8:57=E2=80=AFPM Jerry Wu <w.7erry@foxmail.com> wrote=
:
>
> Previously, the HCI_SOCK_TRUSTED flag was set in hci_sock_bind() by
> checking capable(CAP_NET_ADMIN). This function verifies that the
> current caller of the bind system call has the required capability.
>
> However, this approach is vulnerable to a "confused deputy" attack. A
> malicious unprivileged program can open an HCI socket and deliberately
> share it with a privileged task (e.g., via file descriptor passing).
> If the privileged task is tricked into calling bind() on that socket,
> the capable() check will pass, and the socket will be marked as
> trusted. The original unprivileged program then retains access to this
> now-trusted socket, allowing it to perform privileged operations.
>
> This issue mirrors the vulnerability previously identified and fixed
> in hci_sock_ioctl().
>
> Fix this by using sk_capable() instead of capable(). This ensures that
> both the task performing the bind and the socket opener must have the
> CAP_NET_ADMIN capability before the socket is granted the
> HCI_SOCK_TRUSTED status.
>
> Fixes: f4cdbb3f25c1 ("Bluetooth: Handle HCI raw socket transition from un=
bound to bound")
> Signed-off-by: Jerry Wu <w.7erry@foxmail.com>
> ---
> Commit 25c150ac103a ("bluetooth: Perform careful capability checks in hci=
_sock_ioctl()")
> fixed CVE-2023-2002. hci_sock_bind contains a similar logic. Would it mak=
e sense to
> fix it in the same way?
>
> Thank you for spending time reading this. Apologies if I missed anything.
>
>  net/bluetooth/hci_sock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 4e7bf63af9c5..2bab2532dd9a 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -1259,7 +1259,7 @@ static int hci_sock_bind(struct socket *sock, struc=
t sockaddr_unsized *addr,
>                         }
>                 }
>
> -               if (capable(CAP_NET_ADMIN))
> +               if (sk_capable(CAP_NET_ADMIN))
>                         hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
>
>                 hci_pi(sk)->hdev =3D hdev;
> @@ -1427,7 +1427,7 @@ static int hci_sock_bind(struct socket *sock, struc=
t sockaddr_unsized *addr,
>                  * untrusted users the interface is restricted and
>                  * also only untrusted events are sent.
>                  */
> -               if (capable(CAP_NET_ADMIN))
> +               if (sk_capable(CAP_NET_ADMIN))
>                         hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
>
>                 hci_pi(sk)->channel =3D haddr.hci_channel;
> --
> 2.52.0

Seems like you didn't build test this before sending, it should have
been sk_capable(sk, CAP_NET_ADMIN).


--=20
Luiz Augusto von Dentz
