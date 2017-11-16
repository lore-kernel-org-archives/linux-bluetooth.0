Return-Path: <jikos@kernel.org>
Date: Thu, 16 Nov 2017 13:59:53 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc: Marcel Holtmann <marcel@holtmann.org>, Niels Skou Olsen <nolsen@jabra.com>,
    linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
    linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Quirks cleanup and hid-generic niceness
In-Reply-To: <20171003145729.3135-1-benjamin.tissoires@redhat.com>
Message-ID: <nycvar.YFH.7.76.1711161358020.32604@cbobk.fhfr.pm>
References: <20171003145729.3135-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 3 Oct 2017, Benjamin Tissoires wrote:

> Hi,
> 
> Niels found an issue with v1 of the series, while compiling the usbhid module
> as a separate .ko.
> 
> Sending a v2 with the proper From: field fixed now.
> 
> I also use -M1 to show in 1/4 that usbhid/hid-quirks.c is basically moved to
> hid-quirks.c.

I am planning to queue this for 4.16; do you happen to have any followups 
since you posted v2 in october?

Thanks,

-- 
Jiri Kosina
SUSE Labs
