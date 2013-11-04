Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Nov 2013 21:32:35 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] android: Add support for handling get properties
 commands
Message-ID: <20131104193235.GA17981@x220.p-661hnu-f1>
References: <1383579265-24614-1-git-send-email-szymon.janc@tieto.com>
 <20131104191918.GE13837@x220.p-661hnu-f1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20131104191918.GE13837@x220.p-661hnu-f1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Nov 04, 2013, Johan Hedberg wrote:
> Hi Szymon,
> 
> On Mon, Nov 04, 2013, Szymon Janc wrote:
> > When this commands is received all properties shall be reported to HAL.
> > ---
> >  android/adapter.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> 
> This patch doesn't compile:
> 
>   CC       android/adapter.o
> android/adapter.c: In function ‘get_properties’:
> android/adapter.c:1125:2: error: implicit declaration of function ‘send_adapter_address’ [-Werror=implicit-function-declaration]
>   send_adapter_address();
>   ^
> cc1: all warnings being treated as errors
> make[1]: *** [android/adapter.o] Error 1

Since this was a rather trivial thing introduced by a rename patch from
Andrei E, I went ahead and fixed it myself and applied all three
patches.

Johan
