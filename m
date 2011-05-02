Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 May 2011 10:24:48 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaikumar Ganesh <jaikumar@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix property type of Main Channel of Health plugin
Message-ID: <20110502172448.GB13914@jh-x301>
References: <1304110863-26528-1-git-send-email-jaikumar@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1304110863-26528-1-git-send-email-jaikumar@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaikumar,

On Fri, Apr 29, 2011, Jaikumar Ganesh wrote:
> The property type must be DBUS_TYPE_OBJECT_PATH instead
> of DBUS_TYPE_STRING. This is in sync with the documentation
> and with the other places of usage such as the property change
> signal.
> ---
>  health/hdp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Pushed upstream. Thanks.

Johan
