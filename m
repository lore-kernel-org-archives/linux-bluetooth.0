Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22780C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Dec 2021 02:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243794AbhLGChi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Dec 2021 21:37:38 -0500
Received: from mga02.intel.com ([134.134.136.20]:31924 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232285AbhLGChi (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Dec 2021 21:37:38 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="224732061"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="224732061"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 18:34:08 -0800
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="748520897"
Received: from mzeuthen-mobl.amr.corp.intel.com (HELO [10.252.128.173]) ([10.252.128.173])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 18:34:07 -0800
Message-ID: <7a1cfaac41ddbe617a6a6c283cb82b0baba0bda3.camel@linux.intel.com>
Subject: Re: [PATCH 1/6] tools/mesh-gatt: Add onoff set unack message to
 onoff client model
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     daniele.biagetti@cblelectronics.com,
        linux-bluetooth@vger.kernel.org
Date:   Mon, 06 Dec 2021 18:34:07 -0800
In-Reply-To: <000501d7e85f$2105e2d0$6311a870$@cblelectronics.com>
References: <000501d7e85f$2105e2d0$6311a870$@cblelectronics.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel,

Please add the commit message for each patches.
And the CI bot was not able to apply the patch. Please resubmit after
rebasing to the tip.

Regards,
Tedd

On Fri, 2021-12-03 at 17:02 +0100, daniele.biagetti@cblelectronics.com wrote:
> ---
>  tools/mesh-gatt/onoff-model.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/mesh-gatt/onoff-model.c b/tools/mesh-gatt/onoff-model.c
> index 9dfedd85a..13ff4bbe3 100644
> --- a/tools/mesh-gatt/onoff-model.c
> +++ b/tools/mesh-gatt/onoff-model.c
> @@ -226,6 +226,8 @@ static void cmd_set(int argc, char *argv[])
>         uint16_t n;
>         uint8_t msg[32];
>         struct mesh_node *node;
> +       int np;
> +       uint32_t opcode;
>  
>         if (IS_UNASSIGNED(target)) {
>                 bt_shell_printf("Destination not set\n");
> @@ -237,13 +239,22 @@ static void cmd_set(int argc, char *argv[])
>         if (!node)
>                 return;
>  
> -       if ((read_input_parameters(argc, argv) != 1) &&
> -                                       parms[0] != 0 && parms[0] != 1) {
> -               bt_shell_printf("Bad arguments: Expecting \"0\" or
> \"1\"\n");
> -               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       np = read_input_parameters(argc, argv);
> +       if ((np != 1) && (np != 2) &&
> +               parms[0] != 0 && parms[0] != 1 &&
> +               parms[1] != 0 && parms[1] != 1) {
> +       bt_shell_printf("Bad arguments: Expecting \"0\" or \"1\" "
> +               "and an optional \"0\" or \"1\" as unack\n");
> +       return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       if( (np==2) && parms[1] ){
> +               opcode = OP_GENERIC_ONOFF_SET_UNACK;
> +       }else{
> +               opcode = OP_GENERIC_ONOFF_SET;
>         }
>  
> -       n = mesh_opcode_set(OP_GENERIC_ONOFF_SET, msg);
> +       n = mesh_opcode_set(opcode, msg);
>         msg[n++] = parms[0];
>         msg[n++] = trans_id++;
>  
> @@ -263,7 +274,7 @@ static const struct bt_shell_menu onoff_menu = {
>                                                 "Set node to configure"},
>         {"get",                 NULL,
> cmd_get_status,
>                                                 "Get ON/OFF status"},
> -       {"onoff",               "<0/1>",                        cmd_set,
> +       {"onoff",               "<0/1> [unack]",                cmd_set,
>                                                 "Send \"SET ON/OFF\"
> command"},
>         {} },
>  };


