Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Sep 2012 14:08:33 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 BlueZ 1/4] gatt: Add support for find included services
Message-ID: <20120928110833.GB14450@x220>
References: <1348526019-28402-1-git-send-email-vinicius.gomes@openbossa.org>
 <1348526019-28402-2-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348526019-28402-2-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Mon, Sep 24, 2012, Vinicius Costa Gomes wrote:
> Some services like HID over LE can reference another service using
> included services.
> 
> See Vol 3, Part G, section 2.6.3 of Core specification for more
> details.
> ---
>  attrib/gatt.c | 194 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  attrib/gatt.h |   9 +++
>  2 files changed, 203 insertions(+)

This one doesn't apply:

Applying: gatt: Add support for find included services
WARNING:LONG_LINE: line over 80 characters
#107: FILE: attrib/gatt.c:335:
+					resolve_included_uuid_cb, resolve, NULL);

Btw, if you guys are wondering why the stricter coding style checks,
I've added the following to .git/hooks/pre-{commit,applypatch}:

git diff --cached | ~/src/linux/scripts/checkpatch.pl --no-signoff --ignore INITIALISED_STATIC,NEW_TYPEDEFS,VOLATILE --show-types --mailback -

You might want to do the same (with the correct path to checkpatch.pl)).
And thanks to Luiz for the idea (he's using the same when applying
patches).

Johan
