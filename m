Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Jun 2012 15:51:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 00/10] ATT MTU: cosmetic changes
Message-ID: <20120627125107.GA12889@x220>
References: <1340213272-2853-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340213272-2853-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Jun 20, 2012, Claudio Takahasi wrote:
> This patch series contains minor improvements related to ATT MTU and
> GAttrib buffer usage.
> 
> Claudio Takahasi (10):
>   ATT: Avoid invalid memory access for large PDU
>   dis: Reduce array size for PnP ID
>   thermometer: Use GAttrib buffer
>   gatttool: Use GAttrib buffer
>   thermometer: Reduce the array for Valid Range
>   thermometer: Reduce the array for temperature type
>   thermometer: Reduce array size for Measurement Interval
>   proximity: Reduce array size for Tx Power Level
>   generic attribute: Use GAttrib buffer
>   attrib-server: Fix MTU for GATT
> 
>  attrib/att.c              |   17 +++++++++--------
>  attrib/att.h              |    2 +-
>  attrib/client.c           |    6 ++++--
>  attrib/gatttool.c         |   13 +++++++++----
>  attrib/interactive.c      |   12 ++++++++----
>  deviceinfo/deviceinfo.c   |    9 ++++++---
>  proximity/monitor.c       |   10 ++++++----
>  src/attrib-server.c       |    2 +-
>  thermometer/thermometer.c |   31 ++++++++++++++++++++-----------
>  9 files changed, 64 insertions(+), 38 deletions(-)

All patches in this set have been applied. Thanks.

Be careful with the commit message width in the future, it should be max
72 (I had to fix this at least in one patch).

Johan
