Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795029431;
	b=RNA2aE6Nim+amd0klMj+pnYY8mNXIh6W4Vx/6fZz20v1T4fn1qV77lj0nYomPMn0ERGQ
	 eg2SEd1fdKTrBFHo9Lp28p6KPqRNa96qDayHkz4c1lZRBD3Ur0/ttZBCli/oxxorraW2x
	 /zEUHRZPK4OoPsSXPxv8O81K+Skq5QRn/aOwbBbgpqq4bKQwpNu86XdLAc+D6BLt7mRSZ
	 XEOVBS4K/Z5zKiSAI1X1S9Iq5ZnexdRngYbR0eiy+zAYV2l5nHJblqV/ZJb0f+JIO4Ruj
	 Witldx1LuIEzuehP+uOkq2M8cemUZZv4ima7wjHaVwQwWB+SvmYBV7TSYfXfagFokJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029431;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=m7WT+g39MhJ8JaRbeZEa3vwhsKx2i5yNAE3vyt14FPs=;
	b=yjF429xcjdfwI5/SNCDZwCOUY8QqiQn5AQNEBIJSCSBfdOQMCxxZp0KZ2IKnJ0m9Wb6S
	 oULWvvn/Rcrqpn84+jmBuhKosJk4WxWlXyktZKEQngS1OYKTWw2par001TQpmLPNC5OWl
	 0g2Nqw3MsAxv0GT5F9RnwDim2xyncOsEVhbrMfKfCsOaCSIPyBJDtL1tu3g5xHg4cSOXq
	 RkTOMTDBNAZX4bzj8WTazUIzTQFtC0l083NQjXPRi2DIljw12JLf1PNUJPQlqXHYBV2by
	 s1E38Za8AGCzjazXd472bOTJOqvvCVnH9RYA005nYChSVtxOVjs/AB1Tb7kAYAmBpCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YNLtY2M5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8747606A32C
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8747606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YNLtY2M5
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-67da69e7c31so1326408d50.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:17:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795029429; cv=none;
        d=google.com; s=arc-20260327;
        b=qkjxyR/8YJK9rlUXlk2b+wx/IKp0I672J+lHVw7eQVS63tyt3m5WwyhTfvhIitKLu7
         zog3iMxyb4hQunZiO5niDK5HvR6Qgv9lZOMPDzwETT4lG0AIcJ5c0AAS68rzaY3NKXSs
         2UzbcbiLpqc92MEMgp66FjIZTtblp4Euc9SnRLrknoY1WKfKYcJwxkW0f6yIUH7IeT9N
         Iv2thcz1Scy4fp0H5kNEDvKBGPcx8hC427PtJufPjK4sK9EOmQd8pWAL1Jo21AqL1Hqp
         whHDJ4Yr6i9emCVKmA4YBIB4S/iy1MOKodhPp3vIOZINJyx6llIr52hgtsRT1s/aVTI6
         X8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m7WT+g39MhJ8JaRbeZEa3vwhsKx2i5yNAE3vyt14FPs=;
        fh=fJTvNhOwO3AM3tYUbNMUqA+BVc/up3gAa8zqoR5nDD4=;
        b=Wt8+zpeVPDq0B4DwsoYh1NmusCKnSCPvOZTTgEz7VS7qpz528IyBIKIFVIgnhdrqt0
         Cth2w+t9t4apSDMqydFT6r6aPWhv7CJvkSI0rMjaRzqF+1qlLv3oLrVBC1L3i5MmGkie
         cYHBlpccRtmjMUqydm8HiQ80J8IDp9rzXwhE5bhkHEJkdgMl+dZyWismRrWNJ2pldsfw
         T/Pp1XlBTDJB3tvXYVqEFqroq5ABCR1pVpkwxyLr3kPp1EEQDeRDdVhANk6j0qaeoX3z
         pGM7igzwsSCGoWeltGeoZrMFfU7Q7rNsRkNGXE/QrCY5nL1rgikLqJvq9NDqT+xQErxz
         EZlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795029429; x=1795634229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m7WT+g39MhJ8JaRbeZEa3vwhsKx2i5yNAE3vyt14FPs=;
        b=YNLtY2M5NxqF4obbZMxxxvphatU+GS9afUgOtlZMOqxH4fRyP+pyvjUa8ee2qx105l
         uWj6qS06BccFI3KsVlIP5zWcJl3mXOprU6qJByi49CCkKmRAta+cJ3NkQRPreuN2d9TU
         a4WuHFTc2npH5pcwvCwY5iJ41ngnLUZz46j6fiqWat92TaFvmR8JYisOiLjduaV8Hh/+
         NL5Vac6bDH19QhozfB0XIrVXNqd13WBlcsJmlp6uUiPPw70kM58eO2bcKl3PbXNv43aw
         k7lKdv9CIycR1AumDVHuK/rOE3ud+dIkD5N0PpU3AvvN/1mdDGIeMO81Pt1YkAsoeN6w
         pPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795029429; x=1795634229;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m7WT+g39MhJ8JaRbeZEa3vwhsKx2i5yNAE3vyt14FPs=;
        b=TYkkUyqI2M5ViqAKlyY4KpFz+0eKHEm1vopwMRI3aPbikvehHOOD52b2H8Z7Y9M2Y1
         ty1x/oFIyGwFFu/ai4fpV3aW4FrKmSvGSd37VttiLjBDxcZlDTji0Z6koDvkHJfWBWg8
         GmJd8aZBiK9q8sXfDNWbIQz8cy6POocaBTiVzhsCMbrW0Rc9TWRXEg23p1P6WB6wa97i
         1luGNwF+LXIUpaf+UiwRP/ep17LweLxB0dM7NAYeUJDIXu7HyNIMoTwWz6asPgZvKDGa
         c18IblVSvdbSmAkaD5tkdV1LP/xpwxn0sPk01tve+wU03eHlAoQt06Fxr9L/DeUFtN1w
         481g==
X-Gm-Message-State: APuU4Z8z6YOALq4n2h4RhZN/TW3S3ltjmmLqOxeMc2Uf+fLodX8LA0xO
	7p9P5ZzMVqdECQusmWoutddmci6JTaiZkgR4uSLeC11PP8x77EAtYDpG2v8QJLxIq6HlJ5SY+8l
	YihmnrQ3rpwWUhwXnhhw9QJNjCTLF/NxBwYG7MXg=
X-Gm-Gg: AZFdTZeBOgxUwgG0c0Ybv6xiH4sHv60ykEu3g/lQgYpjUvQj2D1ZkRtl1fMY7rSIuLW
	7s0taBP2LkdrofeMnmW2O03B+mjDLMBFCUYVIr6MZ6ydpzZm74cxNL6+/KlBLz+q7yIAgBlrOxL
	ZVnxlR1qpEmS4UhTXrNhMH29K47xJvy4pTmBwKrDQi0AuAr/j7zbzDb0WS3ONOxkhnrRjF53LRC
	Hi9c9AXockgqapdWrY+yPN7kO9AV4GTI8ncUGOPPOHK5UWCPHIjErq1Nc4JXo/Yuy7MnRRQNYxE
	7Sx1jbBvwn9Cd4fF7jT3bla7lvn8lCJ0M0uPdYCqS/7Bex1V8dMHNPTS6RLcM7L5Dkiou8i8zlf
	sa8FSKU3YFDWbsoVWu7hSFsvkqkYfbjQV7E995fiAcMgJ0GJaJePVfLsHUioyXMYnUdfhnXFXqh
	purUnPOz6wBBGvA/3Xat/QTDeU1w9c74GBA9VH8lKuo3ujLRJaRSXDmsWK4SwY
X-Received: by 2002:a05:690e:1386:b0:67d:a12d:acc1 with SMTP id
 956f58d0204a3-67dd3cf9de3mr1916028d50.5.1795029429510; Wed, 18 Nov 2026
 11:17:09 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117160240.222556-1-rolandschober1968@gmail.com>
In-Reply-To: <20261117160240.222556-1-rolandschober1968@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 18 Nov 2026 14:16:58 -0500
X-Gm-Features: AclHuK-4VujWN15eFD8SXoWuKPmHV3hGHpk131uCm5sIzvaKjAEcOi7cVOjYBss
Message-ID: <CABBYNZKF7jv1SS5KYnPGLafwau-QS4y1mga2=J3EUQXk7vcimg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/4] monitor: Decode Periodic Advertising with Responses
To: Roland Schober <rolandschober1968@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roland,

On Tue, Nov 17, 2026 at 11:09=E2=80=AFAM Roland Schober
<rolandschober1968@gmail.com> wrote:
>
> This series teaches btmon the HCI commands and events of Periodic
> Advertising with Responses (PAwR, Bluetooth 5.4). Until now they were
> only listed by name in the opcode table and the events were printed as
> unknown.
>
> It is meant as the first step towards supporting the PAwR advertiser
> role in the kernel and in BlueZ, which is what an access point of the
> Electronic Shelf Label profile needs: being able to read the traces
> comes before changing anything else.
>
> Patch 1 is a fix for an existing decoder found on the way: the
> Connection_Handle returned by the Periodic Advertising Sync Transfer
> commands and by LE Remove ISO Data Path was read as one octet.
>
> Patch 2 splits the LE Periodic Advertising Report decoding into
> helpers without changing its output, so that patch 4 can share it.
>
> Patch 3 decodes the five commands and patch 4 the six events,
> including the [v2] variants of existing events.
>
> Testing: I have no controller with PAwR support at hand yet. The
> commands were sent with hcitool to a controller which rejects them, so
> that btmon decodes what the host sent, and the events and the
> successful command responses were decoded from hand-made btsnoop
> traces. The output of the existing LE Periodic Advertising Report
> decoder was compared before and after patch 2.
>
> Roland Schober (4):
>   monitor: Fix handle decoding of status_handle_rsp
>   monitor: Split LE PA Report decoding into helpers
>   monitor: Add PAwR HCI commands decoding
>   monitor: Add PAwR HCI events decoding
>
>  monitor/analyze.c |   1 +
>  monitor/bt.h      | 174 +++++++++++++++++
>  monitor/packet.c  | 487 ++++++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 626 insertions(+), 36 deletions(-)
>
> --
> 2.47.3
>

Copilot flagged 2 problems:

https://github.com/bluez/bluez/pull/2842#pullrequestreview-5960745106

--=20
Luiz Augusto von Dentz
