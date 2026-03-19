Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4152E3C8700
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 11:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773918942; cv=none; b=Evh7wEl3KbsLF2bFgMUlzczw/0VcGUU2STFKgB0c6Gv4xhwBzPeeD9zSpLfsThvprCT3nxOFTRffiL+unaVR6a4JMGL/ztjR+/X7XFyOXvzrxFFpgWtAT84eY6doCauSJGc5H+0uidUxqQHu8Xjl+yKu/gz1FtsBrht+WObb3JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773918942; c=relaxed/simple;
	bh=oJaKNdRMoY6Bp7pOkZfOs4V9gnZyCBlb3iizCv/ahhE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=twO5begmNiGMIGCsHJPcWgva669ObJLGlkmBdhSeYrloogzHbZ/Rj9qwXiW1YP/UWXSS1Y/UMuGctcFl87YQkX9IPBB/YmIKKwgVqAECeld3QBYL4+y2wMUiry96/AHv8VEpsAvF6fDU7ErcjHhOXiSE4bBBcQW9/k76Ug62riw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id F3C243E97B;
	Thu, 19 Mar 2026 11:15:33 +0000 (UTC)
Message-ID: <1b00ec2d4091980aac843f65a72c40752436aed9.camel@hadess.net>
Subject: Re: [PATCH BlueZ 1/1] shared/shell: Fix SIGSEGV on invalid input
From: Bastien Nocera <hadess@hadess.net>
To: Wouter <wouter@xesxen.nl>, linux-bluetooth@vger.kernel.org
Date: Thu, 19 Mar 2026 12:15:33 +0100
In-Reply-To: <d0395481e127f9a9324ae515c94e3bf869eb4fe6.camel@hadess.net>
References: <20260319021645.2137513-1-wouter@xesxen.nl>
		 <20260319021645.2137513-2-wouter@xesxen.nl>
	 <d0395481e127f9a9324ae515c94e3bf869eb4fe6.camel@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeikeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkffuhffvffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepueeviedvteekkefgfefffeethfejieekteffvdetjeehfeeileettddvueeludelnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugephfefvedvgeefgfeljeeupdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopeifohhuthgvrhesgigvshigvghnrdhnlhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-State: clean
X-GND-Score: 0

On Thu, 2026-03-19 at 12:08 +0100, Bastien Nocera wrote:
> On Thu, 2026-03-19 at 03:16 +0100, Wouter wrote:
> > This fixes a crash when handling "<space><tab>"
>=20
> That looks good to me, but is there any chance you could add the
> valgrind output when reproducing this crash?
>=20
> This should show the exact line where the problem is.
>=20
> I would also add an explanation to the commit message like:
> "Make sure to check w.we_wordc (word count) before accessing
> w.we_wordv
> (word array)"

Actually, looking at the valgrind output:
=3D=3D1430873=3D=3D Invalid read of size 1
=3D=3D1430873=3D=3D    at 0x484BC77: strcmp (vg_replace_strmem.c:941)
=3D=3D1430873=3D=3D    by 0x435063: menu_completion (shell.c:1126)
=3D=3D1430873=3D=3D    by 0x4352F0: shell_completion (shell.c:1177)
=3D=3D1430873=3D=3D    by 0x4A2542B: gen_completion_matches (complete.c:128=
2)
=3D=3D1430873=3D=3D    by 0x4A2E9CD: rl_complete_internal (complete.c:2104)
=3D=3D1430873=3D=3D    by 0x4A257C2: _rl_dispatch_subseq (readline.c:944)
=3D=3D1430873=3D=3D    by 0x4A26ADF: readline_internal_char (readline.c:693=
)
=3D=3D1430873=3D=3D    by 0x4A46CE4: rl_callback_read_char (callback.c:275)
=3D=3D1430873=3D=3D    by 0x435E54: bt_shell_input_line (shell.c:309)
=3D=3D1430873=3D=3D    by 0x436A34: watch_callback (io-glib.c:173)
=3D=3D1430873=3D=3D    by 0x490A322: g_main_dispatch (gmain.c:3565)
=3D=3D1430873=3D=3D    by 0x490A322:
g_main_context_dispatch_unlocked.lto_priv.0 (gmain.c:4425)
=3D=3D1430873=3D=3D    by 0x4913277: g_main_context_iterate_unlocked.isra.0
(gmain.c:4490)
=3D=3D1430873=3D=3D  Address 0x0 is not stack'd, malloc'd or (recently) fre=
e'd

I think that a check in src/shared/shell.c might be better (and would
avoid having to fix the bug in 6 other places). Something like this?

--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1122,6 +1122,9 @@ static char **menu_completion(const struct bt_shell_m=
enu_entry *entry,
 {
        char **matches =3D NULL;
=20
+       if (argc =3D=3D 0)
+               return NULL;
+
        for (; entry->cmd; entry++) {
                if (strcmp(entry->cmd, input_cmd))
                        continue;
@@ -1146,6 +1149,8 @@ static char **submenu_completion(const char *text, in=
t argc, char *input_cmd)
=20
        if (data.main !=3D data.menu)
                return NULL;
+       if (!input_cmd)
+               return NULL;
=20
        cmd =3D strrchr(input_cmd, '.');
        if (!cmd)

Let me know if you want to send a v2 with the mentioned changes instead.

>=20
> Cheers
>=20
> > ---
> > =C2=A0src/shared/shell.c | 18 ++++++++++--------
> > =C2=A01 file changed, 10 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/src/shared/shell.c b/src/shared/shell.c
> > index b061f8001..57bba0977 100644
> > --- a/src/shared/shell.c
> > +++ b/src/shared/shell.c
> > @@ -1174,15 +1174,17 @@ static char **shell_completion(const char
> > *text, int start, int end)
> > =C2=A0		if (wordexp(rl_line_buffer, &w, WRDE_NOCMD))
> > =C2=A0			return NULL;
> > =C2=A0
> > -		matches =3D menu_completion(default_menu.entries,
> > text,
> > -						w.we_wordc,
> > w.we_wordv[0]);
> > -		if (!matches) {
> > -			matches =3D menu_completion(data.menu-
> > > entries, text,
> > -
> > 							w.we_wordc,
> > -
> > 							w.we_wordv
> > [0]);
> > -			if (!matches)
> > -				matches =3D submenu_completion(text,
> > w.we_wordc,
> > +		if (w.we_wordc !=3D 0) {
> > +			matches =3D
> > menu_completion(default_menu.entries, text,
> > +							w.we_wordc
> > ,
> > w.we_wordv[0]);
> > +			if (!matches) {
> > +				matches =3D
> > menu_completion(data.menu-
> > > entries, text,
> > +								w.
> > we
> > _wordc,
> > =C2=A0								w.
> > we
> > _wordv[0]);
> > +				if (!matches)
> > +					matches =3D
> > submenu_completion(text, w.we_wordc,
> > +							=09
> > 	w.we_wordv[0]);
> > +			}
> > =C2=A0		}
> > =C2=A0
> > =C2=A0		wordfree(&w);
