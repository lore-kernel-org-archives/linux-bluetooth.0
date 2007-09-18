Return-Path: <fchevalier@silicom.fr>
Message-ID: <46EF9302.50403@silicom.fr>
Date: Tue, 18 Sep 2007 10:57:38 +0200
From: Fabien Chevalier <fchevalier@silicom.fr>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Johan Hedberg <johan.hedberg@nokia.com>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [PATCH] Fix bogus avdtp error codes management
References: <46EEBC41.80401@silicom.fr>  <20070918081557.GA13401@localhost> <1190104027.5525.128.camel@aeonflux.holtmann.net>
In-Reply-To: <1190104027.5525.128.camel@aeonflux.holtmann.net>
Content-Type: multipart/mixed;
 boundary="------------020203010909020502080106"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------020203010909020502080106
Content-Type: multipart/alternative;
 boundary="------------040605000005000806040108"


--------------040605000005000806040108
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

The attached patch makes sure that the correct error code is returned to 
the upper layers.
The issue with the current cvs's code is that EIO would be returned 
whatever the error code returned by the L2CAP layer is, as 
getsockopt(sk, SOL_SOCKET, SO_ERROR, ....) would never be called.
The result of this patch is that you now see the reason of the failure 
in daemon log in case of L2CAP issue, such as:

Sep 18 10:32:53 tannat audio[16934]: avdtp_ref(0x806d230): ref=2
Sep 18 10:32:53 tannat audio[16934]: a2dp_source_request_stream: 
selected SEP 0x806a400
Sep 18 10:32:53 tannat audio[16934]: avdtp_ref(0x806d230): ref=3
Sep 18 10:32:53 tannat audio[16934]: stream creation in progress
Sep 18 10:33:13 tannat audio[16934]: connect(): Host is down (112)


As for the POLLOUT thing, i must say i'm confused..., and don't really 
see the link with the patch :-(
I guess it works already as the GIOChannels heavily rely on it.

Can any of you apply this patch ?

Cheers,

Fabien


> Hi Johan,
>
>   
>>> While trying to fix this cross case issue, i came with an issue with the 
>>> way error codes are handled
>>> in avdtp.c.
>>> The issue is basically that the part of the code that retrieves the 
>>> exact error value is never executed
>>> due to premature return.
>>>       
>> Looks fine to me if it works. However, I'd like to hear some comment
>> from Marcel as well. At least my connect(2) manpage implies that a
>> non-blocking connect should always produce a POLLOUT on connection
>> completion regardless if the result was failure or success. So it seems
>> bluez may be behaving differently than other socket types in this
>> respect.
>>     
>
> if that is so, then we have to fix the kernel. Can someone write me a
> simple reproducer or better send me a patch for the kernel.
>
> Regards
>
> Marcel
>
>
>
>
>   


--------------040605000005000806040108
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi All,<br>
<br>
The attached patch makes sure that the correct error code is returned
to the upper layers. <br>
The issue with the current cvs's code is that EIO would be returned
whatever the error code returned by the L2CAP layer is, as
getsockopt(sk, SOL_SOCKET, SO_ERROR, ....) would never be called.<br>
The result of this patch is that you now see the reason of the failure
in daemon log in case of L2CAP issue, such as:<br>
<br>
Sep 18 10:32:53 tannat audio[16934]: avdtp_ref(0x806d230): ref=2<br>
Sep 18 10:32:53 tannat audio[16934]: a2dp_source_request_stream:
selected SEP 0x806a400<br>
Sep 18 10:32:53 tannat audio[16934]: avdtp_ref(0x806d230): ref=3<br>
Sep 18 10:32:53 tannat audio[16934]: stream creation in progress<br>
Sep 18 10:33:13 tannat audio[16934]: connect(): Host is down (112)<br>
<br>
<br>
As for the POLLOUT thing, i must say i'm confused..., and don't really
see the link with the patch :-(<br>
I guess it works already as the GIOChannels heavily rely on it.<br>
<br>
Can any of you apply this patch ?<br>
<br>
Cheers,<br>
<br>
Fabien<br>
<br>
<br>
<blockquote cite="mid1190104027.5525.128.camel@aeonflux.holtmann.net"
 type="cite">
  <pre wrap="">Hi Johan,

  </pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <pre wrap="">While trying to fix this cross case issue, i came with an issue with the 
way error codes are handled
in avdtp.c.
The issue is basically that the part of the code that retrieves the 
exact error value is never executed
due to premature return.
      </pre>
    </blockquote>
    <pre wrap="">Looks fine to me if it works. However, I'd like to hear some comment
from Marcel as well. At least my connect(2) manpage implies that a
non-blocking connect should always produce a POLLOUT on connection
completion regardless if the result was failure or success. So it seems
bluez may be behaving differently than other socket types in this
respect.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
if that is so, then we have to fix the kernel. Can someone write me a
simple reproducer or better send me a patch for the kernel.

Regards

Marcel




  </pre>
</blockquote>
<br>
</body>
</html>

--------------040605000005000806040108--

--------------020203010909020502080106
Content-Type: text/x-vcard; charset=utf-8;
 name="fchevalier.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="fchevalier.vcf"

YmVnaW46dmNhcmQNCmZuOkZhYmllbiBDSEVWQUxJRVINCm46Q0hFVkFMSUVSO0ZhYmllbg0K
b3JnOlNJTElDT00NCmFkcjo7OzQgcnVlIGRlIEpvdWFuZXQ7IFJFTk5FUyBBVEFMQU5URTs7
MzU3MDA7RlJBTkNFDQplbWFpbDtpbnRlcm5ldDpmY2hldmFsaWVyQHNpbGljb20uZnINCnRp
dGxlOlNvZnR3YXJlICYgU3R1ZGllcyBFbmdpbmVlcg0KdGVsO3dvcms6KzMzICgwKSAyIDk5
IDg0IDE3IDE3DQp2ZXJzaW9uOjIuMQ0KZW5kOnZjYXJkDQoNCg==
--------------020203010909020502080106--
