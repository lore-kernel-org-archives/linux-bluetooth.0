Return-Path: <cyrus@holtmann.org>
Date: Fri, 10 May 2013 14:26:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	keybuk@chromium.org
Subject: Re: [PATCH] doc: Document missing errors returned by the Device1 API.
Message-ID: <20130510112650.GA16027@x220.P-661HNU-F1>
References: <1368126588-19304-1-git-send-email-deymo@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1368126588-19304-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Thu, May 09, 2013, Alex Deymo wrote:
> There were two groups of missing error messages in the documentation:
> * For org.bluez.Device1.DisconnectProfile:
>   This method could certainly call btd_error_not_supported or
>   btd_error_failed returning those errors.
> * For org.bluez.Device1.Pair:
>   The pairing process could certainly call new_authentication_return
>   which can return (and actualy does) five other different errors.
> ---
> 
> Hi,
> Those are just a few I found, but didn't check rigorously all the functions.
> This is at least a progress.
> Thanks!
> Alex.
> 
> 
>  doc/device-api.txt | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied. Thanks.

Johan
