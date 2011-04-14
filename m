Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Apr 2011 20:07:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix race condition on gatttool
Message-ID: <20110414170728.GC7152@jh-x301>
References: <1302544624-5216-1-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1302544624-5216-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

On Mon, Apr 11, 2011, Sheldon Demario wrote:
> When the connect_cb() takes too long to be called the event_loop goes to idle
> state and executes the callback too early
> ---
>  attrib/gatttool.c |  128 +++++++++++++++++++++++++---------------------------
>  1 files changed, 62 insertions(+), 66 deletions(-)

Thanks, the patch has been pushed upstream. Could you please fix your
editor settings so that it doesn't produce lines longer than 74
characters for git commit messages? I had to manually edit it this time.

Johan
