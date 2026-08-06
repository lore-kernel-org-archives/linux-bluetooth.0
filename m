Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2623D47AF
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 18:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786042537; cv=pass; b=LClj8GqrgXycJ0mN/c8i7F1XmYtVs8xd8GPa2uuYCvXfWwNOP1jVg0KfsINgAYKnutFmVtSQG+12IFAOGZeqj8NilOsbhWY+vrVIV5QeLFPZ9/FLX/fYVZKI+eKdaquURdFLKQWsew8vCd5zCK9kgWY8dbZYZqbiBC5VbSwqnw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786042537; c=relaxed/simple;
	bh=5/IpOcNfmkuawMpnVdJEufRTFoWhR7T+4g1VX6604+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3DnGFEf+cn+RFSEjX4owhQigvoCk/78xqmCL09yiBrPfrFI+uYD/VH4aAapV1ZPIdghXBUyoAc6V5fza68C3Z9B1VRxu4FZ/2YzcvQ0HBrRbwjpsQ+t74220H+ajXC5ql0Gw3S8AUNF7k42Kzm8NMhpeEZsmzdMhIsb0YFJveA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfwP0xR1; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfwP0xR1"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8201447e8cdso42511117b3.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Aug 2026 11:55:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786042529; cv=none;
        d=google.com; s=arc-20260327;
        b=g1Lbvf+9H3XPXjRQmUNAX77JafOzeZXVSBi5tcPCUTO5NRnBXt8CghUFwiBpDZRvgO
         WALoL5Bl1ZmB7CyWAqBPkuZxpFOmq/4Y+6RCQKxvD2HZboVYxp0MIvoigP1Fa1gaP/pe
         menzpB6MUvvF1DnZDrxQqPdPKVEHepvYQpdyorczCv3AN3NBkuj46MkNb1GvklspX1TL
         XJjbU8pFEqZw9mCQuwnc6T4p6X5MDcy13StamxJwrQaCLrjxJ7XaVb+5u9qOLcTYwIQY
         9tbKlM3Ux1Y9llB3m7I2SbDPNI1I9wjHNhdDtH3bmv/PsY5WOoLpK5hrCnJ1mpmR/YDy
         q+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+ijEOuZ0B1zQLX/0acdYB4Yr9U2fgKW1o7JeKO4NunY=;
        fh=m3QqaSC7XC8aCTD5N8BbwlsE8DgumzFDV6/CM2QXLKM=;
        b=JvZmBmBEpx6A8zjnBfHRxTDHF5Y2PTt687Vsti3Sf+A9vmAYiNsCR/R4W0hIXvRPSw
         UPW2Jshqw1HmQ0l9qgDi5ewZwbMsq7zSAPsaUQs2EACZbZ6+wlwoFyuTYtW9mX8MOQ1A
         g9m+dFqLblL+uvxWbP0PBLjjSPUXhTy4eVU4razxTHtwsU4LgezWLGIjdE5GJRHrJLdq
         t4XrzpNj6v6ojXxg7oteqQ9JzwFlGazSHFkhf2+qxnF+17axrYAf5IsMU6qafVAwFPqs
         UGwRchuUM1x+St9+/76QUt0bRqrDATzJeNU81PxXcGENHn3E3xNlUGyQ2RHqlS0rnIrn
         khAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786042529; x=1786647329; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+ijEOuZ0B1zQLX/0acdYB4Yr9U2fgKW1o7JeKO4NunY=;
        b=kfwP0xR1LYNJeWY9kcse54Qyr1WyZTSP4gf9rry24rOZ8HS00Jnu7Hd/ebi3Nkzdcp
         esniTVDGNdpE86o4RO2uhii+urBHsVj7msfevEbRJZgoFevshtOCNOzSvtWtHn9amrxi
         Rbi59rISahU8HqSTm1R57pwhuxdlgPrF3sqKOIwpNof6t1gg9Uq7+qLknnVs2AJWWGgg
         p3ILUQ7ucVbIuDmJwjIsrWlxRizr7ERkvik8zFzDsQ/fpKqkvMZP5/vxOe334ZDkXPi/
         S+NIhvsEH+LHWAFAb4tTYjzDHVoE2H1dVVXOSpd0olcGRu1KjMZl5PkkprPfAKL5jJom
         iWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786042529; x=1786647329;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ijEOuZ0B1zQLX/0acdYB4Yr9U2fgKW1o7JeKO4NunY=;
        b=HbZDxwo1kFh6OK40wApzkqOM4XDhEa5fCYTdmhzT4yv8vjnEIlxrGYOQFNn4lUqcim
         7dVdUODuQi2FEFMNr5n1u/lVlb0gEEhu0GjegrLokNoQghURKBmW4D6YsutM7uYI4JWQ
         FP1vxN0ctjZnN8ZOW3tcWsqAOv7GYR7pBUq/gvyBD2KUnNVIKuQnNtr2HGXlbLXe4w96
         Pvp/eX1dA4/zto8j33E8R/fJ1xEePxxGYekgNaUmo+T+v4ZGeBgjStmqentnFucJADC+
         TuT1vRCXBx3dUMtOFRTtPZ6sQTB5ywsUC160WyVa9dDxnKMaXZfvBT/mJfoNP78P+S2h
         ImeQ==
X-Forwarded-Encrypted: i=1; AHgh+RoGRp+Ge+Zuz4JjSYg42waHOV16ORB6/Iz4WIVjvXgbKpC21mitWs7HVCX06DbaPcpR+4w1RA5t8TZV5fMiQFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YznjRHV89Nw5YbPrd1TPOJaMha1/rQvoMhZAns2FBrLohNia4Vi
	c6ud4nzRJlhEFHldsZkB/PJM7XzDM9tEVRVdDZCziEMgazTIFq5PHVeBTRXok6Y4dyJP9HlDReD
	9Hobo20NRBEUEKaaUKu2wXkojd8nUA9Q=
X-Gm-Gg: AR+sD13P80ZjQ63aBKR55600y8F1G+a9MgvXUM+ucxMMqYv5GXaB3SqqpoZDsfTxAvG
	BmDX0qI7FJmPeyoNzFhqcv+kc0O1eVddrbs5UvtS4sypSjNAMn3RGflCPRojUey/bTj78DG22lR
	uPxZnbUboDnjxMv5fgcBGdCkiplVjr+DpZWYZEN+g5vpPN+4h9TOJkEHXTuGgsa3V+Zi+Y7DQqw
	bRajWczBeB+YgZpC3kWyMBntt7gbkm4gVqbDKYttPVPEZc5EqkSfOlG4CHhZQUE4pTUx5QpfP4v
	E0RSiJXZKjbnwsKGWGGSz5PUXwoobudI+q12X+/V9YK7zHNJSzBza81jj5wDZ58FLFUTpMv1Gtq
	BdPKUc7hRH/3eXXerK6zYyAP+iB20Fu/2+TF0qTTEdcU=
X-Received: by 2002:a05:690c:45ca:b0:814:585f:73c8 with SMTP id
 00721157ae682-8201ba5dfffmr106233897b3.0.1786042528662; Thu, 06 Aug 2026
 11:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806174001.267127-1-ali@iusegentoo.com>
In-Reply-To: <20260806174001.267127-1-ali@iusegentoo.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 6 Aug 2026 14:55:17 -0400
X-Gm-Features: AUfX_mw527F3Dh7_Uv8aGPmNBmy8iIRhKkdh0MDHMQK3cVSfqHgcuRI15FqDxxI
Message-ID: <CABBYNZ+e_zyDYSGn2uRZUPR-6gn10ft6FUhk=+bG9u_XscwWfA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: MGMT: reject HCI_CMD_SYNC params_len above 255
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ali,

On Thu, Aug 6, 2026 at 1:40=E2=80=AFPM Ali Ahmet Memis <ali@iusegentoo.com>=
 wrote:
>
> mgmt_hci_cmd_sync() checks that the message length agrees with params_len
> but puts no upper bound on it. params_len is __le16 while the parameter
> length in the HCI command header is a u8:
>
>         struct hci_command_hdr {
>                 __le16  opcode;
>                 __u8    plen;
>         } __packed;
>
> hci_cmd_sync_alloc() assigns one to the other:
>
>         hdr->plen =3D plen;
>
>         if (plen)
>                 skb_put_data(skb, param, plen);
>
> so a params_len of 256 leaves plen at 0 while all 256 bytes are still
> appended. The frame handed to the driver then declares no parameters and
> carries 256 of them. On a length framed transport such as H:4 the
> controller takes the trailing bytes as the start of the next packet.
>
> The mgmt socket MTU is HCI_MAX_FRAME_SIZE, so params_len can reach about
> 1KB this way. Commit 03f1700b9b4d ("Bluetooth: MGMT: reject malformed
> HCI_CMD_SYNC commands") only made params_len agree with the message
> length, a value that fits the message but not the header field is still
> accepted.
>
> Reject params_len that does not fit the header field.
>
> Fixes: 827af4787e74 ("Bluetooth: MGMT: Add initial implementation of MGMT=
_OP_HCI_CMD_SYNC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
> ---
> Checked on a vhci controller, with the emulated controller printing what
> it receives on the transport.
>
> Before:
>
>   sending HCI_CMD_SYNC with params_len=3D256
>   controller saw: read()=3D260 bytes, hdr.plen=3D0, params carried=3D256
>   first params bytes: aa aa aa, last: 5a
>   HCI_CMD_SYNC: opcode 0x005b status 0x00
>
> After:
>
>   sending HCI_CMD_SYNC with params_len=3D4
>   controller saw: read()=3D8 bytes, hdr.plen=3D4, params carried=3D4
>   valid: opcode 0x005b status 0x00
>   sending HCI_CMD_SYNC with params_len=3D256
>   HCI_CMD_SYNC: opcode 0x005b cmd status 0x0d
>
> One thing I left alone: hci_cmd_sync_alloc() performs the same truncation
> for every caller, so a guard there would cover more than this one entry
> point. All in kernel callers I looked at pass a fixed sizeof(), except
> msft_add_monitor_sync() which computes total_size from the pattern list a
> user supplies through MGMT_OP_ADD_ADV_PATTERNS_MONITOR. That one looks
> like it can exceed 255 as well, but it needs a controller with MSFT
> extension support and I have not verified it, so I am not claiming it
> here. Happy to send a follow up for either if you want it.
>
>  net/bluetooth/mgmt.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 167d75e34526..c16b0b80c193 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2668,6 +2668,14 @@ static int mgmt_hci_cmd_sync(struct sock *sk, stru=
ct hci_dev *hdev,
>                 return mgmt_cmd_status(sk, hdev->id, MGMT_OP_HCI_CMD_SYNC=
,
>                                        MGMT_STATUS_INVALID_PARAMS);
>
> +       /* The HCI command header carries the parameter length in a u8, a
> +        * larger value would be truncated there while the parameters are
> +        * still appended to the frame in full.
> +        */
> +       if (le16_to_cpu(cp->params_len) > U8_MAX)
> +               return mgmt_cmd_status(sk, hdev->id, MGMT_OP_HCI_CMD_SYNC=
,
> +                                      MGMT_STATUS_INVALID_PARAMS);
> +

Hmm, the command should really use u8 rather than le16 here, but that
is probably too late to change it.

>         hci_dev_lock(hdev);
>         cmd =3D mgmt_pending_new(sk, MGMT_OP_HCI_CMD_SYNC, hdev, data, le=
n);
>         if (!cmd)
>
> base-commit: 0d839570765118029aa8bf4a95444c6a11aacf85
> --
> 2.55.0
>


--=20
Luiz Augusto von Dentz
