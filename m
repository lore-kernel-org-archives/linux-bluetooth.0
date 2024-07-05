Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF693FEC
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 01:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720142804; cv=none; b=GTO43VMl1QY5tPv0anz4k9+UHS8LQuNFo/M5/xe8hMWJOgO7nr1no45sFKXUnzfF5m8NMpVjmIRKrDZ74MXABLNSc4g+9SKOWMLeMPcnKbFdyupFrruGBzlJs1D/36cOWgokC+oXKxa1Jq96KVRugkPZXtiUJnjUoFAmsPN6Uj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720142804; c=relaxed/simple;
	bh=UTde1XQrKn+ZgV+0DgrOjfwPeigw6CbdwqPx4hkFbh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T45697n/wvsMhGxGI7OS+JmiCxeP+9Z2qiHxAfrhh0d4Fbf0Cbp8k6O1I3UysbeH4CdZ10u3Ss7M5nAnzfCB+5yDtXWituBBgUIAJPFLXFyr9iOLAF+t7T5sm/DkvFqdQVxTugdka1Z5nX44ANKLrqD3D3VlgXsUEbAi5ODejHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y60bYUpi; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y60bYUpi"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so14939461fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jul 2024 18:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720142801; x=1720747601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLhRwgrjrIdu7lUe46Zo69IBGq3MxC5JguoCDUbRe7U=;
        b=Y60bYUpilelCLGMyMAIjgYbpRu2GTIFWbgTS6AKEWYi/QOsdL6jV82qLqk9Kvhneb5
         YDtfLxy7K+U29K4N8S4xeccTY4NwZork71EX+XsIS+cNuvTw4uv4GxWUwXzAkgkBZBVq
         NxKvDjN5d0pJeiuho6yYu9Azfbm3Q64v9xqrAYTDihzhdJeD2jyBiL6jvZUxVwcepiir
         T/sWYD3sIAPCMu0kUrhHb8mYeQrxWHZnwIXBo8sn7ph1bdzsq5zN5ljYAER3ZFcJg8TF
         0yqdW1BNLHKDe0obVGIg2yXnKBMmJiDBSwcbJfJ3WWojvsSVO0AkekHlQDpJzd/7kqx8
         aihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720142801; x=1720747601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLhRwgrjrIdu7lUe46Zo69IBGq3MxC5JguoCDUbRe7U=;
        b=NTKfhqSPohhoZosxliRf+CnWd238iGol3GDHCylYTZzFBwUEW94EkESL7F77QouQ+v
         HmTbk7vhfvNp3gil1R7AdoJtGMjUp/7984a3PbbLw0u8B07Rh0H5uiZi39MhiGCSDYUD
         WCFQqsKAN8XrYyCA6wbQtumOfzumkqd54KPnTLbfkQfeOalIVvYQ9CcsI4HriTIlHJTc
         BdI33ZN4WLxIzZFW2WHHDFKS0HXE4izkWVHVHkt06eD5dfCCp1QAn2aXYWiqd64i9cCA
         ZE+LOuoaUrGHL+USe9uC/U0oGq1JKA8BVEj7Z4l5WljGhCv8Gx66tFZjL+QRk7d3DphY
         lwDQ==
X-Gm-Message-State: AOJu0Yx7/be5ThuVl3r95BcCFaIKYeQk+J8dM1ql/PPeSEe3tYOF2GJe
	pztvYAwiWnitnwjabNjM4DVoxdANHs+RenYzB10gv3IH00j1jhRrVb+VNxVyK9ItinwSqp6J8Ge
	muVMPf9o6renGSPV67dV5ruR3ewDoFg==
X-Google-Smtp-Source: AGHT+IEXNT/NDgQf2Lx+kUgy+VfbymDxY5ZkWs9+vIC3I3qhg7GQ00uCzZeA9zgI9T0FhSR55gvK/d1hfoQWXpPIp5U=
X-Received: by 2002:a2e:b3ce:0:b0:2ec:522f:6443 with SMTP id
 38308e7fff4ca-2ee8ee01a78mr20032871fa.33.1720142800461; Thu, 04 Jul 2024
 18:26:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704102617.1132337-1-hadess@hadess.net> <20240704102617.1132337-4-hadess@hadess.net>
In-Reply-To: <20240704102617.1132337-4-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 4 Jul 2024 21:26:25 -0400
Message-ID: <CABBYNZJSFjPb4OegXS6ynXGPitmRUVdydW=h=qHfzFXcj9Yo7g@mail.gmail.com>
Subject: Re: [BlueZ 03/12] shared/shell: Free memory allocated by wordexp()
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Thu, Jul 4, 2024 at 6:33=E2=80=AFAM Bastien Nocera <hadess@hadess.net> w=
rote:
>
> Error: RESOURCE_LEAK (CWE-772): [#def40] [important]
> bluez-5.76/src/shared/shell.c:1113:3: alloc_arg: "wordexp" allocates memo=
ry that is stored into "w.we_wordv".
> bluez-5.76/src/shared/shell.c:1114:4: leaked_storage: Variable "w" going =
out of scope leaks the storage "w.we_wordv" points to.
> 1112|
> 1113|                   if (wordexp(rl_line_buffer, &w, WRDE_NOCMD))
> 1114|->                         return NULL;

Derr, this is NOCMD has been found...

> 1115|
> 1116|                   matches =3D menu_completion(default_menu, text, w=
.we_wordc,
>
> Error: RESOURCE_LEAK (CWE-772): [#def42] [important]
> bluez-5.76/src/shared/shell.c:1412:2: alloc_arg: "wordexp" allocates memo=
ry that is stored into "w.we_wordv".
> bluez-5.76/src/shared/shell.c:1415:3: leaked_storage: Variable "w" going =
out of scope leaks the storage "w.we_wordv" points to.
> 1413|           switch (err) {
> 1414|           case WRDE_BADCHAR:
> 1415|->                 return -EBADMSG;
> 1416|           case WRDE_BADVAL:
> 1417|           case WRDE_SYNTAX:

Ok, but where in the documentation of wordexp it is saying that
we_wordv is left with anything allocated if it fails? Ive assumed if
it returns an error no argument has been processed, otherwise this is
sort of misleading and the errors shall be returned by index of the
word.

> Error: RESOURCE_LEAK (CWE-772): [#def43] [important]
> bluez-5.76/src/shared/shell.c:1412:2: alloc_arg: "wordexp" allocates memo=
ry that is stored into "w.we_wordv".
> bluez-5.76/src/shared/shell.c:1418:3: leaked_storage: Variable "w" going =
out of scope leaks the storage "w.we_wordv" points to.
> 1416|           case WRDE_BADVAL:
> 1417|           case WRDE_SYNTAX:
> 1418|->                 return -EINVAL;
> 1419|           case WRDE_NOSPACE:
> 1420|                   return -ENOMEM;
>
> Error: RESOURCE_LEAK (CWE-772): [#def44] [important]
> bluez-5.76/src/shared/shell.c:1412:2: alloc_arg: "wordexp" allocates memo=
ry that is stored into "w.we_wordv".
> bluez-5.76/src/shared/shell.c:1420:3: leaked_storage: Variable "w" going =
out of scope leaks the storage "w.we_wordv" points to.
> 1418|                   return -EINVAL;
> 1419|           case WRDE_NOSPACE:
> 1420|->                 return -ENOMEM;
> 1421|           case WRDE_CMDSUB:
> 1422|                   if (wordexp(input, &w, 0))
>
> Error: RESOURCE_LEAK (CWE-772): [#def45] [important]
> bluez-5.76/src/shared/shell.c:1422:3: alloc_arg: "wordexp" allocates memo=
ry that is stored into "w.we_wordv".
> bluez-5.76/src/shared/shell.c:1423:4: leaked_storage: Variable "w" going =
out of scope leaks the storage "w.we_wordv" points to.
> 1421|           case WRDE_CMDSUB:
> 1422|                   if (wordexp(input, &w, 0))
> 1423|->                         return -ENOEXEC;
> 1424|                   break;
> 1425|           };
> ---
>  src/shared/shell.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/src/shared/shell.c b/src/shared/shell.c
> index 878be140c336..c09d41ee54df 100644
> --- a/src/shared/shell.c
> +++ b/src/shared/shell.c
> @@ -1117,8 +1117,10 @@ static char **shell_completion(const char *text, i=
nt start, int end)
>         if (start > 0) {
>                 wordexp_t w;
>
> -               if (wordexp(rl_line_buffer, &w, WRDE_NOCMD))
> +               if (wordexp(rl_line_buffer, &w, WRDE_NOCMD)) {
> +                       wordfree(&w);
>                         return NULL;
> +               }
>
>                 matches =3D menu_completion(default_menu, text, w.we_word=
c,
>                                                         w.we_wordv[0]);
> @@ -1421,15 +1423,20 @@ int bt_shell_exec(const char *input)
>         err =3D wordexp(input, &w, WRDE_NOCMD);
>         switch (err) {
>         case WRDE_BADCHAR:
> +               wordfree(&w);
>                 return -EBADMSG;
>         case WRDE_BADVAL:
>         case WRDE_SYNTAX:
> +               wordfree(&w);
>                 return -EINVAL;
>         case WRDE_NOSPACE:
> +               wordfree(&w);
>                 return -ENOMEM;
>         case WRDE_CMDSUB:
> -               if (wordexp(input, &w, 0))
> +               if (wordexp(input, &w, 0)) {
> +                       wordfree(&w);
>                         return -ENOEXEC;
> +               }
>                 break;
>         };

If we really need to call wordfree regardless then I'd probably have a
function that wraps wordexp and automatically does wordfree on error.

--=20
Luiz Augusto von Dentz
