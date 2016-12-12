Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CA+LDafAxHJbaTLgAvyiWRovwc=_19yvtBBp_cUiDPevxZ6MG=Q@mail.gmail.com>
References: <CA+LDafA2A4Jy8s4aYi8DiwZ=L6dNsQm5g6es5jXMu0pqB9fprA@mail.gmail.com>
 <CABBYNZL2gRTEfn2TsLYn8WoxnOH=cdoG8L8FeJMQKtNT89Nqtw@mail.gmail.com>
 <CA+LDafAX78wBWxJ4e4H7LJd6CzONyNuk3Tx2UvF-hGVjeooZ0w@mail.gmail.com>
 <CABBYNZL3uqU=FWvddOhHxjEZ=0bvhUoq6vYjm=79xHOfd=wFAA@mail.gmail.com> <CA+LDafAxHJbaTLgAvyiWRovwc=_19yvtBBp_cUiDPevxZ6MG=Q@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 12 Dec 2016 16:20:02 +0200
Message-ID: <CABBYNZ+mvs+JGby67EioJg2Qi==taoes++GnFPBizAReJwSkug@mail.gmail.com>
Subject: Re: How BLE services could be remembered?
To: =?UTF-8?Q?jos=C3=A9_bollo?= <jose.bollo@iot.bzh>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jose,

On Mon, Dec 12, 2016 at 3:35 PM, Jos=C3=A9 Bollo <jose.bollo@iot.bzh> wrote=
:
> Hi all,
>
> Using the commit c64b4d9e8dc3e36672061f39a9dba19ad0fb1ef1, the issue
> is sloved. Great! Thank you.
>
> But my issue was also related to the fact that 'connected' was
> received before availability of the attributes/services. The code was
> disconnecting with the effect that not attributes/services coulded be
> discovered.
>
> Should I that the variable "ServicesResolved" is intended to reflect
> the service resolution state? How long should I wait after being
> connected for the ServiceResolved Status? Is there a way to know that
> service resolution is in progress?

You should use ServicesResolved and wait until it becomes 1/true,
while it is false it means it is in progress, when connected, but it
should be quite fast to resolve the services once the cache is
populated.
