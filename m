Return-Path: <cyrus@holtmann.org>
Date: Fri, 30 Mar 2012 13:23:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH v2 BlueZ 5/8] attrib: Fix missing Discovery reply when
 disconnected
Message-ID: <20120330102304.GA9799@x220>
References: <1332349255-15764-1-git-send-email-anderson.lizardo@openbossa.org>
 <1332881029-1732-1-git-send-email-anderson.lizardo@openbossa.org>
 <1332881029-1732-6-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332881029-1732-6-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Mar 27, 2012, Anderson Lizardo wrote:
> From: Claudio Takahasi <claudio.takahasi@openbossa.org>
> 
> This patch fixes missing reply for DiscoverCharacteristics method on
> Generic Attribute. If link is disconnected reply message is not sent.
> ---
>  attrib/client.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)

I've applied the first four patches but there was something in this one
that bothered me:

> diff --git a/attrib/client.c b/attrib/client.c
> index ce78ed6..57cd028 100644
> --- a/attrib/client.c
> +++ b/attrib/client.c
> @@ -356,6 +356,20 @@ static void attio_disconnected(gpointer user_data)
>  {
>  	struct gatt_service *gatt = user_data;
>  
> +	if (gatt->query) {
> +		if (gatt->query->msg) {
> +			DBusMessage *reply;
> +
> +			reply = btd_error_failed(gatt->query->msg,
> +						strerror(ECONNRESET));

What's the point of picking a POSIX error and using its glibc string
translation here? Why don't you provide your own string instead which
can be much more understandable for someone who reads the logs, e.g.
"Attribute IO got disconnected" or whatever makes more sense.

Johan
