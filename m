Return-Path: <cyrus@holtmann.org>
Message-ID: <1349863451.27233.116.camel@aeonflux>
Subject: Re: [PATCH 2/9] Pass confirm name as gboolean value
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 10 Oct 2012 12:04:11 +0200
In-Reply-To: <1505997.4TGEV3eNyH@uw000953>
References: <1349784722-14578-1-git-send-email-szymon.janc@tieto.com>
	 <1349784722-14578-3-git-send-email-szymon.janc@tieto.com>
	 <1349794286.27233.95.camel@aeonflux> <1505997.4TGEV3eNyH@uw000953>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> > > confirm_name is a boolean value and can be pass as such instead of
> > > uint8_t.
> > 
> > actually long term I want to move to bool usage. So maybe this is a good
> > start to get this going.
> 
> OK, will send v2 with bool.
> Do you also want to stop introducing other glib types like gchar, gint etc?
> (at least for code that don't inherit this due to glib calls)

yes, please no more gchar and gint. These are horrible. We were young
and naive when we thought they were a good idea ;)

Regards

Marcel


