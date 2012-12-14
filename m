Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1355503519-26573-3-git-send-email-frederic.danis@linux.intel.com>
References: <1355503519-26573-1-git-send-email-frederic.danis@linux.intel.com>
	<1355503519-26573-3-git-send-email-frederic.danis@linux.intel.com>
Date: Fri, 14 Dec 2012 13:31:04 -0400
Message-ID: <CAJdJm_M+6CbRr-uyfsqZtfvPtKiPYxq9H2bf1D0E5zot4TUHNw@mail.gmail.com>
Subject: Re: [PATCH 3/5] adapter: Convert ccc file
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Danis?=
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Fri, Dec 14, 2012 at 12:45 PM, Frédéric Danis
<frederic.danis@linux.intel.com> wrote:
> ---
>  doc/settings-storage.txt |   14 +++++++++++
>  src/adapter.c            |   63 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+)
>
> diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
> index 11b127f..ced51d9 100644
> --- a/doc/settings-storage.txt
> +++ b/doc/settings-storage.txt
> @@ -31,6 +31,7 @@ contains:
>     contains:
>      - an info file
>      - an attributes file containing attributes of remote LE services
> +    - a ccc file containing CCC info of remote LE services

Just a few textual improvements:

"- a ccc file containing persistent Client Characteristic
Configuration (CCC) descriptor information for GATT characteristics"

> +CCC file format
> +======================
> +
> +The ccc file stores CCC  informations related to remote device.
> +
> +Informations are stored using their handle as group name (decimal format).

"""
The ccc file stores the current CCC descriptor values for GATT
characteristics which have notification/indication enabled by the
remote device.

Information is stored using CCC attribute handle as group name (in
decimal format).
"""

> +
> +Each group contains:
> +
> +  Value                        String          Value of the CCC as hexadecimal encoded

"CCC descriptor value encoded in hexadecimal"

> +                                       string
> +

Everything else looks good as per my review.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
