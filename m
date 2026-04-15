Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D7230DED1
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266379; cv=pass; b=d/0ICVGxCI4E1dnioy3PJZxhxwafC08CqI6f/Bj1Brvct3N5fovOVYPOyzuMdghKBv5UiUMiu56lHHZkeHMZJ3tFaFmfWxkBtLKANemvtUO0Q5sN8o4I4W3MTkX6oFMwo82ZcbiPkbMpe4u/5cGByF4VsXX0R8EX4i/XfWkDZaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266379; c=relaxed/simple;
	bh=R35x7FeinH2LTmH0GOByVG4M38bJg/xLsvDfT8GEsJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s05GnXZYKVN+f0vrv8S9I2nppR3h85nADPAMbZ2IMSsWb5ilWcMhkMcxiQhWJ/Gqn2ICxw1yq+thaXJVxZbf9xFlje8ctMPe1/lhdMghkqnXDpRb3tl6bDHkR6CpkLGFxk4Ei1IeFiIE4EiLlDdrH0LaCvSqjrAVMTWtaY2Crts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qFRQHxuh; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFRQHxuh"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d4c383f2fcso5612482a34.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 08:19:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776266377; cv=none;
        d=google.com; s=arc-20240605;
        b=O1XhYJ//vmIdt6pFkWuBMz9HEgOmVbFeZ53KvfZCQqpgkJDJVv7j4QjByj1izQzwGd
         xGRD8tDz75oZokMqeNyhg3L43I9tf2Mqp8pViPXTr66beo/aeiHWGZ6unQXpTHi84zZq
         g8fCZV1WgmVCsCFgvoGiwKxjNWRiVYKAPeePI9gr6n6blGXX2FZyn8exp436i2uxew9c
         MGy6tq0rgq6GW1anIhNSNG6ze4OT4P4U/OdU0wUn0UM1J5xeVQpj4WTgf8s5avOgVsAo
         XL5c91DCCRUmaYECLrDD+/+pO9l8PnAJcpscBPKx8epe83i1YGpoSQK5gMWCYhyXzzJC
         dMoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1VOuNwEfeozQq2kMUhcXYFUYg+uJ+za15jc5bP91H/o=;
        fh=CAl7xfDhI5EfqVR2Yo7REdA/rCCjhGdNBYF2cWCbuF4=;
        b=JMS0jqll7dIR/fueiGPp0L905tpgB16xlcHoNChCBCXfFDxjnta1DiqCj0Pit+PcNO
         azV2Vc798UXFgYX10GhEPtQ2yyEyb8vhphLE9RiWW9SymSVwrgU8rA9entQCcJEY/NgU
         TEarZLOlrPAav6VKc9ZnT1ii60M2KvsTXBZS5+kbotGQoAVlgYhRsmXReCu0ljlgPodA
         LqgeupgXS3l8m0Flyu3ghE3FcRdwlDS6yoqQn1Z6FmWky8+dll/aeslW2gN6WtyRaKOW
         /Ic33Ijy5nIj3T+qiV0JR29uXt9Hae2iDZalcyyrNxcYotFQPjL9R9Py8jE4EVk34hUm
         rp1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776266377; x=1776871177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VOuNwEfeozQq2kMUhcXYFUYg+uJ+za15jc5bP91H/o=;
        b=qFRQHxuh4+ctWi9DbmNYCPbSakY9Apnh9G2PupcDxXkQXRl+tJA2966KYHj0GcpE8M
         pG31wS83LMosq6KV5z0RKaSulG/NOGjG5ZYrfQwA7NZe0rm3giAPsygVPyfcnGNiQsKU
         cV/auqh1BXsj/d0HCIIAjxEB/cgkixDaC6mByDFoL+xOKkz5hGuBrgtVKq8f70jA2+4j
         nWEi3guSfqicPJPoO2FPRvewKWQ1OhYlSKOwBAzzMaSqAxU9uv+qU/1hMGFOxEM9HgQe
         39+d8iLtS4mwX6cofPS71CacQPezPM0/WZp75GGosv9PHNckzb+WVFhHSEI2bHhkpIb4
         XUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776266377; x=1776871177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1VOuNwEfeozQq2kMUhcXYFUYg+uJ+za15jc5bP91H/o=;
        b=L9xXWloZBU8NuF8O7XJTl5WedGN3xVIMg9phSVdsuP5R1cZzqVPdmMsCUV1TqKe8yM
         BADKLDj4z3ggukwPIJ6w+M9lwd94cmx40Dsm/buEnBYURWEPXjG56RiTvIrM6Hmbk6h3
         sVht0aBYOObiSNrXzxT/4I91jA1zcLXIPDzui1YwfWvEoPgRYIorIy4AAgFb1s4zmYp7
         GkNa/EBZy5paM7SHEdLgA2IU3l4rc3thlWrazzB8zd5zpRZfR8vKZzNXZId9tI1nalrz
         WJqLA5ds+v014rHaoO+2J3fEVT1iOUimgW1O4pyh0I8XP9qJEb8Rr9WAa59QRvEr3lgP
         C4rA==
X-Forwarded-Encrypted: i=1; AFNElJ+egqO8+QFY/LTZG9ebxuHxSSIRKm0KFw+lLukY2fbgqgdHcJs5PNHMEDA/JhHDyOhlmXX/j/coG/gjcKs0imM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ4awmGoTXFDsApsbNRglCqQwjlQCYkj8gr+hh9PwPVX5VmGyG
	XktwOR5qN2uVpHUDt15qU6zy5xdPE/KejqgUmxZPwoSOyIZIN7wv4nX1NpSfxQTLp1YHfN2y4O0
	zfsd0mtbgty/KD2qFyDCQgXhDFAEBO1mE/Cd9bexjfQ==
X-Gm-Gg: AeBDietsOrOUXlEeqYgGFNmm1zSuPGcHFh0qkdUbCMhKZKwp6ypzfkjrvoOiZqR2mvi
	NSvrqs4jzjKjxEty4137ruIPk22/AOExA//DxygYnOEguyoA6s0uc+95j2Rs1KhQjAxePLR53pj
	cGx8TWOtwzCwcSQric5Rzbnvcjf6+91UrGclqsx1Cf0ouX1TbGWwiMuIFG9JPRnqcl9fuM7DrSd
	HaK+ZFCUQKiLxRd4E6DURPOvYIiqtpDjMQ8pygkBHBGbkZKEYHYrV3M9hy8E2oTpcebOhIA41Fq
	cllZWbp9VMQjFlvgsVZLT8XW7+zM71q1fML7tHfTUsLbiDevYBX8gxv89KnvsJzwE3xWAO8GXHS
	lZg==
X-Received: by 2002:a05:6820:98a:b0:68c:a53c:8ff1 with SMTP id
 006d021491bc7-68ca54bd3eamr11009276eaf.11.1776266377081; Wed, 15 Apr 2026
 08:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407-brcm-prio-v2-1-3f745edf49af@gmail.com>
 <CABBYNZJAEqwfTuVqbFAnx97HBSjcwn3Hb+y+r4r2C=MMPxFoDg@mail.gmail.com> <CAMT+MTQ6orj5tpiGL9hz8m2TGiBjA-9D_0e1iLt=_dXBFHcOgg@mail.gmail.com>
In-Reply-To: <CAMT+MTQ6orj5tpiGL9hz8m2TGiBjA-9D_0e1iLt=_dXBFHcOgg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 15 Apr 2026 11:19:24 -0400
X-Gm-Features: AQROBzDwk1p0rJ7IlG2lPh_IuUkTifTHO7F9HnsebEPzRDlTsV8TRziiZbRGV7g
Message-ID: <CABBYNZLNR8hYS9jLLKeB=M9XVvtSFtf1wi4DmcJKBbQVvHTPaw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Add Broadcom channel priority commands
To: Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sasha,

On Wed, Apr 15, 2026 at 8:34=E2=80=AFAM Sasha Finkelstein <fnkl.kernel@gmai=
l.com> wrote:
>
> On Tue, 14 Apr 2026 at 16:00, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > > +       if (sock)
> > > +               set_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
> >
> > This is more complicated than it needs to be. I'd just add a new
> > callback, `hdev->set_priority(handle, skb->priority)`, so the driver
> > is called whenever it needs to elevate a connection's priority, that
> > said there could be cases where a connection needs its priority set
> > momentarily to transmit A2DP, followed by OBEX packets that are best
> > effort. Therefore, `hci_conn` will probably need to track the priority
> > so it can detect when it needs changing on a per skb basis.
>
> I have tested per-skb priorities, and unfortunately, this does not work.
> If something tries to send a low-priority packet (for example - a volume
> adjustment), a priority drop causes the same kind of dropout that is
> caused by scans. It appears that the only way to make this hardware work
> is to set the entire hci connection as high priority for as long as it
> is being used to transmit audio.

Ok, then maybe we should decrease the priority, so it can only go up.
That said, in a multiple connection scenario, we cannot really tell
what should be prioritized if we cannot momentarily decrease the
priority.

--=20
Luiz Augusto von Dentz
