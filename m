Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Jul 2011 16:37:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Move attrib server init/exit declaration to hcid.h
Message-ID: <20110714133706.GB2770@dell.ger.corp.intel.com>
References: <1310497518-19526-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310497518-19526-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, Jul 12, 2011, Claudio Takahasi wrote:
> Avoids GATT/ATT headers dependency in main.c.
> ---
>  src/attrib-server.h |    3 ---
>  src/hcid.h          |    3 +++
>  src/main.c          |    1 -
>  3 files changed, 3 insertions(+), 4 deletions(-)

Applied. I supposed it'd make sense to come up with a new name for
hcid.h since there's no such thing as hcid anymore. Suggestions?

Johan
