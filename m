Return-Path: <cyrus@holtmann.org>
Subject: Re: Is it possible that user change a stream path between Speaker
 and Bluetooth like normal phone?
From: Bastien Nocera <hadess@hadess.net>
To: Chan-Yeol Park <chanyeol.park@samsung.com>
Cc: "'Luiz Augusto von Dentz'" <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <002301ca055b$69c4fa00$3d4eee00$%park@samsung.com>
References: <200812301246.25781.siarhei.siamashka@nokia.com>
	 <200901051027.57446.siarhei.siamashka@nokia.com>
	 <2d5a2c100901050453w403ee755u61549a52b6514b65@mail.gmail.com>
	 <002301ca055b$69c4fa00$3d4eee00$%park@samsung.com>
Content-Type: text/plain
Date: Wed, 15 Jul 2009 16:27:45 +0100
Message-Id: <1247671665.8139.1318.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2009-07-15 at 23:49 +0900, Chan-Yeol Park wrote:
> Hi,
> 
> If you know or possible,
> Could you explain me how to change stream path between Speaker or Bluetooth
> with BlueZ gstreamer plug-in like normal phone?
> 
> In my case, I could see it works well with a gstreamer output-selector
> element except some case.

Use PulseAudio's Bluetooth module, that's what it's made for.

