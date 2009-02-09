Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: gfpadovan@gmail.com
In-Reply-To: <1234182681.4705.7.camel@californication>
References: <1234149329-4536-1-git-send-email-gustavo@las.ic.unicamp.br>
	 <1234182681.4705.7.camel@californication>
Date: Mon, 9 Feb 2009 11:28:25 -0200
Message-ID: <6b53b1990902090528j3ed41c65p7bb03ab43a8dc224@mail.gmail.com>
Subject: Re: [PATCH] tools: Fix memory leaks
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Feb 9, 2009 at 10:31 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Gustavo,
>
>> Some printfs was using as parameter functions that return dinamic
>> allocated memory. Now, we free them!
>>
>> Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
>
> BlueZ doesn't use Signed-off-by for commit messages. That is kernel
> stuff.
>
>> @@ -1586,10 +1592,13 @@ static void print_dev_hdr(struct hci_dev_info *d=
i)
>>  static void print_dev_info(int ctl, struct hci_dev_info *di)
>>  {
>>       struct hci_dev_stats *st =3D &di->stat;
>> +     char * str;
>
> This needs to be "char *str;"
>
> Please fix it and re-sent the patch.

Ok.

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
