Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <df2637cb-3888-46c0-53cb-f135e1ecd03b@palumbi.it>
References: <df2637cb-3888-46c0-53cb-f135e1ecd03b@palumbi.it>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sun, 27 May 2018 10:01:00 +0300
Message-ID: <CABBYNZKuGtLtvq2Ciu1Mgn-jZDnN4omc3TuYWg7eL7QsUW9ptA@mail.gmail.com>
Subject: Re: BLE advertise name
To: Marco Palumbi <marco@palumbi.it>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marco,

On Sat, May 26, 2018 at 9:49 PM, Marco Palumbi <marco@palumbi.it> wrote:
> hello to all,
>
> I am trying to let BlueZ advertise on BLE with a name longer than 9
> character. is this possible?
> it seems to me that BlueZ uses the shortname to advertise over BLE.
> Any suggestion?

How exactly are you trying to advertise? Btw, you should be able to
check what type we are using in the advertisement with use of btmon.

-- 
Luiz Augusto von Dentz
