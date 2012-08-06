Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1343987003-17309-1-git-send-email-vani.patel@stericsson.com>
References: <1343987003-17309-1-git-send-email-vani.patel@stericsson.com>
Date: Mon, 6 Aug 2012 11:42:30 +0300
Message-ID: <CABBYNZLpkvViHPONCE=r_NOhfywAuEK_SGLak2VUFPXX9THh_g@mail.gmail.com>
Subject: Re: [PATCH BlueZ V2 4/5]AVRCP: Register/Unregister Browsing handler
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vani-dineshbhai PATEL <vani.patel@stericsson.com>
Cc: User Name <linux-bluetooth@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Joohi <Joohi.rastogi@stericsson.com>, Vani <vani273@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vani,

On Fri, Aug 3, 2012 at 12:43 PM, Vani-dineshbhai PATEL
<vani.patel@stericsson.com> wrote:
> +unsigned int avctp_register_browsing_pdu_handler(avctp_browsing_pdu_cb cb,
> +                                                       void *user_data)
> +{
> +       static unsigned int id = 0;
> +
> +       browsing_handler = g_new(struct avctp_browsing_pdu_handler, 1);
> +       browsing_handler->cb = cb;
> +       browsing_handler->user_data = user_data;
> +       browsing_handler->id = ++id;
> +
> +       return browsing_handler->id;
> +}

If we can only have a single pdu handler there is probably no need to
have an id assigned, but I thought the idea was to reuse
avctp_register_pdu_handler with something outside of the range of
control opcodes e.g. > 0xFF.


-- 
Luiz Augusto von Dentz
