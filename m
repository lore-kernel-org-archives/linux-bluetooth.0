Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5722933064D
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064036; cv=none; b=SDJPZI0FQPp0QKPbAiikxmlMDEZX4ui9N+jyFAVWoj9tXRtfaz9l9wxfSmaE5H077O/P8wEQIGOE60WHyNHcMWaBvET3vdrSg2bTpKdk2JdfCOt2JGCD65yT8YB2d81/xp8aIyntkFCyUJbNfWZrRKCmlS368Nd6Gruof15Ppt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064036; c=relaxed/simple;
	bh=KSYec8e3aca50ez86DPModjdMgRqtgf5HmY9+aG+OLY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TDoQ0R/QYGVNc4KV7WL7ezXk8RDQBbcCDJCw110Qn3QMNDUsELtFs2MHpzq1IhOfFrIISKxH5N0k45OGAR9cG+BntiFK912G+CXlnC9wGyhFcVYqjXr8sJx2o2n48KnTnrACKAaPQ7mMjFqQqSLxvPUrUBySdT23R6bfABu1cyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id A468B3EE0B;
	Tue, 18 Aug 2026 14:40:29 +0000 (UTC)
Message-ID: <2b3db812355f7a8ecb926cc76ed3f464900f1637.camel@hadess.net>
Subject: Re: [PATCH BlueZ v2 1/4] sdp-xml: Use a queue to collect sequence
 members
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Tue, 18 Aug 2026 16:40:29 +0200
In-Reply-To: <20260817210038.1839617-1-luiz.dentz@gmail.com>
References: <20260817210038.1839617-1-luiz.dentz@gmail.com>
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
X-GND-Cause: dmFkZTEwQDFZTwcQT8NY+3joeZppdghkcn+UNOEBOYmFtxhtAM3IVXidmLtcHL/DbbtysXUhvoDQJKRqxuVreY0IjYkLM+tKgH3kFQBliY2OrxlLmXZl45DFGt1eo9lkwo7/fJpAWsSIFow4DsmD1KACxGA4USN+nnQvG31UVtTmNsVxDFq3Fg16DSBJuv3JfcxAljqReE51OgbWfwdSiriyq6YZyqA0XOHYtXhF+IV49UY1PmbxQ0WePvz9xuxg74ZJWXZW2i3hZxOpeqqaLUCuOlFiuZeMtBUqU0hzfDwVONnEV+J8BvYN6qmmJRogVjGP7CO/BFY9FNo0kUjIt7L3ppO8GaJTUvb4VFc2YEAE0cCPLtUG6saPPh2J/KDyPs8ow7Ci5rSzMAFwkLQ6tqMPRTEt28DpU5MdNtTrQqLCkBlPsCEmyk71zZL3CZBjWbmLDJ5zMyZ7lEVIqpuvV6gO5HIfOyt7MmI1d6XNpbamyv1xnk0McqzL94YeedP8lFidN+aBnClUZLG7y73Y0OehfH8GUH8ciRWUu3gfx6Kw+EQNYsfnkeHJ9Kv5kSX5lsD+Ft48T9FVOvsnHhti3BGZt7j8QZtYrbTJQINomNlY5jrRz621TKS2Jf7BLkDFsngyH7L774rEr29MlVv7jmsFcxmkc3oGHIGQravqw4/VNqq7UA
X-GND-State: clean
X-GND-Score: -100

Patchset looks good to me, thanks.

On Mon, 2026-08-17 at 17:00 -0400, Luiz Augusto von Dentz wrote:
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
>=20
> Assisted-by: Claude:claude-opus-5
> ---
> =C2=A0Makefile.tools |=C2=A0 4 +++-
> =C2=A0src/sdp-xml.c=C2=A0 | 60 ++++++++++++++++++++++++++++++++++++------=
------
> --
> =C2=A02 files changed, 46 insertions(+), 18 deletions(-)
>=20
> diff --git a/Makefile.tools b/Makefile.tools
> index 1a4e5660813b..b3ef4ae1c3df 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -437,7 +437,9 @@ tools_hciconfig_LDADD =3D lib/libbluetooth-
> internal.la
> =C2=A0tools_hcitool_SOURCES =3D tools/hcitool.c src/oui.h src/oui.c
> =C2=A0tools_hcitool_LDADD =3D lib/libbluetooth-internal.la $(UDEV_LIBS)
> =C2=A0
> -tools_sdptool_SOURCES =3D tools/sdptool.c src/sdp-xml.h src/sdp-xml.c
> +tools_sdptool_SOURCES =3D tools/sdptool.c src/sdp-xml.h src/sdp-xml.c
> \
> +			src/shared/queue.h src/shared/queue.c \
> +			src/shared/util.h src/shared/util.c
> =C2=A0tools_sdptool_LDADD =3D lib/libbluetooth-internal.la $(GLIB_LIBS)
> =C2=A0
> =C2=A0tools_ciptool_LDADD =3D lib/libbluetooth-internal.la
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
