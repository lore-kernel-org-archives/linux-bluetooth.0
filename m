Return-Path: <cyrus@holtmann.org>
From: <tim.howes@accenture.com>
To: <ville.tervo@nokia.com>, <linux-bluetooth@vger.kernel.org>
Date: Mon, 15 Nov 2010 15:24:29 +0100
Subject: RE: [RFC] Interface to set LE connection parameters
Message-ID: <1AFE20D16950C745A2A83986B72E8748011F571E6CE6@EMEXM3131.dir.svc.accenture.com>
References: <20101115120632.GB16464@null>
In-Reply-To: <20101115120632.GB16464@null>
Content-Type: text/plain;
	charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

As you note the different profiles would likely have different connection parameters.  The different profiles may be running on the same LE link (indeed the same L2CAP [fixed] channel).

Do you have a view on how the different profiles - on the same link - would have different requests arbitrated, and where that arbitration would be done?  I'd imagine that the API towards the profiles should be of the abstract form - such as you mention (eg BT_LE_LOW_LAT).  This would make it easier to arbitrate the different requests, as compared to if the profiles see an API of the "numerical" form (eg interval = N ms).  I guess the arbitration could happen in user or kernel space; as long as there is something with singleton-like semantics to do it.

Also - a quick observation: yes, the connection parameters are only for LE links; however they have some semantic similarity with sniff mode in BR. Especially in the abstract form ("Low Latency" verus "Low Power").  Does BlueZ present an API like this already for BR (I'm new to BlueZ...I was more of a Symbian guy ;)?  If not it might be worth having one API for both BR/Sniff and LE/Connection Parameters - and do the appropriate mapping "under the hood".  

Cheers,

Tim








-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Ville Tervo
Sent: 15 November 2010 12:07
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Interface to set LE connection parameters

Hi,

LE profiles have different requirements for connection parameters. Mainly
trying to balance between power consumption and latencies. Probably more will
factors will be in future.

Currently I have plan to introduce new l2cap socket option which can be used
before connection creation to set inital settings and also change settings
while having a connection.

Since there is no equivalents in EDR/BR connection I'm planning to make then
apply only LE connection.


Other question which parameters should be exposed to user space? Connection
creation and connection update have these common parameters. Connection
creation has in addition some other parameters also but they should be handled
in some other way.

	__le16   conn_interval_min;
	__le16   conn_interval_max;
	__le16   conn_latency;
	__le16   supervision_timeout;
	__le16   min_ce_len;
	__le16   max_ce_len;

So far I have had two ideas. The first is to simply expose all these fields
with sock_opt. In that way profiles would be able to define their requirements
also in future without any sock opt changes.

Second is to define BT_LE_LOW_LAT for low latency connection requirements and
BT_LE_LOW_POWER connection where the latency is not an issue. It would make
usage of this sock opt interface simplier. OTOH the only user should be
bluetoothd so it doesn't need to be as simple as possible.


Comments please.

-- 
Ville
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



This message is for the designated recipient only and may contain privileged, proprietary, or otherwise private information.  If you have received it in error, please notify the sender immediately and delete the original.  Any other use of the email by you is prohibited.
