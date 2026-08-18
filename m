Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB7938DC7C
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787072361; cv=pass; b=PQy91sMjVAkDzGZY6SImmD2SX95uAqrEyqgM7pqPgsnes1Gs38SDzsWe2Jl+jZkrwFrcWSuA9x9aVnLWhKzjcFL67bzBf94BUV6FEcDgFNvQyUmWJwjWZPFSU/HLvhpuMjenlaj8dyCfu0Y8Ht2mrG2DH4ptz+kebcayrUVSTzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787072361; c=relaxed/simple;
	bh=gZGzJWxOxuMRegb7oz5X6aa8mM8sryvxadYFctQKlTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XoHVYnbvDkifkDV2jkxdUQ78UMd0X0THim8NP2XMiS82Fny/m4Xf5jKnegmaxsu+Pf3WD3WtRUJoYtwvBILXvQbf3TNYyjSh1uocXsQViQYr8pX0i4EHoeV/SobGZcTYHLy3sQ3WBo44/GLx/VHK2SVWVXKAASH3yea+iFJGqqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MO2iTzXK; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MO2iTzXK"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-836ce6cbe1eso1850227b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 09:59:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787072359; cv=none;
        d=google.com; s=arc-20260327;
        b=sV2EsCKjvV2sHXDrGNeW5spBotlawRftrWOqbQZjP7bq6jjgXGJd9fUNJ/JOoWs4gn
         YcRx9ztd+IwTp0ZyRf87C2mO3iVPnnROVgDod48Uyy8GTeEJxiix4VMGoTsJyLwum5eK
         IijNjt/SmFgS9QhT9eajRlxvDbWBdF1ZMrV1MY/gj6/nyXjJZgiFIGU/IWciSdLrSzN6
         kr9shX3y4ao01rV9XlfI/Dg/RgaRjonJYaMhYDPb2lFG1mKQY/3dpUtaTfPcY/WWwUe4
         hlF9zPC8ab8FyWu3RvFeuZvk9d6gq/yRMQAyekSLMUj5cTFyhlRhmyLCUMY/8X9b1lzm
         Bosg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gZGzJWxOxuMRegb7oz5X6aa8mM8sryvxadYFctQKlTg=;
        fh=EQOfUM0IlHJPmYk9+dnF565qpFCACyLN6u78Auvm3C0=;
        b=PdN484QnFI3obG3MOwOPm8ArT0MZAnyBsW9qiDZOs58Az8CUBkKA5W6ZLVzwh9vS7m
         Lh4BMQaskBzwGQcmdUFeUa/g8hUHYpT6Hn9A0U/qCBRoD+CnbFv9nlug+LZsrGdHv2z6
         fidVoz7PIUjLxr6LlfqKbTwjRS8w4s6vDLi2nwzSGJJUd7avBzX9Ek2NDz0G96ZB7dY4
         0lZlMMKvtoE99Io27AWnEpOlnfpT0NP+4ka2ZHqhZW8LywP5QVNs2TVUS9dtKjEipLq9
         IZ5cLYSmnc0fIhbNN97cKritTUaSr8TwpKQFfoCUcXBzxjBXbpR8Hrn7RAFLSfey4McX
         pukw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787072359; x=1787677159; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gZGzJWxOxuMRegb7oz5X6aa8mM8sryvxadYFctQKlTg=;
        b=MO2iTzXKbb7QzIZCKxjLBILVmk87O0DFrVXohZIoPCJ8mNlKaqYzUrFyinftRGVgLw
         zu4OgLC8tqWuNn0W/4pC8BhsfFAZcjWbNhFr6vO7M7oIfsA0I6/2de3ZyBAy9mVmyh/h
         M4za9BReL4+a4SDBJ8EaHDwndFvlvHW9K5o1xtBn7nUUIxg9HtY3tBsBIvGiH/0AvOor
         d/qK+f102eThtphLi13r9djWL0c8QVuKXAG1PySp8hOv+5YZcPCVvwCDnLoJCx0xJNz8
         USawapMLauRVFKcRXUgMUdSSEaXre6I/kJTgNXN7iOwy2ikN9JM/WGQmO4IcrRTzL+3W
         HuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787072359; x=1787677159;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gZGzJWxOxuMRegb7oz5X6aa8mM8sryvxadYFctQKlTg=;
        b=hgvOZEaUDRwkEyeZTzIuhD0qbQMIy9DDDZv9BcBOt10zP+I+1hjcC03zbkrKwh8t4d
         SSsAriodfs2zeRxwJ04n7Sf4L8X6P/9IVdAkET7LBzEYtYagVcxp3MiHUkup3MeFqzl3
         ZyES/JiW+PFP52wVvw5MwWbVocnHC0as4GxRm4JjZ5ZrATI3JDMOulvGSpkwg9mmP6qX
         20UUhCwuILeVP7nzWliQ/K4VmGD/U4CmwEFGzGsJGFjT365z/qF2bMt/Puw0AzLadD5h
         3UeOzLauvol7XRQXsv+oVPyHtNX8F2+5NaiKJU+uUomuRN9gejrHQegyfjCBLCQqYua6
         RXhA==
X-Forwarded-Encrypted: i=1; AHgh+Rr8FnB4MzMp/D5NwRWrXdc+/TpJH/MNovGYxFuo439ujd7ea5/EZxF8cxT8StRvcQZ9Uk9yBBo8hxE05J5jDw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcF9ursrDq5r8RVZz9cYl6AyYwoUthVQW7gsJOqI7DiB3titN5
	m03le4w9l27mcUEyfL3LMKdOU+H0vmXa/KI8Fv7qzbx8Cc0wyxlBs8makWlXkOLiW8NBfwl26aR
	z8KP13dP3IdeJzqkrmriHVw7Bpg1aBDc=
X-Gm-Gg: AR+sD13vNw/MzJRheP7i+iJdpKEyxSGeaiIJ9WQOA9vS0+DPJCf+yVQ2rcSfuN0zS8m
	pCwM83h9ovTvGTxhHRUH3abmzMIsU8AxiKtgJXeEYt8Zti/Gr5HVZA/aJjVyWyzvAAinMo9C99E
	LPERbX4g8LSAf+ORWYQqPSOlHznVhDGUa2s/wB5KUy2trbvWFvkeyi5cInbx8pFQlu6xxNZWyhp
	XuDGhICNsMFUoNOSM0brnKZlGdyzFjoXHyOK50CC66Ty8ylLKzglAczBZGyX8qB+ROGIwUZhgKg
	QlRPe/cv7n8UzOAKNo08Od3hKw9vvwCYqL1iKDKZwxtEdHjMe5MJhEPkE00al6hD7UKlEsw/8Lm
	oj9hJTrlEr4BJRCRhg4GMD7NcgkyUq+s=
X-Received: by 2002:a05:690c:60c5:b0:80c:4923:cf4 with SMTP id
 00721157ae682-8412e0c945amr38581887b3.10.1787072359139; Tue, 18 Aug 2026
 09:59:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AS4PR04MB969206113CDC2F5C66994E6EE7A62@AS4PR04MB9692.eurprd04.prod.outlook.com>
 <20260818080104.563675-1-ali@iusegentoo.com> <CABBYNZ+yDwFJ7YFB60-SG6Tr1R+6BeE1E=06d5+UEK_y4j7g+Q@mail.gmail.com>
 <20260818162501.584425-1-ali@iusegentoo.com>
In-Reply-To: <20260818162501.584425-1-ali@iusegentoo.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 18 Aug 2026 12:59:07 -0400
X-Gm-Features: AcwNN1WzSMeUAVS9n4GTWLJsJ8_imbHXtk1Jbx8AVkGVYm0YZRZ6fs3Ru3WU4n4
Message-ID: <CABBYNZLUUBbK47giBBG7KH=9vU7V_wuAcSYB-oTyr0k+7iYw=Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btnxpuart: Keep FW dump header in coredump chunks
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: neeraj.sanjaykale@nxp.com, amitkumar.karwar@nxp.com, marcel@holtmann.org, 
	alex.zhou@nxp.com, song.xue_1@nxp.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ali,

On Tue, Aug 18, 2026 at 12:25=E2=80=AFPM Ali Ahmet Memis <ali@iusegentoo.co=
m> wrote:
>
> Hi Luiz,
>
> On Tue, Aug 18, 2026 at 11:51 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Ok, but if that is the case why are we parsing the headers in the
> > kernel? I thought the idea was that the kernel would assemble all the
> > segments and then push the dump as a whole. However, the above
> > suggests the NXP FW analyzer expects the headers. In that case I would
> > just have each segment reported on its own rather than appending it to
> > a separate skb including the headers.
>
> The two fields are not just optional parsing for a concatenated
> dump. They are what the driver uses to handle the dump state.
>
> seq_num =3D=3D 0x0001 tells us that a new dump has started, so
> hci_devcd_init() is called. buf_len =3D=3D 0 marks the end of the dump,
> so hci_devcd_complete() is called.
>
> The chunks are passed to hci_devcd_append() as they
> arrive. nxp_process_fw_dump() does not check whether the dump is
> currently active before calling it. That state is handled by the
> coredump code itself.

Yeah, and it concatenates the header states into a dump skb,
interleaving data with headers. The worst part is that if the analyzer
finds an issue with the header it can consider the entire trace
malformed. This means both the kernel and userspace try to parse the
same thing but may interpret what each chunk means differently.

> > Id argue that this should be appended as is then, and the analyzer
> > should be the one checking it, _or_ it needs changing and then it only
> > process the dump _after_ reassemble.
>
> The driver also does not otherwise interpret the chunk contents. It
> does not validate the payload length against buf_len, slice the
> payload, or remove anything from it. Once the chunk is long enough
> to contain the header, the whole skb is passed to hci_devcd_append()
> as-is, including the header.
>
> So the length check is only there to make reading seq_num and buf_len
> safe. It does not change what gets appended.

Well, it does change, it doesn't append anything if the chunk is less
than a header and that won't even show up for the analyzer to analyze.
Now, regarding this, I wonder if the driver receives a chunk smaller
than the header size, whether we should either append it and leave
interpretation to userspace, or 2 drop the entire dump because we
can't guarantee its consistency if we suspect data corruption when the
firmware is not supposed to generate chunks smaller than the header
size.

> The only packets we drop are those that are too short to contain
> the header. Without the header, there is no seq_num or buf_len,
> so we cannot determine whether the packet starts or ends a dump.

Yeah, the decision of considering a chunk valid or not seems to be
split between kernel and userspace. The kernel evaluates if the chunk
is too short but won't check any data consistency after that;
userspace will evaluate the headers but won't get a chance to evaluate
if any small chunk was dropped in the process.

--=20
Luiz Augusto von Dentz
