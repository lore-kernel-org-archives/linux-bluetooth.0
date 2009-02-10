Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: gfpadovan@gmail.com
In-Reply-To: <1234280592.12847.33.camel@californication>
References: <1234223456-30790-1-git-send-email-gustavo@las.ic.unicamp.br>
	 <1234280592.12847.33.camel@californication>
Date: Tue, 10 Feb 2009 15:23:20 -0200
Message-ID: <6b53b1990902100923l5f845d31sd414f08936a8b612@mail.gmail.com>
Subject: Re: [PATCH] tools: Fix memory leaks
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Feb 10, 2009 at 1:43 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Gustavo,
>
>> Some printfs was using as parameter functions that return dinamic
>> allocated memory. Now, we free them!
>
> you patch has been applied, but I had to modify the commit message a lot
> to turn it into a little bit more proper English :)

Ok. My English is bad, sorry. ;-)

>
> Regards
>
> Marcel
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



--=20
----------------------------------------------
Gustavo Fernando Padovan
Engenharia de Computa=E7=E3o 2006
Instituto de Computa=E7=E3o - UNICAMP

gfpadovan@gmail.com
gustavo@las.ic.unicamp.br
-------------------------------------------

Seja Livre, use Software Livre
