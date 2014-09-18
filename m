Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: John Tobias <john.tobias.ph@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Create an AVDTP signaling channel
Date: Thu, 18 Sep 2014 12:21:22 +0200
Message-ID: <1643289.HYNdMFzCoG@leonov>
In-Reply-To: <CACUGKYPQJjY+p215wqp6Gp1qtKC_WghsHYoQk5+BvifdOF++=w@mail.gmail.com>
References: <CACUGKYPaqcyKxv9zmiRraDsV1=ErsTCP5rUqguEdh6aEZshZKA@mail.gmail.com> <CACUGKYN0S8aBPL4Q81sFabcJQk8FgdPwMsPEK089QgM3oV_KjQ@mail.gmail.com> <CACUGKYPQJjY+p215wqp6Gp1qtKC_WghsHYoQk5+BvifdOF++=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 17 of September 2014 17:38:26 John Tobias wrote:
> I really apologize for a bit confusion... after running the bluetooth
> daemon without the -EC, I am still seeing bluetoothd got SEGV.
> 
> The pts seems get stuck.... a2dp-sink profile connect failed for
> 00:1B:DC:07:32:D3: Device or resource busy
> 
> Any idea?.

Please run it under valgrind and send results here. That should make debugging 
easier.

-- 
BR
Szymon Janc
