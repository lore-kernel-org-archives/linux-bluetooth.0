Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.64.1307122209580.31230@boston.corp.fedex.com>
References: <Pine.LNX.4.64.1307122209580.31230@boston.corp.fedex.com>
Date: Fri, 12 Jul 2013 10:19:49 -0400
Message-ID: <CAJdJm_NOk5BA+3jWked=ztOYw5rpm16Hnk1c3g3rcs+MhwRWkw@mail.gmail.com>
Subject: Re: bluez-5.x sdptool browse local failed to connect to SDP server
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jeff,

On Fri, Jul 12, 2013 at 10:17 AM, Jeff Chua <jeff.chua.linux@gmail.com> wrote:
>
> # sdptool browse local
> Failed to connect to SDP server on FF:FF:FF:00:00:00: No such file or
> directory

I think you need --compat passed to bluetoothd in order to use sdptool
browse local (which requires the unix socket for SDP).

Hope that helps,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
