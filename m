Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA9413D281
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721306766; cv=none; b=lpPWERr5x9d+cNRiOB/9pWhJPj5sqY2tzhQJMxQr6IStYWNPirLmnTq1c89vq02pVOme38aFBtibMgpfBoO8ySmTXvX4UCftQiJdD2nUzZmt2ZRLUSj0SAb9wcCc1y/pSC7aGyDh90wgChDbQV7LiaD2534g3aSgo4Nl0/NyMl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721306766; c=relaxed/simple;
	bh=M/wztX1SXYm/Iv4ytctFKLjPAaFaboqfOoKzkDTkQc8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GG6RGTpd9TvjS4rM0BeczrjqwC2MBlIcXkB6G3aLgiuW0rdC4sQ4sKGJ71wknxM51XFN93EPKUmIzQg8HIgu6W+ApSWO2q5u65YOTFF9T+VNbBzuWaTxtHAj3Q0BdOuhOe6pI9Z3ks4ZempUiYig/O6MtzJQGU0c5JSBUFdpeF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1BCF36000D
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 12:46:01 +0000 (UTC)
Message-ID: <d268e3addcf7831caea829a09eb6d317d00ec4a1.camel@hadess.net>
Subject: Re: [BlueZ v2 02/11] shared/shell: Free memory allocated by
 wordexp()
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Thu, 18 Jul 2024 14:46:01 +0200
In-Reply-To: <20240705085935.1255725-3-hadess@hadess.net>
References: <20240705085935.1255725-1-hadess@hadess.net>
	 <20240705085935.1255725-3-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net

On Fri, 2024-07-05 at 10:57 +0200, Bastien Nocera wrote:
<snip>
> diff --git a/src/shared/shell.c b/src/shared/shell.c
> index add4fa131c7a..e8f75124f167 100644
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -452,13 +452,23 @@ static void shell_print_menu_zsh_complete(void)
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +static int _wordexp(const char *restrict s, wordexp_t *restrict p,
> int flags)
> +{
> +	int ret;
> +
> +	ret =3D wordexp(s, p, flags);
> +	if (ret !=3D 0)
> +		wordfree(p);
> +	return ret;
> +}
> +
> =C2=A0static int parse_args(char *arg, wordexp_t *w, char *del, int flags=
)
> =C2=A0{
> =C2=A0	char *str;
> =C2=A0
> =C2=A0	str =3D strdelimit(arg, del, '"');
> =C2=A0
> -	if (wordexp(str, w, flags)) {
> +	if (_wordexp(str, w, flags) !=3D 0) {
> =C2=A0		free(str);
> =C2=A0		return -EINVAL;
> =C2=A0	}

Any reason not to pick this patch up?

You can see here:
https://sourceware.org/git/?p=3Dglibc.git;a=3Dblob;f=3Dposix/wordexp.c;h=3D=
a7362ef31b05280001e961c3a630e953110b7397;hb=3DHEAD#l2203
that wordexp() will return without freeing we_wordv if there's an error
and the WRDE_APPEND flag isn't set.

Let me know if you want me to re-spin this one with a different style,
or want me to add the info above to the commit message.

Cheers

> @@ -537,7 +547,7 @@ static int cmd_exec(const struct
> bt_shell_menu_entry *entry,
> =C2=A0		goto fail;
> =C2=A0	}
> =C2=A0
> -	flags |=3D WRDE_APPEND;
> +	flags |=3D WRDE_APPEND | WRDE_REUSE;
> =C2=A0	opt =3D strdup(entry->arg + len + 1);
> =C2=A0
> =C2=A0optional:
> @@ -1043,7 +1053,7 @@ static char **args_completion(const struct
> bt_shell_menu_entry *entry, int argc,
> =C2=A0	args.we_offs =3D 0;
> =C2=A0	wordfree(&args);
> =C2=A0
> -	if (wordexp(str, &args, WRDE_NOCMD))
> +	if (_wordexp(str, &args, WRDE_NOCMD))
> =C2=A0		goto done;
> =C2=A0
> =C2=A0	rl_completion_display_matches_hook =3D NULL;
> @@ -1115,7 +1125,7 @@ static char **shell_completion(const char
> *text, int start, int end)
> =C2=A0	if (start > 0) {
> =C2=A0		wordexp_t w;
> =C2=A0
> -		if (wordexp(rl_line_buffer, &w, WRDE_NOCMD))
> +		if (_wordexp(rl_line_buffer, &w, WRDE_NOCMD))
> =C2=A0			return NULL;
> =C2=A0
> =C2=A0		matches =3D menu_completion(default_menu, text,
> w.we_wordc,
> @@ -1416,7 +1426,7 @@ int bt_shell_exec(const char *input)
> =C2=A0	if (data.monitor)
> =C2=A0		bt_log_printf(0xffff, data.name, LOG_INFO, "%s",
> input);
> =C2=A0
> -	err =3D wordexp(input, &w, WRDE_NOCMD);
> +	err =3D _wordexp(input, &w, WRDE_NOCMD);
> =C2=A0	switch (err) {
> =C2=A0	case WRDE_BADCHAR:
> =C2=A0		return -EBADMSG;
> @@ -1426,7 +1436,7 @@ int bt_shell_exec(const char *input)
> =C2=A0	case WRDE_NOSPACE:
> =C2=A0		return -ENOMEM;
> =C2=A0	case WRDE_CMDSUB:
> -		if (wordexp(input, &w, 0))
> +		if (_wordexp(input, &w, 0))
> =C2=A0			return -ENOEXEC;
> =C2=A0		break;
> =C2=A0	};

