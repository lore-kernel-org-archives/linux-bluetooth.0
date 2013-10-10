Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Oct 2013 09:56:33 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 03/15] android: Add Socket Bluetooth HAL template
Message-ID: <20131010065631.GB23879@aemeltch-MOBL1>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381243883-2745-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381243883-2745-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CCFB8A73-18EC-4FE3-9C92-8FBD91B9F6B9@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CCFB8A73-18EC-4FE3-9C92-8FBD91B9F6B9@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 09, 2013 at 09:14:05PM +0200, Marcel Holtmann wrote:
> > +static bt_status_t listen(btsock_type_t type, const char *service_name,
> > +					const uint8_t *uuid, int chan,
> > +					int *sock, int flags)
> > +{
> > +	if ((uuid == NULL && chan <= 0) || sock == NULL) {
> 
> we are moving away from uuid == NULL checks. Use !uuid instead.

I do not like myself these kind of checks but since this seems to be BlueZ
style. Should I change comparison val != NULL and val != 0 to !val ? Like
in kernel?

Best regards 
Andrei Emeltchenko 

