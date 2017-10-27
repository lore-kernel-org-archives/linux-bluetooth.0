Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1509103771.19297.1.camel@hadess.net>
Subject: Re: [PATCH BlueZ] obexd: Fix compile error due to lack of header
From: Bastien Nocera <hadess@hadess.net>
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 27 Oct 2017 13:29:31 +0200
In-Reply-To: <1158c872-8eb3-b710-5013-fa04bfebd745@jp.fujitsu.com>
References: <0ff16352-9a23-f0b1-5691-d521b36dcd8c@jp.fujitsu.com>
         <1509021568.28409.34.camel@hadess.net>
         <1158c872-8eb3-b710-5013-fa04bfebd745@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2017-10-27 at 16:55 +0900, ERAMOTO Masaya wrote:
> Hi Bastien,
> 
> On 10/26/2017 09:39 PM, Bastien Nocera wrote:
> > On Thu, 2017-10-26 at 15:05 +0900, ERAMOTO Masaya wrote:
> > > When compiling with gcc 7.2.0, gcc outputs the following
> > > messages.
> > > This patch adds the header stdlib.h to each obex-related header
> > > including
> > > functions with the type ssize_t, so the same problem does not
> > > also
> > > happen
> > > in case using there headers individually.
> > 
> > I already sent a patch for this about 2 months ago, look for
> > "obexd:
> > Fix compilation error on F27"
> 
> Sorry for I had missed this patch.
> 
> Now, it seems that you are blocking the patch set including this
> patch
> due to that Florian commented about one of the patch set.

I'm not blocking anything, it didn't get reviewed at all.

>  Is there any
> upgrades for the patch set?

The patch set is just a bunch of unrelated fixes, the patches can be
committed individually.

I think one of us needs to figure out what the change is to put the
justification in the commit message before that's going to be accepted
though.
