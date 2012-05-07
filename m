Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CALF0-+U0YwO+1BtXC4rz0hGNR7AjEjwUnF+MAnAX+SiOTSujDQ@mail.gmail.com>
References: <CALF0-+U0YwO+1BtXC4rz0hGNR7AjEjwUnF+MAnAX+SiOTSujDQ@mail.gmail.com>
Date: Mon, 7 May 2012 15:20:12 -0300
Message-ID: <CALF0-+W=io9JZZz9gX71tGyYZnh_idcRWRSjP0RFkLjFmm0bfQ@mail.gmail.com>
Subject: Re: [Q] Crappy bluetooth usb adapter is timing out
From: Ezequiel Garcia <elezegarcia@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, May 7, 2012 at 3:10 PM, Ezequiel Garcia <elezegarcia@gmail.com> wrote:
> I get this message:
> "Can't init device hci0: Connection timed out (110)"
>
> I've tracked this down to hciconfig.c, when it calls
> HCIDEVUP ioctl.
>
> I just wanted to know if I'm doing anything wrong, and
> if I can raise any timer value, so I don't get the timeout error.
>

So, I was just looking at HCIDEVUP ioctl on my kernel code, and it seems
that the timer value is controlled by "HCI_INIT_TIMEOUT" macro,
and that macro is currently set to 10 seconds.

Now, 10 seconds looks like more than reasonable to me, so I guess
the smart solution is to just re-try the operation.

FWIW, does any of you ever experience this kind of issue?
I would like to know in what ways is my device crappy ;)

Thanks,
Ezequiel.
