Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH bluetooth-next] Added force_acl_master param for
 bluetooth module
From: Marcel Holtmann <marcel@holtmann.org>
To: ilia.kolominsky@gmail.com
Cc: linux-bluetooth@vger.kernel.org, Ilia Kolomisnky <iliak@ti.com>
Date: Mon, 12 Sep 2011 11:28:59 +0200
In-Reply-To: <1315798377-3660-1-git-send-email-iliak@ti.com>
References: <1315798377-3660-1-git-send-email-iliak@ti.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315819740.1937.17.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilia,

> This param allows role switch request while accepting a new acl
> connection. This is an enhancement to l2cap L2CAP_LM role switching
> capability which allows requesting role switch without modification
> to the application code. It was observed that operating as a master
> of piconet (as oposed to scatternet config) is beneficial when
> qos (flow_spec) guarantees are requested.

<snip>
 
>  module_param(enable_le, bool, 0444);
>  MODULE_PARM_DESC(enable_le, "Enable LE support");
> +module_param(force_acl_master, bool, 0644);
> +MODULE_PARM_DESC(force_acl_master, "Always try to switch to master role on ACL link");

using kernel module parameters is not an acceptable API/ABI for this.

Regards

Marcel


