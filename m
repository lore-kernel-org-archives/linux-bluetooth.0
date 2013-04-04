Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Apr 2013 20:49:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2] audio: Track connections to AVRCP roles
 separately
Message-ID: <20130404174918.GA9018@x220.ger.corp.intel.com>
References: <1363611806-8152-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363611806-8152-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Mar 18, 2013, Luiz Augusto von Dentz wrote:
> Currently the code assumes when one role connects the other must be
> connected as well which is bogus and can create problems.
> ---
> v2: Use controller instead of remote
> 
>  profiles/audio/avrcp.c   | 14 ++++++++++++++
>  profiles/audio/control.c |  9 ---------
>  profiles/audio/manager.c | 14 +++++++++++---
>  profiles/audio/manager.h |  6 ++++--
>  4 files changed, 29 insertions(+), 14 deletions(-)

Applied. Thanks.

Johan
