Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 2/9] Pass confirm name as gboolean value
Date: Wed, 10 Oct 2012 11:57:58 +0200
Message-ID: <1505997.4TGEV3eNyH@uw000953>
In-Reply-To: <1349794286.27233.95.camel@aeonflux>
References: <1349784722-14578-1-git-send-email-szymon.janc@tieto.com> <1349784722-14578-3-git-send-email-szymon.janc@tieto.com> <1349794286.27233.95.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 09 of October 2012 17:51:26 Marcel Holtmann wrote:
> Hi Szymon,
> 
> > confirm_name is a boolean value and can be pass as such instead of
> > uint8_t.
> 
> actually long term I want to move to bool usage. So maybe this is a good
> start to get this going.

OK, will send v2 with bool.
Do you also want to stop introducing other glib types like gchar, gint etc?
(at least for code that don't inherit this due to glib calls)

-- 
BR
Szymon Janc
