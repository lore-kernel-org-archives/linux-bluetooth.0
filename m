Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1509632009.2869.61.camel@hadess.net>
Subject: Re: [PATCH BlueZ] obexd: Fix compile error due to lack of header
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 02 Nov 2017 15:13:29 +0100
In-Reply-To: <CABBYNZL6v0qiMJ-73MQmB9nrQhNbq8h0e6fqyBtncRRfTB2E1g@mail.gmail.com>
References: <0ff16352-9a23-f0b1-5691-d521b36dcd8c@jp.fujitsu.com>
         <CABBYNZL6v0qiMJ-73MQmB9nrQhNbq8h0e6fqyBtncRRfTB2E1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2017-10-26 at 15:05 +0300, Luiz Augusto von Dentz wrote:
> Hi Eramoto,
> 
> On Thu, Oct 26, 2017 at 9:05 AM, ERAMOTO Masaya
> <eramoto.masaya@jp.fujitsu.com> wrote:
> > When compiling with gcc 7.2.0, gcc outputs the following messages.
> > This patch adds the header stdlib.h to each obex-related header
> > including
> > functions with the type ssize_t, so the same problem does not also
> > happen
> > in case using there headers individually.
> 
> Weird this is just happening now, so what did change in 7.2? Usually
> we have stdlib.h included in the c file not in the header.

It's not a gcc change, but a glibc change. See the patch labelled "Fix
compilation error on newer glibc" I just sent.

Cheers
