Return-Path: <cyrus@holtmann.org>
Date: Fri, 30 Mar 2012 13:25:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH v2 BlueZ 8/8] gattrib: Protect GAttrib when there is a
 pending write
Message-ID: <20120330102545.GB9799@x220>
References: <1332349255-15764-1-git-send-email-anderson.lizardo@openbossa.org>
 <1332881029-1732-1-git-send-email-anderson.lizardo@openbossa.org>
 <1332881029-1732-9-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332881029-1732-9-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Mar 27, 2012, Anderson Lizardo wrote:
> From: Claudio Takahasi <claudio.takahasi@openbossa.org>
> 
> ---
>  attrib/gattrib.c |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)

Patches 6 and 7 have also been applied but there was one minor thing
with this one:

> +	if (attrib->write_watch != 0)
> +		return;

Could you please try to be consistent with the rest of the code base and
use > 0 for watch id tests.

So I'll be awaiting v3's of patch 5 and 8.

Johan
