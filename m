Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] tools/csr_usb: Fix compilation failure
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1504612685.6911.12.camel@hadess.net>
Date: Tue, 5 Sep 2017 15:05:15 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <852B29E6-9F18-40A5-B870-E408268AC78D@holtmann.org>
References: <20170905083534.19184-1-hadess@hadess.net>
 <FD40CF28-55D4-4091-BAD7-97168812A6B8@holtmann.org>
 <1504612685.6911.12.camel@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

>>> GCC's "format-nonliteral" security check is enabled as an error in
>>> recent versions of Fedora. Given the reduced scope of use, mark the
>>> error as ignorable through pragma.
>>> 
>>> tools/csr_usb.c: In function 'read_value':
>>> tools/csr_usb.c:82:2: error: format not a string literal, argument
>>> types not checked [-Werror=format-nonliteral]
>>> n = fscanf(file, format, &value);
>>> ^
>>> ---
>>> tools/csr_usb.c | 3 +++
>>> 1 file changed, 3 insertions(+)
>>> 
>>> diff --git a/tools/csr_usb.c b/tools/csr_usb.c
>>> index a1d7324f7..33e9968a2 100644
>>> --- a/tools/csr_usb.c
>>> +++ b/tools/csr_usb.c
>>> @@ -67,6 +67,8 @@ struct usbfs_bulktransfer {
>>> #define USBFS_IOCTL_CLAIMINTF	_IOR('U', 15, unsigned int)
>>> #define USBFS_IOCTL_RELEASEINTF	_IOR('U', 16, unsigned int)
>>> 
>>> +#pragma GCC diagnostic push
>>> +#pragma GCC diagnostic ignored "-Wformat-nonliteral"
>>> static int read_value(const char *name, const char *attr, const
>>> char *format)
>>> {
>>> 	char path[PATH_MAX];
>>> @@ -88,6 +90,7 @@ static int read_value(const char *name, const
>>> char *attr, const char *format)
>>> 	fclose(file);
>>> 	return value;
>>> }
>>> +#pragma GCC diagnostic pop
>> 
>> can’t we just use __attribute__((format)) somehow to declare this a
>> format specify?
> 
> Sorry, I'm not sure I understand.
> 
> gcc already knows that this is a format, but because the format changes
> depending on the caller, it cannot actually assert whether the format
> is safe for the arguments passed.
> 
> So this would work:
> vendor = read_value(name, "idVendor", "%04x");
> 
> But the compiler can't see that:
> vendor = read_value(name, "idVendor", "%s");
> would fail at compile time.

since these values are all marked as const, this compiler error is than pretty purely implemented. It could actually traverse this since they are const format strings.

> Would you prefer something like this (untested, but should work):
> diff --git a/tools/csr_usb.c b/tools/csr_usb.c
> index a1d7324f7..c5a39899a 100644
> --- a/tools/csr_usb.c
> +++ b/tools/csr_usb.c
> @@ -67,7 +67,7 @@ struct usbfs_bulktransfer {
> #define USBFS_IOCTL_CLAIMINTF  _IOR('U', 15, unsigned int)
> #define USBFS_IOCTL_RELEASEINTF        _IOR('U', 16, unsigned int)
> 
> -static int read_value(const char *name, const char *attr, const char *format)
> +static int read_value(const char *name, const char *attr, bool hex_number)
> {
>        char path[PATH_MAX];
>        FILE *file;
> @@ -79,7 +79,7 @@ static int read_value(const char *name, const char *attr, const char *format)
>        if (!file)
>                return -1;
> 
> -       n = fscanf(file, format, &value);
> +       n = fscanf(file, hex_number ? "%d" : "%04x", &value);
>        if (n != 1) {
>                fclose(file);
>                return -1;
> @@ -94,21 +94,21 @@ static char *check_device(const char *name)
>        char path[PATH_MAX];
>        int busnum, devnum, vendor, product;
> 
> -       busnum = read_value(name, "busnum", "%d");
> +       busnum = read_value(name, "busnum", false);
>        if (busnum < 0)
>                return NULL;
> 
> -       devnum = read_value(name, "devnum", "%d");
> +       devnum = read_value(name, "devnum", false);
>        if (devnum < 0)
>                return NULL;
> 
>        snprintf(path, sizeof(path), "/dev/bus/usb/%03u/%03u", busnum, devnum);
> 
> -       vendor = read_value(name, "idVendor", "%04x");
> +       vendor = read_value(name, "idVendor", true);
>        if (vendor < 0)
>                return NULL;
> 
> -       product = read_value(name, "idProduct", "%04x");
> +       product = read_value(name, "idProduct", true);
>        if (product < 0)
>                return NULL;

So something with your mailer went bogus here. It should be all proper tabs.

Anyhow, I am fine doing that, but I disliked the true or false parameters if they are not obvious. So maybe adding some like this would be good.

#define read_hex_value(name, file) read_value((name), (file), true)
#define read_num_value(name, file) read_value((name), (file), false)

Then the calling code becomes easy to understand again you don’t have to guess what the boolean value is for.

Regards

Marcel

