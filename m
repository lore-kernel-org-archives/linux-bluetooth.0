Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3916CF28FA2C014B862815C318D03FF5A0A7493AC5@Courier.syntech.org>
References: <3916CF28FA2C014B862815C318D03FF5A0A7493AAF@Courier.syntech.org>
	<CABBYNZJ3DqnNGKGoRZiGGpNSH5r=9FuH6BLeNsjavsgFdZ4=xw@mail.gmail.com>
	<3916CF28FA2C014B862815C318D03FF5A0A7493AB0@Courier.syntech.org>
	<3916CF28FA2C014B862815C318D03FF5A0A7493AB2@Courier.syntech.org>
	<3916CF28FA2C014B862815C318D03FF5A0A7493AC5@Courier.syntech.org>
Date: Fri, 29 Jan 2016 20:16:42 +0200
Message-ID: <CABBYNZLMkELfxSOa3t+c6bNTjmCUfvUuS6+eLanAwvHMod9AMg@mail.gmail.com>
Subject: Re: Bluetooth Smart 5LoWPAN connection between two devices
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jon Hoffman <Jon.Hoffman@myfuelmaster.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jon,

On Fri, Jan 29, 2016 at 7:20 PM, Jon Hoffman
<Jon.Hoffman@myfuelmaster.com> wrote:
> I just solved this based on Luiz Augusto von Dentz that it was working for him.
>
> The problem was with the kernel. I installed Ubuntu 15 and downloaded the source for the 4.4 kernel, configured it and built a new kernel. Once the new kernel was in place everything worked great. Not sure if it was the patch level of the kernel or the configuration but it is now working.

Great, I thought I had mention to run a more recent kernel but good
that you figure it out.

-- 
Luiz Augusto von Dentz
