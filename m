Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Dec 2010 12:10:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Bruna Moreira <bruna.moreira@openbossa.org>
Subject: Re: [PATCH 1/3] Initial attribute permission implementation
Message-ID: <20101202101031.GB18808@jh-x301>
References: <1291219986-29913-1-git-send-email-anderson.lizardo@openbossa.org>
 <1291219986-29913-2-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291219986-29913-2-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Dec 01, 2010, Anderson Lizardo wrote:
> +	attrib_db_add(0x0685, &uuid, ATT_ACCESS(ATT_READ, ATT_NONE), atval,
> +									len);
<snip>
> +/* Access permissions */
> +#define ATT_READ	1
> +#define ATT_WRITE	2
> +/* Authentication/Authorization permissions */
> +#define ATT_NONE		0
> +#define ATT_AUTHENTICATION	2
> +#define ATT_AUTHORIZATION	4
> +/* Build bit mask for permission checks */
> +#define ATT_ACCESS(x, y)	(((x) << y) | (x))

The last macro doesn't make any sense to me. Based the core spec it
seems that the values for the different permission types are
implementation specific and not exposed publicly (vol 2, part G, 2.5.1:
"Attribute Permissions is part of the Attribute that cannot be read from
or written to using the Attribute Protocol"). Why not make sure that
they are all orthogonal from the start instead of ssigning the same
value for authentication and writability like you do now. I.e. instead
you could have:

none		0
read		1
write		2
authentication	4
authorization	8

Then you can just or together whatever you want without having any
complex macros for producing the final permissions value. Alternatively
you could also have a simple enum and use set_bit/test_bit marcos (see
lib/hci_lib.h).

Johan
