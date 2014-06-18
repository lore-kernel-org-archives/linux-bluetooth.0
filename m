Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Jun 2014 11:46:11 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 05/17] android/gatt: Fix wrong initial value
Message-ID: <20140618084609.GC12463@aemeltch-MOBL1>
References: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1402905472-17643-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <3045098.LyDRGR9gjU@athlon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3045098.LyDRGR9gjU@athlon>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Jun 17, 2014 at 11:21:16PM +0200, Szymon Janc wrote:
> Hi Andrei,
> 
> On Monday 16 June 2014 10:57:40 Andrei Emeltchenko wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > Initialize value_len to -1 since otherwise check value_len >= 0 does not
> > make sense.
> > ---
> >  android/gatt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/android/gatt.c b/android/gatt.c
> > index eb977d5..c5cb58f 100644
> > --- a/android/gatt.c
> > +++ b/android/gatt.c
> > @@ -4288,7 +4288,7 @@ static void read_requested_attributes(void *data, void
> > *user_data) struct request_processing_data *process_data = user_data;
> >  	uint32_t permissions;
> >  	uint8_t *value, error;
> > -	int value_len = 0;
> > +	int value_len = -1;
> > 
> >  	if (!gatt_db_get_attribute_permissions(gatt_db, resp_data->handle,
> >  								&permissions)) {
> 
> This is not correct. value_len == -1 means that callback was called from 
> gatt_db_read() and response will be filled later.

Do you mean that in gatt_db_read() we should check for !*length not
!length like it is checked now? Otherwise it does not have effect.

Best regards 
Andrei Emeltchenko 
