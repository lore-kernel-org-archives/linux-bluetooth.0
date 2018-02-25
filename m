Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sun, 25 Feb 2018 20:34:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Steve Brown <sbrown@cortland.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] mesh: prov-db: Correct json database parsing
Message-ID: <20180225183431.GB14209@x1c.home>
References: <20180216122001.6923-1-sbrown@cortland.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180216122001.6923-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

On Fri, Feb 16, 2018, Steve Brown wrote:
>     "composition": {
>         "cid": "0002",
>         "pid": "0010",
>         "vid": "0001",
>         "crpl": "000a",
>         "features": {
>             "relay": false,
>             "proxy": true,
>             "friend": false,
>             "lowPower": false
>         },
>         "elements": [
>             {
>                 "elementIndex": 0,
>                 "location": "0001",
>                 "models": ["0000", "0001", "1001"]
>             }
>         ]
>     },
> ---
>  mesh/prov-db.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

Both patches in this set have been applied. Thanks.

Johan
