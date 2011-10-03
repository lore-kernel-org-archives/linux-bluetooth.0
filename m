Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Oct 2011 11:54:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] AVRCP: return empty string instead of rejecting
Message-ID: <20111003085430.GD8956@fusion.localdomain>
References: <1317249357-1362-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317249357-1362-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Wed, Sep 28, 2011, Lucas De Marchi wrote:
> If media attribute is not available for a certain media file, return an
> empty string instead of rejecting the request. The spec is not so clear
> if only the title should be handled as an empty string when not present,
> but this is the only alternative to rejecting the request.
> 
> IOP tests showed that some CT devices don't like reject messages: they
> never ask for an attribute again if they previously received a REJECTED
> message for that attribute. They consider REJECTED as "TG doesn't
> implement it these optional attributes" as opposed to what we had
> before, "this attribute is currently not available".
> ---
>  audio/avrcp.c |   41 +++++++++++++++++++----------------------
>  1 files changed, 19 insertions(+), 22 deletions(-)

Both patches applied. Thanks.

Johan
