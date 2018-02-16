Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 16 Feb 2018 12:38:55 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Steve Brown <sbrown@cortland.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] mesh: meshctl: Add subscriptions to node structure and
 json database
Message-ID: <20180216103855.GA30338@x1c.lan>
References: <20180214131832.23518-1-sbrown@cortland.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180214131832.23518-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

On Wed, Feb 14, 2018, Steve Brown wrote:
> sub-add 0101 c000 1000
> 
>               {
>                 "modelId":"1000",
>                 "bind":[
>                   1
>                 ],
>                 "subscribe":[
>                   "c000"
>                 ]
>               },
> ---
>  mesh/config-client.c | 15 +++++++----
>  mesh/node.c          | 20 ++++++++++++++-
>  mesh/node.h          |  2 ++
>  mesh/prov-db.c       | 71 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  mesh/prov-db.h       |  2 ++
>  5 files changed, 99 insertions(+), 11 deletions(-)

Applied. Thanks.

Johan
