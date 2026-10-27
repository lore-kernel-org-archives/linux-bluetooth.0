Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793123991;
	b=buUJeIE9KZCuSa00Hhl8EdW/CJP+IfSPgVS6LPJ1/BdYcaruwLY1teeuncK/NXEnIIW3
	 PRIbcubplsSI0U0ul0ySyAVqCnEf1x3MAzAKWCKDYuoS9qONHROZNoowEgglr2GT5jjTW
	 34XnuMSUrt/GBX52Vks2qvRoweBVDWEdy5twpo9BS1pYhy0kAlXgBrZKvhz5nJGiZCMAO
	 kMSlGbCZrpV/ou6yZzk7kshN2fvELi1GuaME4Fzl6QzEwy6KPC1VuiNjEddqaeXoEVSSw
	 LaOzQQE1+DFRmDwreWzies0bkZHccj8ue1eLLOacB/bQkz/D6F6W2/HjDyTWzu1u3Nw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=2IxOFILwuauNdEEukQ/LfmXx8V9lpNm5Z2RcO6aczU0=;
	b=JspCvorP3oMYt45k3rPTq7/fVV8wYvOqgAPTfaIzxBzxfjtUSA+L07OsfkRSq+i3a3mq
	 LxvfxddenrcmbxWN+EC9lpA35lUriJqOUDFn++3r0BqHwRulZ2ZZ4EuMf3qKUdsoCdIRw
	 EJRdcx2BCCVSHPlhj1laTaEgBmEFd2eQ8+it7GLFNF7S8RcIqi3tFhxlui+u7J4EhrCX/
	 1LveC4mxuh5QLEjQFM3DLXkbwVZu0+M0wocU+zqDiEv6Wq1bdK7kZLQH/TuUiaosPG5p2
	 GzivbwugYImE9IQLxC0gvMUY069CrlD3qSZH7llYj5G1tzht9pN6OvABevzg9FrR4BA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SnktLtBr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D36606A325
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 17:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89D36606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SnktLtBr
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b0a28a720aso862867b3.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 10:59:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793123990; cv=none;
        d=google.com; s=arc-20260327;
        b=cycWb+83qlotrnSfqZbnWLfL9sYKQ0fRBajMoCvfrCEle0NatK+hsfaMTSX1C7iEWJ
         ypOOJE4lbvgCCaIBkSHWusxN4BiUKxwZwgc1YkgiB1UORFlk4eGgsQNDtmWmDY9H0ncI
         TOOko1I+voPnJFDugdwgnhcnfdiTYyLGqfljqnzXjgn1dP1sDcH9PMbDAy+saxZMOoyi
         vk3ka/riQ13CD94AFwVCLubkbS9kZ1qmRMjzz5+X13qkT9PkWot73Xa/FMeOR2UwF/wv
         Y3oxQ4PhzGFoBZxfO0M+AX1M2IXsxakM/CaqizFQvmrbrrAR8qjVR2jvhbCmXA3YaC04
         ZFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2IxOFILwuauNdEEukQ/LfmXx8V9lpNm5Z2RcO6aczU0=;
        fh=MUEAtz3gH+Mak1fGzoTxgs9qzNUeP8AI3a77h9dDw+M=;
        b=oCEbsVZLz8jyhp7F4hD04S243YV1IwCOQBzsY7MtXm/db0FKGLteHOjc9chMNTVI90
         fNfvNOOdQxMg7mvP/osxDGFl9G14miDo6krcEyQ7Azqejbpo77tTJGkzKOm51xIPr0gO
         CGQZ3rJGQF0Gsyv3GhEj/WmxCgwHyx3fYd+g7aAnK4TWiuOwiMhFpQ3hqGUSasr8vhfC
         BE5pWTpHo99PGYKVWPngnmp/FE6KLdGYvWYT/ZxqI6w4D8TIMYi1nRb6LM8CabDy1F0n
         Hgvl57G874pdOyvQgUHTEFKgIDDUn5FVCC8/M92304jLMrmRCIx6x4bWOFjsSDxpGlRd
         dnKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793123990; x=1793728790; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2IxOFILwuauNdEEukQ/LfmXx8V9lpNm5Z2RcO6aczU0=;
        b=SnktLtBrnp4+KXkShCo4O628FB7sDZXPhh2wLNzPXbW/WuRMX0wh6RM5VjWxc/8NG6
         5VDxX2lgMz0UOiIoA4JRNxQKmg5wglEqD/n+hbFHHwhBrB38MF20RCZPAtPPCOFN1YIf
         oLu1FgAyaNUGQRTsPqFwC9bDXCejbhhkWc+VcRWsnjtYCHPBAP5LOacQWO3+e3qAiuZO
         LSlN5+cSZebyQ9GHoAiSb7MI0CV4HhaXldL48n2UWIq2/W09S5H7nOIX5sx2zSoia92d
         H29Z4sOxuq9mYSpQt2O4gvxwxlL5nDohaTz+q06tcAO71UIn3CAqiqx9BAyat4V4C00D
         m58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793123990; x=1793728790;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2IxOFILwuauNdEEukQ/LfmXx8V9lpNm5Z2RcO6aczU0=;
        b=bkya/pVo0NEOEdrnyTSjf75mYkcD64ddNXtaR62kLqvlP70gOEPvrxrX1cNgGhwKfX
         2P5PaesggQC1HbZS2gc9pPfTD0YMn8Gaj5C6b/fWco8YUccUD9sCoL5nS70UQeKd9iu8
         aH6HDtGPurcW7iXut7pbJ81jOkjz/oav1m2kaELhGWTfv8HYBSExMjf+6REvbp+fbqBu
         iXT6SWwvRbWGLmBmuNhhUp/ODwNm5LHEWqFu9WZ1PWk8dNrdetoZjn3jTY/L134kZ9yk
         tDp7epOrqSF1U/RGVLsMgk1UyGjzZ/K56BRZiM6qPzBc+dgMpvAeX1ggiRbBXqwH1apW
         oZ+A==
X-Gm-Message-State: AFq9FYIap7mgPbRkAxgEsJmLf6FayoVQvB0FW/LQIlGgMCyWIcAY+BNw
	49n6MOrYVy3FzizWSYTBQP1XVkzHSbLtcMkrg3ubf7L5bUkQZ7ZpyXNeMiml+QvkLtwIm40geVb
	lAh/a+qr6CgzUbv/iyAlZgV4lEiErIJU=
X-Gm-Gg: AYBFou1rR1eGKH5Ld4wcGF+sMtsX7qCaGJVuJs4/fEXf//sF1Lmdb9UcTHoXYj4zFWG
	rVANHnUr4b9zbhELsIiMicOHpxjAbDZq+w0Ibm2Mln3IcEuw6SX+iNhxKa4Q7AjqDEtneSG+Mgm
	BlU/3klA+PTG0RVDT17wJXrIVHXmzNOCv+8nILBs8cmhAGmYsywJ8cextnGjO8Tfu1Ykrdfxirk
	oSc3uq19NbbBtwg5JHw9//InLeZ8brGg+rSINiYYETjr5Yr/45l+yeZO/74xXzhZUfIHCCh6idA
	wbcbxC5/nYEW/vh/Bk5cGwwwj8m5TnedSf0/99jurLOO1SuJJM7x2X3tpr3yKwZrVibzk15yBsT
	wVY1I/RdAQijD5Ni6BlH9DlB73LeVbgRz3oNyLwYPU2DK1n8c29K0qZAxcGmzi0PlM4sOWwuGG/
	NIQBv65Gak2lmjDWUXNKPJoA==
X-Received: by 2002:a05:690c:e3c3:b0:865:838f:485b with SMTP id
 00721157ae682-8b1669cb043mr83823977b3.4.1793123990365; Tue, 27 Oct 2026
 10:59:50 -0700 (PDT)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027172730.86568-1-kevin@simpleble.org>
In-Reply-To: <20261027172730.86568-1-kevin@simpleble.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 27 Oct 2026 13:59:37 -0400
X-Gm-Features: AclHuK-TC4wrsAuuVWed_UFF37S07lH0gzZxu_GrHCIaT30ONdmpqKL6E1OGaZY
Message-ID: <CABBYNZLHcSnD36Y3T=HJD7b56rmmyg+pa=+p_kFpJpVuOvoiPQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: MGMT: Fix discovery stuck after a failed
 Stop Discovery
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

On Tue, Oct 27, 2026 at 1:27=E2=80=AFPM Kevin Dewald <kevin@simpleble.org> =
wrote:
>
> Stop Discovery moves the discovery to DISCOVERY_STOPPING, and
> stop_discovery_complete() only moves it on to DISCOVERY_STOPPED when
> stopping succeeded. When it fails, for example because LE Set Scan
> Enable times out, nothing else moves the discovery out of
> DISCOVERY_STOPPING, as the LE scan timeout was cancelled before the
> scan was disabled. Until the controller is powered off, every Start
> Discovery then fails with Busy, and hci_update_passive_scan_sync()
> skips background scanning, so devices set to auto-connect are not
> connected anymore.
>
> Move the discovery to DISCOVERY_STOPPED also when stopping it failed,
> as start_discovery_complete() does when starting fails. This sends
> Discovering (disabled), and the passive scan update disables the scan
> again if it is still enabled.
>
> Fixes: 0e05bba6f6f8 ("Bluetooth: Update stop_discovery to use HCI request=
")
> Assisted-by: Claude:claude-opus-5.5
> Signed-off-by: Kevin Dewald <kevin@simpleble.org>
> ---
> Changes in v2:
> - Add the missing Signed-off-by. v1 went out three times without it,
>   sorry for the noise.
> - v1: https://lore.kernel.org/linux-bluetooth/20261027171913.82628-1-kevi=
n@simpleble.org/
>
> Reproduced in test-runner with a new mgmt-tester case, "Stop Discovery -
> Scan Disable Failed 1", in which the emulator answers LE Set Scan Enable
> (disable) with Unspecified Error: without this patch no Discovering
> (disabled) event is sent, the scan is left enabled and Start Discovery
> fails with Busy one second later (3 of 3 runs); with it the scan is
> disabled again and Start Discovery succeeds (3 of 3). Freezing the
> emulated controller while bluetoothd stops discovering gives the same
> result through the HCI command timeout. The other kernel testers pass as
> before. Only tested with the emulator, not with real controllers. I can
> send the mgmt-tester case to BlueZ if you want it.

Ok, but this is not the expected behavior, I can agree if the error
indicates the scan has already stopped; otherwise, we should probably
fail and restore the discovery state won't be, or starting it again
may fail because the controller state in sync with the discovery
state.

> hci_pause_discovery_sync() has the same pattern on suspend, which I have
> not reproduced.
>
>  net/bluetooth/mgmt.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 3cb4f9ece8..06595175d9 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -6322,8 +6322,11 @@ static void stop_discovery_complete(struct hci_dev=
 *hdev, void *data, int err)
>                           cmd->param, 1);
>         mgmt_pending_free(cmd);
>
> -       if (!err)
> -               hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> +       /* Leave DISCOVERY_STOPPING also when stopping failed, since noth=
ing
> +        * else moves the discovery out of it: Start Discovery would keep
> +        * failing with Busy and passive scanning would not be resumed.
> +        */
> +       hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
>  }
>
>  static int stop_discovery_sync(struct hci_dev *hdev, void *data)
>
> base-commit: 47d4d9f67e92d56ef3965f2727f9c98a5a611368
> --
> 2.53.0
>


--=20
Luiz Augusto von Dentz
