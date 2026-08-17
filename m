Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C4F5477E
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786955702; cv=none; b=OrIyj0SpjIoaJ+t/Z0s2nsN7fQV5ZLzIYFfCkA942Nv3EKG34Mk4+FqNf2ISmSLwE5kkgW08CWVKeBeEINZG5bnzwbecnpy3KFiKZ+ja9x0QMuu19SKlMG0XCBUQNfM8p20zqSA8/DhrpCWKr1Xm1UfCSmPEDJp4vkMDLEXRDDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786955702; c=relaxed/simple;
	bh=dq/UEZGtOcPYUJDy5jMxon+R0l4Hl0GpYUqVw220oLo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rZlRfFIy3WKojiQ7fIRtli3aJEGUlhe/9TMO3NZAgFiOoOXkVKALp5Scfd/5dBOHzZ1pHJTDQE7QoDCVhbUg3Id3uPh98VyCFWe0U/sl4HjSFTgkrIJWwwjhn0f4WFXqvkjqTx1dSnbVCxCY5YBkCrrc63tcHBh71q6oX3Ys+A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id E88763E9BC;
	Mon, 17 Aug 2026 08:34:51 +0000 (UTC)
Message-ID: <949a111b168f3ce54e60b4f625ad94b156ac738f.camel@hadess.net>
Subject: Re: [PATCH BlueZ v1] sdp-xml: Use a queue to collect sequence
 members
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Mon, 17 Aug 2026 10:34:51 +0200
In-Reply-To: <20260814173225.1410500-1-luiz.dentz@gmail.com>
References: <20260814173225.1410500-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTGVl6nSONEh41ByYeL+pKALquxE2Cwf3YJg2LoNiwWaWqD6VuQwKoCL10HHmLg2QMG0YEyWmjh3lOKs6pbZsbh+vq0kmJ6yXfNbgT1F5Mq/y3ihIexB23oHMqxrWt7OslxqNCD1idjt8ewbq+LK9KW5RqI4w9LHE0Y5UJnRVKcMm/0qTWb8RV2NpUpH5PMqDX/5Fwj+si9RaYjWJYCedmrOJnbuh/AyAkK4AuQkPXACD/Tjmee8X8lO0xhn/GQ8NMYcbGp6L/Qa0jFz1E+/ZiJhQCvwQcmvgsRD8SK1uXWj2kKrEftgO/fmCRwAGb+sHdLygGcDrKIzyBEdCJ8cyMuDERwC1HYKR9691Uj4u8HFzJ4D6MTTlwu4BfPLggTVF/+8qrSoeT+TAn8A1R9EqRWcSzAqL+QMHag1ixe0jbbyv6FFFvD88zXjCqbRtfQpqELpgQw2tCIqx5/xKMgghfQlqSjtb72O8YmCW19fOnYXuMYRU0bj41FBb674/xFnvS1jblrVcB8spuQYJFv544j5NTuWCAOYJRw6zyJM6w8yyWxeMavbTxaGtxG16/FPNPsLmJ4QcbF2fgGLOuw2VD9rccufV7T2sOlIwdv8AK7811UMx7eg9YyZTR6XjI7SdSbAD0vt/X39sokd2q4U3t72PGdMBichv5h0IQMOIUZLQg
X-GND-State: clean
X-GND-Score: -100

On Fri, 2026-08-14 at 13:32 -0400, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> Appending a member to a sequence with sdp_seq_append() walks the
> single-linked list to find its tail, so building a sequence is
> O(n^2).
>=20
> This was previously worked around by caching the tail of the sequence
> in
> struct sdp_xml_data, which required the caller to pick between
> appending
> to the cached tail and initialising val.dataseq, and to keep the
> cache in
> sync on every append.
>=20
> Collect the members in a struct queue instead, which tracks its own
> tail,
> and link them into val.dataseq once the element is closed. Appending
> is a
> plain queue_push_tail(), and the queue is destroyed along with the
> rest
> of the element so members that were never linked, such as on
> malformed
> input, are still freed.
>=20
> The sequence_on_squared() test stays at less than 0.1 seconds.

Fails to link sdptool without this patch:

diff --git a/Makefile.tools b/Makefile.tools
index 1a4e5660813b..84004c12c642 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -437,7 +437,7 @@ tools_hciconfig_LDADD =3D lib/libbluetooth-internal.la
 tools_hcitool_SOURCES =3D tools/hcitool.c src/oui.h src/oui.c
 tools_hcitool_LDADD =3D lib/libbluetooth-internal.la $(UDEV_LIBS)
=20
-tools_sdptool_SOURCES =3D tools/sdptool.c src/sdp-xml.h src/sdp-xml.c
+tools_sdptool_SOURCES =3D tools/sdptool.c src/shared/queue.h src/shared/qu=
eue.c src/shared/util.h src/shared/util.c src/sdp-xml.h src/sdp-xml.c
 tools_sdptool_LDADD =3D lib/libbluetooth-internal.la $(GLIB_LIBS)
=20
 tools_ciptool_LDADD =3D lib/libbluetooth-internal.la

>=20
> Assisted-by: Claude:claude-opus-5
> ---
> =C2=A0src/sdp-xml.c | 60 ++++++++++++++++++++++++++++++++++++------------=
-
> --
> =C2=A01 file changed, 43 insertions(+), 17 deletions(-)
>=20
> diff --git a/src/sdp-xml.c b/src/sdp-xml.c
> index 5b448fe83410..bad9e289344f 100644
> --- a/src/sdp-xml.c
> +++ b/src/sdp-xml.c
> @@ -25,6 +25,8 @@
> =C2=A0#include "bluetooth/sdp.h"
> =C2=A0#include "bluetooth/sdp_lib.h"
> =C2=A0
> +#include "shared/queue.h"
> +
> =C2=A0#include "sdp-xml.h"
> =C2=A0
> =C2=A0#define DBG(...) (void)(0)
> @@ -44,7 +46,7 @@ struct sdp_xml_data {
> =C2=A0	char type;			/* 0 =3D Text or Hexadecimal
> */
> =C2=A0	char *name;			/* Name, optional in the dtd
> */
> =C2=A0	/* TODO: What is it used for? */
> -	sdp_data_t *tail;		/* Tail for O(1) dataseq
> append */
> +	struct queue *seq;		/* Members of a dataseq, if
> any */
> =C2=A0};
> =C2=A0
> =C2=A0struct context_data {
> @@ -510,8 +512,37 @@ static void element_start(GMarkupParseContext
> *context,
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +/*
> + * Link the members collected in elem->seq into elem->data-
> >val.dataseq.
> + *
> + * Members are collected in a queue so that appending is O(1),
> sdp_seq_append()
> + * would otherwise have to walk to the tail of the sequence on every
> append.
> + */
> +static void sdp_xml_data_flush_seq(struct sdp_xml_data *elem)
> +{
> +	const struct queue_entry *entry;
> +	sdp_data_t *tail =3D NULL;
> +
> +	if (!elem->seq)
> +		return;
> +
> +	for (entry =3D queue_get_entries(elem->seq); entry; entry =3D
> entry->next) {
> +		if (tail)
> +			sdp_seq_append(tail, entry->data);
> +		else
> +			elem->data->val.dataseq =3D
> sdp_seq_append(NULL,
> +								entr
> y->data);
> +		tail =3D entry->data;
> +	}
> +
> +	queue_destroy(elem->seq, NULL);
> +	elem->seq =3D NULL;
> +}
> +
> =C2=A0static void sdp_xml_data_free(struct sdp_xml_data *elem)
> =C2=A0{
> +	queue_destroy(elem->seq, (queue_destroy_func_t)
> sdp_data_free);
> +
> =C2=A0	if (elem->data)
> =C2=A0		sdp_data_free(elem->data);
> =C2=A0
> @@ -568,6 +599,8 @@ static void element_end(GMarkupParseContext
> *context,
> =C2=A0		return;
> =C2=A0	}
> =C2=A0
> +	sdp_xml_data_flush_seq(ctx_data->stack_head);
> +
> =C2=A0	if (!strcmp(element_name, "sequence")) {
> =C2=A0		if (!SDP_IS_SEQ(ctx_data->stack_head->data->dtd)) {
> =C2=A0			g_set_error(err, G_MARKUP_ERROR,
> @@ -610,28 +643,21 @@ static void element_end(GMarkupParseContext
> *context,
> =C2=A0
> =C2=A0	if (ctx_data->stack_head->next && ctx_data->stack_head->data
> &&
> =C2=A0					ctx_data->stack_head->next-
> >data) {
> -		sdp_data_t *tail;
> -		switch (ctx_data->stack_head->next->data->dtd) {
> +		struct sdp_xml_data *parent =3D ctx_data->stack_head-
> >next;
> +
> +		switch (parent->data->dtd) {
> =C2=A0		case SDP_SEQ8:
> =C2=A0		case SDP_SEQ16:
> =C2=A0		case SDP_SEQ32:
> =C2=A0		case SDP_ALT8:
> =C2=A0		case SDP_ALT16:
> =C2=A0		case SDP_ALT32:
> -			tail =3D ctx_data->stack_head->next->data-
> >val.dataseq ?
> -				ctx_data->stack_head->next->tail :
> NULL;
> -			if (tail) {
> -				sdp_seq_append(tail,
> -					ctx_data->stack_head->data);
> -			} else {
> -				ctx_data->stack_head->next->data-
> >val.dataseq =3D
> -					sdp_seq_append(NULL,
> -						ctx_data-
> >stack_head->data);
> -			}
> -			ctx_data->stack_head->next->tail =3D
> -					ctx_data->stack_head->data;
> -			ctx_data->stack_head->data =3D NULL;
> -			ctx_data->stack_head->tail =3D NULL;
> +			if (!parent->seq)
> +				parent->seq =3D queue_new();
> +
> +			if (queue_push_tail(parent->seq,
> +						ctx_data-
> >stack_head->data))
> +				ctx_data->stack_head->data =3D NULL;
> =C2=A0			break;
> =C2=A0		}
> =C2=A0
