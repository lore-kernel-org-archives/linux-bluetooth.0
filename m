Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Apr 2012 13:24:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arek Lichwa <Arkadiusz.Lichwa@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] lib: Populate response status field with rigth
 error code value taken from command status event.
Message-ID: <20120404102430.GB29893@x220>
References: <1331291566-8997-1-git-send-email-Arkadiusz.Lichwa@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331291566-8997-1-git-send-email-Arkadiusz.Lichwa@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arek,

On Fri, Mar 09, 2012, Arek Lichwa wrote:
> ---
>  lib/hci.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/lib/hci.c b/lib/hci.c
> index 269c021..186d408 100644
> --- a/lib/hci.c
> +++ b/lib/hci.c
> @@ -1156,6 +1156,7 @@ int hci_send_req(int dd, struct hci_request *r, int to)
>  
>  			if (r->event != EVT_CMD_STATUS) {
>  				if (cs->status) {
> +					memcpy(r->rparam, &cs->status, 1);
>  					errno = EIO;
>  					goto failed;
>  				}

I don't think we can apply this since it breaks the way that the library
function works (guaranteeing that rparam isn't touched if the function
returns an error).

Johan
