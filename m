Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Dec 2014 10:18:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/2] attrib/gatt.c: Fix for attrib ref
Message-ID: <20141210081858.GA13749@t440s.lan>
References: <1418114425-22455-1-git-send-email-lukasz.rymanowski@tieto.com>
 <CAMudyAstnmV4JCxc8=7RrBnhGZ=XEH7fgysbkw53uCRTvHx0Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMudyAstnmV4JCxc8=7RrBnhGZ=XEH7fgysbkw53uCRTvHx0Xg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Tue, Dec 09, 2014, Lukasz Rymanowski wrote:
> On 9 December 2014 at 09:40, Lukasz Rymanowski
> <lukasz.rymanowski@tieto.com> wrote:
> > This patch makes sure that attrib instance will not disappear while
> > reading characteristic
> 
> Just noticed that there is small issue in the commit msg. Should be
> "attrib/gatt" instead of "attrib/gatt.c" :) Please fix when pushing or
> let me know so I will send v2.

I fixed the commit message myself. Both patches are now upstream.
Thanks.

Johan
