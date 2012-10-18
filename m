Return-Path: <cyrus@holtmann.org>
Message-ID: <50800C08.6040100@monom.org>
Date: Thu, 18 Oct 2012 16:02:48 +0200
From: Daniel Wagner <wagi@monom.org>
MIME-Version: 1.0
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?=
	<frederic.danis@linux.intel.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 01/15] doc: Add settings storage documentation
References: <1350550858-12239-1-git-send-email-frederic.danis@linux.intel.com> <1350550858-12239-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1350550858-12239-2-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On 18.10.2012 11:00, Frédéric Danis wrote:
> ---
>   doc/settings-storage.txt |  106 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 106 insertions(+)
>   create mode 100644 doc/settings-storage.txt
>
> diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
> new file mode 100644
> index 0000000..bc9ac66
> --- /dev/null
> +++ b/doc/settings-storage.txt
> @@ -0,0 +1,106 @@
> +Information related to local adapters and remote devices are stored in storage
> +directory (default: /var/lib/bluetooth).
> +Files are in ini-file format.
> +
> +There is one directory per adapter, named by its bluetooth address, which
> +contains:
> + - a settings file for the local adapter
> + - an attribute_db file containing attributes of supported LE services
> + - names file containing names of all devices already seen
> + - one directory per remote device, named by remote device address, which
> +   contains:
> +    - a settings file
> +    - a key file accessible only by root
> +    - an attribute_db file containing attributes of remote LE services
> +
> +So the directory structure should be:

"should be" -> "is"?

cheers,
daniel
