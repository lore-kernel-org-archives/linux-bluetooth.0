Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Oct 2011 14:05:12 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel Wagner <wagi@monom.org>
Cc: linux-bluetooth@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [PATCH v1] main: Use glib signal handler
Message-ID: <20111028110512.GC15672@fusion.localdomain>
References: <1319024783-11087-1-git-send-email-wagi@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319024783-11087-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Wed, Oct 19, 2011, Daniel Wagner wrote:
> Writing anything to syslog in the signal hander is in danger
> to deadlock with any ongoing syslog write (syslock is taking
> a mutex). Fortunatly, BlueZ's signal handler doesn't do this,
> therefore the change isn't strickly necessary, but the same changes
> were done to oFono and ConnMan. So this patch streamlines BlueZ
> with the other projects.
> ---
>  src/main.c |   97 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
>  1 files changed, 79 insertions(+), 18 deletions(-)

Applied. Thanks.

Johan
