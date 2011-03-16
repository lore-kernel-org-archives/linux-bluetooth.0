Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <johan.hedberg@nokia.com>
CC: <linux-bluetooth@vger.kernel.org>
Date: Wed, 16 Mar 2011 10:49:16 +0200
Subject: RE: [PATCH v4 2/6] Sim Access Profile Server
Message-ID: <99B09243E1A5DA4898CDD8B70011144810830AA84A@EXMB04.eu.tieto.com>
References: <1300207401-23438-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1300207401-23438-3-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <20110315175408.GC16335@jh-x301>
In-Reply-To: <20110315175408.GC16335@jh-x301>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sure, 

>I've pushed the first two patches in this set, but it's gonna 
>take quite a bit longer to properly review the rest (at a 
>quick glance I noticed at least some coding style stuff with 
>over 80-character lines).

Yes, I guess you refer  to eg.

case SAP_SET_TRANSPORT_PROTOCOL_REQ:
	if (msg->nparam == 0x01 &&
			msg->param->id == SAP_PARAM_ID_TRANSPORT_PROTOCOL &&
			ntohs(msg->param->len) == SAP_PARAM_ID_TRANSPORT_PROTOCOL_LEN &&
			(*msg->param->val  == SAP_TRANSPORT_PROTOCOL_T0 ||
			*msg->param->val == SAP_TRANSPORT_PROTOCOL_T1))
		return 0;

Well, I didn't know how to spit up something like "ntohs(msg->param->len) == SAP_PARAM_ID_TRANSPORT_PROTOCOL_LEN &&"  correctly.
Any sugestion?

/Waldek
