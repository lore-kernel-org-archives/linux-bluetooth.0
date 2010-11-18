Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Nov 2010 23:16:13 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Implement Characteristic Value Read using UUID in the
 gatttool
Message-ID: <20101118211613.GA9786@jh-x301>
References: <1290113736-9432-1-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1290113736-9432-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

On Thu, Nov 18, 2010, Sheldon Demario wrote:
> Sub-procedure used to read a Characteristic Value when the client
> only knows the characteristic UUID and doesn't know the handle.
> More than one handle and attribute value pair can be returned,
> it is up to the user define the handles range based on the service
> handles range.
> 
> Usage example:
> $gatttool --char-read --uuid=2a00 -i hcix -b xx:xx:xx:xx:xx:xx
> ---
>  attrib/gatt.c     |   13 ++++++++++++-
>  attrib/gatt.h     |    4 ++++
>  attrib/gatttool.c |   39 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 55 insertions(+), 1 deletions(-)

Doesn't compile:

attrib/gatt.c: In function ‘gatt_discover_char’:
attrib/gatt.c:79: error: unused variable ‘plen’
attrib/gatt.c:77: error: unused variable ‘pdu’
make[1]: *** [attrib/gatt.o] Error 1

Always check your patches against ./bootstrap-configure

Furthermore, there's at least one coding style issue:

> +guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
> +					uuid_t *uuid, GAttribResultFunc func,
> +							gpointer user_data)

The lines after the first one should all have the same indentation, i.e.
the third one has one tab too much.

Johan
