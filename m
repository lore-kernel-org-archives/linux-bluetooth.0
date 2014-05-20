Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <OF9492748C.5E888D74-ON65257CDE.00285283-65257CDE.00285286@tcs.com>
References: <OF9492748C.5E888D74-ON65257CDE.00285283-65257CDE.00285286@tcs.com>
Date: Tue, 20 May 2014 18:13:18 +0300
Message-ID: <CABBYNZJi49XwzbWwtSvwGD5xzPGBG8OmRyi=RxdxiBfimOEprQ@mail.gmail.com>
Subject: Re: AVRCP support required in Bluez 4.98 or 4.101
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vinod Rayapudi <vinod.rayapudi@tcs.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	linux-bluetooth-owner@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, May 20, 2014 at 10:20 AM, Vinod Rayapudi <vinod.rayapudi@tcs.com> wrote:
> Dear Team,
>
> I am working with Bluez 4.98 and 4.101 version.
> Due to some project related constraints we are not able to move to Bluez 5+ versions.
>
> I want to use AVRCP and where as in Bluez 4.98 or 4.101 versions, I couldn't find any support for PLAY,PAUSE,STOP,FORWARD etc.
>
> Can anyone help me, how to add these features with Bluez 4+ version.
>
> With Bluez 4.98, I can see that VolumeUp and Down controls in d-feet but from hcidump shows those commands are not implemented.

You are mostly on your own with 4.x, you can try backporting from what
is currently upstream but there is no support for 4.x anymore.

-- 
Luiz Augusto von Dentz
