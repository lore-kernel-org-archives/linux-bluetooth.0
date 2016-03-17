Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZK94wg-AM=QVT4+R=hWCWGf81t877qPi+vSLv8tA2_0Xg@mail.gmail.com>
References: <CAASrBQ=Wd1Jdp1GHEzjPrZ=-nZocAo9qx05pvsMsz0T6Btc95Q@mail.gmail.com>
	<CABBYNZ+4r+YTJByojL8QBCtWnUFeojqOoKkiOBycJFrfCdWz=g@mail.gmail.com>
	<CAASrBQmixu2USeLXSsR3vaSWUujra=Ky1TcXTyMUgsr4GR9_Jw@mail.gmail.com>
	<CAASrBQnKW-zcVy=8ncXay9USaMT4czqqKp1Gp_PHkDAOQ2fWag@mail.gmail.com>
	<CABBYNZK94wg-AM=QVT4+R=hWCWGf81t877qPi+vSLv8tA2_0Xg@mail.gmail.com>
Date: Thu, 17 Mar 2016 13:59:44 -0600
Message-ID: <CAASrBQk2TPshzkE74unr20CdckxNr2QbMc7SGbF7tw0h6Y-DTg@mail.gmail.com>
Subject: Re: setting indication on GattCharacteristic1 interface
From: Mark Rages <markrages@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Mar 17, 2016 at 1:51 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Mark,
>
> On Wed, Mar 16, 2016 at 11:16 PM, Mark Rages <markrages@gmail.com> wrote:
>> Maybe this is more helpful. This time it failed on an assertion:
>
> Those seems to be different issues.
>
>> bluetoothd: src/shared/gatt-client.c:1593: disable_ccc_callback:
>> Assertion `notify_data->chrc->ccc_write_id' failed.
>
> Do you have the trace before this? btw, what version are you using?

You mean the btmon trace?  I don't have it, sorry.  I will keep it
running in case it happens again.

I am using bluetoothd from git pull from yesterday.  And I tried again
with the two patches from yesterday that seemed to be possibly
related, same result.

Regards,
Mark
markrages@gmail
