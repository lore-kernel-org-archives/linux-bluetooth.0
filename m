Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CB81E5718
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 14:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765377731; cv=none; b=YP/bN0LC2kJ5SwoA9Y6TdMXwF2M3vRdkcPyrQCUb1A+dkfm+3P+NwJ+tOYTS+vlh/mZsP1+PafCc0PcInUefqc4CRhNL0RYk9yW9hF/SnzlVM5KmArR28hS+f1w3Yv++CJYpWuFvFn8b4pCb/kuxWBNT/bjWm7CWr5bbHAE0xVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765377731; c=relaxed/simple;
	bh=PBBISkA+qLlv7WSI7xEfMW5nHMg3ufUizxm8boAu+nE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NeLwrNLrV1x2RM8lBSN8tJODygzDw2L9zf7SYFtN21nGbR//3iVu+LY4d7AZ1T8dVk6Jy4hxKV3fZHgLXT0d5UBPr46izPWFBVURwiLCgJ77gs0ve7RgwS1FHbd/L5XWsaP007KctxOARiZAp5c3S0Qi+2kkmBMIluqDAVna2uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDXKB7JQ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDXKB7JQ"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-37e578d04b5so61323341fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 06:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765377727; x=1765982527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QYb54U1fhzPowjaezENyMdTxXRPVId7KyqKSxIrwtU=;
        b=nDXKB7JQcynR+/cdd9DOKrbDmoh7wwsJNm323Q8JEw9ONmXTLHXBW/SdlMEzLg77uU
         yKoaBie8SvBmUNDW9j3nf/yRCssqIfaMdVkPUYtl/vYDhb8YR9FqLKFlkZB0bZJfenxq
         6RdgVYlZF/Phg8CwV5iVmgeo0NlxRRbbx8MOsMiZc/Mw4rlMJxzXMwFBku1NN7uryrs0
         xX+xP1+nEJCNTBp4ORgDUMvlGitwlO/iHOowy2whxoqbVswCbjLse+FBe37YcGSoI8Mc
         DVR7DfMfgzuf0K3MlYXxgt3VdM9fCfJR1voBfmrNRDEbRUOQUpY1KFAEOJ83Lh2ZvdCh
         4tkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765377727; x=1765982527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7QYb54U1fhzPowjaezENyMdTxXRPVId7KyqKSxIrwtU=;
        b=mQH1/f4Vzw/PaKHsVoaztW9FLkiyOtV6f9VApkYZof73ai6bmVG9NQFimviIGCIVj5
         bwu8mNT9jGEF4Ojxmx8TiJEyovH29hlqPrxQlYDbfsn3MHuu713qkQNBqYnDWRzi+boq
         wJI5gJbN5mV2g0UnR8jBvVegSfxBfAzE5ud+tNuiJRqDxz1/2iTI52i50gXzO4T8WhJE
         zZfpR4RWvVelJKSNrW1wxjU3XW4RX+Bm6lpGFEBLy389/a4UeI2SQU1tpTMtA/yNPqoY
         kwmEyiiPLBNC4whfEPzH07IqwQW3tSzQHHd9GmUgeY50NwAvYa7pflSDeS96auJbT/VK
         jpVA==
X-Gm-Message-State: AOJu0Yyrx4LByz+u9Ebv8RmYIr101hzKlJWp/htCkwOYwEZXNFcEiCHz
	kFZM61fXIk+3MPOMYVBzituyiHy2YBEO2nYVByyZYilixGT9EBKadSpYxd5Qy9+0RD5pg5Hoyum
	avGb2ghiCfsss4BTwAsCSWhgm8b6OFy4=
X-Gm-Gg: AY/fxX7U0MNKII89Rghy5XY+ECPhSqNdY6KCY3Ae3dFr+5t/Xv8MaGkqLblQOCYconr
	FOfcojyMtCvsRtLWibHDG0sVtNIBXiHpX0OzpwfCIypVdfBx/p0Aam2XoISPheDXUaIPyd4kcrj
	IF8XC1DtbrZGzsxxKWppcLmP8P578M4o+K9t51vdz9spuUG9O7gtn2F9z/Tno+uI3CNyUXyVPKP
	noD1p/GM6LvUlv/lyPq/xqAdq3mgYCHJrSbY8m/80RuUuoNXY9xE+XgDycE/y39FvLKu5a14dpD
	znDW
X-Google-Smtp-Source: AGHT+IGcgGaWP0vysLjwZnBc8Cm2EUxlCaZLSTu3OhBSAtpqVPZ2UkGKD/WMgddcGxwfie+wp0eI8LAOYZYsyuWjBEA=
X-Received: by 2002:a2e:be9d:0:b0:37b:aaf7:eff3 with SMTP id
 38308e7fff4ca-37fb20531damr7273391fa.28.1765377726695; Wed, 10 Dec 2025
 06:42:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208101915.247459-1-mengshi.wu@oss.qualcomm.com>
 <CABBYNZJ=S3LHcwyXAc=gxf0RptcOC+6TPaWvoEmJquar54b3dQ@mail.gmail.com> <ee21c657-5120-4dbd-8660-d2a522f8578b@oss.qualcomm.com>
In-Reply-To: <ee21c657-5120-4dbd-8660-d2a522f8578b@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 10 Dec 2025 09:41:54 -0500
X-Gm-Features: AQt7F2r-0Fa8PtM40ab9Ug0_3MG0fWx2T05HBRkDQO0RzYjeyRuAXvHOAzTpozk
Message-ID: <CABBYNZ+s3Oj5zM9uL-SPLQAmo3y+-06JLK4mn-YF-j-e196T8A@mail.gmail.com>
Subject: Re: [PATCH v1] gatt-client:Implement error handling for
 DB_OUT_OF_SYNC in GATT caching.
To: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com, 
	cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com, 
	wei.deng@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 10, 2025 at 2:59=E2=80=AFAM Mengshi Wu <mengshi.wu@oss.qualcomm=
.com> wrote:
>
> Hi,
>
> Thank you for your comments.
>
> On 12/8/2025 11:35 PM, Luiz Augusto von Dentz wrote:
> > Hi,
> >
> > On Mon, Dec 8, 2025 at 5:19=E2=80=AFAM Mengshi Wu <mengshi.wu@oss.qualc=
omm.com> wrote:
> >>
> >> Add automatic DB re-discovery on receiving BT_ATT_ERROR_DB_OUT_OF_SYNC
> >> error code from ATT operations. This ensures the local GATT database
> >> stays synchronized with the remote device by triggering a full service
> >> discovery (handles 0x0001-0xffff) when the database becomes out of syn=
c.
> >>
> >> The process_db_out_of_sync() function is now called in all ATT error
> >> response handlers (read_multiple, read_long, write, execute_write,
> >> prepare_write, and prep_write callbacks) to handle this error conditio=
n
> >> consistently.
> >>
> >> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
> >> ---
> >>  src/shared/gatt-client.c | 35 +++++++++++++++++++++++++++++++++--
> >>  1 file changed, 33 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> >> index f6d5dc4b7..087d4e228 100644
> >> --- a/src/shared/gatt-client.c
> >> +++ b/src/shared/gatt-client.c
> >> @@ -1965,6 +1965,29 @@ fail:
> >>                 "Failed to initiate service discovery after Service Ch=
anged");
> >>  }
> >>
> >> +static void process_db_out_of_sync(struct bt_gatt_client *client,
> >> +                                  uint8_t att_ecode)
> >> +{
> >> +       struct service_changed_op *op;
> >> +
> >> +       if (att_ecode !=3D BT_ATT_ERROR_DB_OUT_OF_SYNC)
> >> +               return;
> >> +
> >> +       DBG(client, "Database Out of Sync - triggering full re-discove=
ry");
> >> +
> >> +       if (!client->in_svc_chngd) {
> >> +               process_service_changed(client, 0x0001, 0xffff);
> >> +               return;
> >> +       }
> >> +
> >> +       op =3D new0(struct service_changed_op, 1);
> >> +
> >> +       op->start_handle =3D 0x0001;
> >> +       op->end_handle =3D 0xffff;
> >> +
> >> +       queue_push_tail(client->svc_chngd_queue, op);
> >> +}
> >
> > Id just change process_error to call into db_out_sync, that said this
> > is not recovering at all, it just rediscovering but the original
> > request will be lost, I wonder if we should implement some backoff
> > logic wait to see if the server do a service changed, read the hash
> > (in case we are not doing it already), and then redo the operation.
> > Also we do need to make sure we don't end up in a loop rediscovery.
>
> At the beginning, we considered implementing recovery for failed ATT
> requests caused by a Database Out of Sync error. However, we identified
> potential risks in retrying some ATT requests after the remote device=E2=
=80=99s
> services have changed. For example, the handle in the ATT_READ_REQ PDU,
> which identifies the target attribute, may have changed on the remote
> device. Even if the retry succeeds, it might operate on the wrong
> attribute.
>
> As usual, any ATT response error will be propagated to the application
> layer, so the operation will not be lost but will fail. We did not modify
> this behavior.

We do recovery for encryption/pairing errors.

> It may not be appropriate to implement recovery logic for failed ATT
> requests at the BlueZ host layer. Therefore, we only do a rediscovery
> as required by the Core Spec, Vol. 3, Part G, Section 2.5.2.1,
> after receiving a Database Out of Sync error.
>
> For the suggestion about back-off logic,
>
> We are considering reading the remote database hash and comparing it
> with the locally stored hash before initiating rediscovery. If reading
> the remote database hash fails, we will assume that the remote GATT
> database has changed and proceed with rediscovery immediately.
>
> As shown below, the client checks the remote database hash after
> receiving a Database Out of Sync error. If the remote services have
> changed, the client initiates rediscovery.
>
> btmon HCI Logs:
> > ACL Data RX: Handle 2 flags 0x02 dlen 9
>       ATT: Error Response (0x01) len 4
>         Read Request (0x0a)
>         Handle: 0x000d
>         Error: Database Out of Sync (0x12)
> bluetoothd[57993]: < ACL Data TX: Handle 2 flags 0x00 dlen 11
>       ATT: Read By Type Request (0x08) len 6
>         Handle range: 0x0001-0xffff
>         Attribute type: Database Hash (0x2b2a)
> > HCI Event: Number of Completed Packets (0x13) plen 5
>         Num handles: 1
>         Handle: 2
>         Count: 1
> > ACL Data RX: Handle 2 flags 0x02 dlen 24
>       ATT: Read By Type Response (0x09) len 19
>         Attribute data length: 18
>         Attribute data list: 1 entry
>         Handle: 0x000f
>         Value: 10d6a00f95bb0eeec55a097ccf7dead8
> bluetoothd[57993]: < ACL Data TX: Handle 2 flags 0x00 dlen 11
>       ATT: Read By Type Request (0x08) len 6
>         Handle range: 0x0010-0xffff
>         Attribute type: Database Hash (0x2b2a)
> > HCI Event: Number of Completed Packets (0x13) plen 5
>         Num handles: 1
>         Handle: 2
>         Count: 1
> > ACL Data RX: Handle 2 flags 0x02 dlen 9
>       ATT: Error Response (0x01) len 4
>         Read By Type Request (0x08)
>         Handle: 0x0010
>         Error: Attribute Not Found (0x0a)

I don't recall if we have this behavior earlier of using Read By Type
request for hash in the beginning? We need to limit the results to one
and not proceed to read it again since it is supposed to exist only
once in the database. Anyway I don't see a problem if we do read the
hash and that didn't change we should probably go ahead and resend the
original request, in the meantime if we receive a service changed we
can narrow down the range that needs to be rediscovered and not use
0x0001-0xffff as bellow, and we can actually perform recovery also in
case the service changed don't affect the original operation handle.

> bluetoothd[57993]: < ACL Data TX: Handle 2 flags 0x00 dlen 11
>       ATT: Read By Group Type Request (0x10) len 6
>         Handle range: 0x0001-0xffff
>         Attribute group type: Primary Service (0x2800)
>
> >
> >>  static void service_changed_cb(uint16_t value_handle, const uint8_t *=
value,
> >>                                         uint16_t length, void *user_da=
ta)
> >>  {
> >> @@ -2709,10 +2732,12 @@ static void read_multiple_cb(uint8_t opcode, c=
onst void *pdu, uint16_t length,
> >>                         (!pdu && length)) {
> >>                 success =3D false;
> >>
> >> -               if (opcode =3D=3D BT_ATT_OP_ERROR_RSP)
> >> +               if (opcode =3D=3D BT_ATT_OP_ERROR_RSP) {
> >>                         att_ecode =3D process_error(pdu, length);
> >> -               else
> >> +                       process_db_out_of_sync(req->client, att_ecode)=
;
> >> +               } else {
> >>                         att_ecode =3D 0;
> >> +               }
> >>
> >>                 pdu =3D NULL;
> >>                 length =3D 0;
> >> @@ -2864,6 +2889,7 @@ static void read_long_cb(uint8_t opcode, const v=
oid *pdu,
> >>         if (opcode =3D=3D BT_ATT_OP_ERROR_RSP) {
> >>                 success =3D false;
> >>                 att_ecode =3D process_error(pdu, length);
> >> +               process_db_out_of_sync(req->client, att_ecode);
> >>                 goto done;
> >>         }
> >>
> >> @@ -3050,6 +3076,7 @@ static void write_cb(uint8_t opcode, const void =
*pdu, uint16_t length,
> >>         if (opcode =3D=3D BT_ATT_OP_ERROR_RSP) {
> >>                 success =3D false;
> >>                 att_ecode =3D process_error(pdu, length);
> >> +               process_db_out_of_sync(req->client, att_ecode);
> >>                 goto done;
> >>         }
> >>
> >> @@ -3213,6 +3240,7 @@ static void execute_write_cb(uint8_t opcode, con=
st void *pdu, uint16_t length,
> >>         if (opcode =3D=3D BT_ATT_OP_ERROR_RSP) {
> >>                 success =3D false;
> >>                 att_ecode =3D process_error(pdu, length);
> >> +               process_db_out_of_sync(req->client, att_ecode);
> >>         } else if (opcode !=3D BT_ATT_OP_EXEC_WRITE_RSP || pdu || leng=
th)
> >>                 success =3D false;
> >>
> >> @@ -3278,6 +3306,7 @@ static void prepare_write_cb(uint8_t opcode, con=
st void *pdu, uint16_t length,
> >>         if (opcode =3D=3D BT_ATT_OP_ERROR_RSP) {
> >>                 success =3D false;
> >>                 att_ecode =3D process_error(pdu, length);
> >> +               process_db_out_of_sync(req->client, att_ecode);
> >>                 goto done;
> >>         }
> >>
> >> @@ -3447,6 +3476,7 @@ static void prep_write_cb(uint8_t opcode, const =
void *pdu, uint16_t length,
> >>                 success =3D false;
> >>                 reliable_error =3D false;
> >>                 att_ecode =3D process_error(pdu, length);
> >> +               process_db_out_of_sync(req->client, att_ecode);
> >>                 goto done;
> >>         }
> >>
> >> @@ -3597,6 +3627,7 @@ static void exec_write_cb(uint8_t opcode, const =
void *pdu, uint16_t length,
> >>         if (opcode =3D=3D BT_ATT_OP_ERROR_RSP) {
> >>                 success =3D false;
> >>                 att_ecode =3D process_error(pdu, length);
> >> +               process_db_out_of_sync(req->client, att_ecode);
> >>                 goto done;
> >>         }
> >>
> >> --
> >> 2.34.1
> >>
> >>
> >
> >
>


--=20
Luiz Augusto von Dentz
