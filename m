Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Nov 2013 10:32:23 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/2] android/debug: Export print uuid function
Message-ID: <20131106083144.GD18874@aemeltch-MOBL1>
References: <1383660378-23198-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <C04753B6-1BA7-459F-830F-981D46C10AF3@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C04753B6-1BA7-459F-830F-981D46C10AF3@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Nov 05, 2013 at 05:56:08PM +0100, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > The function will be reused in socket HAL.
> > ---
> > android/client/textconv.c |    2 +-
> > android/client/textconv.h |    1 +
> > 2 files changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/android/client/textconv.c b/android/client/textconv.c
> > index 9a2f7e6..e6f327f 100644
> > --- a/android/client/textconv.c
> > +++ b/android/client/textconv.c
> > @@ -237,7 +237,7 @@ char *bdaddr2str(const bt_bdaddr_t *bd_addr)
> > 	return bt_bdaddr_t2str(bd_addr, bdaddr_tls_buffer);
> > }
> > 
> > -static char *btuuid2str(const bt_uuid_t *uuid)
> > +char *btuuid2str(const bt_uuid_t *uuid)
> > {
> > 	static char buf[MAX_UUID_STR_LEN];
> > 
> > diff --git a/android/client/textconv.h b/android/client/textconv.h
> > index 1c848ef..7520b04 100644
> > --- a/android/client/textconv.h
> > +++ b/android/client/textconv.h
> > @@ -109,6 +109,7 @@ void str2bt_uuid_t(const char *str, bt_uuid_t *uuid);
> > 
> > char *btproperty2str(const bt_property_t *property);
> > char *bdaddr2str(const bt_bdaddr_t *bd_addr);
> > +char *btuuid2str(const bt_uuid_t *uuid);
> 
> this is totally backwards then. The HAL should not depend on client code.
> 

So shall the function be moved to utils.c inside android or even better
src/shared?

Best regards 
Andrei Emeltchenko 
