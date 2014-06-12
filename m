Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Jun 2014 13:40:41 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Fix wrong check
Message-ID: <20140612104039.GB27592@aemeltch-MOBL1>
References: <1402567085-26830-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <7D349CBE-361A-4F82-8D38-BE57012D65C1@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7D349CBE-361A-4F82-8D38-BE57012D65C1@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jun 12, 2014 at 12:08:29PM +0200, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > android/gatt.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/android/gatt.c b/android/gatt.c
> > index cc3746c..08da856 100644
> > --- a/android/gatt.c
> > +++ b/android/gatt.c
> > @@ -4133,7 +4133,7 @@ static void fill_gatt_response_by_handle(uint16_t handle, uint16_t offset,
> > 
> > 	entry = queue_find(dev->pending_requests, match_dev_request_by_handle,
> > 							UINT_TO_PTR(handle));
> > -	if (entry) {
> > +	if (!entry) {
> > 		DBG("No pending response found! Bogus android response?");
> > 		return;
> 
> on a different note, if this is a case that is not suppose to happen and indicates a bug in Android Bluetooth service, we should at minimum print a warning here and not debug. Maybe even just print an error.
> 

so change DGB() to error() ?

Best regards 
Andrei Emeltchenko 
