Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1357758529.1806.46.camel@aeonflux>
References: <1357744762-5111-1-git-send-email-anderson.lizardo@openbossa.org>
	<1357758529.1806.46.camel@aeonflux>
Date: Wed, 9 Jan 2013 16:06:35 -0400
Message-ID: <CAJdJm_NyJRKKinVCBQnO9=cjG3qZWwWJcZ2BJGO7hd3U57ygPA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] unit: Reuse define_test() macro for
 /TP/SERVER/BRW/* tests
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jan 9, 2013 at 3:08 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> -#define define_test(name, args...) \
>> +#define define_test(name, _mtu, args...) \
>>       do {                                                            \
>>               const struct sdp_pdu pdus[] = {                         \
>>                       args, { }, { }                                  \
>>               };                                                      \
>>               static struct test_data data;                           \
>> -             data.mtu = 48;                                          \
>> +             data.mtu = _mtu;                                        \
>
> so using _mtu instead of mtu was the trick here. For the heck of it I
> could not figure that one out. So in the end I gave up on it and
> hardcoded it :(

Yes, I was caught by it as well, until I realized that the
preprocessor might be replacing the "mtu" part of "data.mtu" (I
confirmed when I saw the cpp output).

>
> Patch has been applied.

Thanks,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
