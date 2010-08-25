Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Aug 2010 18:03:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Vrabel <david.vrabel@csr.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: bluetoothd does not check remote names for valid utf8 data
Message-ID: <20100825150323.GA28680@jh-x301>
References: <4C75292E.9080304@csr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4C75292E.9080304@csr.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Wed, Aug 25, 2010, David Vrabel wrote:
> bluetoothd does not check in some (all?) places that the remote name
> reported by a device is valid utf8 data.  e.g., extract_eir_name() in
> src/dbus-hci.c.
> 
> The reception of an extended inquiry response containing a name with
> invalid utf8 data can cause the dbus interface to disappear.  This is
> therefore a denial-of-service vulnerability (at the very least).
> 
> The following patch fixes the above problem but there are probably other
> places where the check needs to be done.
> 
> --- bluez-4.51.orig/src/dbus-hci.c
> +++ bluez-4.51/src/dbus-hci.c
> @@ -450,6 +450,8 @@
>  	switch (*type) {
>  	case 0x08:
>  	case 0x09:
> +		if (!g_utf8_validate(data + 2, data[0] - 1, NULL))
> +			return strdup("");
>  		return strndup((char *) (data + 2), data[0] - 1);
>  	}

Good catch. At least the legacy name queries are already protected
(remote_name_information function in security.c) so I think this is the only
place missing the UTF-8 validation. However, your patch doesn't compile cleanly
so some fine tuning is still needed (always check compilation with
"./bootstrap-configure && make" before sending upstream):

src/dbus-hci.c: In function ‘extract_eir_name’:
src/dbus-hci.c:466: error: pointer targets in passing argument 1 of ‘g_utf8_validate’ differ in signedness
/usr/include/glib-2.0/glib/gunicode.h:356: note: expected ‘const gchar *’ but argument is of type ‘uint8_t *’
make[1]: *** [src/dbus-hci.o] Error 1

After fixing that, could you prepare the patch through git format-patch so that
I can easily apply it using git am? Thanks.

Johan
