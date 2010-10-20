Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Oct 2010 13:38:02 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Balamurugan Mahalingam <mbalamurugan@atheros.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
	charubala@charubala.com
Subject: Re: [PATCH] Fix hidd to use ServiceName attribute for device name
Message-ID: <20101020103802.GA9794@jh-x301>
References: <1287570077-5669-1-git-send-email-mbalamurugan@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287570077-5669-1-git-send-email-mbalamurugan@atheros.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Oct 20, 2010, Balamurugan Mahalingam wrote:
> This patch lets hidd use ServiceName attribute from the SDP response
> instead of ProviderName+ServiceDescription for device name.
> SDP response from Microsoft Bluetooth device has extended ASCII
> character 174(registered symbol) in its ServiceDescription attribute.
> This causes some Bluetooth application which expects only printable
> characters as device name to crash.
> ---
>  compat/sdp.c |   33 +++++++++++++++++----------------
>  1 files changed, 17 insertions(+), 16 deletions(-)

The patch has been pushed upstream. Thanks.

Johan
