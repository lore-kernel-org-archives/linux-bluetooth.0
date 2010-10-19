Return-Path: <cyrus@holtmann.org>
Date: Tue, 19 Oct 2010 16:44:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Pawlik <lucas.pawlik@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix problem with handling CHLD=0 command
Message-ID: <20101019134409.GC13310@jh-x301>
References: <1287491524-8384-1-git-send-email-lucas.pawlik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287491524-8384-1-git-send-email-lucas.pawlik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Tue, Oct 19, 2010, Lukasz Pawlik wrote:
> This patch change handling of CHLD=0 command. Previously both calls
> (held and waiting) were terminated when HS sent CHLD=0. Now all held
> calls will be released or only incoming call will be rejected without
> affecting any held calls.
> ---
>  audio/telephony-maemo6.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)

Thanks. Pushed upstream.

Johan
