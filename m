Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBAF46C848
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514818; cv=pass; b=Lnfj1IJJy6qhoBDLEudN36E8P7AYdzaHo8Sz0nL2R5pV44EV0yRXEvbsE+rAzCHd+c+Aya66K2oC2uHpAEEAzIzM4CBnkLxwe8JsjzESWOOdjKw4EXtg+lUU0Q3DAKD2pc7paJMXLexekE9dGqdaCOTEW93FrBGeLR2n0fuXZWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514818; c=relaxed/simple;
	bh=wjLpdoDwkaJT+VxWHf4cNI+aM2CE4+3a29T/VMfcNwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9gBeR1E2jlhNciGHdyQzvm4eF0sEnm/w1Z+m5wyjIyaDdZR91rtCEzxQfLb8XZcebdwfOLvPBVTD/+HFCL0/at2qqQ+YX4Atps7HLzYjentFJkr5NT/82ZcbbP2FCWLVl0d8Nre2xi0OAxlm2qOvblW4E41T3SMxKWLYmdXv0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IN0F/d2v; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IN0F/d2v"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81ed2a00f12so17280887b3.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 09:20:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785514805; cv=none;
        d=google.com; s=arc-20260327;
        b=ma2rIzL7yIeWHA+2mvln8Ad8db7bRpsGtEptm53aO9Kv+H/fOS/3mLyqBKO8kjIfpD
         h9GZ/o1Z7OzwmxlHbzcOEtifgEWyIrbarlGQimt8c8tl87F/JihiMSbdTfLX3rj+7RUs
         wR4OiEWTRcNmhdsAlUrRYzCrCVjFs0kW6tyPjwvGXZj5iPp0eqnvh6i502IIVBkX5dSi
         0vKYT5EaFmW4bDusqXQCoP1vXK8kvrCTlrOIiZbu0R6NUpgmuUw+uUBfW87cEOWxZBdu
         zK9ZC1Umnz6CNUPgCVXKj40BiyFzK+973pDI7gt0QfNqoZymWYLbAc1dqAYBHQbGFuc7
         SLWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yCULnJco8gaTEp7zxl3li7Ik1reSj0lzDw4rIk21mOU=;
        fh=dwl5VjatbW6W+yBgZw0bxCMs+YFp9WOREj6+O/QQRsw=;
        b=GSdQjvzGr9qxH2BR/ElXWou2Hg8dZM9GsSbU/3A8oxtJvtaadTjv/HhnxsGg3KIF49
         T6BwkrGF9xqulT2B54P+59ieEaHTrZYt3aRb9cqh1WEA34cgeSCJwatfvUVKwDNrvFd0
         vwVAP+mHMfKxIoGlWg3FaIDAkTElhc+LRVQadTBiG0Vlv3DyLvehhVctFKvKJS//tR9B
         OAEeNonJccXkuyrj16Xd4/Uu6NQpWb/8SJ1QBKuKjWjcOcMybex1ebJQLLM+PyxT31YT
         EswT2IqivJ3f6XZHKWGf9ehssf/CVSv6oBmZij0fuOKDBbb0LJ1SCnGW6xBYazEgmz3Z
         s7xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785514805; x=1786119605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yCULnJco8gaTEp7zxl3li7Ik1reSj0lzDw4rIk21mOU=;
        b=IN0F/d2v+C/MA7frkUb50nK3znVTKxsVUtPJ5RYSlidl/yibQ8UzZHKoBR1t+uRlmN
         8rAJ7e/twQk8gvSikIreE85FwvlTnFqGDKocnWYkYxvNsHw6M+TOf1HBZLi8AqHVYeVv
         MpOQdi2hvaL3S4sVyO2rSdclF0Jggd0seXNLXAMfoWlouUBmt/atnCqtt4hB/tpLY272
         jGCsSy2qNP1roeGqPyHVnZXJwvBdi/nf8pvlFEEIsV42muRqJ7REINE/OtCHaijfG9GE
         s9/xYIW5xEFBO96cunBcoZCeSjSwxBNRgqKhr+ho0AOVeDedsCPEk1qe6EFEC/DakVAu
         AbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785514805; x=1786119605;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yCULnJco8gaTEp7zxl3li7Ik1reSj0lzDw4rIk21mOU=;
        b=n7XESxPkyVptkcTFhdegILzhXeey7X+76WZLGKRdLCtnQKM+WYhAyyTkllY5Hqw+6Y
         lKYhfLSX8sxlWmEdWh7ne4VRYHzWO+kC7/ubAF5jsmuwOzkIUmsKc6jNGiLpubGBSDfR
         j0vQgB0V1YG2DH7OnBtQhLwm/sZyFA0QQJVhGetvTwnTFEWDcgL3HmMzrAlQgbdiBqHd
         Xbg+QzSPvguFTM1fbkwIaN0bBZbOx0Gk2enjeOF0T/hMXhUM5HyhiTrHhNUPUELwduuE
         yKdbisOoJj8PDk+O7dc4YjjhK3+4g4+rqPxMdwX3uJ1zCR2YEjbDVkG3aMRQgIvtE+5b
         +3qA==
X-Forwarded-Encrypted: i=1; AHgh+Rpi6Ci98iIUGkM/a71ng69RgFslpGu+ZwFRBocjzjSVzpkhDvMrTLPPmofZcEn51aTR2B5n6buQR5sYNoea22k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKdvZtRQxdzyINcMwLBMEZDHRMA54KbneLydo0Dne4IoFaveoQ
	5Wclv9kYk1qZZPaw41ACsIjf+3gXi7sWatgNZd+ZkPFut31WO1FQ1ctOGqNxV8PyerHX6X6Ep0D
	OJYGVsswzL27NMI3ZeVh4SaLpdFqlAY3dre4g
X-Gm-Gg: AR+sD11S/dh0Ls0cslEbCS/gUbnjg5g02BqdoKjADg97pdmr4KH/MJZImyelMUM9iBl
	gza+6FUBzHBqf+rM2DwjFynlCO1YOL2APRf4m+58Pnix2GC98AutKW7Ms7xkN53xZs3Ah8SMb5w
	8lWg25CMUCbhSGXCoheOjI3gKqsx9hy2WfBNq4yYOH0ui6mEqstq1nbxaT8ufT9WlAPciAJIuLP
	d7W+hE8C7np85q++VnqJili/0tKnyQKrexwN6sIjxgGdCqCIsfckDE3gc3jCYwUZ5//kwbNgKrj
	G4B5c+lSqW+antGBJAONee4xK71YWl415DWECLhGDXsCcQpLOdIP4NS/EmBkMgXzmoVAXm1Op87
	kGblrrYVIoa15+Cz10vcX1D7hkxIZPxyvEYE=
X-Received: by 2002:a05:690c:f10:b0:81f:3dab:372f with SMTP id
 00721157ae682-81fd4a32817mr6542407b3.12.1785514804966; Fri, 31 Jul 2026
 09:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEzAHR-7LQak12o_Xt7QrvLHRw3GSLDgco6o7Fru-wVXyBW7mQ@mail.gmail.com>
 <3ebd064b6e7a9d3d8d72f1da618765affbd30cd7.1785459643.git.amirabudubai@gmail.com>
In-Reply-To: <3ebd064b6e7a9d3d8d72f1da618765affbd30cd7.1785459643.git.amirabudubai@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 31 Jul 2026 12:19:53 -0400
X-Gm-Features: AUfX_myT_wquKm7qvPRj8WJgjMNkDqDUw05lYE8_GjC0at05YDNrVAp7b7SDuTI
Message-ID: <CABBYNZKF8LQ-TzTnNkChHBiwLpRbbmi6pZQJ2yF1dNJWTKNqjw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_core: Queue out-of-order ACL packets
To: Amir Abudubai <amirabudubai@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amir,

On Thu, Jul 30, 2026 at 9:22=E2=80=AFPM Amir Abudubai <amirabudubai@gmail.c=
om> wrote:
>
> On some USB adapters, the interrupt-IN endpoint can lag behind the
> bulk-IN endpoint by multiple polling intervals. Early ACL data can
> then arrive before the Connection Complete event establishes its
> handle, causing packets to be dropped due to an unknown handle.
>
> To resolve this, add a queue to hold ACL traffic received with an
> unknown handle. Re-check queued packets after processing HCI events,
> and drop packets if they remain unmatched when the 4 ms timeout expires.
> Introduce HCI_QUIRK_OUT_OF_ORDER_ACL to restrict this behavior to
> transports that set the quirk.
>
> Add BT_HCIBTUSB_EARLY_ACL_HOLD to set the default behavior for USB
> adapters, along with a force_early_acl_hold debugfs entry to control
> it per adapter while the adapter is down.
>
> This issue was observed and the fix verified on:
> - 8087:0025 Intel Corp. Wireless-AC 9260 Bluetooth Adapter
> - 7392:c611 Edimax Technology Co., Ltd Edimax Bluetooth Adapter
>
> Assisted-by: OpenCode:openai/gpt-5.6-sol
> Signed-off-by: Amir Abudubai <amirabudubai@gmail.com>
> ---
> Hi Luiz,
>
> I worked on finding a simpler fix that didn't require adding latency,
> and this is what I got. I based it on Fluoride's fix for the same race
> condition. The main difference is doing it in HCI core, which comes
> out cleaner because all the logic for valid handles and timestamps is
> already in place.
>
>  drivers/bluetooth/Kconfig         |  12 ++++
>  drivers/bluetooth/btusb.c         |  59 ++++++++++++++++
>  include/net/bluetooth/bluetooth.h |   6 ++
>  include/net/bluetooth/hci.h       |   9 +++
>  include/net/bluetooth/hci_core.h  |   3 +
>  net/bluetooth/hci_core.c          | 111 +++++++++++++++++++++++++++---
>  net/bluetooth/hci_sync.c          |   6 ++
>  net/bluetooth/l2cap_core.c        |   2 +-
>  8 files changed, 199 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 4e8c24d757e9..027762e0da3f 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -56,6 +56,18 @@ config BT_HCIBTUSB_POLL_SYNC
>           Say Y here to enable USB poll_sync for Bluetooth USB devices by
>           default.
>
> +config BT_HCIBTUSB_EARLY_ACL_HOLD
> +       bool "Enable USB early ACL packet hold by default"
> +       depends on BT_HCIBTUSB
> +       default n
> +       help
> +         Hold ACL packets for a nominal 4 milliseconds when their connec=
tion
> +         handle has not been registered yet. This works around USB contr=
ollers
> +         whose event endpoint can lag behind their ACL data endpoint.
> +
> +         The default can be overridden per adapter using the
> +         force_early_acl_hold debugfs entry while the adapter is down.
> +
>  config BT_HCIBTUSB_BCM
>         bool "Broadcom protocol support"
>         depends on BT_HCIBTUSB
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index be82bbbc1b5c..2752bfb89670 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -34,6 +34,8 @@ static bool disable_scofix;
>  static bool force_scofix;
>  static bool enable_autosuspend =3D IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUS=
PEND);
>  static bool enable_poll_sync =3D IS_ENABLED(CONFIG_BT_HCIBTUSB_POLL_SYNC=
);
> +static bool enable_early_acl_hold =3D
> +       IS_ENABLED(CONFIG_BT_HCIBTUSB_EARLY_ACL_HOLD);
>  static bool reset =3D true;
>
>  static struct usb_driver btusb_driver;
> @@ -3964,6 +3966,57 @@ static const struct file_operations force_poll_syn=
c_fops =3D {
>         .llseek         =3D default_llseek,
>  };
>
> +static ssize_t force_early_acl_hold_read(struct file *file,
> +                                        char __user *user_buf, size_t co=
unt,
> +                                        loff_t *ppos)
> +{
> +       struct btusb_data *data =3D file->private_data;
> +       char buf[3];
> +
> +       buf[0] =3D hci_dev_test_flag(data->hdev,
> +                                  HCI_OUT_OF_ORDER_ACL_ENABLED) ? 'Y' : =
'N';
> +       buf[1] =3D '\n';
> +       buf[2] =3D '\0';
> +
> +       return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
> +}
> +
> +static ssize_t force_early_acl_hold_write(struct file *file,
> +                                         const char __user *user_buf,
> +                                         size_t count, loff_t *ppos)
> +{
> +       struct btusb_data *data =3D file->private_data;
> +       bool enabled;
> +       int err;
> +
> +       err =3D kstrtobool_from_user(user_buf, count, &enabled);
> +       if (err)
> +               return err;
> +
> +       /* Only allow changes while the adapter is down */
> +       if (test_bit(HCI_UP, &data->hdev->flags))
> +               return -EPERM;
> +
> +       if (hci_dev_test_flag(data->hdev, HCI_OUT_OF_ORDER_ACL_ENABLED) =
=3D=3D
> +           enabled)
> +               return -EALREADY;
> +
> +       if (enabled)
> +               hci_dev_set_flag(data->hdev, HCI_OUT_OF_ORDER_ACL_ENABLED=
);
> +       else
> +               hci_dev_clear_flag(data->hdev, HCI_OUT_OF_ORDER_ACL_ENABL=
ED);
> +
> +       return count;
> +}
> +
> +static const struct file_operations force_early_acl_hold_fops =3D {
> +       .owner          =3D THIS_MODULE,
> +       .open           =3D simple_open,
> +       .read           =3D force_early_acl_hold_read,
> +       .write          =3D force_early_acl_hold_write,
> +       .llseek         =3D default_llseek,
> +};
> +
>  #define BTUSB_HCI_DRV_OP_SUPPORTED_ALTSETTINGS \
>                 hci_opcode_pack(HCI_DRV_OGF_DRIVER_SPECIFIC, 0x0000)
>  #define BTUSB_HCI_DRV_SUPPORTED_ALTSETTINGS_SIZE       0
> @@ -4460,6 +4513,10 @@ static int btusb_probe(struct usb_interface *intf,
>         if (enable_autosuspend)
>                 usb_enable_autosuspend(data->udev);
>
> +       hci_set_quirk(hdev, HCI_QUIRK_OUT_OF_ORDER_ACL);
> +       if (enable_early_acl_hold)
> +               hci_dev_set_flag(hdev, HCI_OUT_OF_ORDER_ACL_ENABLED);
> +
>         data->poll_sync =3D enable_poll_sync;
>
>         err =3D hci_register_dev(hdev);
> @@ -4470,6 +4527,8 @@ static int btusb_probe(struct usb_interface *intf,
>
>         debugfs_create_file("force_poll_sync", 0644, hdev->debugfs, data,
>                             &force_poll_sync_fops);
> +       debugfs_create_file("force_early_acl_hold", 0644, hdev->debugfs, =
data,
> +                           &force_early_acl_hold_fops);
>
>         return 0;
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index b624da5026f5..19fd03103dff 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -486,6 +486,10 @@ struct mgmt_ctrl {
>         u16 opcode;
>  };
>
> +struct hci_acl_ctrl {
> +       unsigned long expires;
> +};
> +
>  struct bt_skb_cb {
>         u8 pkt_type;
>         u8 force_active;
> @@ -496,6 +500,7 @@ struct bt_skb_cb {
>         union {
>                 struct l2cap_ctrl l2cap;
>                 struct hci_ctrl hci;
> +               struct hci_acl_ctrl hci_acl;
>                 struct mgmt_ctrl mgmt;
>                 struct scm_creds creds;
>         };
> @@ -509,6 +514,7 @@ struct bt_skb_cb {
>  #define hci_skb_opcode(skb) bt_cb((skb))->hci.opcode
>  #define hci_skb_event(skb) bt_cb((skb))->hci.req_event
>  #define hci_skb_sk(skb) bt_cb((skb))->hci.sk
> +#define hci_skb_acl_expires(skb) bt_cb((skb))->hci_acl.expires
>
>  static inline struct sk_buff *bt_skb_alloc(unsigned int len, gfp_t how)
>  {
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index cd3520a29131..04b6bbc4c803 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -375,6 +375,14 @@ enum {
>          */
>         HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE,
>
> +       /* When this quirk is set, ACL packets received before their conn=
ection
> +        * handle is registered may be queued briefly. This can happen on
> +        * transports with separate event and ACL data channels.
> +        *
> +        * This quirk must be set before hci_register_dev is called.
> +        */
> +       HCI_QUIRK_OUT_OF_ORDER_ACL,
> +
>         __HCI_NUM_QUIRKS,
>  };
>
> @@ -468,6 +476,7 @@ enum {
>         HCI_OFFLOAD_CODECS_ENABLED,
>         HCI_LE_SIMULTANEOUS_ROLES,
>         HCI_CMD_DRAIN_WORKQUEUE,
> +       HCI_OUT_OF_ORDER_ACL_ENABLED,
>
>         HCI_MESH_EXPERIMENTAL,
>         HCI_MESH,
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 01b938c4b24a..f23b1a11e4b2 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -516,10 +516,12 @@ struct hci_dev {
>         struct work_struct      rx_work;
>         struct work_struct      cmd_work;
>         struct work_struct      tx_work;
> +       struct delayed_work     unknown_acl_work;
>
>         struct delayed_work     le_scan_disable;
>
>         struct sk_buff_head     rx_q;
> +       struct sk_buff_head     unknown_acl_q;
>         struct sk_buff_head     raw_q;
>         struct sk_buff_head     cmd_q;
>
> @@ -873,6 +875,7 @@ extern struct mutex hci_cb_list_lock;
>  /* ----- HCI interface to upper protocols ----- */
>  int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
>  int l2cap_disconn_ind(struct hci_conn *hcon);
> +/* The caller retains ownership of skb only when -ENOENT is returned. */
>  int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle, struct sk_buff =
*skb,
>                        u16 flags);
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 9d5adf882509..a6531926e0cd 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -47,6 +47,7 @@
>  static void hci_rx_work(struct work_struct *work);
>  static void hci_cmd_work(struct work_struct *work);
>  static void hci_tx_work(struct work_struct *work);
> +static void hci_unknown_acl_work(struct work_struct *work);
>
>  /* HCI device list */
>  LIST_HEAD(hci_dev_list);
> @@ -2511,6 +2512,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
>         INIT_WORK(&hdev->rx_work, hci_rx_work);
>         INIT_WORK(&hdev->cmd_work, hci_cmd_work);
>         INIT_WORK(&hdev->tx_work, hci_tx_work);
> +       INIT_DELAYED_WORK(&hdev->unknown_acl_work, hci_unknown_acl_work);
>         INIT_WORK(&hdev->power_on, hci_power_on);
>         INIT_WORK(&hdev->error_reset, hci_error_reset);
>
> @@ -2519,6 +2521,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
>         INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
>
>         skb_queue_head_init(&hdev->rx_q);
> +       skb_queue_head_init(&hdev->unknown_acl_q);
>         skb_queue_head_init(&hdev->cmd_q);
>         skb_queue_head_init(&hdev->raw_q);
>
> @@ -2669,6 +2672,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
>         disable_work_sync(&hdev->rx_work);
>         disable_work_sync(&hdev->cmd_work);
>         disable_work_sync(&hdev->tx_work);
> +       disable_delayed_work_sync(&hdev->unknown_acl_work);
>         disable_work_sync(&hdev->power_on);
>         disable_work_sync(&hdev->error_reset);
>         disable_delayed_work_sync(&hdev->cmd_timer);
> @@ -3793,8 +3797,11 @@ static void hci_tx_work(struct work_struct *work)
>
>  /* ----- HCI RX task (incoming data processing) ----- */
>
> +#define HCI_UNKNOWN_ACL_TIMEOUT_MS 4
> +
>  /* ACL data packet */
> -static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb=
)
> +static int hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb,
> +                             bool retry)
>  {
>         struct hci_acl_hdr *hdr;
>         __u16 handle, flags;
> @@ -3804,7 +3811,7 @@ static void hci_acldata_packet(struct hci_dev *hdev=
, struct sk_buff *skb)
>         if (!hdr) {
>                 bt_dev_err(hdev, "ACL packet too small");
>                 kfree_skb(skb);
> -               return;
> +               return -EINVAL;
>         }
>
>         handle =3D __le16_to_cpu(hdr->handle);
> @@ -3814,15 +3821,93 @@ static void hci_acldata_packet(struct hci_dev *hd=
ev, struct sk_buff *skb)
>         bt_dev_dbg(hdev, "len %d handle 0x%4.4x flags 0x%4.4x", skb->len,
>                    handle, flags);
>
> -       hdev->stat.acl_rx++;
> +       if (!retry)
> +               hdev->stat.acl_rx++;
>
>         err =3D l2cap_recv_acldata(hdev, handle, skb, flags);
> -       if (err =3D=3D -ENOENT)
> -               bt_dev_err(hdev, "ACL packet for unknown connection handl=
e %d",
> -                          handle);
> -       else if (err)
> +       if (err =3D=3D -ENOENT) {
> +               skb_push(skb, sizeof(*hdr));
> +               return err;
> +       }
> +
> +       if (err)
>                 bt_dev_dbg(hdev, "ACL packet recv for handle %d failed: %=
d",
>                            handle, err);
> +
> +       return err;
> +}
> +
> +static bool hci_unknown_acl_expired(struct sk_buff *skb)
> +{
> +       return time_after_eq(jiffies, hci_skb_acl_expires(skb));
> +}
> +
> +static u16 hci_unknown_acl_handle(struct sk_buff *skb)
> +{
> +       return hci_handle(le16_to_cpu(hci_acl_hdr(skb)->handle));
> +}
> +
> +static void hci_drop_unknown_acl(struct hci_dev *hdev, struct sk_buff *s=
kb)
> +{
> +       bt_dev_err(hdev, "ACL packet for unknown connection handle %d",
> +                  hci_unknown_acl_handle(skb));
> +       kfree_skb(skb);
> +}
> +
> +static void hci_queue_unknown_acl(struct hci_dev *hdev, struct sk_buff *=
skb)
> +{
> +       bt_dev_warn_ratelimited(hdev,
> +                               "Queuing ACL packet for unknown connectio=
n handle %d",
> +                               hci_unknown_acl_handle(skb));
> +       hci_skb_acl_expires(skb) =3D
> +               jiffies + msecs_to_jiffies(HCI_UNKNOWN_ACL_TIMEOUT_MS);
> +       skb_queue_tail(&hdev->unknown_acl_q, skb);
> +       queue_delayed_work(hdev->workqueue, &hdev->unknown_acl_work,
> +                          msecs_to_jiffies(HCI_UNKNOWN_ACL_TIMEOUT_MS));
> +}
> +
> +static void hci_retry_unknown_acl(struct hci_dev *hdev)
> +{
> +       unsigned int count =3D skb_queue_len(&hdev->unknown_acl_q);
> +       struct sk_buff *skb;
> +       unsigned long delay;
> +
> +       if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
> +               cancel_delayed_work(&hdev->unknown_acl_work);
> +               skb_queue_purge(&hdev->unknown_acl_q);
> +               return;
> +       }
> +
> +       while (count-- && (skb =3D skb_dequeue(&hdev->unknown_acl_q))) {
> +               if (hci_acldata_packet(hdev, skb, true) !=3D -ENOENT)
> +                       continue;
> +
> +               if (hci_unknown_acl_expired(skb)) {
> +                       hci_drop_unknown_acl(hdev, skb);
> +                       continue;
> +               }
> +
> +               skb_queue_tail(&hdev->unknown_acl_q, skb);
> +       }
> +
> +       if (skb_queue_empty(&hdev->unknown_acl_q)) {
> +               cancel_delayed_work(&hdev->unknown_acl_work);
> +               return;
> +       }
> +
> +       skb =3D skb_peek(&hdev->unknown_acl_q);
> +       delay =3D time_after(hci_skb_acl_expires(skb), jiffies) ?
> +               hci_skb_acl_expires(skb) - jiffies : 0;
> +       queue_delayed_work(hdev->workqueue, &hdev->unknown_acl_work,
> +                          max_t(unsigned long, 1, delay));
> +}
> +
> +static void hci_unknown_acl_work(struct work_struct *work)
> +{
> +       struct hci_dev *hdev =3D container_of(work, struct hci_dev,
> +                                          unknown_acl_work.work);
> +
> +       hci_retry_unknown_acl(hdev);
>  }
>
>  /* SCO data packet */
> @@ -4039,11 +4124,21 @@ static void hci_rx_work(struct work_struct *work)
>                 case HCI_EVENT_PKT:
>                         BT_DBG("%s Event packet", hdev->name);
>                         hci_event_packet(hdev, skb);
> +                       if (!skb_queue_empty(&hdev->unknown_acl_q))
> +                               hci_retry_unknown_acl(hdev);
>                         break;
>
>                 case HCI_ACLDATA_PKT:
>                         BT_DBG("%s ACL data packet", hdev->name);
> -                       hci_acldata_packet(hdev, skb);
> +                       if (hci_acldata_packet(hdev, skb, false) =3D=3D -=
ENOENT) {
> +                               if (hci_test_quirk(hdev,
> +                                                  HCI_QUIRK_OUT_OF_ORDER=
_ACL) &&
> +                                   hci_dev_test_flag(hdev,
> +                                                     HCI_OUT_OF_ORDER_AC=
L_ENABLED))
> +                                       hci_queue_unknown_acl(hdev, skb);
> +                               else
> +                                       hci_drop_unknown_acl(hdev, skb);
> +                       }
>                         break;
>
>                 case HCI_SCODATA_PKT:
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 307fd47f8459..839f9fe91d20 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -5396,9 +5396,11 @@ int hci_dev_open_sync(struct hci_dev *hdev)
>                  */
>                 flush_work(&hdev->rx_work);
>                 flush_work(&hdev->cmd_work);
> +               cancel_delayed_work_sync(&hdev->unknown_acl_work);
>
>                 skb_queue_purge(&hdev->cmd_q);
>                 skb_queue_purge(&hdev->rx_q);
> +               skb_queue_purge(&hdev->unknown_acl_q);
>
>                 if (hdev->flush)
>                         hdev->flush(hdev);
> @@ -5503,6 +5505,8 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>
>         if (!test_and_clear_bit(HCI_UP, &hdev->flags)) {
>                 cancel_delayed_work_sync(&hdev->cmd_timer);
> +               cancel_delayed_work_sync(&hdev->unknown_acl_work);
> +               skb_queue_purge(&hdev->unknown_acl_q);
>                 hci_dev_clear_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
>                 return err;
>         }
> @@ -5512,6 +5516,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>         /* Flush RX and TX works */
>         flush_work(&hdev->tx_work);
>         flush_work(&hdev->rx_work);
> +       cancel_delayed_work_sync(&hdev->unknown_acl_work);
>
>         if (hdev->discov_timeout > 0) {
>                 hdev->discov_timeout =3D 0;
> @@ -5582,6 +5587,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>
>         /* Drop queues */
>         skb_queue_purge(&hdev->rx_q);
> +       skb_queue_purge(&hdev->unknown_acl_q);
>         skb_queue_purge(&hdev->cmd_q);
>         skb_queue_purge(&hdev->raw_q);
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 1156aba4e83c..a53179897054 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -7799,7 +7799,7 @@ int l2cap_recv_acldata(struct hci_dev *hdev, u16 ha=
ndle,
>         hcon =3D hci_conn_hash_lookup_handle(hdev, handle);
>         if (!hcon) {
>                 hci_dev_unlock(hdev);
> -               kfree_skb(skb);
> +               /* Leave ownership with HCI so it can retry the packet. *=
/
>                 return -ENOENT;

If you are going to make it non-driver/transport specific then the
right way would be to handle this here and then queue into pending_rx
which already exists to handle packets for connections not considered
connected, which is probably how we shoud treat this, then we can
create a temporary hcon and set a idle timeout or something to cleanup
if the connection doesn't complete within that time it is cleanup and
the pending_rx is freed.

>         }
>
>
> base-commit: 735a14a2a4426760c5ff41ef3db5543fececcb75
> --
> 2.43.0



--=20
Luiz Augusto von Dentz
