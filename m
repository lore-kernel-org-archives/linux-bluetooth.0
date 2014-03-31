Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: Missing Linux Bluetooth Headers
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALkxMhFwk=JwSbA_uPgLxAjQUAhGiqTjPsEOQSer90BX+ojOfg@mail.gmail.com>
Date: Mon, 31 Mar 2014 09:10:48 -0700
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <E7B700CC-2115-4762-8F53-7671D9B1DDA6@holtmann.org>
References: <CALkxMhEJxUXaKZgSQ4BSa-UvuEx1uFwVbr4yikH+qB81cUkvDw@mail.gmail.com> <5B9B1FB0-A822-4B5E-A040-42920D336457@holtmann.org> <CALkxMhFwk=JwSbA_uPgLxAjQUAhGiqTjPsEOQSer90BX+ojOfg@mail.gmail.com>
To: Michal Labedzki <michal.labedzki@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

> So what external application should do? Add own copy of headers to
> sources or try use BlueZ copy of headers. I think that first option is
> better, because build dependency with BlueZ does not make
> implementation kernel-safe. I think about user try to use one version
> of libpcap and try to change kernel to older (there can be old kernel
> API).

for libpcap and sockaddr_hci and the HCI_CHANNEL_MONITOR, you should just add your own copy of these structs and defines. Do not even bother copying BlueZ headers. Just create the structs and defines by yourself and use them. We have done this internally inside BlueZ as well a few times.

A build or runtime dependency on libbluetooth is a bad idea. You can install libbluetooth if you build BlueZ with —enable-library, but that library will be deprecated at some point. So might well just prepare yourself for it.

Regards

Marcel

