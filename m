Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3043149620
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914733; cv=none; b=daPkzrQcKZCuB9Gt3l/P26GbIPRASrX4l0a2oZZrM5ELna82EcWcENHXWfznCBP/ncK/RdY/hmdSHYFjZrFhAJNmrmCEtCcvO/LB57JLS0igUDHDbS1gtKABmq83LFsssb7v8U1YFvGL4R5L2e+g4R7QSMwB1iH6r4LFXOf3Jow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914733; c=relaxed/simple;
	bh=Lriy2/savmlitRwjQVAAHff6H1AoJ13Dlz+wcqYkdwQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FmsY2+IW/0182OYzNyw5/6N3UjxEuMXxNGqMFM5pa++Z6Ic54OMEm3zlR0YcBQN3cG8NskZe/TgQXtuSdCueuqFIRKBKv9YToN15m8+nJhuf11QxxYEHp00tcpaPvLLg90wzYsmT8sggpPu7axC+FpSR9Y84ZcOtZdA/GMG07R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fluentlogic.org; spf=pass smtp.mailfrom=fluentlogic.org; dkim=pass (2048-bit key) header.d=fluentlogic.org header.i=@fluentlogic.org header.b=RlJsEQmX; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fluentlogic.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluentlogic.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluentlogic.org header.i=@fluentlogic.org header.b="RlJsEQmX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluentlogic.org;
	s=protonmail; t=1777914727; x=1778173927;
	bh=xRKcEQbutf2fMqCUa+/ZNP12+5TQVyIEJdmPXW2pr3E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RlJsEQmXqfLzXeHodkBwyq/zIzP+ao49a03NaRHCNJZ1vkiYo98R3x+CKG58gETpC
	 FAjgZr5zp8lTv4pwPzRuctL+/C/hVYuWMJuwFEBRq7uPxqBsAtg1ZrjRVIKAIwzxCw
	 9ckaalSHzc8WwlCz5+PSGiX0hT9fCMA89hsXW+EUlTf6QV+8TfGG65E6n4Y6Ez5Vad
	 rMV0ONK/vTc2RFhPi+DMRsZ+NvEpSPrYGyuBf9mDmC9n3JphkSrjneBWh79Wn9MUs0
	 rrhrlWlAQASS++pNPScu1cW3pf5TS1OmY4PF95SfFZnxEhzOlKmmNrje8irXw+kNsh
	 1dSHEk+PcQXiQ==
Date: Mon, 04 May 2026 17:12:04 +0000
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: admin <admin@fluentlogic.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Subject: Re: [PATCH BlueZ v2] sdp: fix overflow in sdp_extract_seqtype()
Message-ID: <Rv_xUQOJhZyTRklb1n0yF71KB-MkPlAP_82ZjQSJv12SJaBr5vbpfWcwI3PVtuwotxG27kKsVi92OzRN92zaEBytgiCqZoWASokdLaxzuRA=@fluentlogic.org>
In-Reply-To: <CABBYNZLQVVrxpcVqU4abyE5sodh6wq=a_z4NbPp+XN04RYz2nA@mail.gmail.com>
References: <20260504164649.31170-1-admin@fluentlogic.org> <CABBYNZLQVVrxpcVqU4abyE5sodh6wq=a_z4NbPp+XN04RYz2nA@mail.gmail.com>
Feedback-ID: 121058281:user:proton
X-Pm-Message-ID: 0888bdfa1ddcbdae8d730ed8413f7d7cbfc81fce
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Luiz,=20
Sorry for the multiple submissions, couldn't figure out something on the em=
ailing side of things.

Here's what my setup sees that you also must change since this is a more in=
vasive fix:
                                                                           =
                                                    =20
v3 changes the parameter type to uint32_t * and updates all callers (sdp.c =
=C3=973, sdp-client.c, sdpd-request.c, sdpd-service.c, obexd/client/bluetoo=
th.c).=20

Here are the details as needed:

                                                                       =20
                                                                           =
                                                                     =20
  bt_get_be32() returns uint32_t. Assigning the result directly            =
                                                                     =20
  to the int *size parameter sign-extends values greater than              =
                                                                     =20
  INT_MAX to negative, bypassing sequence-length sanity checks             =
                                                                     =20
  in extract_seq() and sdp_extract_pdu() callers.                          =
                                                                     =20
                                                                           =
                                                                     =20
  Change the type of the size parameter from int * to uint32_t *,          =
                                                                     =20
  which correctly reflects the wire encoding and eliminates the
  need for an intermediate overflow check. Update all callers.             =
                                                                     =20
                                                                           =
                                                                     =20
  Reported-by: Martin Brodeur <admin@fluentlogic.org>                      =
                                                                     =20
  ---                                                                      =
                                                                     =20
   lib/bluetooth/sdp.c      | 11 +++++++----                               =
                                                                     =20
   lib/bluetooth/sdp_lib.h  |  2 +-        =20
   obexd/client/bluetooth.c |  2 +-                                        =
                                                                     =20
   src/sdp-client.c         |  3 ++-
   src/sdpd-request.c       |  3 ++-                                       =
                                                                     =20
   src/sdpd-service.c       |  2 +-        =20
   6 files changed, 14 insertions(+), 9 deletions(-)                       =
                                                                     =20
                                                                           =
                                                                     =20
  diff --git a/lib/bluetooth/sdp.c b/lib/bluetooth/sdp.c
  index 7210ce0..fd443a7 100644                                            =
                                                                     =20
  --- a/lib/bluetooth/sdp.c                                                =
                                                                     =20
  +++ b/lib/bluetooth/sdp.c
  @@ -1210,7 +1210,7 @@ static sdp_data_t *extract_str(const void *p, int b=
ufsize, int *len)                                                    =20
    * Extract the sequence type and its length, and return offset into buf =
                                                                     =20
    * or 0 on failure.
    */                                                                     =
                                                                     =20
  -int sdp_extract_seqtype(const uint8_t *buf, int bufsize, uint8_t *dtdp, =
int *size)
  +int sdp_extract_seqtype(const uint8_t *buf, int bufsize, uint8_t *dtdp, =
uint32_t *size)                                                      =20
   {                                                                       =
                                                                     =20
        uint8_t dtd;                                                       =
                                                                     =20
        int scanned =3D sizeof(uint8_t);                                   =
                                                                       =20
  @@ -1262,7 +1262,8 @@ int sdp_extract_seqtype(const uint8_t *buf, int buf=
size, uint8_t *dtdp, int *siz
   static sdp_data_t *extract_seq(const void *p, int bufsize, int *len,    =
                                                                     =20
                                                        sdp_record_t *rec) =
                                                                     =20
   {                                                                       =
                                                                     =20
  -     int seqlen, n =3D 0;                                               =
                                                                       =20
  +     uint32_t seqlen;                   =20
  +     int n =3D 0;
        sdp_data_t *curr, *prev;
        sdp_data_t *d =3D bt_malloc0(sizeof(sdp_data_t));                  =
                                                                       =20
  =20
  @@ -1391,7 +1392,8 @@ void sdp_print_service_attr(sdp_list_t *svcAttrList=
)                                                                    =20
                                           =20
   sdp_record_t *sdp_extract_pdu(const uint8_t *buf, int bufsize, int *scan=
ned)                                                                 =20
   {                                       =20
  -     int extracted =3D 0, seqlen =3D 0;
  +     int extracted =3D 0;
  +     uint32_t seqlen =3D 0;                                             =
                                                                       =20
        uint8_t dtd;
        uint16_t attr;                                                     =
                                                                     =20
        sdp_record_t *rec =3D sdp_record_alloc();
  @@ -4422,7 +4424,8 @@ int sdp_service_search_attr_req(sdp_session_t *sess=
ion, const sdp_list_t *search                                        =20
        int status =3D 0;
        uint32_t reqsize =3D 0, _reqsize;                                  =
                                                                       =20
        uint32_t rspsize =3D 0;                                            =
                                                                       =20
  -     int seqlen =3D 0, attr_list_len =3D 0;
  +     uint32_t seqlen =3D 0;                                             =
                                                                       =20
  +     int attr_list_len =3D 0;             =20
        int rsp_count =3D 0, cstate_len =3D 0;                             =
                                                                         =
=20
        unsigned int pdata_len;
        uint8_t *pdata, *_pdata;                                           =
                                                                     =20
  diff --git a/lib/bluetooth/sdp_lib.h b/lib/bluetooth/sdp_lib.h
  index 7a48ad5..96048e6 100644                                            =
                                                                     =20
  --- a/lib/bluetooth/sdp_lib.h
  +++ b/lib/bluetooth/sdp_lib.h                                            =
                                                                     =20
  @@ -610,7 +610,7 @@ void sdp_append_to_buf(sdp_buf_t *dst, uint8_t *data,=
 uint32_t len);                                                      =20
   int sdp_gen_pdu(sdp_buf_t *pdu, sdp_data_t *data);
   int sdp_gen_record_pdu(const sdp_record_t *rec, sdp_buf_t *pdu);        =
                                                                     =20
                                           =20
  -int sdp_extract_seqtype(const uint8_t *buf, int bufsize, uint8_t *dtdp, =
int *size);                                                          =20
  +int sdp_extract_seqtype(const uint8_t *buf, int bufsize, uint8_t *dtdp, =
uint32_t *size);
                                                                           =
                                                                     =20
   sdp_data_t *sdp_extract_attr(const uint8_t *pdata, int bufsize, int *ext=
ractedLength, sdp_record_t *rec);                                    =20
  =20
  diff --git a/obexd/client/bluetooth.c b/obexd/client/bluetooth.c         =
                                                                     =20
  index 96c69d8..4f1da37 100644            =20
  --- a/obexd/client/bluetooth.c                                           =
                                                                     =20
  +++ b/obexd/client/bluetooth.c           =20
  @@ -135,7 +135,7 @@ static void search_callback(uint8_t type, uint16_t st=
atus,
   {                                                                       =
                                                                     =20
        struct bluetooth_session *session =3D user_data;
        unsigned int scanned, bytesleft =3D size;                          =
                                                                       =20
  -     int seqlen =3D 0;                    =20
  +     uint32_t seqlen =3D 0;                                             =
                                                                       =20
        uint8_t dataType;
        uint16_t port =3D 0;                                               =
                                                                       =20
        GError *gerr =3D NULL;               =20
  diff --git a/src/sdp-client.c b/src/sdp-client.c
  index 4f35cf1..a3ac6de 100644                                            =
                                                                     =20
  --- a/src/sdp-client.c
  +++ b/src/sdp-client.c                                                   =
                                                                     =20
  @@ -151,7 +151,8 @@ static void search_completed_cb(uint8_t type, uint16_=
t status,
   {                                                                       =
                                                                     =20
        struct search_context *ctxt =3D user_data;
        sdp_list_t *recs =3D NULL;                                         =
                                                                       =20
  -     int scanned, seqlen =3D 0, bytesleft =3D size;
  +     int scanned, bytesleft =3D size;                                   =
                                                                       =20
  +     uint32_t seqlen =3D 0;
        uint8_t dataType;                                                  =
                                                                     =20
        int err =3D 0;                                                     =
                                                                       =20
  =20
  diff --git a/src/sdpd-request.c b/src/sdpd-request.c                     =
                                                                     =20
  index c78bfdf..6ce5a81 100644            =20
  --- a/src/sdpd-request.c
  +++ b/src/sdpd-request.c                                                 =
                                                                     =20
  @@ -135,7 +135,8 @@ struct attrid {
   static int extract_des(uint8_t *buf, int len, sdp_list_t **svcReqSeq, ui=
nt8_t *pDataType, uint8_t expectedType)                              =20
   {                                                                       =
                                                                     =20
        uint8_t seqType;
  -     int scanned, data_size =3D 0;                                      =
                                                                       =20
  +     int scanned;                       =20
  +     uint32_t data_size =3D 0;
        short numberOfElements =3D 0;                                      =
                                                                       =20
        int seqlen =3D 0;
        sdp_list_t *pSeq =3D NULL;                                         =
                                                                       =20
  diff --git a/src/sdpd-service.c b/src/sdpd-service.c
  index 3f3b540..e0f5783 100644                                            =
                                                                     =20
  --- a/src/sdpd-service.c
  +++ b/src/sdpd-service.c                                                 =
                                                                     =20
  @@ -703,7 +703,7 @@ static sdp_record_t *extract_pdu_server(bdaddr_t *dev=
ice, uint8_t *p,
   {
        int extractStatus =3D -1, localExtractedLength =3D 0;
        uint8_t dtd;
  -     int seqlen =3D 0;                                                  =
                                                                       =20
  +     uint32_t seqlen =3D 0;
        sdp_record_t *rec =3D NULL;                                        =
                                                                       =20
        uint16_t attrId, lookAheadAttrId;  =20
        sdp_data_t *pAttr =3D NULL;                                        =
                                                                       =20
  --
  2.39.5 (Apple Git-154)        
