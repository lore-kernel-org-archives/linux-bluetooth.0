Return-Path: <benjamin.tissoires@redhat.com>
Date: Thu, 16 Nov 2017 17:44:17 +0100
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Niels Skou Olsen <nolsen@jabra.com>, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Quirks cleanup and hid-generic niceness
Message-ID: <20171116164417.GG403@mail.corp.redhat.com>
References: <20171003145729.3135-1-benjamin.tissoires@redhat.com>
 <nycvar.YFH.7.76.1711161358020.32604@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <nycvar.YFH.7.76.1711161358020.32604@cbobk.fhfr.pm>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jiri,

On Nov 16 2017 or thereabouts, Jiri Kosina wrote:
> On Tue, 3 Oct 2017, Benjamin Tissoires wrote:
> 
> > Hi,
> > 
> > Niels found an issue with v1 of the series, while compiling the usbhid module
> > as a separate .ko.
> > 
> > Sending a v2 with the proper From: field fixed now.
> > 
> > I also use -M1 to show in 1/4 that usbhid/hid-quirks.c is basically moved to
> > hid-quirks.c.
> 
> I am planning to queue this for 4.16; do you happen to have any followups 
> since you posted v2 in october?

Cool. I did not updated it since, but if you want I can send a v3
tomorrow based on your for-next branch.

Cheers,
Benjamin

> 
> Thanks,
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 
