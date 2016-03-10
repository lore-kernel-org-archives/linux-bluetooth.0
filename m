Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAExxLLD+Z4rVRhXqU0MYFKTvOeq09_=-C55fWF9oXdY=mUowTA@mail.gmail.com>
References: <1457094267-5925-1-git-send-email-luiz.dentz@gmail.com>
	<1457094267-5925-2-git-send-email-luiz.dentz@gmail.com>
	<CAExxLLC4moiHCOtWo+L+d9R=M1K_tVsvB4GRCbjGCAeswz3Gtg@mail.gmail.com>
	<CABBYNZLYzkL8x7rVfrO9tO=xqfKScbOWU=NVhVdy4cgKuxBbJw@mail.gmail.com>
	<CAExxLLASt8XG35wPH1XeWVm4PUZ3V9Jdxz-nhgNmD5+YPdQ0+w@mail.gmail.com>
	<CABBYNZ+RbMV3=wovooRXv8yXQmROyT5TSMUy-F_4OouNjPrzLw@mail.gmail.com>
	<CAExxLLDU=U1V9E-Q1dge5nTC_K7T5P9gWabDFQUXgBE3Md4-kA@mail.gmail.com>
	<CABBYNZ+gLweEjUit-MEbNQkOFNRytRdmi-qqPepSsJHoGd8tVA@mail.gmail.com>
	<CAExxLLD+Z4rVRhXqU0MYFKTvOeq09_=-C55fWF9oXdY=mUowTA@mail.gmail.com>
Date: Thu, 10 Mar 2016 11:35:23 +0200
Message-ID: <CABBYNZKNkEFO7uAsH55Un47esqezPV-acTiqE1NFMfNXFWKj2Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] core/device: Don't set MTU when acting as a peripheral
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?UTF-8?Q?=C5=81ukasz_Rymanowski?= <lukasz.rymanowski@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Thu, Mar 10, 2016 at 11:17 AM, Łukasz Rymanowski
<lukasz.rymanowski@codecoup.pl> wrote:
>> Not only we cannot be configured as server, but even if we do the
>> roles are only relevant for PTS because otherwise there is no way to
>> tell the roles of the remote device.
>
> If device sends request that means it is a Client. If not that means
> it is a Server.

Well if it send it can be a Client/Server as well, btw some systems
including Android appear to have support to send Exchange MTU at any
point so detecting a server only pretty hard, besides our current
design split Server and Client functionality so waiting to see if
anything has been received before starting sending anything is not so
trivial and we had still to choose an arbitrary timeout to wait for
detecting the role but if both are based on BlueZ this would just
delay each other.
