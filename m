Return-Path: <mfrey@pepper.com>
In-Reply-To: <1090864026.29589.1.camel@pegasus>
References: <1090054739.4558.2.camel@pegasus> <1090759952.4791.91.camel@pegasus> <9A44A69C-DF28-11D8-B83A-00039390D626@pepper.com> <1090864026.29589.1.camel@pegasus>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5F07F140-DF2E-11D8-B83A-00039390D626@pepper.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
From: Michael Frey <mfrey@pepper.com>
Subject: Re: [Bluez-devel] HIDP backport for 2.4
Date: Mon, 26 Jul 2004 14:05:26 -0400
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

ok -- got past those -- now here are some more.

sock.c: In function `hidp_sock_ioctl':
sock.c:84: warning: implicit declaration of function `sockfd_lookup'
sock.c:84: warning: assignment makes pointer from integer without a cast
sock.c:88: warning: assignment makes pointer from integer without a cast
sock.c: In function `hidp_init_sockets':
sock.c:200: error: `BTPROTO_HIDP' undeclared (first use in this 
function)
sock.c:200: error: (Each undeclared identifier is reported only once
sock.c:200: error: for each function it appears in.)
sock.c: In function `hidp_cleanup_sockets':
sock.c:210: error: `BTPROTO_HIDP' undeclared (first use in this 
function)
make[3]: *** [sock.o] Error 1


Michael

On Jul 26, 2004, at 1:47 PM, Marcel Holtmann wrote:

> Hi Michael,
>
>> I get the following build errors.  I am using MontaVista Linux 2.4.20
>>
>> In file included from core.c:46:
>> hidp.h:72: warning: no semicolon at end of struct or union
>> hidp.h:72: error: parse error before '*' token
>
> this one is easy. Remove the __user from that line. It is only useful 
> in
> a 2.6 kernel.
>
>> core.c: In function `hidp_session':
>> core.c:344: error: structure has no member named `nice'
>
> Remove that line and try again. Maybe the MontaVista kernel has a
> special backport.
>
>> core.c: In function `hidp_get_connlist':
>> core.c:598: error: dereferencing pointer to incomplete type
>> core.c:603: error: dereferencing pointer to incomplete type
>> core.c:606: error: dereferencing pointer to incomplete type
>> core.c:608: error: dereferencing pointer to incomplete type
>
> These are related to error number one.
>
> Regards
>
> Marcel
>
