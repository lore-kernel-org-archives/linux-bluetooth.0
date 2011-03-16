Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Date: Wed, 16 Mar 2011 13:04:55 +0200
Subject: RE: [PATCH v4 2/6] Sim Access Profile Server
Message-ID: <99B09243E1A5DA4898CDD8B70011144810830AA9CA@EXMB04.eu.tieto.com>
References: <1300207401-23438-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1300207401-23438-3-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <20110315175408.GC16335@jh-x301>
 <99B09243E1A5DA4898CDD8B70011144810830AA84A@EXMB04.eu.tieto.com>
 <20110316094003.GA11136@jh-x301>
In-Reply-To: <20110316094003.GA11136@jh-x301>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>Use shorter define names (since they really are quite long), 
>move the checks into separate functions, e.g. 
>validate_set_transport_protocol_req(),
>or redo the if-statement to something like:
>
>	if (msg->nparam != 0x01)
>		return -EBADMSG;
>	if (msg->param->id != SAP_PARAM_ID_TRANSPORT_PROTOCOL)
>		return -EBADMSG;
>	if (ntohs(msg->param->len) != 
>SAP_PARAM_ID_TRANSPORT_PROTOCOL_LEN)
>		return -EBADMSG;
>        ...
>	return 0;
>
>It becomes much easier for a human to parse it that way since 
>you get to process the individual conditions clearly one at a time.
>

Thanks.  I will rearrange if-statements now. I agree, however, defines are to long and will change it in a separate patch not to introduce a mess. The defines are used in already upstream code.
Will send v5 in a while.

Waldek


