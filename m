Return-Path: <SRS0=ORc3=EC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC16EC4363A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Oct 2020 22:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A62220878
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Oct 2020 22:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqrEXlHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505929AbgJ0WIY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Oct 2020 18:08:24 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39482 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505872AbgJ0WIY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Oct 2020 18:08:24 -0400
Received: by mail-ot1-f66.google.com with SMTP id o14so2548245otj.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2020 15:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JoUZfq1mKwk4Qo4cLHBwt4zrD0LinXAdTQYbZ41xLnE=;
        b=sqrEXlHVT7iWFU0GX7p79ahjDvmlgoj8faV5VYm5YgImH3581NgyhU3oLMpmwrgoqb
         KgPO76z3JVCRt6ouCt6L+LZSgeL3cyT9Q68a+i+nnHdN4bx4oV47HkI2pw3Ob0OBQRJ3
         Bw5teaAvDVAin6C/ix7JYXEHmfWGgJXzL6ZTxHafiar19eDDkQrnnUGbs4obCZSRRIrQ
         TKE9MTAvNZ6z3emTlD/0WuTNm1QwydFRwwxuAaBGjXkjurVIdILHiCUx37Wh3OKN68Tx
         /5EDFHRdAAg008Y31M+b8PKvKXmgMfUT6czwCo5KeSHqdrG89a42sbQSZmg/eg6QwlYr
         NGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JoUZfq1mKwk4Qo4cLHBwt4zrD0LinXAdTQYbZ41xLnE=;
        b=rs00/J+zfTYwODNZaldOPfr3Pi5rbZlGJr2PyVuOTvhkkS6yVjlqku61ZfGHMrXvvf
         wzsaqa0ZiwBpJBhV7dXc7k0gAG4bolmaQOOFZpaSDJtHLEdc9F/ZQhNPYIQ6YEFCbKlj
         +vx3YDifVltrjti3opqa2Bjwq6FFmuaTvTyI3xHn5kGFLVCwzdK3cjtuA1H1lg0z7pdF
         Y6XTFmPdkgGhl6LugqZAKWXxMRapv+ArfXcqxTmH2hplgwCpnfKuUxxArGoHJ55UgArO
         gYGDmyK/Mz77AHsXAtWMb6qfa52Tw9QEbo7cAjZkOuaj4sBnG5A6yM++Yi7ABRIGOauC
         gaeQ==
X-Gm-Message-State: AOAM533gkxdmFW56gjBDj06Lx2GImuJVqxR3mq6y9yCPdDBb/6OVBnb8
        KwczRcH8eNX34zSZDoDXKKVofPUdijpOb2+gV+0=
X-Google-Smtp-Source: ABdhPJyiNwfW4UGdYDLJqCG2O5b/NcHKIylYEBruZeU6w5jKpyG5nj52/7DCkKPZiSNErxtD6QUsdPTS0BEZ74fdFvE=
X-Received: by 2002:a05:6830:134c:: with SMTP id r12mr2923219otq.240.1603836502258;
 Tue, 27 Oct 2020 15:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201001230152.2422908-1-danielwinkler@google.com> <20201001155738.Bluez.v4.7.I187f71748b9bd93f6bf97ec4a195216109c3ea06@changeid>
In-Reply-To: <20201001155738.Bluez.v4.7.I187f71748b9bd93f6bf97ec4a195216109c3ea06@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 27 Oct 2020 15:08:11 -0700
Message-ID: <CABBYNZK3SQeWp3OHSgapqL+HEZqcFuPFbwMFCiU9m-vAKd-1gQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v4 07/10] advertising: Query LE TX range at manager initialization
To:     Daniel Winkler <danielwinkler@google.com>
Cc:     Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel,

On Thu, Oct 1, 2020 at 4:05 PM Daniel Winkler <danielwinkler@google.com> wrote:
>
> This patch calls the new MGMT command to get controller capabilities,
> and parses the min and max LE tx power range when the manager is
> initialized. This will be used to populate a client-facing dbus entry so
> that the client will know the advertising capabilities of the controller
> before registering an advertisement.
>
> This patch is tested by manually verifying the data is parsed correctly
> from the MGMT response.
>
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> ---
>
> Changes in v4:
> - Move tx power range into single capability field
>
> Changes in v3: None
> Changes in v2: None
>
>  lib/mgmt.h        | 14 ++++++++----
>  src/advertising.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++
>  tools/btmgmt.c    | 12 +++++------
>  3 files changed, 70 insertions(+), 10 deletions(-)
>
> diff --git a/lib/mgmt.h b/lib/mgmt.h
> index 7ab4fb797..f37f7e654 100644
> --- a/lib/mgmt.h
> +++ b/lib/mgmt.h
> @@ -599,10 +599,16 @@ struct mgmt_cp_set_blocked_keys {
>         struct mgmt_blocked_key_info keys[0];
>  } __packed;
>
> -#define MGMT_OP_READ_SECURITY_INFO     0x0048
> -struct mgmt_rp_read_security_info {
> -       uint16_t sec_len;
> -       uint8_t  sec[0];
> +#define MGMT_CAP_SEC_FLAGS             0x01
> +#define MGMT_CAP_MAX_ENC_KEY_SIZE      0x02
> +#define MGMT_CAP_SMP_MAX_ENC_KEY_SIZE  0x03
> +#define MGMT_CAP_LE_TX_PWR             0x04
> +
> +#define MGMT_OP_READ_CONTROLLER_CAP    0x0048
> +#define MGMT_READ_CONTROLLER_CAP_SIZE  0
> +struct mgmt_rp_read_controller_cap {
> +       uint16_t cap_len;
> +       uint8_t cap[0];
>  } __packed;
>
>  #define MGMT_OP_READ_EXP_FEATURES_INFO 0x0049
> diff --git a/src/advertising.c b/src/advertising.c
> index 052964d42..41d0658c8 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -49,6 +49,8 @@ struct btd_adv_manager {
>         uint32_t supported_flags;
>         unsigned int instance_bitmap;
>         bool extended_add_cmds;
> +       int8_t min_tx_power;
> +       int8_t max_tx_power;
>  };
>
>  #define AD_TYPE_BROADCAST 0
> @@ -1679,6 +1681,49 @@ static void read_adv_features_callback(uint8_t status, uint16_t length,
>                 remove_advertising(manager, 0);
>  }
>
> +static void read_controller_cap_complete(uint8_t status, uint16_t length,
> +                                       const void *param, void *user_data)
> +{
> +       struct btd_adv_manager *manager = user_data;
> +       const struct mgmt_rp_read_controller_cap *rp = param;
> +       const uint8_t *ptr = rp->cap;
> +       size_t offset = 0;
> +       uint8_t tag_len;
> +       uint8_t tag_type;
> +
> +       if (status || !param) {
> +               error("Failed to read advertising features: %s (0x%02x)",
> +                                               mgmt_errstr(status), status);
> +               return;
> +       }
> +
> +       if (sizeof(rp->cap_len) + rp->cap_len != length) {
> +               error("Controller capabilities malformed, size %lu != %u",
> +                               sizeof(rp->cap_len) + rp->cap_len, length);
> +               return;
> +       }
> +
> +       while (offset < rp->cap_len) {
> +               tag_len = ptr[offset++];
> +               tag_type = ptr[offset++];
> +
> +               switch (tag_type) {
> +               case MGMT_CAP_LE_TX_PWR:
> +                       if ((tag_len - sizeof(tag_type)) !=
> +                                       2*sizeof(manager->min_tx_power)) {
> +                               error("TX power had unexpected length %d",
> +                                       tag_len);
> +                               break;
> +                       }
> +                       memcpy(&manager->min_tx_power, &ptr[offset], tag_len);
> +                       memcpy(&manager->max_tx_power, &ptr[offset+1], tag_len);
> +               }
> +
> +               /* Step to the next entry */
> +               offset += (tag_len - sizeof(tag_type));
> +       }
> +}
> +
>  static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
>                                                 struct mgmt *mgmt)
>  {
> @@ -1700,6 +1745,8 @@ static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
>         manager->supported_flags = MGMT_ADV_FLAG_LOCAL_NAME;
>         manager->extended_add_cmds =
>                         btd_has_kernel_features(KERNEL_HAS_EXT_ADV_ADD_CMDS);
> +       manager->min_tx_power = ADV_TX_POWER_NO_PREFERENCE;
> +       manager->max_tx_power = ADV_TX_POWER_NO_PREFERENCE;
>
>         if (!g_dbus_register_interface(btd_get_dbus_connection(),
>                                         adapter_get_path(manager->adapter),
> @@ -1716,6 +1763,13 @@ static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
>                 goto fail;
>         }
>
> +       /* Query controller capabilities. This will be used to display valid
> +        * advertising tx power range to the client.
> +        */
> +       mgmt_send(manager->mgmt, MGMT_OP_READ_CONTROLLER_CAP,
> +               manager->mgmt_index, 0, NULL,
> +               read_controller_cap_complete, manager, NULL);

I'd make this conditional to experimental for now, also don't we need
to check the kernel has support for it?

>         return manager;
>
>  fail:
> diff --git a/tools/btmgmt.c b/tools/btmgmt.c
> index 48c9e5887..8b1cc4df5 100644
> --- a/tools/btmgmt.c
> +++ b/tools/btmgmt.c
> @@ -1531,7 +1531,7 @@ static void cmd_extinfo(int argc, char **argv)
>  static void sec_info_rsp(uint8_t status, uint16_t len, const void *param,
>                                                         void *user_data)
>  {
> -       const struct mgmt_rp_read_security_info *rp = param;
> +       const struct mgmt_rp_read_controller_cap *rp = param;
>         uint16_t index = PTR_TO_UINT(user_data);
>
>         if (status != 0) {
> @@ -1546,7 +1546,7 @@ static void sec_info_rsp(uint8_t status, uint16_t len, const void *param,
>         }
>
>         print("Primary controller (hci%u)", index);
> -       print("\tSecurity info length: %u", le16_to_cpu(rp->sec_len));
> +       print("\tSecurity info length: %u", le16_to_cpu(rp->cap_len));
>
>  done:
>         pending_index--;
> @@ -1589,11 +1589,11 @@ static void sec_index_rsp(uint8_t status, uint16_t len, const void *param,
>                 if (rp->entry[i].type != 0x00)
>                         continue;
>
> -               if (!mgmt_send(mgmt, MGMT_OP_READ_SECURITY_INFO,
> +               if (!mgmt_send(mgmt, MGMT_OP_READ_CONTROLLER_CAP,
>                                                 index, 0, NULL, sec_info_rsp,
>                                                 UINT_TO_PTR(index), NULL)) {
> -                               error("Unable to send read_security_info cmd");
> -                               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +                       error("Unable to send read_security_info cmd");
> +                       return bt_shell_noninteractive_quit(EXIT_FAILURE);
>                 }
>                 pending_index++;
>         }
> @@ -1615,7 +1615,7 @@ static void cmd_secinfo(int argc, char **argv)
>                 return;
>         }
>
> -       if (!mgmt_send(mgmt, MGMT_OP_READ_SECURITY_INFO, mgmt_index, 0, NULL,
> +       if (!mgmt_send(mgmt, MGMT_OP_READ_CONTROLLER_CAP, mgmt_index, 0, NULL,
>                                         sec_info_rsp,
>                                         UINT_TO_PTR(mgmt_index), NULL)) {
>                 error("Unable to send read_security_info cmd");
> --
> 2.28.0.709.gb0816b6eb0-goog
>


-- 
Luiz Augusto von Dentz
