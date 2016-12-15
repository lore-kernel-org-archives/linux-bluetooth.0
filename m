Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Reply-To: jose.bollo@iot.bzh
In-Reply-To: <CABBYNZ+mvs+JGby67EioJg2Qi==taoes++GnFPBizAReJwSkug@mail.gmail.com>
References: <CA+LDafA2A4Jy8s4aYi8DiwZ=L6dNsQm5g6es5jXMu0pqB9fprA@mail.gmail.com>
 <CABBYNZL2gRTEfn2TsLYn8WoxnOH=cdoG8L8FeJMQKtNT89Nqtw@mail.gmail.com>
 <CA+LDafAX78wBWxJ4e4H7LJd6CzONyNuk3Tx2UvF-hGVjeooZ0w@mail.gmail.com>
 <CABBYNZL3uqU=FWvddOhHxjEZ=0bvhUoq6vYjm=79xHOfd=wFAA@mail.gmail.com>
 <CA+LDafAxHJbaTLgAvyiWRovwc=_19yvtBBp_cUiDPevxZ6MG=Q@mail.gmail.com> <CABBYNZ+mvs+JGby67EioJg2Qi==taoes++GnFPBizAReJwSkug@mail.gmail.com>
From: =?UTF-8?Q?Jos=C3=A9_Bollo?= <jose.bollo@iot.bzh>
Date: Thu, 15 Dec 2016 09:09:47 +0100
Message-ID: <CA+LDafAOJLQGEBdc1uTqnhnAD0u06GfHNoAzeYAi1Nhf1pm6bg@mail.gmail.com>
Subject: Re: How BLE services could be remembered?
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?Q?jos=C3=A9_bollo?= <jose.bollo@iot.bzh>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

Few words, just to tell that it works fine now.

Thank you Luiz and Petri

Best regards
Jos=C3=A9 Bollo
Jos=C3=A9 Bollo - Senior Software Engineer
www.iot.bzh



2016-12-12 15:20 GMT+01:00 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
> Hi Jose,
>
> On Mon, Dec 12, 2016 at 3:35 PM, Jos=C3=A9 Bollo <jose.bollo@iot.bzh> wro=
te:
>> Hi all,
>>
>> Using the commit c64b4d9e8dc3e36672061f39a9dba19ad0fb1ef1, the issue
>> is sloved. Great! Thank you.
>>
>> But my issue was also related to the fact that 'connected' was
>> received before availability of the attributes/services. The code was
>> disconnecting with the effect that not attributes/services coulded be
>> discovered.
>>
>> Should I that the variable "ServicesResolved" is intended to reflect
>> the service resolution state? How long should I wait after being
>> connected for the ServiceResolved Status? Is there a way to know that
>> service resolution is in progress?
>
> You should use ServicesResolved and wait until it becomes 1/true,
> while it is false it means it is in progress, when connected, but it
> should be quite fast to resolve the services once the cache is
> populated.
