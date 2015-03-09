Return-Path: <cyrus@holtmann.org>
Message-ID: <54FDBBD2.10608@ubnt.com>
Date: Mon, 09 Mar 2015 17:27:14 +0200
From: Andrejs Hanins <andrejs.hanins@ubnt.com>
MIME-Version: 1.0
To: Tim Tisdall <tisdall@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: bt dongle goes awry after too many connections
References: <CAGxYWpZ8cfgtdO8ZX39cPBOs4OZ=PaO5pOHotjBt0u7HsnVXFA@mail.gmail.com>	<6EDCDCB4-6F4D-4DE6-88DB-88D333FC2CCC@holtmann.org>	<CAGxYWpY0afTXOW1=jS1dmY7XBg3nR8a8itXiiiXdofKkhkyjKg@mail.gmail.com>	<EC9E947B-7BEA-47D9-B546-F18208D4AE97@holtmann.org>	<CAGxYWpaaj=_J801VUe1WphQtdEr-MOMzZ10-w_iFWUdjBPkL5Q@mail.gmail.com> <CAGxYWpZCC1m1Ow-NAXp_f3AV9StE3sBHNJ2_vtY0owJ8SknffA@mail.gmail.com>
In-Reply-To: <CAGxYWpZCC1m1Ow-NAXp_f3AV9StE3sBHNJ2_vtY0owJ8SknffA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
On 2015.03.09. 16:40, Tim Tisdall wrote:
> On Tue, Mar 3, 2015 at 11:19 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> If you do not need BR/EDR, you can switch that off and it might free the radio resources you need for the many LE connections.
> Would someone please tell me how you do that?  I haven't seen this
> being done before.  Is it an HCI command?  ioctl command to the
> kernel?
ControllerMode = le
in /etc/bluetooth/main.conf
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
