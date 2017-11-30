Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 30 Nov 2017 23:19:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Michal Hobot <michal.hobot@silvair.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] Fix parsing composition data for custom models
Message-ID: <20171130211906.GA6133@x1c.home>
References: <616ECE7C-5CD6-43DB-8B11-5F6A786DA61E@silvair.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <616ECE7C-5CD6-43DB-8B11-5F6A786DA61E@silvair.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Thu, Nov 30, 2017, Michal Hobot wrote:
> Custom model ids consist of model id and vendor id. Instead, vendor id
> was used twice to build model id.
> ---
>  mesh/node.c    | 2 +-
>  mesh/prov-db.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
