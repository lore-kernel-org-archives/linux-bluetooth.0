Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_NOk5BA+3jWked=ztOYw5rpm16Hnk1c3g3rcs+MhwRWkw@mail.gmail.com>
References: <Pine.LNX.4.64.1307122209580.31230@boston.corp.fedex.com>
	<CAJdJm_NOk5BA+3jWked=ztOYw5rpm16Hnk1c3g3rcs+MhwRWkw@mail.gmail.com>
Date: Sat, 13 Jul 2013 00:47:19 +0800
Message-ID: <CAAJw_Zvm+MgRPpb4+p+BvxPvh+ocpPKoGdy+CvPysvPjo27i7g@mail.gmail.com>
Subject: Re: bluez-5.x sdptool browse local failed to connect to SDP server
From: Jeff Chua <jeff.chua.linux@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jul 12, 2013 at 10:19 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Jeff,
>
> On Fri, Jul 12, 2013 at 10:17 AM, Jeff Chua <jeff.chua.linux@gmail.com> wrote:
>>
>> # sdptool browse local
>> Failed to connect to SDP server on FF:FF:FF:00:00:00: No such file or
>> directory
>
> I think you need --compat passed to bluetoothd in order to use sdptool
> browse local (which requires the unix socket for SDP).
>
> Hope that helps,

That does it!

Thank you so much!!!

Jeff
