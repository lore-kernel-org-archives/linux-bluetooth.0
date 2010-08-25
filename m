Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Aug 2010 00:38:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Vrabel <david.vrabel@csr.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: bluetoothd does not check remote names for valid utf8 data
Message-ID: <20100825213838.GA2765@jh-x301>
References: <4C75292E.9080304@csr.com>
 <20100825150323.GA28680@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20100825150323.GA28680@jh-x301>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi again,

On Wed, Aug 25, 2010, Johan Hedberg wrote:
> Good catch. At least the legacy name queries are already protected
> (remote_name_information function in security.c) so I think this is the only
> place missing the UTF-8 validation. However, your patch doesn't compile cleanly
> so some fine tuning is still needed (always check compilation with
> "./bootstrap-configure && make" before sending upstream):
> 
> src/dbus-hci.c: In function ‘extract_eir_name’:
> src/dbus-hci.c:466: error: pointer targets in passing argument 1 of ‘g_utf8_validate’ differ in signedness
> /usr/include/glib-2.0/glib/gunicode.h:356: note: expected ‘const gchar *’ but argument is of type ‘uint8_t *’
> make[1]: *** [src/dbus-hci.o] Error 1

Since this was the only thing blocking a new release I went ahead and
fixed the issue myself. The (fixed) patch is now upstream.

Johan
