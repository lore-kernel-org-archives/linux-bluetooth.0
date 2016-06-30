Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1467195230-11433-1-git-send-email-t.shripati@samsung.com>
References: <1467195230-11433-1-git-send-email-t.shripati@samsung.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 30 Jun 2016 15:53:11 +0300
Message-ID: <CABBYNZKsTjKVexbfa+r5AexcC2p1oqCi2LeCAfNaEm59_KJzOg@mail.gmail.com>
Subject: Re: Query regarding A2DP roles
To: Trimbake Nilesh Shripati <t.shripati@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	sachin.dev@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nilesh,

On Wed, Jun 29, 2016 at 1:13 PM, Trimbake Nilesh Shripati
<t.shripati@samsung.com> wrote:
> Hi Bluez Developers,
>
> Does latest bluez 5.x support A2DP source and A2DP sink roles simultaneously?
> [e.g one device act as a sink to receive data, and at same time act as a source to send
> send same data]

Yes, this has been supported for while actually, it is even possible
to bridge audio from a phone to headset using both roles, well if your
controller is good enough to deal with 2 streams.

-- 
Luiz Augusto von Dentz
