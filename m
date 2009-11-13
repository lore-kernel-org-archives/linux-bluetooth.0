Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] SDP patch to add support for HDP
Date: Fri, 13 Nov 2009 13:43:18 +0100
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3888760.h0OXbaUz8b";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200911131343.21326.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--nextPart3888760.h0OXbaUz8b
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patch tries to simplify the way the SDP records for HDP are created. T=
he=20
created functions allow adding supported features easily to an sdp record. =
The=20
are similar to sdp_set_profile_descs and sdp_get_profile_descs.  I've also =
added=20
some macros to define new UUID's for HDP.


diff --git a/lib/sdp.c b/lib/sdp.c
index 822ec1a..93490e7 100644
=2D-- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -4621,3 +4621,82 @@ uint16_t sdp_gen_tid(sdp_session_t *session)
 {
 	return session->tid++;
 }
+
+/*
+* Set the supported features
+*/
+void sdp_set_supp_feat(sdp_record_t *rec, const sdp_list_t *sf)
+{
+	const sdp_list_t *p, *r;
+	sdp_data_t *feat =3D NULL, *seq_feat =3D NULL;
+=09
+	int seqlen =3D sdp_list_len(sf);
+	void **seqDTDs =3D (void **)malloc (seqlen *  sizeof(void *));
+	void **seqVals =3D (void **)malloc (seqlen *  sizeof(void *));
+	int i =3D 0;
+
+	for (p =3D sf; p; p =3D p->next) {
+		int plen =3D sdp_list_len(p->data);
+		void **dtds =3D (void **)malloc (plen *  sizeof(void *));
+		void **vals =3D (void **)malloc (plen *  sizeof(void *));
+		int j =3D 0;
+		for (r=3Dp->data; r; r =3D r->next) {
+			sdp_data_t *data =3D (sdp_data_t*)r->data;
+			dtds[j] =3D &data->dtd;
+			vals[j] =3D &data->val;
+			j++;
+		}
+		feat =3D sdp_seq_alloc(dtds, vals, plen);
+		free(dtds);
+		free(vals);
+
+		seqDTDs[i] =3D &feat->dtd;
+		seqVals[i] =3D feat;
+		i++;
+	}
+	seq_feat =3D sdp_seq_alloc(seqDTDs, seqVals, seqlen);
+
+	sdp_attr_replace(rec, SDP_ATTR_SUPPORTED_FEATURES_LIST, seq_feat);
+}
+
+/*
+ * Get the supported features
+ * If an error occurred -1 is returned and errno is set
+ */
+int sdp_get_supp_feat (const sdp_record_t *rec, sdp_list_t **seqp)
+{
+
+	*seqp =3D NULL;
+	sdp_data_t * sdpdata =3D NULL;
+
+	sdpdata =3D sdp_data_get(rec, SDP_ATTR_SUPPORTED_FEATURES_LIST);
+	if (sdpdata && sdpdata->dtd >=3D SDP_SEQ8 && sdpdata->dtd <=3D SDP_SEQ32)=
 {
+		sdp_data_t *d;
+		for (d =3D sdpdata->val.dataseq; d; d =3D d->next) {
+			if ( d->dtd >=3D SDP_SEQ8 && d->dtd <=3D SDP_SEQ32 ) {
+				sdp_data_t *dd;
+				sdp_list_t *subseq =3D NULL;
+				for (dd =3D d->val.dataseq; dd; dd =3D dd->next) {
+					sdp_data_t *data;
+					if ( dd->dtd !=3D SDP_UINT8 &&
+						dd->dtd !=3D SDP_UINT16 &&
+						dd->dtd !=3D SDP_TEXT_STR8)
+						goto fail;
+					data =3D sdp_data_alloc(dd->dtd, &dd->val);
+					subseq =3D sdp_list_append(subseq, data);
+				}
+				*seqp =3D sdp_list_append (*seqp, subseq);
+			} else
+				goto fail;
+		}
+		return 0;
+	}
+
+
+	return sdp_get_uuidseq_attr(rec, SDP_ATTR_SUPPORTED_FEATURES_LIST, seqp);
+
+fail:
+	sdp_list_free(*seqp, free);
+	errno =3D EINVAL;
+	return -1;
+}
diff --git a/lib/sdp.h b/lib/sdp.h
index 375261e..1bb351a 100644
=2D-- a/lib/sdp.h
+++ b/lib/sdp.h
@@ -244,13 +244,16 @@ extern "C" {
 #define SDP_ATTR_GROUP_ID			0x0200
 #define SDP_ATTR_IP_SUBNET			0x0200
 #define SDP_ATTR_VERSION_NUM_LIST		0x0200
+#define SDP_ATTR_SUPPORTED_FEATURES_LIST 0x0200
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
index ee39df8..41d5786 100644
=2D-- a/lib/sdp_lib.h
+++ b/lib/sdp_lib.h
@@ -585,6 +585,19 @@ static inline int sdp_get_icon_url(const sdp_record_t=
=20
*rec, char *str, int len)
 	return sdp_get_string_attr(rec, SDP_ATTR_ICON_URL, str, len);
 }
=20
+/*
+ * Set the supported features
+ * sf should be a list of list with each feature data
+ */
+void sdp_set_supp_feat(sdp_record_t *rec, const sdp_list_t *sf);
+
+/*
+ * Get the supported features
+ * seqp is set to a list of list with each feature data
+ * If an error occurred -1 is returned and errno is set
+ */
+int sdp_get_supp_feat (const sdp_record_t *rec, sdp_list_t **seqp);
+
 sdp_record_t *sdp_extract_pdu(const uint8_t *pdata, int bufsize, int=20
*scanned);
 sdp_record_t *sdp_copy_record(sdp_record_t *rec);
=20


--nextPart3888760.h0OXbaUz8b
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkr9VGYACgkQ35o/gIXgrCfflgCdFNa8iHSGZp0lFRdYmf58rvKS
ZLYAnAr3Tb/+Fuiq90o0UsBv/MEQwSve
=dAZw
-----END PGP SIGNATURE-----

--nextPart3888760.h0OXbaUz8b--
