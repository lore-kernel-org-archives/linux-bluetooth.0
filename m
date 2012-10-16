Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <507D6F26.8040306@schulz.dk>
References: <507D6F26.8040306@schulz.dk>
Date: Tue, 16 Oct 2012 11:45:38 -0300
Message-ID: <CAJdJm_NZwNbLwAHNj7JVPVKK2eBe90AeqPRFfqD0Rqr9=bWpNg@mail.gmail.com>
Subject: Re: gatttool and multiple devices connected
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Kim Schulz <kim@schulz.dk>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kim,

On Tue, Oct 16, 2012 at 11:28 AM, Kim Schulz <kim@schulz.dk> wrote:
> Hi guys,
> I was just testing the LE functionality a bit and decided to connect to two
> different LE devices at the same time using gatttool in interactive mode
> (two different terminals). Connection to the two devices went well, but when
> I tried to get primary services on the devices it was only possible to do so
> on one of the devices.
> Connecting to them one by one showed that it was actually possible to get
> the primary service listing of both devices - just not when both are
> connected at the same time.
> I guess this is a bug somewhere in the primary-service lookup code but have
> yet to look more into the details of this.
>
> Just thought that you might wanted to know about this.

Which kernel version are you running? Older kernels had a LE
connection routing issue which I believe was fixed long ago.

And what do you mean with not being able to get services? which error
did you get?

Do you have hcidump logs from these sessions?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
