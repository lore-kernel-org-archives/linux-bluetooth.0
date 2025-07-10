Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED362EF2BA;
	Thu, 10 Jul 2025 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163857; cv=none; b=A4tpx/bZyMgBsEUXK88Bb+8616lUl9L6CNWkkGBM4M34gfcRptcbN3PYjfXsvGV1pyQikfxG5v28zFOtKW5gGiyJy6eJflRwIUnCGieJx7u8sDepLZTL4u0UB49GeqZPRoPIBloTsXtxugI+o+6GcuJiiAjeEQ4FD/KpKWTRwPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163857; c=relaxed/simple;
	bh=ISHB/Po+9eQX62wK6KPfaqD9bGDamlEMD8Y4kO6UsLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5IWJ6zfndigr5TBEHMfkivIrsiptgXYGmvbRpoXCkpZAoS03ZMFpytFCyOOegDHrteCvonJtk+mZ/Z0ntOgPSLMoRatrinNU7V7v18ZwxiX4tqzJRcwKt09/IeMVhilM88RxoTzwmSyqQ+J08x/3XfEwjJ9qWb2ssVyacOOaYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gfaa8w5L; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gfaa8w5L"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32b5931037eso8794401fa.2;
        Thu, 10 Jul 2025 09:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752163854; x=1752768654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67MsjhFku0WddwVZP0eBGDYOy/yKGnEa9ZGOUZttChI=;
        b=Gfaa8w5LY3GRS40J3t2P8rmy+t6Q7Sx7YTnmembi2v25hOmnKLtXAp8xZCXCY0et34
         +F3hDxoJiWT2K4Q8WIz9c8WBT2OUJ7W9yEIKyUtxFvfbMH2XJhv+KNdJy4llWKzwNS1S
         xaYAbmE/tqiuqiuWZ8r+VlS/D13VNcrEyq9YjlzITEx3yCDX99VksptPZ26Owd079Pn0
         Yq0RJ+eYq1wcma4DrYcyTNzoHLfzLgQ+ETDbTQi6sz9wp6LRcbZUt8Oly8RhsCTQz+8J
         by9MfHG5QZnqtFenarBPvOqLPSXcKBnfbIKgsnUeDDSfYlp3wWaKdFBZLqv6EUYMLOyT
         Qd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163854; x=1752768654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67MsjhFku0WddwVZP0eBGDYOy/yKGnEa9ZGOUZttChI=;
        b=oBil6KferQekag/t5bd7izQnBgtGKM4tjBxrnnOz/vZfKKazRQpfYElEfcjkQ+KNb8
         IOFF4/Jw2oblU70ZeCASooE9xtNcDXmu9XWMs188jyyqc8s2+8dw7hY4roFzAQyybvHQ
         +RSZER0BIHy0XZhwLtvQkeSDGrUbawE+Da0aa3v/qjcE9IUHahdvMNg+Ec2CJ+jZE/4V
         A2jMSL9n+nzy4hFsIC4vmLx7b5/pdpmr++reGsVQgfu3TY0LIYIZCoVJKObf5yCWuDB2
         Up3ZrBw5Uqc8MBu7ig4wMJUFgGsqdVfiTzXgC4ukybQgm+0Pe2BO2MZycOvVK+GIXJim
         ogfA==
X-Forwarded-Encrypted: i=1; AJvYcCWBFjHJRFynxCgwA6AdhF5+VsB9kvaJzPP+FaFlHHF+76lxtwbcqa2yLN3gTxHdoNsYklDvK8YJTflyGUbsTqc=@vger.kernel.org, AJvYcCWMxMAXpqdDAdAtgAAgUqpTt2vS1zbyT8GR43NgaL+UppKBQ/0TImRl1Dx0L+w+oPRQOhKa7LAKxdZn3qrP@vger.kernel.org
X-Gm-Message-State: AOJu0Ywld4+8Oq5ikFYVGG9CtZ8TwLnsjhespLwTXOTOdBevyNXI/Ohi
	Y82BzebW0RYBUIMI9e7JTc7O+HjKPxzk9q0EnK18KSjF1s38UOMVKlfGoLQa+pulNq17fCmIkAH
	3W2OTYl9IafPhCOWNFnOGeDIk7aIvlnE=
X-Gm-Gg: ASbGncvae9DeAC4cvW/FnT+yRwSCT+0IuxVbgoK+iLzomZJnauOep3yUdtoHlyVjqAm
	zArMAbIWkWDRhW6MfU0QfJ0FHkd2k2yB4Tau6tfqqP6QJFk9ZsCqTn6iU+UKn4tcZocTCMNvrU2
	odAa1oJ6c7c5ODixGbLVERrkSQ8bSBJmAHPavXPKGLqw==
X-Google-Smtp-Source: AGHT+IFQHq9IoXlt7friTmhpyw8xEhMPg1PD3fwChm+XElxb+A/WPAnmU6OWqONd3BOXxtbD2+ZKBZ7B8MjEB9+P3oI=
X-Received: by 2002:a05:651c:2117:b0:32b:805e:20d9 with SMTP id
 38308e7fff4ca-32f485ba328mr24797751fa.38.1752163853406; Thu, 10 Jul 2025
 09:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708124516.2836881-1-hildawu@realtek.com> <20250708124516.2836881-2-hildawu@realtek.com>
In-Reply-To: <20250708124516.2836881-2-hildawu@realtek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 10 Jul 2025 12:10:40 -0400
X-Gm-Features: Ac12FXxHapfqDo_3N2VL0d9LAQRHEug1P_zqHODz7Ai-McvVHopDASLuyVPilVA
Message-ID: <CABBYNZJWYNJLpHG-ZGWyGS0DvY_gAtHmsQexsXtOeNvPymsBLg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] Bluetooth: btrtl: Add enhanced download support
To: Hilda Wu <hildawu@realtek.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex_lu@realsil.com.cn, max.chou@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hilda,

On Tue, Jul 8, 2025 at 8:45=E2=80=AFAM Hilda Wu <hildawu@realtek.com> wrote=
:
>
> Add an enhanced download mode for firmware format v3.
> Use ACL to speed up firmware downloads.
>
> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> Signed-off-by: Hilda Wu <hildawu@realtek.com>
> ---
> Change in V3:
> - Avoiding memory leak
>
> Change in V2:
> - Move structure to btrtl.h
> - Fix build warnings
> ---
> ---
>  drivers/bluetooth/btrtl.c | 193 +++++++++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btrtl.h |  20 ++++
>  2 files changed, 211 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index af28f5355aa1..27df5e439e89 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -108,6 +108,8 @@ struct btrtl_device_info {
>         u32 opcode;
>         u8 fw_type;
>         u8 key_id;
> +       u16 handle;
> +       u16 acldata_pkt_len;
>         struct list_head patch_subsecs;
>         struct list_head patch_images;
>  };
> @@ -1310,6 +1312,163 @@ static int rtl_check_download_state(struct hci_de=
v *hdev,
>         return 0;
>  }
>
> +static int btrtl_enhanced_download_mode_enable(struct hci_dev *hdev,
> +                                       struct btrtl_device_info *btrtl_d=
ev)
> +{
> +       struct hci_rp_enhanced_download_mode *ev;
> +       struct sk_buff *skb;
> +       u16 opcode =3D 0xfc1f;
> +       u8 val =3D 1;
> +       int ret =3D -EINVAL;
> +
> +       skb =3D __hci_cmd_sync(hdev, opcode, 1, &val, HCI_CMD_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               bt_dev_err(hdev, "send %04x error (%lu)", opcode, PTR_ERR=
(skb));
> +               return -EIO;
> +       }
> +       if (skb->len !=3D sizeof(*ev)) {
> +               bt_dev_err(hdev, "got invalid cmd complete, %u %zu", skb-=
>len,
> +                          sizeof(*ev));
> +               goto err;
> +       }
> +       ev =3D (struct hci_rp_enhanced_download_mode *)skb->data;

Use skb_pull_data above.

> +       if (ev->status) {
> +               bt_dev_err(hdev, "got invalid status 0x%02x", ev->status)=
;
> +               goto err;
> +       }
> +       btrtl_dev->handle =3D le16_to_cpu(ev->handle);
> +       btrtl_dev->acldata_pkt_len =3D le16_to_cpu(ev->acldata_pkt_len);
> +       kfree_skb(skb);
> +
> +       bt_dev_info(hdev, "enhanced download mode enabled, handle %04x, a=
cl %u",
> +                   btrtl_dev->handle, btrtl_dev->acldata_pkt_len);

Don't think the users need to see this message, please use bt_dev_dbg
for debug messages.

> +       return 0;
> +err:
> +       kfree_skb(skb);
> +       return ret;
> +}
> +
> +static int rtl_acl_download_firmware(struct hci_dev *hdev,
> +                                    struct btrtl_device_info *btrtl_dev,
> +                                    const unsigned char *data, int fw_le=
n)
> +{
> +       struct btrealtek_data *btrtl_data =3D hci_get_priv(hdev);
> +       int frag_num =3D fw_len / RTL_FRAG_LEN + 1;
> +       int frag_len =3D RTL_FRAG_LEN;
> +       int ret =3D 0;
> +       int i;
> +       int j =3D 0;
> +       struct sk_buff *skb;
> +       struct rtl_acl_download_rp *rp;
> +       u16 max_payload_len;
> +       struct hci_acl_hdr *hdr;
> +       u8 index;
> +
> +       if (is_v3_fw(btrtl_dev->fw_type))
> +               j =3D 1;
> +
> +       btrtl_data->dlreq_status =3D 0;
> +       btrtl_data->dlreq_result =3D 0;
> +       btrtl_data->dlreq_rsp =3D NULL;
> +       max_payload_len =3D (btrtl_dev->acldata_pkt_len - 1) & ~0x3;
> +
> +       for (i =3D 0; i < frag_num; i++) {
> +               index =3D j++;
> +               if (index =3D=3D 0x7f)
> +                       j =3D 1;
> +
> +               if (i =3D=3D (frag_num - 1) && !is_v3_fw(btrtl_dev->fw_ty=
pe)) {
> +                       index |=3D 0x80; /* data end */
> +                       frag_len =3D fw_len % max_payload_len;
> +               }
> +               rtl_dev_dbg(hdev, "acl download fw (%d/%d). index =3D %d"=
, i,
> +                           frag_num, index);
> +
> +               skb =3D bt_skb_alloc(sizeof(*hdr) + 1 + frag_len, GFP_KER=
NEL);
> +               if (!skb)
> +                       return -ENOMEM;
> +               hdr =3D (struct hci_acl_hdr *)skb_put(skb, sizeof(*hdr));
> +               hdr->handle =3D cpu_to_le16(btrtl_dev->handle | 0x8000);
> +               hdr->dlen =3D cpu_to_le16(1 + frag_len);
> +               *(u8 *)skb_put(skb, 1) =3D index;
> +               memcpy(skb_put(skb, frag_len), data, frag_len);
> +
> +               hci_skb_pkt_type(skb) =3D HCI_ACLDATA_PKT;
> +
> +               btrtl_data->dlreq_status =3D HCI_REQ_PEND;
> +
> +               ret =3D hdev->send(hdev, skb);
> +               if (ret < 0) {
> +                       bt_dev_err(hdev, "sending frame failed (%d)", ret=
);
> +                       goto err;
> +               }
> +
> +               ret =3D wait_event_interruptible_timeout(btrtl_data->dlre=
q_wait_q,
> +                               btrtl_data->dlreq_status !=3D HCI_REQ_PEN=
D,
> +                               HCI_INIT_TIMEOUT);
> +               if (ret =3D=3D -ERESTARTSYS)
> +                       goto out;
> +
> +               switch (btrtl_data->dlreq_status) {
> +               case HCI_REQ_DONE:
> +                       ret =3D -bt_to_errno(btrtl_data->dlreq_result);
> +                       break;
> +
> +               case HCI_REQ_CANCELED:
> +                       ret =3D -btrtl_data->dlreq_result;
> +                       break;
> +
> +               default:
> +                       ret =3D -ETIMEDOUT;
> +                       break;
> +               }
> +
> +               btrtl_data->dlreq_status =3D 0;
> +               btrtl_data->dlreq_result =3D 0;
> +               skb =3D btrtl_data->dlreq_rsp;
> +               btrtl_data->dlreq_rsp =3D NULL;
> +
> +               bt_dev_dbg(hdev, "end: err %d", ret);
> +
> +               if (ret < 0) {
> +                       bt_dev_err(hdev, "wait on complete err (%d)", ret=
);
> +                       goto err;
> +               }
> +
> +               if (!skb)
> +                       return -ENODATA;
> +
> +               if (skb->len !=3D sizeof(*rp)) {
> +                       rtl_dev_err(hdev, "acl download fw event len mism=
atch");
> +                       ret =3D -EIO;
> +                       goto err;
> +               }
> +               rp =3D (struct rtl_acl_download_rp *)skb->data;

Ditto, use skb_pull_data.

> +               if ((btrtl_dev->handle & 0xfff) !=3D le16_to_cpu(rp->hand=
le)) {
> +                       rtl_dev_err(hdev, "handle mismatch (%04x %04x)",
> +                                   btrtl_dev->handle & 0xfff,
> +                                   le16_to_cpu(rp->handle));
> +                       ret =3D -EINVAL;
> +                       goto err;
> +               }
> +               if (index !=3D rp->index) {
> +                       rtl_dev_err(hdev, "index mismatch (%u, %u)", inde=
x,
> +                                   rp->index);
> +                       ret =3D -EINVAL;
> +                       goto err;
> +               }
> +
> +               kfree_skb(skb);
> +               data +=3D frag_len;
> +       }
> +out:
> +       return ret;
> +err:
> +       kfree_skb(skb);
> +       return ret;
> +}
> +
>  static int rtl_finalize_download(struct hci_dev *hdev,
>                                  struct btrtl_device_info *btrtl_dev)
>  {
> @@ -1394,6 +1553,7 @@ static int rtl_download_firmware_v3(struct hci_dev =
*hdev,
>         struct rtl_section_patch_image *image, *tmp;
>         struct rtl_rp_dl_v3 *rp;
>         struct sk_buff *skb;
> +       u8 enh_dl =3D 0;
>         u8 *fw_data;
>         int fw_len;
>         int ret =3D 0;
> @@ -1408,6 +1568,16 @@ static int rtl_download_firmware_v3(struct hci_dev=
 *hdev,
>                 }
>         }
>
> +       switch (btrtl_dev->project_id) {
> +       case CHIP_ID_8852C:
> +       case CHIP_ID_8922D:
> +               if (!btrtl_enhanced_download_mode_enable(hdev, btrtl_dev)=
)
> +                       enh_dl =3D 1;
> +               break;
> +       default:
> +               break;
> +       }
> +
>         list_for_each_entry_safe(image, tmp, &btrtl_dev->patch_images, li=
st) {
>                 rtl_dev_dbg(hdev, "image (%04x:%02x)", image->image_id,
>                             image->index);
> @@ -1446,8 +1616,13 @@ static int rtl_download_firmware_v3(struct hci_dev=
 *hdev,
>                 rtl_dev_dbg(hdev, "fw_data %p, image buf %p, len %u", fw_=
data,
>                             image->image_data, image->image_len);
>
> -               ret =3D rtl_download_firmware(hdev, btrtl_dev->fw_type, f=
w_data,
> -                                           fw_len);
> +               if (enh_dl)
> +                       ret =3D rtl_acl_download_firmware(hdev, btrtl_dev=
,
> +                                                       fw_data, fw_len);
> +               else
> +                       ret =3D rtl_download_firmware(hdev, btrtl_dev->fw=
_type,
> +                                                   fw_data, fw_len);
> +
>                 kvfree(fw_data);
>                 if (ret < 0) {
>                         rtl_dev_err(hdev, "download firmware failed (%d)"=
, ret);
> @@ -1705,6 +1880,7 @@ struct btrtl_device_info *btrtl_initialize(struct h=
ci_dev *hdev,
>
>         INIT_LIST_HEAD(&btrtl_dev->patch_subsecs);
>         INIT_LIST_HEAD(&btrtl_dev->patch_images);
> +       init_waitqueue_head(&btrtl_data->dlreq_wait_q);
>
>  check_version:
>         ret =3D btrtl_read_chip_id(hdev, &chip_id);
> @@ -2025,6 +2201,7 @@ EXPORT_SYMBOL_GPL(btrtl_shutdown_realtek);
>
>  int btrtl_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
>  {
> +       struct btrealtek_data *btrtl_data =3D hci_get_priv(hdev);
>         struct hci_event_hdr *hdr =3D (void *)skb->data;
>
>         if (skb->len > HCI_EVENT_HDR_SIZE && hdr->evt =3D=3D 0xff &&
> @@ -2032,6 +2209,18 @@ int btrtl_recv_event(struct hci_dev *hdev, struct =
sk_buff *skb)
>                 if (skb->data[2] =3D=3D 0x77 &&
>                     btrealtek_test_and_clear_flag(hdev, REALTEK_DOWNLOADI=
NG)) {
>                         btrealtek_wake_up_flag(hdev, REALTEK_DOWNLOADING)=
;
> +                       /* skb should be free here. */
> +                       kfree_skb(skb);
> +                       return 0;
> +               } else if (skb->data[2] =3D=3D 0x2a) {

These accesses of skb->data probably need to be removed, even if you
are doing some checks for skb->len it is probably more readable to use
skb_pull_data, we may as well route the vendor events (0xff) from
hci_event.c with usage of an hci_ev table the driver can register to
avoid the drivers having to intercept the events like in the above.

> +                       if (btrtl_data->dlreq_status =3D=3D HCI_REQ_PEND)=
 {
> +                               btrtl_data->dlreq_result =3D 0;
> +                               btrtl_data->dlreq_status =3D HCI_REQ_DONE=
;
> +                               skb_pull(skb, sizeof(*hdr));
> +                               btrtl_data->dlreq_rsp =3D skb_get(skb);
> +                               wake_up_interruptible(&btrtl_data->dlreq_=
wait_q);
> +                       }
> +                       kfree_skb(skb);
>                         return 0;
>                 }
>         }
> diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
> index f6f03a5fefba..7f15b30680d7 100644
> --- a/drivers/bluetooth/btrtl.h
> +++ b/drivers/bluetooth/btrtl.h
> @@ -203,8 +203,28 @@ struct btrealtek_data {
>         DECLARE_BITMAP(flags, __REALTEK_NUM_FLAGS);
>
>         struct rtl_dump_info rtl_dump;
> +
> +       wait_queue_head_t       dlreq_wait_q;
> +       __u32                   dlreq_status;
> +       __u32                   dlreq_result;
> +       struct sk_buff          *dlreq_rsp;
>  };
>
> +struct rtl_acl_download_rp {
> +       __u8 subevent;
> +       __u8 index;
> +       __le16 handle;
> +       __le32 loaded_len;
> +} __packed;
> +
> +struct hci_rp_enhanced_download_mode {
> +       __u8 status;
> +       __u8 reserved1;
> +       __le16 handle;
> +       __le16 acldata_pkt_len;
> +       __u8 reserved2;
> +} __packed;
> +
>  #define btrealtek_set_flag(hdev, nr)                                   \
>         do {                                                            \
>                 struct btrealtek_data *realtek =3D hci_get_priv((hdev)); =
 \
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
