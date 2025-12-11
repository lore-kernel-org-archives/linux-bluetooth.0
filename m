Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9752E325735
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765474614; cv=none; b=oy7IaniyRYiInNXO9DZ5Uc7j0/lV9XDZfUXkkvcuDDWsG99+HDWzcCGg8bNNXZ6OiKiUPCtuXiuhKu8IFk0yqlyAM9CDNMhT4Dob76vEuODsJehgjka7Qjebw8STvSafpXGaB2D0ihLIu8vbkhbT1yHB4+GcaDNvcHHCbT3ksTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765474614; c=relaxed/simple;
	bh=756m3GZPErH9mpfHbUAmLV4vkcmMCsVHvth8+h3iTJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PoJVyyW4jzWEGG9M5lZTzl3lGyezBHWlUKJpShpj47kcVsuutQHgG5f0Ca0jsbN8W+mk82G0xJJeOfEoURSNUlW////YGWEGOLkPUZeVe7DZpI6mP0lSlImRMogcz5SThNXNNoWFOYTVoiOF4prdR7PpGJBAMIFU3C/5ThysEW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEYgCEqL; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEYgCEqL"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-37e6dd536b0so4243411fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 09:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765474610; x=1766079410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bF66F6E5WANIqBrjAL92U4mp6JV7UGyZrwmotPTjHM=;
        b=HEYgCEqL/bOlphCP4k2xFwJ1ensqsn46g6Ms9RVUSymGshhmZn5Faf++cwYCcAKkF9
         lA9zhjzQ/DIMVKdc+DdmyTDZPVWOA/MOS9902Qd1PzK+LMBkA5aeN0/nWPcWntYjQ6hE
         H5lbwNtFM0DpE6rbvjHhIGVSwsp+yyBKETMFY15F4pBqN8vFZ78MwmST9dsrzNigLiwz
         7MRhPe7+NA31dbJfAu0d89BYt2t+HoMVbmFLvNovCAGfo9RP/j9eRgkMyCbVKbrEg0T8
         h7ADry1FhXQ4HuseZ+Q/4sL4Mn6+5czFRm3XZl3iMJ2lxivnKnr1mLmGZntsZwrnh3J8
         IQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765474610; x=1766079410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/bF66F6E5WANIqBrjAL92U4mp6JV7UGyZrwmotPTjHM=;
        b=LS9aS8qfyfRkHsSAdKj3MpRhVByQJEY1eEkoaguibK6SGKXKr9hOKSeceip2NoyyNK
         y5gqBCJHaFgF2iSYbU4FC+VCZz4rd1M7RdhB4Aob5gD4GjsokGghPBv4nbK4/smr+EW+
         ozKgMbwTx0vl7or9/clJGaRkcr9O50HL2Ksn16lnlE8riYt2VR+kOSlCOlcfMcrGZEur
         cY5GXz+hUyjblg+UAdzuWIcMklttiyYVRwISjw9CLTY4JWTzBpBjdk1h2jdJXsSz1Qc2
         Y08FHgp8Rl5ESNQ6fzqilEyLy58pyP8iRHrSiUYVKY+DLoRzoVVOjPC/8C261jDXGrVD
         iEDQ==
X-Gm-Message-State: AOJu0YzSFAxKwViGhWrSo5rimXjP2PHIPLBL+LvC25ALftuFDdV0aHBW
	1ViBiwNUZaubGDYJctlclRGfxqmud/PpidXBqI5lPrWInc1y0MOWXh0YK1Ij5JMJvK5vgugYqWz
	LuRHZPj9KIUeR2dDY+SWWkE8GUPxxpMU=
X-Gm-Gg: AY/fxX6ZajJ37y111QnqgoBsk4HADemYfdD0+W+9syyVQpBGTj93wrugAp8G7kYJO2C
	dVBPP8UFd6dCfZ7HGOryLIq3SOIOmcKInIPypk8dxQMtiqlC+NCrSiA24LzLfLV13iSI/GEyK5L
	VSc18uDH6qt0y6kF5Z6POTlEcIbZ7lSFFInrtz6rpHUa3pR4/vXtz0173uPHUrtoiNmGTHBvZUF
	3LJpz/01hVMcRl+NQY6ZnhE+z0EPQ2vhRawUDuSbyYWgrRSNEkbjhuls7qtjTZO3n7/pw==
X-Google-Smtp-Source: AGHT+IGy5OpuVncRBROIee1gW3orbh9jAJTiIfl+ONFf97/40AVnfdNSw6tX/dr0PIp39XW111W/GZ2yn9owqaBZX18=
X-Received: by 2002:a05:651c:31cb:b0:37b:9867:890d with SMTP id
 38308e7fff4ca-37fb2036db8mr22060981fa.2.1765474609325; Thu, 11 Dec 2025
 09:36:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208101915.247459-1-mengshi.wu@oss.qualcomm.com>
 <CABBYNZJ=S3LHcwyXAc=gxf0RptcOC+6TPaWvoEmJquar54b3dQ@mail.gmail.com>
 <ee21c657-5120-4dbd-8660-d2a522f8578b@oss.qualcomm.com> <CABBYNZ+s3Oj5zM9uL-SPLQAmo3y+-06JLK4mn-YF-j-e196T8A@mail.gmail.com>
 <29919357-f843-4c28-8b54-001955f4f09e@oss.qualcomm.com>
In-Reply-To: <29919357-f843-4c28-8b54-001955f4f09e@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 11 Dec 2025 12:36:36 -0500
X-Gm-Features: AQt7F2oCmLiRbb6_P_jPfWy4zwQ39cUwNgbmjWe0rFjNOFRAxjqUnPP0V0FCY_Q
Message-ID: <CABBYNZJZreb5oowVXJMVqsqsvgEGX9=yK7kFOJp8MhNrfBJGLw@mail.gmail.com>
Subject: Re: [PATCH v1] gatt-client:Implement error handling for
 DB_OUT_OF_SYNC in GATT caching.
To: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com, 
	cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com, 
	wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 10, 2025 at 11:32=E2=80=AFPM Mengshi Wu <mengshi.wu@oss.qualcom=
m.com> wrote:
>
> Hi,
>
> On 12/10/2025 10:41 PM, Luiz Augusto von Dentz wrote:
> > Hi,
> >
> > On Wed, Dec 10, 2025 at 2:59=E2=80=AFAM Mengshi Wu <mengshi.wu@oss.qual=
comm.com> wrote:
> >>
> >> Hi,
> >>
> >> Thank you for your comments.
> >>
> >> On 12/8/2025 11:35 PM, Luiz Augusto von Dentz wrote:
> >>> Hi,
> >>>
> >>> On Mon, Dec 8, 2025 at 5:19=E2=80=AFAM Mengshi Wu <mengshi.wu@oss.qua=
lcomm.com> wrote:
> >>>>
> >>>> Add automatic DB re-discovery on receiving BT_ATT_ERROR_DB_OUT_OF_SY=
NC
> >>>> error code from ATT operations. This ensures the local GATT database
> >>>> stays synchronized with the remote device by triggering a full servi=
ce
> >>>> discovery (handles 0x0001-0xffff) when the database becomes out of s=
ync.
> >>>>
> >>>> The process_db_out_of_sync() function is now called in all ATT error
> >>>> response handlers (read_multiple, read_long, write, execute_write,
> >>>> prepare_write, and prep_write callbacks) to handle this error condit=
ion
> >>>> consistently.
> >>>>
> >>>> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
> >>>> ---
> >>>>  src/shared/gatt-client.c | 35 +++++++++++++++++++++++++++++++++--
> >>>>  1 file changed, 33 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> >>>> index f6d5dc4b7..087d4e228 100644
> >>>> --- a/src/shared/gatt-client.c
> >>>> +++ b/src/shared/gatt-client.c
> >>>> @@ -1965,6 +1965,29 @@ fail:
> >>>>                 "Failed to initiate service discovery after Service =
Changed");
> >>>>  }
> >>>>
> >>>> +static void process_db_out_of_sync(struct bt_gatt_client *client,
> >>>> +                                  uint8_t att_ecode)
> >>>> +{
> >>>> +       struct service_changed_op *op;
> >>>> +
> >>>> +       if (att_ecode !=3D BT_ATT_ERROR_DB_OUT_OF_SYNC)
> >>>> +               return;
> >>>> +
> >>>> +       DBG(client, "Database Out of Sync - triggering full re-disco=
very");
> >>>> +
> >>>> +       if (!client->in_svc_chngd) {
> >>>> +               process_service_changed(client, 0x0001, 0xffff);
> >>>> +               return;
> >>>> +       }
> >>>> +
> >>>> +       op =3D new0(struct service_changed_op, 1);
> >>>> +
> >>>> +       op->start_handle =3D 0x0001;
> >>>> +       op->end_handle =3D 0xffff;
> >>>> +
> >>>> +       queue_push_tail(client->svc_chngd_queue, op);
> >>>> +}
> >>>
> >>> Id just change process_error to call into db_out_sync, that said this
> >>> is not recovering at all, it just rediscovering but the original
> >>> request will be lost, I wonder if we should implement some backoff
> >>> logic wait to see if the server do a service changed, read the hash
> >>> (in case we are not doing it already), and then redo the operation.
> >>> Also we do need to make sure we don't end up in a loop rediscovery.
> >>
> >> At the beginning, we considered implementing recovery for failed ATT
> >> requests caused by a Database Out of Sync error. However, we identifie=
d
> >> potential risks in retrying some ATT requests after the remote device=
=E2=80=99s
> >> services have changed. For example, the handle in the ATT_READ_REQ PDU=
,
> >> which identifies the target attribute, may have changed on the remote
> >> device. Even if the retry succeeds, it might operate on the wrong
> >> attribute.
> >>
> >> As usual, any ATT response error will be propagated to the application
> >> layer, so the operation will not be lost but will fail. We did not mod=
ify
> >> this behavior.
> >
> > We do recovery for encryption/pairing errors.
>
> Sorry for the confusion. I meant that the Database Out of Sync error is
> directly propagated to the bluetoothctl console, whereas not all errors
> are.
>
> >
> >> It may not be appropriate to implement recovery logic for failed ATT
> >> requests at the BlueZ host layer. Therefore, we only do a rediscovery
> >> as required by the Core Spec, Vol. 3, Part G, Section 2.5.2.1,
> >> after receiving a Database Out of Sync error.
> >>
> >> For the suggestion about back-off logic,
> >>
> >> We are considering reading the remote database hash and comparing it
> >> with the locally stored hash before initiating rediscovery. If reading
> >> the remote database hash fails, we will assume that the remote GATT
> >> database has changed and proceed with rediscovery immediately.
> >>
> >> As shown below, the client checks the remote database hash after
> >> receiving a Database Out of Sync error. If the remote services have
> >> changed, the client initiates rediscovery.
> >>
> >> btmon HCI Logs:
> >>> ACL Data RX: Handle 2 flags 0x02 dlen 9
> >>       ATT: Error Response (0x01) len 4
> >>         Read Request (0x0a)
> >>         Handle: 0x000d
> >>         Error: Database Out of Sync (0x12)
> >> bluetoothd[57993]: < ACL Data TX: Handle 2 flags 0x00 dlen 11
> >>       ATT: Read By Type Request (0x08) len 6
> >>         Handle range: 0x0001-0xffff
> >>         Attribute type: Database Hash (0x2b2a)
> >>> HCI Event: Number of Completed Packets (0x13) plen 5
> >>         Num handles: 1
> >>         Handle: 2
> >>         Count: 1
> >>> ACL Data RX: Handle 2 flags 0x02 dlen 24
> >>       ATT: Read By Type Response (0x09) len 19
> >>         Attribute data length: 18
> >>         Attribute data list: 1 entry
> >>         Handle: 0x000f
> >>         Value: 10d6a00f95bb0eeec55a097ccf7dead8
> >> bluetoothd[57993]: < ACL Data TX: Handle 2 flags 0x00 dlen 11
> >>       ATT: Read By Type Request (0x08) len 6
> >>         Handle range: 0x0010-0xffff
> >>         Attribute type: Database Hash (0x2b2a)
> >>> HCI Event: Number of Completed Packets (0x13) plen 5
> >>         Num handles: 1
> >>         Handle: 2
> >>         Count: 1
> >>> ACL Data RX: Handle 2 flags 0x02 dlen 9
> >>       ATT: Error Response (0x01) len 4
> >>         Read By Type Request (0x08)
> >>         Handle: 0x0010
> >>         Error: Attribute Not Found (0x0a)
> >
> > I don't recall if we have this behavior earlier of using Read By Type
> > request for hash in the beginning? We need to limit the results to one
> > and not proceed to read it again since it is supposed to exist only
> > once in the database. Anyway I don't see a problem if we do read the
> > hash and that didn't change we should probably go ahead and resend the
>
> I checked this and found that the stored hash value in the database
> would only be updated at the beginning of a connection, using Read By
> Type request. The process of service changed indication will not update
> the stored hash value.
>
> I read cache file after a service changed indication done, it shows:
> ------------------
> [Attributes]
> .....
> 000e=3D2803:000f:02:f74347d19eef647d97f0b2f7af502e33: \
> 00002b2a-0000-1000-8000-00805f9b34fb
> .....
> ------------------
>
> Then I read database hash from remote device, it shows:
> ------------------
> [:/service0008/char000e]# read
> Attempting to read
> /org/bluez/hci0/dev_C8_A3_E8_DD_3D_cC/service0oo8/char000e
> [:/service0008/char000e]# [CHG] Attribute
> /org/bluez/hci0/dev_C8_A3_E8_DD_3D_CC/service0008/char00e Value:
> [:/service0008/char000e]# 0f 15 81 0b e0 c9 55 66 7e 2f f8 73 37 16 88 bc
> [:/service0008/char000e]# 0f 15 81 0b e0 c9 55 66 7e 2f f8 73 37 16 88 bc
> ------------------
>
> The stored hash value is not updated. Based on this, it seems to be safe
> to resend the original request if hash values are the same, since there
> are no risks of critical section operations between handling Service
> Changed Indication and handling Database Out of Sync error. We will add
> resend logic for this condition.
>
>
> > original request, in the meantime if we receive a service changed we
> > can narrow down the range that needs to be rediscovered and not use
>
> Sure. Since we reuse the process_service_changed(), we are capable of
> knowing that the Service Changed Indication comes simultaneously under
> certain conditions. We will not append a full range rediscovery to the
> client->svc_chngd_queue if client->in_svc_chngd is true.
>
> > 0x0001-0xffff as bellow, and we can actually perform recovery also in
> > case the service changed don't affect the original operation handle.
>
> Unlike the Service Changed indication, the Database Out of Sync error
> provides no information about the affected range. Consequently, we cannot
> determine whether the original operation handle is impacted. By the way,
> Service Changed characteristic is not readable, so we can not get effect
> from it either.

Service Changed must always be generated in case the database changes,
otherwise it would be broken with legacy devices that don't use the db
hash, and since the later is the reason for the server to send out of
sync we can infer what is the affected range and either do the resend
before or after handing the rediscover on the Service Changed range,
either way it should be possible to recover from out of sync errors
automatically. If the remote misbehaves, or is just playing tricks
with out of sync error to force the stack to rediscover the whole db,
we should just wait a short grace time and if it doesn't send the
service changed on then we should initiate a full rediscover.

> >
> >> bluetoothd[57993]: < ACL Data TX: Handle 2 flags 0x00 dlen 11
> >>       ATT: Read By Group Type Request (0x10) len 6
> >>         Handle range: 0x0001-0xffff
> >>         Attribute group type: Primary Service (0x2800)
> >>
> >>>
> >>>>  static void service_changed_cb(uint16_t value_handle, const uint8_t=
 *value,
> >>>>                                         uint16_t length, void *user_=
data)
> >>>>  {
> >>>> @@ -2709,10 +2732,12 @@ static void read_multiple_cb(uint8_t opcode,=
 const void *pdu, uint16_t length,
> >>>>                         (!pdu && length)) {
> >>>>                 success =3D false;
> >>>>
> >>>> -               if (opcode =3D=3D BT_ATT_OP_ERROR_RSP)
> >>>> +               if (opcode =3D=3D BT_ATT_OP_ERROR_RSP) {
> >>>>                         att_ecode =3D process_error(pdu, length);
> >>>> -               else
> >>>> +                       process_db_out_of_sync(req->client, att_ecod=
e);
> >>>> +               } else {
> >>>>                         att_ecode =3D 0;
> >>>> +               }
> >>>>
> >>>>                 pdu =3D NULL;
> >>>>                 length =3D 0;
> >>>> @@ -2864,6 +2889,7 @@ static void read_long_cb(uint8_t opcode, const=
 void *pdu,
> >>>>         if (opcode =3D=3D BT_ATT_OP_ERROR_RSP) {
> >>>>                 success =3D false;
> >>>>                 att_ecode =3D process_error(pdu, length);
> >>>> +               process_db_out_of_sync(req->client, att_ecode);
> >>>>                 goto done;
> >>>>         }
> >>>>
> >>>> @@ -3050,6 +3076,7 @@ static void write_cb(uint8_t opcode, const voi=
d *pdu, uint16_t length,
> >>>>         if (opcode =3D=3D BT_ATT_OP_ERROR_RSP) {
> >>>>                 success =3D false;
> >>>>                 att_ecode =3D process_error(pdu, length);
> >>>> +               process_db_out_of_sync(req->client, att_ecode);
> >>>>                 goto done;
> >>>>         }
> >>>>
> >>>> @@ -3213,6 +3240,7 @@ static void execute_write_cb(uint8_t opcode, c=
onst void *pdu, uint16_t length,
> >>>>         if (opcode =3D=3D BT_ATT_OP_ERROR_RSP) {
> >>>>                 success =3D false;
> >>>>                 att_ecode =3D process_error(pdu, length);
> >>>> +               process_db_out_of_sync(req->client, att_ecode);
> >>>>         } else if (opcode !=3D BT_ATT_OP_EXEC_WRITE_RSP || pdu || le=
ngth)
> >>>>                 success =3D false;
> >>>>
> >>>> @@ -3278,6 +3306,7 @@ static void prepare_write_cb(uint8_t opcode, c=
onst void *pdu, uint16_t length,
> >>>>         if (opcode =3D=3D BT_ATT_OP_ERROR_RSP) {
> >>>>                 success =3D false;
> >>>>                 att_ecode =3D process_error(pdu, length);
> >>>> +               process_db_out_of_sync(req->client, att_ecode);
> >>>>                 goto done;
> >>>>         }
> >>>>
> >>>> @@ -3447,6 +3476,7 @@ static void prep_write_cb(uint8_t opcode, cons=
t void *pdu, uint16_t length,
> >>>>                 success =3D false;
> >>>>                 reliable_error =3D false;
> >>>>                 att_ecode =3D process_error(pdu, length);
> >>>> +               process_db_out_of_sync(req->client, att_ecode);
> >>>>                 goto done;
> >>>>         }
> >>>>
> >>>> @@ -3597,6 +3627,7 @@ static void exec_write_cb(uint8_t opcode, cons=
t void *pdu, uint16_t length,
> >>>>         if (opcode =3D=3D BT_ATT_OP_ERROR_RSP) {
> >>>>                 success =3D false;
> >>>>                 att_ecode =3D process_error(pdu, length);
> >>>> +               process_db_out_of_sync(req->client, att_ecode);
> >>>>                 goto done;
> >>>>         }
> >>>>
> >>>> --
> >>>> 2.34.1
> >>>>
> >>>>
> >>>
> >>>
> >>
> >
> >
>


--=20
Luiz Augusto von Dentz
