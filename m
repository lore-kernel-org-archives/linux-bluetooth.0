Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20141210081858.GA13749@t440s.lan>
References: <1418114425-22455-1-git-send-email-lukasz.rymanowski@tieto.com>
	<CAMudyAstnmV4JCxc8=7RrBnhGZ=XEH7fgysbkw53uCRTvHx0Xg@mail.gmail.com>
	<20141210081858.GA13749@t440s.lan>
Date: Wed, 10 Dec 2014 09:40:51 +0100
Message-ID: <CAMudyAuvTA7yAevLB62bfrt4kaGkS=j=yUCq+fos50_RFkMM=Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] attrib/gatt.c: Fix for attrib ref
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi  Johan,

On 10 December 2014 at 09:18, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lukasz,
>
> On Tue, Dec 09, 2014, Lukasz Rymanowski wrote:
>> On 9 December 2014 at 09:40, Lukasz Rymanowski
>> <lukasz.rymanowski@tieto.com> wrote:
>> > This patch makes sure that attrib instance will not disappear while
>> > reading characteristic
>>
>> Just noticed that there is small issue in the commit msg. Should be
>> "attrib/gatt" instead of "attrib/gatt.c" :) Please fix when pushing or
>> let me know so I will send v2.
>
> I fixed the commit message myself.
Thanks

\Lukasz

 Both patches are now upstream.
> Thanks.
>
> Johan
