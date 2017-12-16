Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sat, 16 Dec 2017 16:49:32 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: sbrown@cortland.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH V3 7/9] mesh: meshctl: Add get/set identity
Message-ID: <20171216154932.GA21312@x1c>
References: <20171215064606.15051-1-sbrown@cortland.com>
 <20171215064606.15051-8-sbrown@cortland.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20171215064606.15051-8-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

On Fri, Dec 15, 2017, sbrown@cortland.com wrote:
> +	case OP_NODE_IDENTITY_STATUS:
> +		if (len != 4)
> +			return true;
> +		bt_shell_printf("Network index 0x%04x has "
> +				"Node Identity state 0x%02x %s\n",
> +				get_le16(data + 1), data[3],
> +				mesh_status_str(data[0]));
> +
>  	case OP_CONFIG_PROXY_STATUS:

This throws the following compilation error for me:

mesh/config-client.c: In function ‘client_msg_recvd’:
mesh/config-client.c:165:3: error: this statement may fall through [-Werror=implicit-fallthrough=]
   bt_shell_printf("Network index 0x%04x has "
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     "Node Identity state 0x%02x %s\n",
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     get_le16(data + 1), data[3],
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     mesh_status_str(data[0]));
     ~~~~~~~~~~~~~~~~~~~~~~~~~
mesh/config-client.c:170:2: note: here
  case OP_CONFIG_RELAY_STATUS:
  ^~~~
cc1: all warnings being treated as errors

The above looks like a valid error, i.e. it seems there's a missing
break or return statement in your patch.

You might want to upgrade to a newer gcc version if you're not getting
these errors. At least version 7.2.1 from Fedora 27 give me these.

Johan
