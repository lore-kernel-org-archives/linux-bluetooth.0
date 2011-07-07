Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1310027746.21109.56.camel@aeonflux>
References: <1309983041-23744-1-git-send-email-vinicius.gomes@openbossa.org>
	<1309983041-23744-7-git-send-email-vinicius.gomes@openbossa.org>
	<1310027746.21109.56.camel@aeonflux>
Date: Thu, 7 Jul 2011 07:01:18 -0400
Message-ID: <CAJdJm_OPxpGLE+=_xEyqabMR_Z7J7vGsch=Q7r81YOqFDk2PXw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 6/9] Fix memory leak when loading keys
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jul 7, 2011 at 4:35 AM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
>> + =A0 =A0 =A0 =A0 =A0 =A0 n->data =3D g_malloc0(sizeof(*orig) + orig->dl=
en);
>> + =A0 =A0 =A0 =A0 =A0 =A0 memcpy(n->data, orig, sizeof(*orig) + orig->dl=
en);
>
> you don't need to add a memset via g_malloc0 here. And do we really not
> wanna check the memory allocation here?

What about using g_memdup() ? it does the equivalent of both calls.

Unfortunately, there is no "g_try_memdup"...

Regards,
--=20
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
