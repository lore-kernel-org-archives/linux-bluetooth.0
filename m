Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2250C2AE74
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754645703; cv=none; b=Cvh8gtnCIq8ipUB6rfZZSFOPZFQjTonzKzK0xPkYUNEd631/S/N6rtB+IvSiyuOxR3EFngAmaT0sGIQvkrg2TF/lGyIeOQBdwJDh8aOQWbxFC3FlVpmvoDaYuL0Ocf+fFi+cP+gwud0TCH63tEaqNDOD+6aWnaX/+ca5EgOJtL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754645703; c=relaxed/simple;
	bh=81ROJ1HwiMbVT6P/afr1B8sD+TzHzV7Knn7ePUUSAYU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q/xPS7Rdxv4VzqAWSF1rPp1ULSz/VROuN9dcnyoIOo/A3KyNiMjNzRU4w/wWbXUgm4EjicbNx1GG871vQeFOvOJ2wgQnDQsD9/4wkpQWtW5BITCXyuuJQfX7ZrTy+AofYUpnGAR4KM7bOarGQCK2I9puIWLZotHjzFjEum0du9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6C62841C7C;
	Fri,  8 Aug 2025 09:34:51 +0000 (UTC)
Message-ID: <8f18dbeaf80530fb3d460060864a2a15f73b7039.camel@hadess.net>
Subject: Re: [PATCH BlueZ 1/1] Fixed heap-buffer-overflow in
 `compute_seq_size`.
From: Bastien Nocera <hadess@hadess.net>
To: Oliver Chang <ochang@google.com>, linux-bluetooth@vger.kernel.org
Cc: oss-fuzz-bugs@google.com
Date: Fri, 08 Aug 2025 11:34:51 +0200
In-Reply-To: <20250808013402.548986-2-ochang@google.com>
References: <20250808013402.548986-1-ochang@google.com>
	 <20250808013402.548986-2-ochang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdefgeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhephffgueelgeefjefggfduieefteeuieehheeijeeggeekveehtdfgvdehtedvudelnecuffhomhgrihhnpehoshhsqdhfuhiiiidrtghomhenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepohgthhgrnhhgsehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgp
 dhrtghpthhtohepohhsshdqfhhuiiiiqdgsuhhgshesghhoohhglhgvrdgtohhm
X-GND-Sasl: hadess@hadess.net

On Fri, 2025-08-08 at 01:34 +0000, Oliver Chang wrote:
> By adding checks for sequence/alternate types in element_end and
> ensuring proper cleanup in sdp_xml_parse_record error path.
>=20
> https://issues.oss-fuzz.com/issues/42516062
> https://oss-fuzz.com/testcase-detail/5896441415729152

Neither of those URLs show any details about the problem that was
detected.

It would be useful if there was a regression test in unit/ either in
unit/sdp.c or as a separate sdp-xml.c test that, for example, showed
the lost memory in a valgrind run, which the patch would fix.

Cheers

> ---
> =C2=A0src/sdp-xml.c | 19 +++++++++++++++++++
> =C2=A01 file changed, 19 insertions(+)
>=20
> diff --git a/src/sdp-xml.c b/src/sdp-xml.c
> index 5efa62ab8..b10882db2 100644
> --- a/src/sdp-xml.c
> +++ b/src/sdp-xml.c
> @@ -545,6 +545,13 @@ static void element_end(GMarkupParseContext
> *context,
> =C2=A0	}
> =C2=A0
> =C2=A0	if (!strcmp(element_name, "sequence")) {
> +		if (!SDP_IS_SEQ(ctx_data->stack_head->data->dtd)) {
> +			g_set_error(err, G_MARKUP_ERROR,
> G_MARKUP_ERROR_INVALID_CONTENT,
> +					"Unexpected data type %d for
> sequence",
> +					ctx_data->stack_head->data-
> >dtd);
> +			return;
> +		}
> +
> =C2=A0		ctx_data->stack_head->data->unitSize =3D
> compute_seq_size(ctx_data->stack_head->data);
> =C2=A0
> =C2=A0		if (ctx_data->stack_head->data->unitSize >
> USHRT_MAX) {
> @@ -557,6 +564,13 @@ static void element_end(GMarkupParseContext
> *context,
> =C2=A0			ctx_data->stack_head->data->unitSize +=3D
> sizeof(uint8_t);
> =C2=A0		}
> =C2=A0	} else if (!strcmp(element_name, "alternate")) {
> +		if (!SDP_IS_ALT(ctx_data->stack_head->data->dtd)) {
> +			g_set_error(err, G_MARKUP_ERROR,
> G_MARKUP_ERROR_INVALID_CONTENT,
> +					"Unexpected data type %d for
> alternate",
> +					ctx_data->stack_head->data-
> >dtd);
> +			return;
> +		}
> +
> =C2=A0		ctx_data->stack_head->data->unitSize =3D
> compute_seq_size(ctx_data->stack_head->data);
> =C2=A0
> =C2=A0		if (ctx_data->stack_head->data->unitSize >
> USHRT_MAX) {
> @@ -621,6 +635,11 @@ sdp_record_t *sdp_xml_parse_record(const char
> *data, int size)
> =C2=A0	if (g_markup_parse_context_parse(ctx, data, size, NULL) =3D=3D
> FALSE) {
> =C2=A0		error("XML parsing error");
> =C2=A0		g_markup_parse_context_free(ctx);
> +		while (ctx_data->stack_head) {
> +			struct sdp_xml_data *elem =3D ctx_data-
> >stack_head;
> +			ctx_data->stack_head =3D elem->next;
> +			sdp_xml_data_free(elem);
> +		}
> =C2=A0		sdp_record_free(record);
> =C2=A0		free(ctx_data);
> =C2=A0		return NULL;
