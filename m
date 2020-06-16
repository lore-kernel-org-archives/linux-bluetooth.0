Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46407C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 01:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D75120739
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 01:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="yyXcwwnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgFPBe2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jun 2020 21:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgFPBe1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jun 2020 21:34:27 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C009C08C5C2
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 18:34:27 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i27so21480369ljb.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 18:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fBOUW8DcQP5RUVEFEB+Nscd2xBILZhFX+tn0TCk7DB8=;
        b=yyXcwwnYrYybF2aEe0N4qbSKVu4CEbbanw0eikFKGAjDHQ8W8ACE5USzpdhsz3pIKc
         dm6vzTKbutAEzmVrAMtktWr7qRMqTm1oc4QlBxMvjra5wuXWh9kXX6pl1QxROcmMZQbU
         jAAGEpBYPBGseoHI1SMfii39mkVf4JuyUxjNbsZcaPRHo1BG+I1vsxabf0gSCfsAyN9x
         b9nPMYYhjebTf0g0ds2lpyohjkUP0/+r8KlxO21AFe7BSPN1VAUOz/uU5P47kxqm4szP
         ibOorSmHkYUdRJVg8n27iZI6ZM5hR7GLnRvrKYieF2QvsDOef2/mpuDc+NByhOJC/CKx
         IoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fBOUW8DcQP5RUVEFEB+Nscd2xBILZhFX+tn0TCk7DB8=;
        b=e1DpsCnu/AKHABJ3CDhl46xsyf2s3/WXMy0JqySb2aaCoqzjZEKk80D4GBnBn0kBkp
         0ipt0v/ntTldNGS0Am9O1qAod8byRvJKndpehWp39hVa0Rzhg+awQU7SR5Sjdegpf86E
         1rHPXLt2owHwQLDHYN5pDpqn6Setr23EMup0njZ1NTW4ZXn/Dy0tGYvihE0/1MTQyEbz
         VAY2V+BdpBt1EeWSwtsxpBI3Ydj8rtjc6hRszRB7e04mmnv8Gr3YSaF6Xb5yy6TuTOAS
         cebBLiYbEXijfoFTlgR1gLGLRI+emGA3kYlDfwP5+7PKSpyy2kGrsfYZDUeRDeX1y+Mx
         4rUg==
X-Gm-Message-State: AOAM530UtIN4gFYgOBKNBK/Oq0vrsAHHVOa7oKvWlL7ZI9XVxBtqwLbO
        Q8kulJVUu+RJVrHUpMz9tBp+INdncaf7UmlCzhOTrQ==
X-Google-Smtp-Source: ABdhPJz+Wg9Z0NbEWwfXy+zMFK5B15e9mQDuJzw6r8c/XGOODhFRM6krLVSR3Atai7Y1d3stFKOyJjWWo3QM93mTa5g=
X-Received: by 2002:a2e:7107:: with SMTP id m7mr184599ljc.342.1592271265772;
 Mon, 15 Jun 2020 18:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200616000318.42664-1-michaelfsun@google.com> <20200616000318.42664-2-michaelfsun@google.com>
In-Reply-To: <20200616000318.42664-2-michaelfsun@google.com>
From:   "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Date:   Mon, 15 Jun 2020 18:34:13 -0700
Message-ID: <CACumGO+banV_pQNnB53ddqU2Rjj+K+FnLnNTyztOQMcA3n2yGg@mail.gmail.com>
Subject: Re: [bluez PATCH v1 1/3] btmgmt: Add btmgmt command advmon-features
To:     Michael Sun <michaelfsun@google.com>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Miao-chen Chou <mcchou@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Michael,

On Mon, Jun 15, 2020 at 5:03 PM Michael Sun <michaelfsun@google.com> wrote:
>
> This patch introduces a new btmgmt command =E2=80=98advmon-features=E2=80=
=99 to help
> user query for supported advertisement features. The command will work
> with the new MGMT opcode MGMT_OP_READ_ADV_MONITOR_FEATURES.
>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> Signed-off-by: Michael Sun <michaelfsun@google.com>
> ---
>
>  tools/btmgmt.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>
> diff --git a/tools/btmgmt.c b/tools/btmgmt.c
> index 46e7465b3..1aae7098c 100644
> --- a/tools/btmgmt.c
> +++ b/tools/btmgmt.c
> @@ -4567,6 +4567,84 @@ static void cmd_wbs(int argc, char **argv)
>         cmd_setting(MGMT_OP_SET_WIDEBAND_SPEECH, argc, argv);
>  }
>
> +static const char *advmon_features_str[] =3D {
> +       "Pattern monitor with logic OR.",
> +};
> +
> +static const char *advmon_features2str(uint32_t features)
> +{
> +       static char str[512];
> +       int off, i;
> +
> +       off =3D 0;
> +       snprintf(str, sizeof(str), "\n\tNone");
> +
> +       for (i =3D 0; i < NELEM(advmon_features_str); i++) {
> +               if ((features & (1 << i)) !=3D 0 && off < sizeof(str))
> +                       off +=3D snprintf(str + off, sizeof(str) - off, "=
\n\t%s",
> +                                               advmon_features_str[i]);
> +       }
> +
> +       return str;
> +}
> +
> +static void advmon_features_rsp(uint8_t status, uint16_t len, const void=
 *param,
> +                                                       void *user_data)
> +{
> +       const struct mgmt_rp_read_adv_monitor_features *rp =3D param;
> +       uint32_t supported_features, enabled_features;
> +       uint16_t num_handles;
> +       int i;
> +
> +       if (status !=3D MGMT_STATUS_SUCCESS) {
> +               error("Reading adv monitor features failed with status 0x=
%02x "
> +                                       "(%s)", status, mgmt_errstr(statu=
s));
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       if (len < sizeof(*rp)) {
> +               error("Too small adv monitor features reply (%u bytes)", =
len);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       if (len < sizeof(*rp) + rp->num_handles * sizeof(uint16_t)) {
> +               error("Handles count (%u) doesn't match reply length (%u)=
",
> +                                                       rp->num_handles, =
len);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       supported_features =3D le32_to_cpu(rp->supported_features);
> +       enabled_features =3D le32_to_cpu(rp->enabled_features);
> +       num_handles =3D le16_to_cpu(rp->num_handles);
> +
> +       print("Supported features:%s", advmon_features2str(supported_feat=
ures));
> +       print("Enabled features:%s", advmon_features2str(enabled_features=
));
> +       print("Max number of handles: %u", le16_to_cpu(rp->max_num_handle=
s));
> +       print("Max number of patterns: %u", rp->max_num_patterns);
> +       print("Handles list with %u item%s", num_handles,
> +                       num_handles =3D=3D 0 ? "" : num_handles =3D=3D 1 =
? ":" : "s:");
> +       for (i =3D 0; i < num_handles; i++) {
> +               print("\t0x%04x ", le16_to_cpu(rp->handles[i]));
> +       }
> +
> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +}
> +
> +static void cmd_advmon_features(int argc, char **argv)
> +{
> +       uint16_t index;
> +
> +       index =3D mgmt_index;
> +       if (index =3D=3D MGMT_INDEX_NONE)
> +               index =3D 0;
> +
> +       if (!mgmt_send(mgmt, MGMT_OP_READ_ADV_MONITOR_FEATURES, index, 0,=
 NULL,
> +                                       advmon_features_rsp, NULL, NULL))=
 {
> +               error("Unable to send advertising monitor features comman=
d");
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +}
> +
>  static void register_mgmt_callbacks(struct mgmt *mgmt, uint16_t index)
>  {
>         mgmt_register(mgmt, MGMT_EV_CONTROLLER_ERROR, index, controller_e=
rror,
> @@ -4776,6 +4854,9 @@ static const struct bt_shell_menu main_menu =3D {
>                 cmd_expinfo,            "Show experimental features"    }=
,
>         { "exp-debug",          "<on/off>",
>                 cmd_exp_debug,          "Set debug feature"             }=
,
> +       { "advmon-features",    NULL,
> +               cmd_advmon_features,    "Show advertisement monitor "
> +                                       "features"                      }=
,
>         {} },
>  };

It might be a good idea to organize this as a submenu e.g.
> menu monitor
> features

That way we can expand the number of commands for adding/removing
monitors without making the list of commands way too big to show in
one screen (although it already is).
