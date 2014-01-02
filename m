Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1388667286-28993-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1388667286-28993-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Thu, 2 Jan 2014 16:18:14 +0200
Message-ID: <CABBYNZJ5KvVv3MUgMMMZ46BjX9iEnbBrcpZ4toh1SNV7iML7mA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] sdp: Add MAP_PROFILE_ID
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Szymon Janc <szymon.janc@tieto.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Thu, Jan 2, 2014 at 2:54 PM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> ---
>  lib/sdp.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/sdp.h b/lib/sdp.h
> index f2f2484..c6dfc27 100644
> --- a/lib/sdp.h
> +++ b/lib/sdp.h
> @@ -207,6 +207,7 @@ extern "C" {
>  #define PBAP_PCE_PROFILE_ID            PBAP_PCE_SVCLASS_ID
>  #define PBAP_PSE_PROFILE_ID            PBAP_PSE_SVCLASS_ID
>  #define PBAP_PROFILE_ID                        PBAP_SVCLASS_ID
> +#define MAP_PROFILE_ID                 MAP_SVCLASS_ID
>  #define PNP_INFO_PROFILE_ID            PNP_INFO_SVCLASS_ID
>  #define GENERIC_NETWORKING_PROFILE_ID  GENERIC_NETWORKING_SVCLASS_ID
>  #define GENERIC_FILETRANS_PROFILE_ID   GENERIC_FILETRANS_SVCLASS_ID
> --
> 1.8.4
>

Applied, thanks.

-- 
Luiz Augusto von Dentz
