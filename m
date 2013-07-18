Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Jul 2013 14:16:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sathish N <sathish.n@globaledgesoft.com>
Cc: linux-bluetooth@vger.kernel.org, girish.br@globaledgesoft.com,
	ajay.kv@globaledgesoft.com, anderson.lizardo@openbossa.org
Subject: Re: [PATCH bluez] attrib: Fix interactive gatttool segfault
Message-ID: <20130718111646.GA4708@x220.p-661hnu-f1>
References: <1374144156-16351-1-git-send-email-sathish.n@globaledgesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1374144156-16351-1-git-send-email-sathish.n@globaledgesoft.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Satish,

On Thu, Jul 18, 2013, Sathish N wrote:
> From: sathish N <sathish.n@globaledgesoft.com>

Since this seems to be your first submission let me confirm these git
author details: is this really how you want your author name to be, i.e.
with a lower case "s" and just "N" as your surname? At least in your
email "From" header your name was with a capital "S".

> ---
>  bluez/attrib/interactive.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

There seems to be something strange with your tree that generates this
extra bluez/* path component. It makes "git am" fail to apply this
patch:

Applying: attrib: Fix interactive gatttool segfault
error: bluez/attrib/interactive.c: does not exist in index
Patch failed at 0001 attrib: Fix interactive gatttool segfault

Besides the above issues the actual change to the code itself looks fine
to me.

Johan
