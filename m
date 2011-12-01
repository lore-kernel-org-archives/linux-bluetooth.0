Return-Path: <cyrus@holtmann.org>
Date: Thu, 1 Dec 2011 22:34:34 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix byte order problems getting PSM through btio API
Message-ID: <20111201203434.GA16339@fusion.localdomain>
References: <1322670976-9517-1-git-send-email-sancane@gmail.com>
 <CACLukzJWL5=w59ARvwKvz+_Q81=ZJ+4qj_tU0+AxmT4g6847Sw@mail.gmail.com>
 <20111130211600.GA9230@fusion.localdomain>
 <CACLukzJExFe0cYZBwAcU70ajDODJ5_RxVYx4pDxRq9DQCj2z7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACLukzJExFe0cYZBwAcU70ajDODJ5_RxVYx4pDxRq9DQCj2z7g@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Thu, Dec 01, 2011, Santiago Carot wrote:
> As far as I see, CID uses little endian as well, There are some parts
> in the code where the byte conversion is done when BT_IO_OPT_CID is
> provided, for example in l2cap_connect, Conversely, this attribute is
> being provided in bt_io_get without host endian conversion.
> 
> Diving in the code I can see that the gatt-server is getting it in
> ./src/attrib-server.c:1039 so I guess that there is the same problem
> that we had in big endian architectures.

Please also take a look at the kernel side since that's the only way to
be sure. Last time I checked I saw byte-order conversion for CID but not
for PSM (i.e. PSM was expected in little endian whereas CID wasn't).

Johan
