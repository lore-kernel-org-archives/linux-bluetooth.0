Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Jan 2012 13:00:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] Add Proximity Reporter API
Message-ID: <20120123110038.GD13100@x220>
References: <CAKT1EBfCGV8GjzVdJ-UKRZOuKRZ_ftijCwJ_DRuRssac7+yYiw@mail.gmail.com>
 <1326998219-2255-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326998219-2255-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Jan 19, 2012, Claudio Takahasi wrote:
> Adds API for Immediate Alert Service(IAS) abstraction. IAS is used
> by Proximity Monitors and Find Me Locators to notify the user that
> reporter/target has been found. This new interface combines Proximity
> Reporter and Find Me Target in the same API providing the flexibility
> to implement external applications to control alerts(including per
> device alerts).
> 
> This abstraction allows the development of platform specific
> applications to control Immediate Alert coming from Proximity Monitor
> and Find Me Locator. This provides flexibility to define different level
> and tone for each device. Use case: watch finding a mobile phone.
> ---
>  doc/proximity-api.txt |   34 ++++++++++++++++++++++++++++++++--
>  1 files changed, 32 insertions(+), 2 deletions(-)

Both patches have been applied. Thanks.

Johan
