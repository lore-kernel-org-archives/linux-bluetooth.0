Return-Path: <cyrus@holtmann.org>
Date: Wed, 7 Dec 2011 16:58:51 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/6] Implement SetProperty D-Bus method
Message-ID: <20111207145851.GA19842@x220>
References: <1321973388-16300-1-git-send-email-sancane@gmail.com>
 <1321973388-16300-2-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321973388-16300-2-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Tue, Nov 22, 2011, Santiago Carot-Nemesio wrote:
> ---
>  thermometer/thermometer.c |  118 +++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 99 insertions(+), 19 deletions(-)

Is this patch set still valid? If so, could you resend it with proper
commit messages. "Implement SetProperty D-Bus method" is much too
generic. It'd be nice if you could start using the convention we've
tried to adopt where we add context dependent prefixes to the message
summaries. In this case "thermometer: Add SetProperty D-Bus method"
would have already given enough of context to not have to look at the
patch content to know what it does.

Johan
