Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1354193256-30610-3-git-send-email-mikel.astiz.oss@gmail.com>
References: <1354193256-30610-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1354193256-30610-3-git-send-email-mikel.astiz.oss@gmail.com>
Date: Fri, 30 Nov 2012 08:28:00 -0400
Message-ID: <CAJdJm_PYpbCoWngU_cvBCLTW9hOBKpM0ci1BrTiGW-i8=tjvWA@mail.gmail.com>
Subject: Re: [RFC v2 02/15] test: Add utility library for python scripts
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Thu, Nov 29, 2012 at 8:47 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> +def find_adapter_in_objects(objects, pattern=None):
> +       bus = dbus.SystemBus()
> +       for path, ifaces in objects.iteritems():
> +               adapter = ifaces.get(ADAPTER_INTERFACE)
> +               if adapter == None:
> +                       continue

It is usually considered bad to use "== None" in Python. Either use
"adapter is None" or just "not adapter" (which is broader, but is
probably okay in this context).

> +               if (pattern == None or pattern == adapter["Address"] or
> +                                                       path.endswith(pattern)):

Same here, better use "pattern is None" or "not pattern" (which will
also match empty strings, which will always match due to the
"endswith()" usage).

> +                       obj = bus.get_object(SERVICE_NAME, path)
> +                       return dbus.Interface(obj, ADAPTER_INTERFACE)
> +       raise Exception("Bluetooth adapter not found")

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
