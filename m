Return-Path: <cyrus@holtmann.org>
Message-ID: <1357684913.1806.36.camel@aeonflux>
Subject: Re: [PATCH BlueZ 2/2] lib: Fix SDP_TEXT_STR16/SDP_URL_STR16 parsing
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 08 Jan 2013 14:41:53 -0800
In-Reply-To: <CAJdJm_PV7qMJWQLJBOmA0tqqDzor6immypKGgGTtLVy9SR5A8A@mail.gmail.com>
References: <1357670608-19081-1-git-send-email-anderson.lizardo@openbossa.org>
	 <1357670608-19081-2-git-send-email-anderson.lizardo@openbossa.org>
	 <1357672384.1806.34.camel@aeonflux>
	 <CAJdJm_PV7qMJWQLJBOmA0tqqDzor6immypKGgGTtLVy9SR5A8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> >> diff --git a/lib/sdp.c b/lib/sdp.c
> >> index ca474cd..b87f392 100644
> >> --- a/lib/sdp.c
> >> +++ b/lib/sdp.c
> >> @@ -1176,7 +1176,7 @@ static sdp_data_t *extract_str(const void *p, int bufsize, int *len)
> >>               }
> >>               n = bt_get_be16(p);
> >>               p += sizeof(uint16_t);
> >> -             *len += sizeof(uint16_t) + n;
> >> +             *len += sizeof(uint16_t);
> >
> > I do not get this fix. Isn't this str8 and url8 part wrong?
> 
> On the same function, next to the return, there is:
> 
> *len += n;
> 
> This is why STR8/URL8 actually are okay. For STR16 the "n" part is
> added twice due to the snippet I change in this patch.

good catch. However I like to see that tiny piece of extra information
in the commit message as well. Makes it a lot clearer.

Regards

Marcel


