Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Nov 2010 10:56:47 +0200
From: Ville Tervo <ville.tervo@nokia.com>
To: ext Mike Tsai <Mike.Tsai@Atheros.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] Interface to set LE connection parameters
Message-ID: <20101116085647.GG16464@null>
References: <20101115120632.GB16464@null>
 <35B17FE5076C7040809188FBE7913F98406D465470@SC1EXMB-MBCL.global.atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <35B17FE5076C7040809188FBE7913F98406D465470@SC1EXMB-MBCL.global.atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

n Mon, Nov 15, 2010 at 07:15:44PM +0100, ext Mike Tsai wrote:
> Hi Ville,
> 
> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Ville Tervo
> Sent: Monday, November 15, 2010 4:07 AM
> To: linux-bluetooth@vger.kernel.org
> Subject: [RFC] Interface to set LE connection parameters
> 
> Hi,
> 
> LE profiles have different requirements for connection parameters. Mainly
> trying to balance between power consumption and latencies. Probably more will
> factors will be in future.
> 
> Currently I have plan to introduce new l2cap socket option which can be used
> before connection creation to set inital settings and also change settings
> while having a connection.
> 
> Since there is no equivalents in EDR/BR connection I'm planning to make then
> apply only LE connection.
> 
> 
> Other question which parameters should be exposed to user space? Connection
> creation and connection update have these common parameters. Connection
> creation has in addition some other parameters also but they should be handled
> in some other way.
> 
> 	__le16   conn_interval_min;
> 	__le16   conn_interval_max;
> 	__le16   conn_latency;
> 	__le16   supervision_timeout;
> 	__le16   min_ce_len;
> 	__le16   max_ce_len;
> 
> So far I have had two ideas. The first is to simply expose all these fields
> with sock_opt. In that way profiles would be able to define their requirements
> also in future without any sock opt changes.
> 
> Second is to define BT_LE_LOW_LAT for low latency connection requirements and
> BT_LE_LOW_POWER connection where the latency is not an issue. It would make
> usage of this sock opt interface simplier. OTOH the only user should be
> bluetoothd so it doesn't need to be as simple as possible.
> 
> 
> Comments please.
> 
> [MTsai] - how about following parameters,
> 
> 	Scan internal,
> 	Scan window,
> 	Peer address type,

These are connection creation parameters. Maybe BT_LE_LOW_LAT/BT_LE_LOW_POWER
could be used also for these values. But I think they should defined in some
other way.

-- 
Ville
