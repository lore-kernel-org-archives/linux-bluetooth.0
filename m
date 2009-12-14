Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1260810093.3311.5884.camel@localhost.localdomain>
References: <1260810093.3311.5884.camel@localhost.localdomain>
Date: Mon, 14 Dec 2009 15:44:04 -0300
Message-ID: <2a9506370912141044s2f5ed846ub2072b0d378d7a11@mail.gmail.com>
Subject: Re: No way to cancel SendFiles() in obexd
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Mon, Dec 14, 2009 at 2:01 PM, Bastien Nocera <hadess@hadess.net> wrote:
> Heya,
>
> I have a slight problem with SendFiles().
>
> When sending multiple files, and refusing one of them on the phone, the
> subsequent files are still sent.
>
> Is there a way to avoid that? Or should I rework the UI slightly to
> mention that some files were not sent?
>

As of now, there's no way to avoid that. Personally, I like the
current behavior, at least, it is consistent with other tools, cp for
example.

> For a single file, you'll get a nice "retry" button if the phone refused
> the connection. I'd prefer it if the agent could ask me whether to carry
> on sending files, or cancel all the sending.
>

Between those two options, I prefer cancel all the sending.

> Cheers
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


Cheers,
-- 
Vinicius Gomes
INdT - Instituto Nokia de Tecnologia
