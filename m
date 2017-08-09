Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH BlueZ] device: Fix crash when connecting ATT with BR/EDR
 only device
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20170809111859.10644-1-luiz.dentz@gmail.com>
From: =?UTF-8?Q?Per_Waag=c3=b8?= <pwaago@cisco.com>
Message-ID: <521fe3ec-b1d8-1eda-183a-c2093568b7e3@cisco.com>
Date: Wed, 9 Aug 2017 14:17:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170809111859.10644-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,


On 09. aug. 2017 13:18, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz<luiz.von.dentz@intel.com>
>
> The fix introduced in 006213cf4d231ce66de273e96619474bd516359b only
> works for dual mode devices, if the device is BR/EDR the address type
> would match the type on browsing_req so it still possible to crash.
> ---
>   src/device.c | 38 +++++++++++++++++++++++---------------
>   1 file changed, 23 insertions(+), 15 deletions(-)

I have tested the patch. I can't reproduce the crash anymore when it's 
in, so this solves the problem. Thank you!

Per

