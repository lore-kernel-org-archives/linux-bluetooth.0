Return-Path: <cyrus@holtmann.org>
Date: Sat, 3 Oct 2009 04:00:06 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Karsten Keil <isdn@linux-pingi.de>,
	Andreas Eversberg <andreas@eversberg.eu>,
	Matthias Urlichs <matthias@urlichs.de>,
	Hannes Eder <hannes@hanneseder.net>,
	Michal Ostrowski <mostrows@earthlink.net>,
	Cyrill Gorcunov <gorcunov@openvz.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	James Chapman <jchapman@katalix.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Marcel Holtmann <marcel@holtmann.org>,
	"Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>,
	Andrew Morton <akpm@linux-foundation.org>,
	Harvey Harrison <harvey.harrison@gmail.com>,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Mark Smith <markzzzsmith@yahoo.com.au>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Woodhouse <David.Woodhouse@intel.com>,
	Chas Williams <chas@cmf.nrl.navy.mil>,
	Joerg Reuter <jreuter@yaina.de>, Ralf Baechle <ralf@linux-mips.org>,
	Bernard Pidoux F6BVP <f6bvp@free.fr>,
	James Morris <jmorris@namei.org>,
	Dave Young <hidave.darkstar@gmail.com>,
	Jan Engelhardt <jengelh@medozas.de>,
	Oliver Hartkopp <oliver@hartkopp.net>, Ingo Molnar <mingo@elte.hu>,
	Johan Hedberg <johan.hedberg@nokia.com>,
	Urs Thuermann <urs@isnogud.escape.de>,
	Christine Caulfield <christine.caulfield@googlemail.com>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	Sergey Lapin <slapin@ossfans.org>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	"Pekka Savola (ipv6)" <pekkas@netcore.fi>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Patrick McHardy <kaber@trash.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"Denis V. Lunev" <den@openvz.org>,
	Vlad Yasevich <vladislav.yasevich@hp.com>,
	Samuel Ortiz <samuel@sortiz.org>,
	Ursula Braun <ursula.braun@de.ibm.com>, linux390@de.ibm.com,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	Qinghuang Feng <qhfeng.kernel@gmail.com>,
	Jiri Pirko <jpirko@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	remi.denis-courmont@nokia.com, Andy Grover <andy.grover@oracle.com>,
	Huang Weiyi <weiyi.huang@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Dan Carpenter <error27@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Henner Eisen <eis@baty.hanse.de>,
	netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-hams@vger.kernel.org, linux-decnet-user@lists.sourceforge.net,
	linux-zigbee-devel@lists.sourceforge.net,
	linux-s390@vger.kernel.org, rds-devel@oss.oracle.com,
	linux-afs@lists.infradead.org, linux-x25@vger.kernel.org
Subject: Re: [PATCH 1/1] net: mark net_proto_ops as const
Message-ID: <20091003000006.GA2020@x200>
References: <20091002232520.925496630@vyatta.com>
 <20091002232721.385245919@vyatta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091002232721.385245919@vyatta.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Oct 02, 2009 at 04:25:21PM -0700, Stephen Hemminger wrote:
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -842,7 +842,7 @@ static struct packet_type can_packet __r
>  	.func = can_rcv,
>  };
>  
> -static struct net_proto_family can_family_ops __read_mostly = {
> +static const struct net_proto_family can_family_ops __read_mostly = {
						       ^^^^^^^^^^^^^
>  	.family = PF_CAN,
>  	.create = can_create,
>  	.owner  = THIS_MODULE,

ACK, except this chunk: const already means read-only.
