Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 Jun 2010 16:05:31 +0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/8] Fix regression with debug via SIGUSR2
Message-ID: <20100608080531.GB1839@jh-x301>
References: <1275981114-18019-1-git-send-email-gustavo@padovan.org>
 <1275981114-18019-2-git-send-email-gustavo@padovan.org>
 <1275981114-18019-3-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1275981114-18019-3-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Jun 08, 2010, Gustavo F. Padovan wrote:
> The new dynamic debug feature was not using the SIGUSR2 signal so this was
> causing bluetoothd to crash when one tries to toggle debug via SIGUSR2.
> This patch brings back such compatibility andadds debug_string and
> debug_enabled vars.
> ---
>  src/log.c  |   17 +++++++++++++++--
>  src/log.h  |    6 +++++-
>  src/main.c |    8 ++++++++
>  3 files changed, 28 insertions(+), 3 deletions(-)

I've commited the debug patches this far, i.e. the D-Bus changes aren't
in yet. I'd like to get a quick ok from Marcel before pushing (both on
the concept itself as well as the names for the new Manager properties).

Johan
