Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?= <jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] SDP patch to add support for HDP
Date: Thu, 10 Dec 2009 11:49:18 +0100
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <200911131343.21326.jcaden@libresoft.es> <200911171208.13972.jcaden@libresoft.es> <1260030350.3041.25.camel@violet>
In-Reply-To: <1260030350.3041.25.camel@violet>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4659294.4aleNdArbq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200912101149.22315.jcaden@libresoft.es>
List-ID: <linux-bluetooth.vger.kernel.org>

--nextPart4659294.4aleNdArbq
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

here is the corrected patch.

diff --git a/lib/sdp.c b/lib/sdp.c
index 822ec1a..ddf2d1a 100644
=2D-- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -4621,3 +4621,113 @@ uint16_t sdp_gen_tid(sdp_session_t *session)
 {
 	return session->tid++;
 }
+
+/*
+ * Set the supported features
+ */
+int sdp_set_supp_feat(sdp_record_t *rec, const sdp_list_t *sf)
+{
+	const sdp_list_t *p, *r;
+	sdp_data_t *feat, *seq_feat;
+	int seqlen, i, err;
+	void **seqDTDs, **seqVals;
+
+	err =3D -1;
+	i =3D 0;
+	seqlen =3D sdp_list_len(sf);
+	seqDTDs =3D malloc(seqlen * sizeof(void *));
+	if (!seqDTDs)
+		return err;
+	seqVals =3D malloc(seqlen * sizeof(void *));
+	if (!seqVals) {
+		free(seqDTDs);
+		return err;
+	}
+
+	for (p =3D sf; p; p =3D p->next) {
+		int plen, j;
+		void **dtds, **vals;
+
+		plen =3D sdp_list_len(p->data);
+		dtds =3D malloc(plen * sizeof(void *));
+		if (!dtds)
+			goto set_sup_feat_exit;
+		vals =3D malloc(plen * sizeof(void *));
+		if (!vals) {
+			free(dtds);
+			goto set_sup_feat_exit;
+		}
+		j =3D 0;
+		for (r =3D p->data; r; r =3D r->next) {
+			sdp_data_t *data =3D (sdp_data_t*)r->data;
+			dtds[j] =3D &data->dtd;
+			vals[j] =3D &data->val;
+			j++;
+		}
+		feat =3D sdp_seq_alloc(dtds, vals, plen);
+		free(dtds);
+		free(vals);
+		if (!feat)
+			goto set_sup_feat_exit;
+		seqDTDs[i] =3D &feat->dtd;
+		seqVals[i] =3D feat;
+		i++;
+	}
+	seq_feat =3D sdp_seq_alloc(seqDTDs, seqVals, seqlen);
+	if (!seq_feat)
+		goto set_sup_feat_exit;
+	sdp_attr_replace(rec, SDP_ATTR_SUPPORTED_FEATURES_LIST, seq_feat);
+
+	err =3D 0;
+
+set_sup_feat_exit:
+	free(seqVals);
+	free(seqDTDs);
+	return err;
+}
+
+/*
+ * Get the supported features
+ * If an error occurred -1 is returned and errno is set
+ */
+int sdp_get_supp_feat(const sdp_record_t *rec, sdp_list_t **seqp)
+{
+	sdp_data_t * sdpdata, *d;
+	sdp_list_t * next;
+	*seqp =3D NULL;
+
+	sdpdata =3D sdp_data_get(rec, SDP_ATTR_SUPPORTED_FEATURES_LIST);
+
+	if (!sdpdata || sdpdata->dtd < SDP_SEQ8 || sdpdata->dtd > SDP_SEQ32)
+		return sdp_get_uuidseq_attr(rec,
+				     SDP_ATTR_SUPPORTED_FEATURES_LIST, seqp);
+
+	for (d =3D sdpdata->val.dataseq; d; d =3D d->next) {
+		sdp_data_t *dd;
+		sdp_list_t *subseq;
+		subseq =3D NULL;
+		if (d->dtd < SDP_SEQ8 || d->dtd > SDP_SEQ32)
+			goto fail;
+		for (dd =3D d->val.dataseq; dd; dd =3D dd->next) {
+			sdp_data_t *data;
+			if (dd->dtd !=3D SDP_UINT8 && dd->dtd !=3D SDP_UINT16 &&
+						dd->dtd !=3D SDP_TEXT_STR8)
+				goto fail;
+			data =3D sdp_data_alloc(dd->dtd, &dd->val);
+			if (data)
+				subseq =3D sdp_list_append(subseq, data);
+		}
+		*seqp =3D sdp_list_append(*seqp, subseq);
+	}
+	return 0;
+
+fail:
+	while (*seqp) {
+		next =3D (*seqp)->next;
+		sdp_list_free(*seqp, free);
+		*seqp =3D next;
+	}
+	errno =3D EINVAL;
+	return -1;
+}
+
diff --git a/lib/sdp.h b/lib/sdp.h
index 375261e..b493985 100644
=2D-- a/lib/sdp.h
+++ b/lib/sdp.h
@@ -244,13 +244,16 @@ extern "C" {
 #define SDP_ATTR_GROUP_ID			0x0200
 #define SDP_ATTR_IP_SUBNET			0x0200
 #define SDP_ATTR_VERSION_NUM_LIST		0x0200
+#define SDP_ATTR_SUPPORTED_FEATURES_LIST	0x0200
 #define SDP_ATTR_SVCDB_STATE			0x0201
=20
 #define SDP_ATTR_SERVICE_VERSION		0x0300
 #define SDP_ATTR_EXTERNAL_NETWORK		0x0301
 #define SDP_ATTR_SUPPORTED_DATA_STORES_LIST	0x0301
+#define SDP_ATTR_DATA_EXCHANGE_SPEC		0x0301
 #define SDP_ATTR_FAX_CLASS1_SUPPORT		0x0302
 #define SDP_ATTR_REMOTE_AUDIO_VOLUME_CONTROL	0x0302
+#define SDP_ATTR_MCAP_SUPPORTED_PROCEDURES	0x0302
 #define SDP_ATTR_FAX_CLASS20_SUPPORT		0x0303
 #define SDP_ATTR_SUPPORTED_FORMATS_LIST		0x0303
 #define SDP_ATTR_FAX_CLASS2_SUPPORT		0x0304
diff --git a/lib/sdp_lib.h b/lib/sdp_lib.h
index ee39df8..bebb745 100644
=2D-- a/lib/sdp_lib.h
+++ b/lib/sdp_lib.h
@@ -585,6 +585,20 @@ static inline int sdp_get_icon_url(const sdp_record_t =
*rec, char *str, int len)
 	return sdp_get_string_attr(rec, SDP_ATTR_ICON_URL, str, len);
 }
=20
+/*
+ * Set the supported features
+ * sf should be a list of list with each feature data
+ * Returns 0 on success -1 on fail
+ */
+int sdp_set_supp_feat(sdp_record_t *rec, const sdp_list_t *sf);
+
+/*
+ * Get the supported features
+ * seqp is set to a list of list with each feature data
+ * Returns 0 on success, if an error occurred -1 is returned and errno is =
set
+ */
+int sdp_get_supp_feat(const sdp_record_t *rec, sdp_list_t **seqp);
+
 sdp_record_t *sdp_extract_pdu(const uint8_t *pdata, int bufsize, int *scan=
ned);
 sdp_record_t *sdp_copy_record(sdp_record_t *rec);
=20


--nextPart4659294.4aleNdArbq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAksg0i4ACgkQ35o/gIXgrCeqMQCgvThObvaXlrQeIMxGbnjoYJy2
T0sAn1pNJ+euC5hToxlzBX2LatP/4tiK
=8/lT
-----END PGP SIGNATURE-----

--nextPart4659294.4aleNdArbq--
