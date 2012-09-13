Return-Path: <cyrus@holtmann.org>
Message-ID: <50522A54.4050907@butterbrot.org>
Date: Thu, 13 Sep 2012 20:47:48 +0200
From: Florian Echtler <floe@butterbrot.org>
MIME-Version: 1.0
To: David Herrmann <dh.herrmann@googlemail.com>
CC: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Subject: Re: [PATCH] wiimote: add Wii Balance Board detection
References: <1347485573-23623-1-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1347485573-23623-1-git-send-email-dh.herrmann@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Confirmed to work, with patch applied against 4.101 Ubuntu package.

Florian

On 12.09.2012 23:32, David Herrmann wrote:
> Add the name of the Wii Balance Board so it can be paired with BlueZ like
> any other Wii Remote. Reported by Florian Echtler.
> ---
>   plugins/wiimote.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/plugins/wiimote.c b/plugins/wiimote.c
> index 337d408..3d16966 100644
> --- a/plugins/wiimote.c
> +++ b/plugins/wiimote.c
> @@ -76,6 +76,7 @@ static ssize_t wii_pincb(struct btd_adapter *adapter, struct btd_device *device,
>   	name[sizeof(name) - 1] = 0;
>
>   	if (g_str_equal(name, "Nintendo RVL-CNT-01") ||
> +	    g_str_equal(name, "Nintendo RVL-WBC-01") ||
>   				(vendor == 0x057e && product == 0x0306)) {
>   		DBG("Forcing fixed pin on detected wiimote %s", addr);
>   		memcpy(pinbuf, &sba, 6);
>


-- 
SENT FROM MY DEC VT50 TERMINAL
