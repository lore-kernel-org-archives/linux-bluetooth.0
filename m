Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <22E34ABC-A5CD-4F06-9453-F6B1A4BE8C66@gmail.com>
References: <CAFZwcqVpwTvphhTFN15ttbZNj9m1e6wEqEh8g3BDCafkuYeSUQ@mail.gmail.com>
 <22E34ABC-A5CD-4F06-9453-F6B1A4BE8C66@gmail.com>
From: Szymon Janc <szymon.janc@codecoup.pl>
Date: Fri, 2 Jun 2017 12:27:41 +0200
Message-ID: <CAAEJBhK98+5ALZhQKbDUucD=o-90ibpqunScq5ANat7QjCAA2Q@mail.gmail.com>
Subject: Re: CVE's CVE-2016-9797 to 9804, CVE-2016-9918
To: gw rdk <gwcpesi@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 1 June 2017 at 21:31, gw rdk <gwcpesi@gmail.com> wrote:
> Hi =E2=80=94
>
> We'd like to update our bluez - can you tell me if these vulnerability re=
ports were addressed?  They aren't specifically called out in the change lo=
g and a spot check doesn't show, for example, a fix for the issue in packet=
.c
>
> Were they determined to be too low-risk? or invalid reports?
>
>
>
> Any info appreciated, thanks in advance.
> gw (on behalf of customer)

I'm not sure if those are fixed but this seems to only affect HCI
monitor (btmon) which is our testing/debugging tool.

--=20
pozdrawiam
Szymon K. Janc
