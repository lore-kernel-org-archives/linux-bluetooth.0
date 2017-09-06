Return-Path: <hadess@hadess.net>
Message-ID: <1504708668.6911.56.camel@hadess.net>
Subject: Re: Bluetooth LE battery reporting?
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	 <luiz.dentz@gmail.com>
Cc: Szymon Janc <szymon.janc@codecoup.pl>, Bluez mailing list
	 <linux-bluetooth@vger.kernel.org>
Date: Wed, 06 Sep 2017 16:37:48 +0200
In-Reply-To: <9713FF9C-7E23-448F-AC8B-755F32C461C7@holtmann.org>
References: <1504627402.6911.48.camel@hadess.net>
	 <CAAEJBh+bjNrjSvTD-F1LBTKnO36kvDZmavJaRR8ZWhR6pTwz9g@mail.gmail.com>
	 <9D01587F-3821-46CF-B8CE-2311BE8E8592@holtmann.org>
	 <CABBYNZLDGJTj+jeKUuRAmm_FznUzAy--zE1YVto2t5Fb4zOQ6w@mail.gmail.com>
	 <9713FF9C-7E23-448F-AC8B-755F32C461C7@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2017-09-06 at 10:40 +0200, Marcel Holtmann wrote:
> 
<snip>
> I assumed that it is forbidden to include HID battery reporting
> events via the GATT HID descriptors. I think the standard clearly
> says these have to come via battery service and not via HID.

So we're back to implementing battery reporting as a separate profile.
What would be a good example/skeleton to use to implement this?
