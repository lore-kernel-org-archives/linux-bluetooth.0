Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171102143847.3614-1-hadess@hadess.net>
References: <20171102143847.3614-1-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 3 Nov 2017 13:22:18 +0200
Message-ID: <CABBYNZ+5ckCDY4tmVfi+1Cg8775hnq1PLPK=LaEUv_UD7qJhow@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] battery: Add BT SIG reserved number used by
 Battery Service
To: Bastien Nocera <hadess@hadess.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Nov 2, 2017 at 4:38 PM, Bastien Nocera <hadess@hadess.net> wrote:
> Add the Battery Level UUID as per:
> https://www.bluetooth.com/specifications/gatt/viewer?attributeXmlFile=org.bluetooth.characteristic.battery_level.xml
> ---
>  lib/uuid.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/uuid.h b/lib/uuid.h
> index 2c57a3378..7e13e0fda 100644
> --- a/lib/uuid.h
> +++ b/lib/uuid.h
> @@ -119,6 +119,7 @@ extern "C" {
>  #define GATT_CHARAC_RECONNECTION_ADDRESS               0x2A03
>  #define GATT_CHARAC_PERIPHERAL_PREF_CONN               0x2A04
>  #define GATT_CHARAC_SERVICE_CHANGED                    0x2A05
> +#define GATT_CHARAC_BATTERY_LEVEL                      0x2A19
>  #define GATT_CHARAC_SYSTEM_ID                          0x2A23
>  #define GATT_CHARAC_MODEL_NUMBER_STRING                        0x2A24
>  #define GATT_CHARAC_SERIAL_NUMBER_STRING               0x2A25
> --
> 2.14.3

Applied, thanks.

-- 
Luiz Augusto von Dentz
