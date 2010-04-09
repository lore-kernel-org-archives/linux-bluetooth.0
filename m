Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <o2p977a2be21004090135u225590edn39c803c9d201b308@mail.gmail.com>
References: <o2p977a2be21004090135u225590edn39c803c9d201b308@mail.gmail.com>
Date: Fri, 9 Apr 2010 15:32:51 +0300
Message-ID: <h2i2d5a2c101004090532o6c7e33a4k7563fe8f628f3d6f@mail.gmail.com>
Subject: Re: Is hsp code in BlueZ and pulseaudio broken?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Zhu Yanhai <zhu.yanhai@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	pulseaudio-discuss@mail.0pointer.de, vivian.zhang@intel.com,
	guannan.ou@intel.com, Zheng Huan <huan.zheng@intel.com>,
	Zhu Yanhai <yanhai.zhu@linux.intel.com>,
	"Zhu, Yanhai" <yanhai.zhu@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Apr 9, 2010 at 11:35 AM, Zhu Yanhai <zhu.yanhai@gmail.com> wrote:
> 'hcitool con' reported there was no connections after that, and the
> headset was power off automatically. And of course I can't see this
> headset by
> 'ilst-cards' or 'list-sinks' in pacmd.
>
> Is it because there is anything broken in the latest BlueZ +
> Pulseaudio, or am I doing something wrong?

It seems ok in bluetoothd size, maybe it is the suspend logic that
disconnect sco after a few seconds when idle, but it doesn't seems to
be the case here as also rfcomm connection is dropped somehow.

-- 
Luiz Augusto von Dentz
Computer Engineer
