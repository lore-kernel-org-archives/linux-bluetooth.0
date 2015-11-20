Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1448028820-25330-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1448028820-25330-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Date: Fri, 20 Nov 2015 17:37:13 +0100
Message-ID: <CADAkoF4zi-ae-e9SS=idtbPHFaZHRw0XGX8pS-jGT4qKANd0SQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/22] Add AVDTP/A2DP decoding to btmon
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Nov 20, 2015 at 3:13 PM, Andrzej Kaczmarek
<andrzej.kaczmarek@codecoup.pl> wrote:
> Hi,
>
> Here's series of patches which adds decoding of AVDTP signalling channel
> and A2DP codec capabilities information. Few things are missing:
> - no fragmentation support
> - some rarely used capabilities are not decoded
> - ATRAC capabilities are not decoded
>
> Other that above, pretty much everything should be decoded.
>
> Changes in v2:
> - fixed formatting according to comments
> - updated commit messages to include decoded frames (except for few of
>   them where I was not able trigger proper signalling)
> - some minor fixed found during development

I'll send v3 later which will fix some weird copy&pasted gotos and
for-loops used in commands decoding... I'll make this code look more
sane.

BR,
Andrzej
