Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Aug 2010 00:57:12 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Mol <marcel@mesa.nl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] obexd: ebook backend: return all TEL attribs from
 vcard in string
Message-ID: <20100802215712.GA3392@jh-x301>
References: <201008022131.o72LVpuL011014@joshua.mesa.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <201008022131.o72LVpuL011014@joshua.mesa.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Aug 02, 2010, Marcel Mol wrote:
> +	for (; l; l = g_list_next(l)) {
> +		EVCardAttribute *attrib = l->data;
>  		if (!attrib)
>  			continue;

Add an empty line after variable declarations.

> -
> -		e_vcard_add_attribute(evcard2, e_vcard_attribute_copy(attrib));
> +		const char *name = e_vcard_attribute_get_name(attrib);

plugins/phonebook.c: In function ‘evcard_to_string’:
plugins/phonebook.c:119: error: ISO C90 forbids mixed declarations and code
make[1]: *** [plugins/phonebook.o] Error 1
make: *** [all] Error 2

> +		for (i = 0; attribute_mask[i] != NULL; i++) {
> +			if (!(filter & (1 << i)))
> +				continue;
> +			if (g_strcmp(name, attribute_mask[i]) != 0)

plugins/phonebook.c:123: error: implicit declaration of function ‘g_strcmp’

Probably some missing include. Furthermore, use g_strcmp0 if there's a
risk that one of the inputs might be NULL.

Always compile test with ./bootstrap-configure (in this case
--with-phonebook=ebook) before submitting patches.

Johan
