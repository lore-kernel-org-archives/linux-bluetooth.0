Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Mar 2011 11:40:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar.Rymarkiewicz@tieto.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 2/6] Sim Access Profile Server
Message-ID: <20110316094003.GA11136@jh-x301>
References: <1300207401-23438-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1300207401-23438-3-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <20110315175408.GC16335@jh-x301>
 <99B09243E1A5DA4898CDD8B70011144810830AA84A@EXMB04.eu.tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <99B09243E1A5DA4898CDD8B70011144810830AA84A@EXMB04.eu.tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Wed, Mar 16, 2011, Waldemar.Rymarkiewicz@tieto.com wrote:
> >I've pushed the first two patches in this set, but it's gonna 
> >take quite a bit longer to properly review the rest (at a 
> >quick glance I noticed at least some coding style stuff with 
> >over 80-character lines).
> 
> Yes, I guess you refer  to eg.
> 
> case SAP_SET_TRANSPORT_PROTOCOL_REQ:
> 	if (msg->nparam == 0x01 &&
> 			msg->param->id == SAP_PARAM_ID_TRANSPORT_PROTOCOL &&
> 			ntohs(msg->param->len) == SAP_PARAM_ID_TRANSPORT_PROTOCOL_LEN &&
> 			(*msg->param->val  == SAP_TRANSPORT_PROTOCOL_T0 ||
> 			*msg->param->val == SAP_TRANSPORT_PROTOCOL_T1))
> 		return 0;
> 
> Well, I didn't know how to spit up something like
> "ntohs(msg->param->len) == SAP_PARAM_ID_TRANSPORT_PROTOCOL_LEN &&"
> correctly.  Any sugestion?

Use shorter define names (since they really are quite long), move the
checks into separate functions, e.g. validate_set_transport_protocol_req(),
or redo the if-statement to something like:

	if (msg->nparam != 0x01)
		return -EBADMSG;
	if (msg->param->id != SAP_PARAM_ID_TRANSPORT_PROTOCOL)
		return -EBADMSG;
	if (ntohs(msg->param->len) != SAP_PARAM_ID_TRANSPORT_PROTOCOL_LEN)
		return -EBADMSG;
        ...
	return 0;

It becomes much easier for a human to parse it that way since you get to
process the individual conditions clearly one at a time.

Take your pick ;)

Johan
