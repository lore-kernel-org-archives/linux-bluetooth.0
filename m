Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Brown <sbrown@cortland.com>
Message-ID: <1513442634.18172.80.camel@ewol.com>
Subject: Re: [PATCH V3 7/9] mesh: meshctl: Add get/set identity
To: Johan Hedberg <johan.hedberg@gmail.com>,
        Steve Brown <sbrown@cortland.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        inga.stotland@intel.com
Date: Sat, 16 Dec 2017 09:43:54 -0700
In-Reply-To: <20171216154932.GA21312@x1c>
References: <20171215064606.15051-1-sbrown@cortland.com>
         <20171215064606.15051-8-sbrown@cortland.com> <20171216154932.GA21312@x1c>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Sat, 2017-12-16 at 16:49 +0100, Johan Hedberg wrote:
> Hi Steve,
> 
> On Fri, Dec 15, 2017, sbrown@cortland.com wrote:
> > +	case OP_NODE_IDENTITY_STATUS:
> > +		if (len != 4)
> > +			return true;
> > +		bt_shell_printf("Network index 0x%04x has "
> > +				"Node Identity state 0x%02x %s\n",
> > +				get_le16(data + 1), data[3],
> > +				mesh_status_str(data[0]));
> > +
> >  	case OP_CONFIG_PROXY_STATUS:
> 
> This throws the following compilation error for me:
> 
> mesh/config-client.c: In function ‘client_msg_recvd’:
> mesh/config-client.c:165:3: error: this statement may fall through [-
> Werror=implicit-fallthrough=]
>    bt_shell_printf("Network index 0x%04x has "
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      "Node Identity state 0x%02x %s\n",
>      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      get_le16(data + 1), data[3],
>      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      mesh_status_str(data[0]));
>      ~~~~~~~~~~~~~~~~~~~~~~~~~
> mesh/config-client.c:170:2: note: here
>   case OP_CONFIG_RELAY_STATUS:
>   ^~~~
> cc1: all warnings being treated as errors
> 
> The above looks like a valid error, i.e. it seems there's a missing
> break or return statement in your patch.
> 
> You might want to upgrade to a newer gcc version if you're not
> getting
> these errors. At least version 7.2.1 from Fedora 27 give me these.
> 
> Johan

Spot on. An out of date compiler.

I'll send a V4 after I get Inga's comments.

Thanks,

Steve

