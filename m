Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGxYWpaaj=_J801VUe1WphQtdEr-MOMzZ10-w_iFWUdjBPkL5Q@mail.gmail.com>
References: <CAGxYWpZ8cfgtdO8ZX39cPBOs4OZ=PaO5pOHotjBt0u7HsnVXFA@mail.gmail.com>
	<6EDCDCB4-6F4D-4DE6-88DB-88D333FC2CCC@holtmann.org>
	<CAGxYWpY0afTXOW1=jS1dmY7XBg3nR8a8itXiiiXdofKkhkyjKg@mail.gmail.com>
	<EC9E947B-7BEA-47D9-B546-F18208D4AE97@holtmann.org>
	<CAGxYWpaaj=_J801VUe1WphQtdEr-MOMzZ10-w_iFWUdjBPkL5Q@mail.gmail.com>
Date: Mon, 9 Mar 2015 10:40:06 -0400
Message-ID: <CAGxYWpZCC1m1Ow-NAXp_f3AV9StE3sBHNJ2_vtY0owJ8SknffA@mail.gmail.com>
Subject: Re: bt dongle goes awry after too many connections
From: Tim Tisdall <tisdall@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Mar 3, 2015 at 11:19 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> If you do not need BR/EDR, you can switch that off and it might free the radio resources you need for the many LE connections.

Would someone please tell me how you do that?  I haven't seen this
being done before.  Is it an HCI command?  ioctl command to the
kernel?
