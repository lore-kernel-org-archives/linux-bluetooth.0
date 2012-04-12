Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Apr 2012 12:18:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <Mikel.Astiz@bmw-carit.de>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: Re: [PATCH BlueZ v0 1/7] btio: Fix bind SCO socket only if server
Message-ID: <20120412091832.GA8109@x220.ger.corp.intel.com>
References: <1334127438-27617-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1334127438-27617-2-git-send-email-mikel.astiz.oss@gmail.com>
 <CABBYNZJF8XSSdVH2PCB7aX2eNyrPq5Nfj7L5gGV-WMcXyUaPhg@mail.gmail.com>
 <CABBYNZ+So=kMMjN+ZkLB+gHnAy2EZGvhATbANSdfbpnWEMbQYQ@mail.gmail.com>
 <66BD268F973E3544A665E5F503FB38B71AFB7646BB@DC01.bmw-carit.intra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <66BD268F973E3544A665E5F503FB38B71AFB7646BB@DC01.bmw-carit.intra>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Thu, Apr 12, 2012, Mikel Astiz wrote:
> If I understand this correctly, this means we need some kernel
> patches. Either (a) we add the source address in sockaddr_sco so we
> can drop the bind() call (because sco_sock_connect would already
> receive both addresses), or (b) we modify sco_sock_bind such that it
> doesn't complain with EADDRINUSE.
> 
> I don't have much experience with sockets but the second approach
> seems a workaround to me.

Actually b) sounds more like a bugfix than a workaround (and a doesn't
sound like a good idea at all). Returning that error only makes sense
for server sockets but we can't know if this is a server socket or not
at the bind stage. What should probably be done is that the EADDRINUSE
isn't returned for bind() but for listen().

Johan
