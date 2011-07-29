Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 Jul 2011 12:14:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix global_mode shall be updated by plug-in
Message-ID: <20110729091418.GA11061@dell>
References: <1311928428-5708-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311928428-5708-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Fri, Jul 29, 2011, Dmitriy Paliy wrote:
> Currently, use of RequestSession and SetProperty adapter method
> calls sets global_mode to on. Switching adapter off via plug-in
> interface in this scenario releases all sessions, that, in turn,
> restores adapter's state to global_mode, which is on.
> 
> Result is the adapter is switched off and immediately switched on.
> This patch fixes such inconsistency by overwriting global_mode to
> mode off when request comes from plug-in.
> ---
>  src/adapter.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Applied. Thanks.

Johan
