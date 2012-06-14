Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4FD99618.6030100@samsung.com>
References: <1339620223-6639-1-git-send-email-gustavo@padovan.org>
	<1339620223-6639-4-git-send-email-gustavo@padovan.org>
	<4FD99618.6030100@samsung.com>
Date: Thu, 14 Jun 2012 11:14:58 +0300
Message-ID: <CABBYNZ+x4WM56g_kTKPaotMjkQv3bEz1itkXRA6VqC5+nuiV7w@mail.gmail.com>
Subject: Re: [PATCH 03/21] headset: remove deprecated DBus methods
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Chanyeol Park <chanyeol.park@samsung.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chanyel,

On Thu, Jun 14, 2012 at 10:43 AM, Chanyeol Park
<chanyeol.park@samsung.com> wrote:
> If you remove these APIs, could you guide me how to use SCO open officially?
> Currently we don't use PulseAudio HFP modules.

Via org.bluez.MediaTransport.Acquire, see doc/media-api.txt for more details.


-- 
Luiz Augusto von Dentz
