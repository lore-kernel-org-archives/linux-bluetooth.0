Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130507150638.GA17193@x220.P-661HNU-F1>
References: <1367912644-17401-1-git-send-email-mikel.astiz.oss@gmail.com>
	<CAE6HaMmP6VzUdqn1xNfo5zC2_Bx33cJ5bR37FAwU_fOSa7-WYQ@mail.gmail.com>
	<20130507150638.GA17193@x220.P-661HNU-F1>
Date: Tue, 7 May 2013 17:40:26 +0200
Message-ID: <CANT-zCW6DkL7YBngrayLpiZjnbefCimqCO7JFAjqpL-nZZh=Eg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 0/3] Issue with incoming connections
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Vinicius Gomes <vinicius.gomes@openbossa.org>,
	Mikel Astiz <mikel.astiz.oss@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan, Vinicius,

On Tue, May 7, 2013 at 5:06 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Vinicius,
>
> On Tue, May 07, 2013, Vinicius Gomes wrote:
>> > As compared to his original patch, this patchset avoid creating an
>> > additional service instance (which should already be created) and
>> > instead performs a search within the list of existing services for
>> > the given device.
>>
>> In the AG case when the external profile registers itself with the
>> "server" role, the service doesn't get created.
>
> Hmm? HFP profile instances should be registered without any specific
> "Role" property in RegisterProfile since both client and server sides
> are required.
>
>> Nowadays, the service is created when the service is probed (with
>> requires profile->device_probe), which doesn't happen for "adapter"
>> services. I am still not sure about the right place/time to create the
>> service for these cases.
>
> To my understanding btd_service is only for describing remote services
> and not local ones, i.e. those that we can connect to as a client. I may
> have misunderstood something about this though (for which Mikel is free
> to correct me).

The statement above is correct, btd_service is designed to represent
remote services only.

The confusion here might be caused by the fact that profile.c makes
use of struct ext_io to represent both local and remote "services",
but I believe this is an unfortunate implementation detail.

Cheers,
Mikel
