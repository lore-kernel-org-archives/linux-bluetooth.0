Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJ+kH0sOjcuhzT6MAoJ=exnqGK9BKs92rs6N6RV8eH+SA@mail.gmail.com>
References: <CADGFtMXS0+XWywLJ_=0B_xWaHLCKUKK4HC+ge+3d_G5X_v7z0A@mail.gmail.com>
	<CABBYNZJ+kH0sOjcuhzT6MAoJ=exnqGK9BKs92rs6N6RV8eH+SA@mail.gmail.com>
Date: Tue, 15 Mar 2016 16:50:45 +0100
Message-ID: <CADGFtMXKGALWPNBRmWrmgqAv1vrga-auJpO8E25Jrx5uGPLvdg@mail.gmail.com>
Subject: Re: device keeps being found and removed
From: Luca Dionisi <luca.dionisi@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Mar 15, 2016 at 4:42 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> It has probably deleted your link-key which means you wont be to
> reconnect to it until you do a new pairing. Usually for this type of
> peripheral you need to put them into pairing mode so that way it
> becomes visible again and then you can use the UI or bluetoothctl to
> pair to it again which should fix the problem.

Thanks for the hint. But it seems not to be that case to me.

I already kept the pairing button pressed for several seconds on the
bluetooth keyboard. And I tried to launch many scans from the UI of
the phone or from the bluetoothctl CLI.
