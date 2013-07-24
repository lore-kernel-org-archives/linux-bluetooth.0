Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Jul 2013 15:46:52 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/4 v2] audio: Move AVRCP related code to its own
 plugin
Message-ID: <20130724224652.GA23025@x220.p-661hnu-f1>
References: <1374666984-14158-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1374666984-14158-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Jul 24, 2013, Luiz Augusto von Dentz wrote:
> This moves AVRCP related code to avrcp plugin and making it possible to
> disable by passing -P avrcp and increasing the modularity of the code.
> ---
> v2: Make media driver part of a2dp plugin as they dependend on one another
> 
>  Makefile.plugins         |  10 +-
>  profiles/audio/avrcp.c   | 345 ++++++++++++++++++++++++++++-------------------
>  profiles/audio/avrcp.h   |   7 -
>  profiles/audio/manager.c | 113 +---------------
>  4 files changed, 214 insertions(+), 261 deletions(-)

All patches in this set have been applied. Thanks.

Johan
