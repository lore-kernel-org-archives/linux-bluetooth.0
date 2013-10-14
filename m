Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1381595148.21761.0.camel@nuvo>
References: <1381592725-28212-1-git-send-email-scampa.giovanni@gmail.com>
	<0262656B-5656-422C-B12D-C6BF7239AA11@holtmann.org>
	<1381595148.21761.0.camel@nuvo>
Date: Mon, 14 Oct 2013 18:02:25 +0300
Message-ID: <CABBYNZJt2n_DZmR2SQk8HvgkRgf4yuPJnYr=HFxqb3H-Y0mQyw@mail.gmail.com>
Subject: Re: [PATCH] Allow using obexd without systemd in the user session
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: Marcel Holtmann <marcel@holtmann.org>, Giovanni Campagna <scampa.giovanni@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Giovanni Campagna <gcampagna@src.gnome.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Sat, Oct 12, 2013 at 7:25 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Sat, 2013-10-12 at 18:08 +0200, Marcel Holtmann wrote:
>> Hi Giovanni,
> <snip>
>> that is something your distro specific package should be fixing if
>> that is needed. The focus is on integration with systemd and nothing
>> else. You can use --disable-systemd and provide your own set of D-Bus
>> service files.
>
> There aren't any distributions that ship systemd for user sessions
> though.

How far we are with this? If that will take a while perhaps we should
support the old D-Bus service too.


-- 
Luiz Augusto von Dentz
