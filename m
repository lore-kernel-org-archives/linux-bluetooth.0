Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A821D86CB
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730130905; cv=none; b=iarrVXsxcabKqxuRw8m231lgTJbPQ9onKsLddgoTc8vIkDdBLly9+Qa7y2JQUvfkCowXKXwgOx6gJ7KBdsF2BPIv96tAtu6DM96cNimM2MnI1Y1f6iaiyfAuQDsck9E5+sQgIJhXaORGw5oShXoMJoXisL4X77zcxHNAaHIQUG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730130905; c=relaxed/simple;
	bh=+5kVm7u0CDJNQISM/i42/NwMVkQ+nI5uipUZ7dwm/6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWhPUMeVS5ChDrL+lNVe4/bivxWUgqiFsqyG+w+m0G4jFZDZS/okji8/3nkpB+/dYR7DMDdZsOqEgBR4A2Phl6TXJtURspqSizWDc7U5GmxbopTb7cXxUXuPEM71GK14OblD/aHQzLrw84lSAdQvMQ9igrn1fRU/+9h6cas8x3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CySnOgbZ; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CySnOgbZ"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so64758751fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 08:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730130902; x=1730735702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXBnvsPSv3Wi51jh/3xEwL1sFmwykFtrb4JgbdjgSuQ=;
        b=CySnOgbZ/fT2NxZWq1BIDC/SfQu/SvPGcRTJ1L8fRBMSr0aG5O2ez7hQ+gSiwgou+J
         EH02ZEwvM2ZgdRaJe5nZLSwpOoNFXyvDBsge0P5acQ7jjMuiUROJBqDeOf0ImBtH3NKK
         8/vrBCcY29sKLgMHFJTjP0Tflgov2n9r+oJHj8EmRGs4UkAP1njD1ekj0gJFafhG6zdU
         PJWczAsGSZO54NG/mrBT5DIRXAcgLUYL8GtbkBJqFgyOT4kbfo9D862PYaRGv966ph1z
         PlEJfILnE1qHCiOE7WGSXvDMmNMZtfds6CRf7HZ7p6bU1L1JWAPIAa5E4zDgEZmdsMwt
         gq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730130902; x=1730735702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXBnvsPSv3Wi51jh/3xEwL1sFmwykFtrb4JgbdjgSuQ=;
        b=eDcUG34McJv5FTa2vBcv3lpYQK0zZ/G6e8kWsNyZ+7U0cGt14UVOfo4D8V0TzchlJV
         wcmgmvgIlX4JT9zMfRK3oNEp5gmryeX4uL1EK/tHoC/1KMFLmkM+X1I/ZsAYwdoX+BOu
         1hjJ/8q3utagOyOj++SegraTNex5nINzOUxImt1ytkVnHMTTVE2FCX3TT5yJikO3d/eR
         cmIIASNq0hL909S3LqjM92ZQlvMv3cPM2MnalMwtVvqSNQYyeWWQF3XYHpRlKi73nY5l
         608sJBJTzaKjx6iDZ4WhOfencPtUWT0OtlpUQzsx0U/EklEjtqoi4rtl3/paMGvDkNgg
         9m4w==
X-Gm-Message-State: AOJu0YzDUemJNxHTLxzxCpSCvZ/tmuBLeAgi+Anfz+OCn+LiAXK19Lhr
	1PjfoZS9Mi0zPuobB9zwzyWkf1piAec9jMUfFJBRbAGYAIYVx7MQFxI0BhV+miXb5qWmfHNOBRJ
	3w8m0OpItr25kydTyCE4JhLZN1unQsQ==
X-Google-Smtp-Source: AGHT+IGwBFDlRTp3CmLPQmaLiEQ+AaF45xLGm0QKQnRBwyTs3T2RL9Rw57qN4UViWPnU6KkWYOw7Q4n9weZErmGScQo=
X-Received: by 2002:a05:651c:b0d:b0:2fa:d604:e519 with SMTP id
 38308e7fff4ca-2fcbdf7db48mr55811331fa.11.1730130901461; Mon, 28 Oct 2024
 08:55:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022141118.150143-1-hadess@hadess.net> <20241022141118.150143-8-hadess@hadess.net>
 <CABBYNZ+aMaDp0BC6F0yG+mJU9hgkeNtbOxNwYx1D7Yj3rU8bzw@mail.gmail.com> <2d19a91da040a9298402303377ddc8c02a6a2c9a.camel@hadess.net>
In-Reply-To: <2d19a91da040a9298402303377ddc8c02a6a2c9a.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 28 Oct 2024 11:54:48 -0400
Message-ID: <CABBYNZKRBwdP_R6yKwcXNEg+O5HXDDd3NZ+bncWecvRUmQqfLg@mail.gmail.com>
Subject: Re: [BlueZ v3 7/7] client: Fix --help hanging if bluetoothd is not running
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Mon, Oct 28, 2024 at 11:35=E2=80=AFAM Bastien Nocera <hadess@hadess.net>=
 wrote:
>
> On Thu, 2024-10-24 at 12:08 -0400, Luiz Augusto von Dentz wrote:
> > Hi Bastien,
> >
> > On Tue, Oct 22, 2024 at 10:11=E2=80=AFAM Bastien Nocera <hadess@hadess.=
net>
> > wrote:
> > >
> > > Exit after printing all the main and submenu commands.
> > > ---
> > >  client/main.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/client/main.c b/client/main.c
> > > index f60bef1a6d3a..f5ed9f9f5297 100644
> > > --- a/client/main.c
> > > +++ b/client/main.c
> > > @@ -3193,6 +3193,8 @@ int main(int argc, char *argv[])
> > >         assistant_add_submenu();
> > >         bt_shell_set_prompt(PROMPT_OFF, NULL);
> > >
> > > +       bt_shell_handle_non_interactive_help();
> > > +
> > >         if (agent_option)
> > >                 auto_register_agent =3D g_strdup(agent_option);
> > >         else
> > > --
> > > 2.47.0
> > >
> >
> > Having some thoughts about how to do this is more clean way, perhaps
> > we should do this as part of bt_shell_run and then introduce .run
> > callback to bt_shell_menu so it is called as part of bt_shell_run,
> > under the .run callback the menu can place e.g. DBUS connection
> > setup,
> > etc, but before it reaches that we can check if it just a help
> > pending.
>
> We need to:
> 1) set the top menu
> 2) populate the submenus without any D-Bus IO
> 3) turn off the prompt
> 4) print the help and exit if that's what was requested
> 5) setup IO for submenus
> 6) run the mainloop
>
> I guess I could do 2) with a callback from bt_shell_set_menu()
> and then do 4) and 5) from a bt_shell_run() callback.

Yep.

> Is that what you expected?
> Do you have preferred names for the callback functions?

Id call it .run since it should be the result of bt_shell_run

> I think that we can still use the function split from 3/7, did you have
> a better name for the functions?

Not sure I follow, there will be a split between adding submenus and
.run to achieve the 2 stages, or are you talking about some other
split?

> Cheers
>


--=20
Luiz Augusto von Dentz
