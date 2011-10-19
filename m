Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Oct 2011 12:37:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
	claudio.takahasi@openbossa.org
Subject: Re: [PATCH BlueZ] Fix release all sessions on powering adapter off
Message-ID: <20111019093752.GA5790@fusion.localdomain>
References: <1319012398-13859-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319012398-13859-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Wed, Oct 19, 2011, Dmitriy Paliy wrote:
> When adapter is powered off, all sessions should be released without
> changing mode, which is contrary to what session_remove does. This
> prevents from such situation when powering off leads to new mode
> derived from mode_sessions.
> 
> Currently, if there are multiple mode sessions requested by different
> clients, powering adapter off results in powering immediately it on.
> ---
>  src/adapter.c |   14 ++------------
>  1 files changed, 2 insertions(+), 12 deletions(-)

Applied. Thanks.

Johan
