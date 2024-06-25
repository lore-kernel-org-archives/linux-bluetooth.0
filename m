Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C48D1684AD
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329962; cv=pass; b=G/Oa6z13nw0IVGoDx8yEIxdTn2Nz9IQk6azrgECCeKl3RwT+EaL5H59dJmF8jf5uelKAu6VlZb0/1jGCu/iFGBzmCiRUDj0LWCbBBlZhNi8/Rb4/agaHEJ7G9I6iTtEnhk3PMYMMwBEZwS/3pQVkl8DWQl8bDiEu3RlBLK7Iplg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329962; c=relaxed/simple;
	bh=zHhVLab+rzgOYIHvRFjcbpOcYWcylmXL5DI6AWILuXY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dGVkI3KgpeJTegf7YhNcfWQNGkQsK91cna9o4A3CeqpA8vGEBTFT6eUDrYF2NDvRX6F3N7lU/9+H3V3Pi9ASdqULLK7NLkJtNNXSGb1XYr/KtAwQ50DdRpbKASw/gPSI3LGhwGnJXtl6JOUdRuCWj2OQv3riKz5EMoVnAXsmgfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=i+lwC7NF; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="i+lwC7NF"
Received: from monolith.lan (91-152-121-138.elisa-laajakaista.fi [91.152.121.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4W7psS44KZzyR6;
	Tue, 25 Jun 2024 18:39:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1719329949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QTLosToxQfzRjhN/iJtwNO6go3Qov5FBCLU1NfrR0gU=;
	b=i+lwC7NFIIsj5ZE2u+ppVmnaSkaMRuHQVF6cgNfypqNSAzXGJ+nqMVNc1TF1ZyzFn6iuLq
	hIuQHaxMaGO8UzCyxgSgt41fmLncS6Rnaoku6k2+G4zi0HRivhIx3RCQ7cCARK1hhhBU9/
	mXyEFlW2TL/r7qeG3iNEN7Vdo0y6ATI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1719329949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QTLosToxQfzRjhN/iJtwNO6go3Qov5FBCLU1NfrR0gU=;
	b=NHSx5eLVj/yvkk7ecKzGLYpGSaLlG0apQRCVpB+33HdUMg3iiZ/OOAcI71I5EiA709/MaN
	YwhkrnAXdiNFksdfHlNp/HjRWYvDwpBKnlQa9RIvl67HyCi04hKRpcOkzmJxgoim+8fEzt
	gMTXcg8IbJuwYTpeCA5N0hzXiBXfC8U=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1719329949; a=rsa-sha256; cv=none;
	b=AQpLIJMdNSei0onhsAhTs+c63+sMz+B7mPEIpARMK/bq3woP/RW095dxJ5ecsRSL4ryT3g
	ftT8SICINT0+u6DRGpGoBCizpm1SOaNV4crs1EX0R+4aWexMbKUor5wfZIzQrDyH+LqlZY
	vfpWEqqKlMa3ZAdvE1+Mz5yojceD9bI=
Message-ID: <dac1d55c940b3a9afb971263c8195e765e77c598.camel@iki.fi>
Subject: Re: [PATCH v2] Bluetooth : Update the mas session structure
From: Pauli Virtanen <pav@iki.fi>
To: Amisha Jain <quic_amisjain@quicinc.com>, linux-bluetooth@vger.kernel.org
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, 
	quic_anubhavg@quicinc.com
Date: Tue, 25 Jun 2024 18:39:08 +0300
In-Reply-To: <20240625063533.30536-1-quic_amisjain@quicinc.com>
References: <20240625063533.30536-1-quic_amisjain@quicinc.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ti, 2024-06-25 kello 12:05 +0530, Amisha Jain kirjoitti:
> Update the 'mas_session' structure such that
> manager_emit_transfer_property(os->service_data, "Size")
> will get the proper structure in arguments as
> expected like structure 'obex_transfer' and transfer->path
> won't be populated with inappropriate value.
>=20
> As there is no new transfer registered during mas connect,
> hence setting the path to NULL to avoid invoking the
> g_dbus_emit_property_changed() property.
>=20
> Signed-off-by: Amisha Jain <quic_amisjain@quicinc.com>
> ---
>  obexd/plugins/mas.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c
> index 10b972d65..71bf12ad3 100644
> --- a/obexd/plugins/mas.c
> +++ b/obexd/plugins/mas.c
> @@ -51,6 +51,8 @@
>  #define ML_BODY_END "</MAP-msg-listing>"
> =20
>  struct mas_session {
> +	uint8_t notification_status;
> +	char *path;
>  	struct mas_request *request;
>  	void *backend_data;
>  	gboolean finished;
> @@ -59,7 +61,6 @@ struct mas_session {
>  	GObexApparam *inparams;
>  	GObexApparam *outparams;
>  	gboolean ap_sent;
> -	uint8_t notification_status;
>  };
> =20
>  static const uint8_t MAS_TARGET[TARGET_SIZE] =3D {
> @@ -125,6 +126,7 @@ static void *mas_connect(struct obex_session *os, int=
 *err)
>  		goto failed;
> =20
>  	manager_register_session(os);
> +	mas->path =3D NULL;

Maybe the problem here is that the change in commit bb160515185e
("obexd: Emit Size property of transfer after open()") is not right?

diff --git a/obexd/src/obex.c b/obexd/src/obex.c
index a4bae857f..ed219d3e7 100644
--- a/obexd/src/obex.c
+++ b/obexd/src/obex.c
@@ -779,6 +779,9 @@ int obex_put_stream_start(struct obex_session *os, cons=
t char *filename)
                return err;
        }
=20
+       if (os->size !=3D OBJECT_SIZE_DELETE && os->size !=3D OBJECT_SIZE_U=
NKNOWN)
+               manager_emit_transfer_property(os->service_data, "Size");
+
        os->path =3D g_strdup(filename);

This casts os->service_data to obex_transfer which IIUC does not work
for most the plugins, as it's the session struct.

Maybe plugins can emit the transfer property change in their open()
callback, for the plugins where it makes sense?

> =20
>  	return mas;
> =20

--=20
Pauli Virtanen
