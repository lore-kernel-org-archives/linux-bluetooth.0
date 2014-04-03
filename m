Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_P+OjFYyggY4g_TTZJ7V1H7a46k45KntCZxnTwFRCE4ZA@mail.gmail.com>
References: <1396518234-8375-1-git-send-email-marcin.kraglak@tieto.com>
	<CAJdJm_P+OjFYyggY4g_TTZJ7V1H7a46k45KntCZxnTwFRCE4ZA@mail.gmail.com>
Date: Thu, 3 Apr 2014 10:01:21 -0400
Message-ID: <CAJdJm_NYJ3+j-RNJK60CamCOCKkFHik9mZ4260P95PnQkPoE8A@mail.gmail.com>
Subject: Re: [RFC] gatt: Add API for creating services
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thu, Apr 3, 2014 at 9:34 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> So here is my *personal* proposal: you create an attribute database
> management API in src/shared (e.g. src/shared/gatt-db.c), which could
> be shared by src/gatt.c and Android's android/gatt.c. This API would
> reference attributes and attribute groups (i.e. services and
> characteristics) by handle.
>
> This API needs functions for:
> [...]

BTW, If you guys agree this attribute database API may work well for
Android needs, I'll proceed implementing an initial version and send
patches to the list as RFC (so hopefully it becomes clearer with
working source code). IMHO it helps both Android and Linux if we have
code in src/shared that can be useful to both code bases.

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
