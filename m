Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6324A1C860C
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773927042; cv=none; b=ne9m/Utt5BCwYj90jShdSYwygGCPKHvRZw8NzoMV1eOtGys0BwnHgLJeShkP5P+KEvi8HqWvtA4H1OL2c3gq9xNc611LupG1kYviv1+xcx//X6eFEQbbSwilQTQGzeXWi1tHwX500qBfFOmLE8yScx3XzKnjdzqet7aVq8cyFDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773927042; c=relaxed/simple;
	bh=iu0NrWf5L6JKKRRfbAgIopYSk0e1u1/cNT4hWsiao+c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WN0Cj/JLRVXP9J7x6NvSxR1XcbiX0f/fsrO0cjIcgjYCIAKIUqEyjNuGs/DS6vJfH09LgG8+/GXg3LlRvxBD0LsqOFElqGZ85NwFSMQ0aOszvkkQTi1SPkper0pAj5wbdCv8S2+y1gptye9MkjeaMMuAR3YbZ7aC9IQqGsHIYjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 34F2C3E954;
	Thu, 19 Mar 2026 13:30:38 +0000 (UTC)
Message-ID: <be54d7f2d9df1524e651d16803cbb004328967e8.camel@hadess.net>
Subject: Re: [PATCH BlueZ 1/1] shared/shell: Fix crash on bluetoothctl
 command completion
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Wouter <wouter@xesxen.nl>
Date: Thu, 19 Mar 2026 14:30:37 +0100
In-Reply-To: <20260319132720.1517783-2-hadess@hadess.net>
References: <20260319132720.1517783-1-hadess@hadess.net>
	 <20260319132720.1517783-2-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkffuhffvveffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeeifffgheettdeggfejgefgffeguedvgeevkeevjeefkeekudejheetffeufeffueenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeefgefhvdevfefgleehgedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeifohhuthgvrhesgigvshigvghnrdhnlh

On Thu, 2026-03-19 at 14:25 +0100, Bastien Nocera wrote:
> Don't try to complete empty commands, leading to invalid reads and
> crashes.

I forgot to add Wouter's explanation on how to reproduce the bug. Let
me know if I should send a v2 (probably next week).

Cheers

>=20
> =3D=3D1430873=3D=3D Invalid read of size 1
> =3D=3D1430873=3D=3D=C2=A0=C2=A0=C2=A0 at 0x484BC77: strcmp (vg_replace_st=
rmem.c:941)
> =3D=3D1430873=3D=3D=C2=A0=C2=A0=C2=A0 by 0x435063: menu_completion (shell=
.c:1126)
> =3D=3D1430873=3D=3D=C2=A0=C2=A0=C2=A0 by 0x4352F0: shell_completion (shel=
l.c:1177)
> =3D=3D1430873=3D=3D=C2=A0=C2=A0=C2=A0 by 0x4A2542B: gen_completion_matche=
s (complete.c:1282)
> =3D=3D1430873=3D=3D=C2=A0=C2=A0=C2=A0 by 0x4A2E9CD: rl_complete_internal =
(complete.c:2104)
> =3D=3D1430873=3D=3D=C2=A0=C2=A0=C2=A0 by 0x4A257C2: _rl_dispatch_subseq (=
readline.c:944)
> =3D=3D1430873=3D=3D=C2=A0=C2=A0=C2=A0 by 0x4A26ADF: readline_internal_cha=
r (readline.c:693)
> =3D=3D1430873=3D=3D=C2=A0=C2=A0=C2=A0 by 0x4A46CE4: rl_callback_read_char=
 (callback.c:275)
> =3D=3D1430873=3D=3D=C2=A0=C2=A0=C2=A0 by 0x435E54: bt_shell_input_line (s=
hell.c:309)
> =3D=3D1430873=3D=3D=C2=A0=C2=A0=C2=A0 by 0x436A34: watch_callback (io-gli=
b.c:173)
> =3D=3D1430873=3D=3D=C2=A0=C2=A0=C2=A0 by 0x490A322: g_main_dispatch (gmai=
n.c:3565)
> =3D=3D1430873=3D=3D=C2=A0=C2=A0=C2=A0 by 0x490A322:
> g_main_context_dispatch_unlocked.lto_priv.0 (gmain.c:4425)
> =3D=3D1430873=3D=3D=C2=A0=C2=A0=C2=A0 by 0x4913277: g_main_context_iterat=
e_unlocked.isra.0
> (gmain.c:4490)
> =3D=3D1430873=3D=3D=C2=A0 Address 0x0 is not stack'd, malloc'd or (recent=
ly)
> free'd
>=20
> =3D=3D1516885=3D=3D=C2=A0=C2=A0=C2=A0 at 0x484A126: rindex (vg_replace_st=
rmem.c:216)
> =3D=3D1516885=3D=3D=C2=A0=C2=A0=C2=A0 by 0x4353AA: submenu_completion (sh=
ell.c:1153)
> =3D=3D1516885=3D=3D=C2=A0=C2=A0=C2=A0 by 0x4353AA: shell_completion (shel=
l.c:1187)
> =3D=3D1516885=3D=3D=C2=A0=C2=A0=C2=A0 by 0x4A2542B: gen_completion_matche=
s (complete.c:1282)
> =3D=3D1516885=3D=3D=C2=A0=C2=A0=C2=A0 by 0x4A2E9CD: rl_complete_internal =
(complete.c:2104)
> =3D=3D1516885=3D=3D=C2=A0=C2=A0=C2=A0 by 0x4A257C2: _rl_dispatch_subseq (=
readline.c:944)
> =3D=3D1516885=3D=3D=C2=A0=C2=A0=C2=A0 by 0x4A26ADF: readline_internal_cha=
r (readline.c:693)
> =3D=3D1516885=3D=3D=C2=A0=C2=A0=C2=A0 by 0x4A46CE4: rl_callback_read_char=
 (callback.c:275)
> =3D=3D1516885=3D=3D=C2=A0=C2=A0=C2=A0 by 0x435E94: bt_shell_input_line (s=
hell.c:309)
> =3D=3D1516885=3D=3D=C2=A0=C2=A0=C2=A0 by 0x436A74: watch_callback (io-gli=
b.c:173)
> =3D=3D1516885=3D=3D=C2=A0=C2=A0=C2=A0 by 0x490A322: g_main_dispatch (gmai=
n.c:3565)
> =3D=3D1516885=3D=3D=C2=A0=C2=A0=C2=A0 by 0x490A322:
> g_main_context_dispatch_unlocked.lto_priv.0 (gmain.c:4425)
> =3D=3D1516885=3D=3D=C2=A0=C2=A0=C2=A0 by 0x4913277: g_main_context_iterat=
e_unlocked.isra.0
> (gmain.c:4490)
> =3D=3D1516885=3D=3D=C2=A0=C2=A0=C2=A0 by 0x491351E: g_main_loop_run (gmai=
n.c:4695)
> =3D=3D1516885=3D=3D=C2=A0 Address 0x0 is not stack'd, malloc'd or (recent=
ly)
> free'd
>=20
> Reported-by: Wouter <wouter@xesxen.nl>
>=20
> ---
> =C2=A0src/shared/shell.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/src/shared/shell.c b/src/shared/shell.c
> index b061f8001414..805f4b77016b 100644
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -1122,6 +1122,9 @@ static char **menu_completion(const struct
> bt_shell_menu_entry *entry,
> =C2=A0{
> =C2=A0	char **matches =3D NULL;
> =C2=A0
> +	if (argc =3D=3D 0)
> +		return NULL;
> +
> =C2=A0	for (; entry->cmd; entry++) {
> =C2=A0		if (strcmp(entry->cmd, input_cmd))
> =C2=A0			continue;
> @@ -1146,6 +1149,8 @@ static char **submenu_completion(const char
> *text, int argc, char *input_cmd)
> =C2=A0
> =C2=A0	if (data.main !=3D data.menu)
> =C2=A0		return NULL;
> +	if (!input_cmd)
> +		return NULL;
> =C2=A0
> =C2=A0	cmd =3D strrchr(input_cmd, '.');
> =C2=A0	if (!cmd)
