Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06352FD7D5
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765383092; cv=none; b=q712i7a5gnym+hG8uvwTE95qStvkoI6AH+G2ww8CRsMbCcYR1wNhn1noG7Q+2UhgIY4kQLgKiCGX3ATc/WfBoRWNA7i10ST1MIa46uo+utkeTejOof5yaBeXgpVkwwUgTz3ehfYcr4GutIMQ19LJZEFw11GB8Zvc+e55TYvItoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765383092; c=relaxed/simple;
	bh=6wtAnwNbRjQ25WrWRQnsCF+ptNXlSHPpQblgPTCqk+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvXrhqHRa2T/am8CJusifdAgClTNf3nOdrJdWKnNKEsu1DOqiBbxqxENifdw942WW66YVoUCw29Sk+iTSxgWB7na6ukOjRSlUwyGehAQPW2eoLIu0WP81+mPoNQB1oOv4ZCHrus84Ag+OSnrSMbSrk8+fZfpNQs3lSyahRzVZ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilVaDm5N; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilVaDm5N"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37ba5af5951so65731071fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 08:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765383089; x=1765987889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzYalpcoQ3dqM63Jfz1Y0hWN7ulQUqnY0RQxlrz6O8c=;
        b=ilVaDm5NYkF9GA0NetYGAIYeyCo4FdUH/8Mq7AHelwBSnhTOsqwldCWFjRRRFU9Plu
         NvMS8a1aCxfT5RnqXoSx27gDsubZc1zPQpHB6oiH1upJbYuHGR4/754sZKE0GRXa99mu
         gVvyYgdID1JJfiboOB2JdKAt+e0NryNc58LTVydSbCTPNpWi4eUCJ5pKzeci74p+iARV
         vf3/KIyDE/p6ZoNPiOxVP6NJ/Le2WfxCePTBf+qKDp1KyUxET40RhW8s3Nm+RCjg/RGX
         SiBgKeugBHnFntIiUk96ozgG3OfGQK/b1kNN9WhYOtpwo/Wo8MdZxcCOcoCHzj4ZjIC7
         POAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765383089; x=1765987889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bzYalpcoQ3dqM63Jfz1Y0hWN7ulQUqnY0RQxlrz6O8c=;
        b=XbIswbNJR1wCyPXk02HdKvlHohkkzD2sugtUhPBy3ubwkKk2mWV2GFtXX6s4tMcWYV
         NmRc91frZvf1rrbOwRmeNYWv+RyGJe8pdk5mMMi09rogXZeqkBAbgcY3S2SjDsFiPD74
         SgQL/MX2HZ73QhQT34rCGWhiEoyPHSO48wlLc5R3BURbooWDYB2zAwcaHSIPYBQD7uoq
         pJWWK+jWxMBcuPGiH47rnUe/V6pzXYzzcqc9uHiO4TJd9EhnCWDxlwDI1/Tk+r0hhLAW
         4oKgALn+6ws7DKFpp9GQrdJ9B14vdfx43aG0cF4DnJo618Mvb7yyCXilRYgtVYnd+VfZ
         XBmg==
X-Gm-Message-State: AOJu0YxpTGD7tabpIqqlD6vCWJnuB7SLNcQOpuSNzkb3QMHB871r8CGL
	hzNIZDRcpU5MgEhHgPl/woey4NIU+8YDoGV0te0asMLet7uDs136C1n7Xo1HXmieZQ7oq/qwZL8
	t95DQgwhpS6YylmOJgsTtzMEsA12iKLIZHJ9q
X-Gm-Gg: AY/fxX52X7cjlj4FcHPmjPFPfRzkfSnhvDyol2Q0L9krMlgqx9h585ejkLSwvoFkeJA
	xjrtqkkwidPAjbp0VM0GD2WqPHW88AIHxZoZR9PHUkl7IlTqiyPbJO6+JXNn91QSkABJ4PUO8D5
	+/y4qQe66tYtjKHajmZ3d2f5GX+25CneXhnV7/FguvAtms+wlGZXRe6elhTFL8pEFY3rUTv62DK
	MBtp7ZWkP1V4QIs0aPMQOojUwj3R85bAeh6CbOUZo4rIVFSXnNQNf1jgalwl2d0MRKEbw==
X-Google-Smtp-Source: AGHT+IFZp9QJlYTxew9S13s3KTVFJCp/wXQfPJR0kUDUq3jPTNbn5S6vwP6rpxKbpwG1lJvzW0uLgYRjVBTp2OQ7Egc=
X-Received: by 2002:a2e:be9d:0:b0:37e:56d0:1a42 with SMTP id
 38308e7fff4ca-37fb207453fmr8317011fa.17.1765383088593; Wed, 10 Dec 2025
 08:11:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765381438.git.pav@iki.fi>
In-Reply-To: <cover.1765381438.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 10 Dec 2025 11:11:16 -0500
X-Gm-Features: AQt7F2q5bO4JcVbkNcTfNXE0ZmN44siUSpq4xUCtt6DXtAg8y1rK8-xFiK97upc
Message-ID: <CABBYNZJr2URs9X4N97qf0YrjTb8fTsFpA12ENAQFHdmDhctXig@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2.. 0/7] mcp: support multiple MCP and implement
 local GMCS
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Wed, Dec 10, 2025 at 10:46=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> v2:
> - fix compilation issues
> - remove unnecessary code in get_media_cp_op_supported
>
> ***
>
> For Media Control Client, add support for multiple GMCS / MCS services
> on the server. Revise the API accordingly.
>
> For Media Control Server, make it a non-stub implementation (OTS still
> missing), and add an API the profile can use.
>
> Add tests.
>
> This changes the design of the previous MCP code, so it's mostly a
> rewrite.
>
> The shared/mcp: commit doesn't fix the API in profiles/audio, that's
> done in the later mcp: commit, as it's a rewrite of the API.
>
> TODO (for later): OTP/OTS parts -- requires design for OTP/OTS
> implementation first

We will probably need something similar to g_obex (e.g. bt_otp) to
allow us to handle transfers for MCP.

> TODO (for later): MPRIS integration to GMCS server -- this needs some
> redesign in media.c as it's hardcoded to AVRCP there.

We will probably need to decouple the struct media_player from struct
avrcp_player.

> Pauli Virtanen (7):
>   shared/mcp: support multiple MCP, and add non-stub MCS server
>   test-mcp: add tests for MCP / MCS
>   mcp: adapt to new MCP API to support multiple remote MCS services
>   avctp: move uinput utilities to uinput-util.c
>   uinput-util: fix compiler complaint about strncpy usage
>   mcp: add local GMCS service that emits uinput media keys
>   shared/gatt-client: fix notify_data leak in notify_data_write_ccc
>
>  .gitignore                   |    1 +
>  Makefile.am                  |    6 +
>  Makefile.plugins             |    4 +-
>  lib/bluetooth/uuid.h         |   27 +-
>  profiles/audio/avctp.c       |  119 +-
>  profiles/audio/mcp.c         |  802 ++++++---
>  profiles/audio/uinput-util.c |  146 ++
>  profiles/audio/uinput-util.h |   23 +
>  src/shared/gatt-client.c     |    3 +
>  src/shared/mcp.c             | 3216 ++++++++++++++++++++--------------
>  src/shared/mcp.h             |  186 +-
>  src/shared/mcs.h             |   51 +-
>  unit/test-mcp.c              | 1807 +++++++++++++++++++
>  13 files changed, 4650 insertions(+), 1741 deletions(-)
>  create mode 100644 profiles/audio/uinput-util.c
>  create mode 100644 profiles/audio/uinput-util.h
>  create mode 100644 unit/test-mcp.c
>
> --
> 2.51.1
>
>


--=20
Luiz Augusto von Dentz
