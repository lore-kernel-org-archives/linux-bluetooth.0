Return-Path: <cyrus@holtmann.org>
Date: Sun, 27 Jan 2013 18:03:47 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] media: Fix custom property registration for
 multiple adapters
Message-ID: <20130128000347.GA15519@x220>
References: <1358775253-29202-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1358775253-29202-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Jan 21, 2013, Luiz Augusto von Dentz wrote:
> The function btd_profile_add_custom_prop register a custom property for
> an UUID which is valid for every adapter so its user_data cannot be tied
> to a single adapter.
> 
> To fix this now NULL is passed as user_data and the callbacks checks if
> the adapter passed has been registered and if there is an endpoint for
> the UUID requested.
> ---
>  profiles/audio/media.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)

Applied. Thanks.

Johan
