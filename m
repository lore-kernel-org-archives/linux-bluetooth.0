Return-Path: <hadess@hadess.net>
Message-ID: <1504795362.6911.71.camel@hadess.net>
Subject: Re: Bluetooth LE battery reporting?
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Szymon Janc
 <szymon.janc@codecoup.pl>,  Bluez mailing list
 <linux-bluetooth@vger.kernel.org>
Date: Thu, 07 Sep 2017 16:42:42 +0200
In-Reply-To: <CABBYNZLOCkKnPU0HBkDSwJgus7fwXV80yreET1zG+qF7-oy+rg@mail.gmail.com>
References: <1504627402.6911.48.camel@hadess.net>
	 <CAAEJBh+bjNrjSvTD-F1LBTKnO36kvDZmavJaRR8ZWhR6pTwz9g@mail.gmail.com>
	 <9D01587F-3821-46CF-B8CE-2311BE8E8592@holtmann.org>
	 <CABBYNZLDGJTj+jeKUuRAmm_FznUzAy--zE1YVto2t5Fb4zOQ6w@mail.gmail.com>
	 <9713FF9C-7E23-448F-AC8B-755F32C461C7@holtmann.org>
	 <1504708668.6911.56.camel@hadess.net> <1504739780.6911.60.camel@hadess.net>
	 <1504793016.6911.70.camel@hadess.net>
	 <CABBYNZLOCkKnPU0HBkDSwJgus7fwXV80yreET1zG+qF7-oy+rg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2017-09-07 at 17:15 +0300, Luiz Augusto von Dentz wrote:
> 
<snip>
> We should probably make similar changes to what was done in dis.c so
> it can operate with gatt_db directly instead of doing its own
> discovery.

That's doable. I'll try it out.
