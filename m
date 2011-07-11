Return-Path: <cyrus@holtmann.org>
Message-Id: <7.0.1.0.2.20110711234654.033dd5a8@gmx.net>
Date: Tue, 12 Jul 2011 00:07:04 +0200
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: Peter Kornatowski <pkorn@gmx.net>
Subject: Re: Media API with more than one headset
Cc: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <7.0.1.0.2.20110708213144.033af340@gmx.net>
References: <7.0.1.0.2.20110622230344.031f5790@gmx.net>
 <BANLkTikuRgeFW-fXckR4ST14idxPSmNP7g@mail.gmail.com>
 <7.0.1.0.2.20110627205517.03250550@gmx.net>
 <BANLkTinFieuN8HSLu8-pTaMix9r48d6HBw@mail.gmail.com>
 <BANLkTimMQcjj3A=cNaUWY4xByY2WrhA9RA@mail.gmail.com>
 <BANLkTiknkbZcS2AASzS_qeXbNJ3_Qa2e1A@mail.gmail.com>
 <7.0.1.0.2.20110629214327.0321b4e0@gmx.net>
 <7.0.1.0.2.20110706214918.03262000@gmx.net>
 <CABBYNZ+y1EkxNOr53Cr2SkbYfgKV3SCDK10ejo1mjHzdcB2BvQ@mail.gmail.com>
 <7.0.1.0.2.20110707101900.03230f68@gmx.net>
 <CABBYNZ+7952MAawEKusu2UcPwbGQ1ZS8sKiDmDLg+ZiE0-5wPw@mail.gmail.com>
 <7.0.1.0.2.20110707213702.033c8098@gmx.net>
 <CABBYNZ+w2kFrKiuCpXFeXo+uTX1cf+DxQGWVD2F_GEESOoW+Aw@mail.gmail.com>
 <7.0.1.0.2.20110708213144.033af340@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_3026390==_"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--=====================_3026390==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 21:43 08.07.2011, Peter Kornatowski wrote:
>Hi Luiz,
>
>At 12:08 08.07.2011, Luiz Augusto von Dentz wrote:
>>Hi Peter,
>>
>>On Thu, Jul 7, 2011 at 10:57 PM, Peter Kornatowski <pkorn@gmx.net> wrote:
>> > I'm calling Acquire when SetConfiguration is called by bluez 
>> (isn't that the
>> > correct spot, cause there you get the transport path?). I 
>> attached the whole
>> > modified script, so you can see exactly what I'm doing.
>>
>>As I explained in the last email you have to reply to the
>>SetConfiguration before you are able to do Acquire, that is on purpose
>>to avoid a possible deadlock where you are the application is waiting
>>for Acquire to complete but bluetoothd is waiting the application to
>>reply to SetConfiguration, bluetoothd won't block but the application
>>may block trying to Acquire and by doing that it is not able to reply
>>to SetConfiguration.
>
>This is why I'm calling Acquire asynchronously. But ok, I will test 
>it with a postponed Acquire.

Tested it with a seperate python-script for calling Acquire (attached 
it). Modified the previous script so that it doesn't call Acquire anymore.
So when registering two endpoints and connecting one headset, I see 
bluez calling SetConfiguration for both endpoints (so two transport 
paths with just different fdX at the end). I then call Acquire with 
the new script for one endpoint at get the headset into playing mode 
every time. When trying to call Acquire for the second headset I 
always get Operation Not Authorized (which is fine I guess, but the 
second SetConfiguration call in the first place is not). When 
stopping this last scquire-script with ctrl+c (just the one that 
produced Operation Not Authorized), bluetoothd always segfaults. 
Stopping the other acquire-script or the endpoint-dual doesn't 
segfault bluetoothd. I could reproduce this with my C code as well.

Also with endpoint and Acquire being in two different scripts I could 
play around a little and found out that starting more endpoints than 
there are connected headsets is not a good idea, even when you don't 
call Acquire. So to workaround this behaviour I have to wait for a 
headset to connect, then register just one endpoint for it and call 
Acquire. For the next headset that connects I have to do the same. 
And when a headset disconnects, the endpoint has to be unregistered 
and closed as well. Or is this the intended way of doing it anyway?



>> > It also works for the first headset or if all headsets are in 
>> connected mode
>> > and you start the script, so generally it should be ok.
>> > But it doesn't work if you start the script and then connect the first
>> > headset (or start the script after just one headset is in connected mode).
>> > Then the headset gets into playing mode, but bluez tries to put it into
>> > playing mode on the other endpoint, too (at least it looks that way to me
>> > cause SetConfiguration is being called twice). So then Acquire is being
>> > called twice, too. For one call I get the file descriptor, but 
>> for the other
>> > call I get "Operation Not Authorized". Maybe because the second
>> > SetConfiguration is called for the other endpoint, which is on the other
>> > adapter with which the headset is not paired (each headset is only paired
>> > with one adapter). On the other hand, the transport path from both
>> > SetConfiguration calls is for the same adapter... But when you 
>> then connect
>> > the second headset (which is paired with the other adapter), bluez doesn't
>> > call SetConfiguration for it (probably because this endpoint is still
>> > "blocked" by the first headset, but it shouldn't be).
>>
>>The Operation Not Authorized in because you didn't reply to
>>SetConfiguration, also bluetoothd will try to match the profile
>>capabilities with the endpoint capabilities and then call
>>SetConfiguration to the endpoint to confirm if it is able to handle
>>the transport, in theory I don't see any problem to the same endpoint
>>to get multiple SetConfiguration as long it is for different devices,
>>but perhaps we need to limit to only one transport per endpoint which
>>is usually the case for a2dp since the sep has the in_use flag.
>
>Where do you see that I'm not replying to SetConfiguration? Because 
>of the asynchronous Acquire call it should always reply.
>But the limit would probably be a good idea.
>
>
>> > Additionally, when you try to end the script with ctrl+c now, bluetoothd
>> > segfaults with: segfault at 3c ip b75359d5 sp bfd25c10 error 4 in
>> > libdbus-1.so.3.5.7[b7521000+48000]
>> > I tried the whole use case as user and as root, but no difference. I also
>> > attached the syslog output (bluetoothd started with -d).
>>
>>The syslog doesn't seems to indicate any crashes, did you left it out?
>>Btw, to get more information about the crash please run bluetooth with
>>valgrind e.g:
>>
>>sudo G_SLICE=always-malloc G_DEBUG=gc-friendly,resident-module
>>valgrind --trace-children=yes  ./bluetoothd -dn
>
>I didn't leave out anything. I attached the valgrind log. This is what I did:
>1. Started bluetoothd with valgrind.
>2. Started simple-endpoint-dual (see my last e-mail) with no 
>headsets in connected mode.
>3. Connected one headset (got one file descriptor and one Operation 
>Not Authorized).
>4. Ended simple-endpoint-dual with ctrl+c (and bluetoothd segfaults).
>
>
>>--
>>Luiz Augusto von Dentz
>>--
>
>Peter
>
>
>

--=====================_3026390==_
Content-Type: application/octet-stream; name="simple-endpoint-acquire"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="simple-endpoint-acquire"

IyEvdXNyL2Jpbi9weXRob24KCmltcG9ydCBzeXMKaW1wb3J0IGRidXMKaW1wb3J0IGRidXMuc2Vy
dmljZQppbXBvcnQgZGJ1cy5tYWlubG9vcC5nbGliCmltcG9ydCBnb2JqZWN0CgpkZWYgYWNxdWly
ZV9jYihmZCwgaW10dSwgb210dSk6CglwcmludCAiQWNxdWlyZSBzdWNjZXNzZnVsbCEgTmV3IGZk
OiAlcyB3aXRoIGlNVFUgJWkgYW5kIG9NVFUgJWkiICUgKGZkLCBpbXR1LCBvbXR1KQoKZGVmIGFj
cXVpcmVfZXJyb3IoZXJyb3IpOgoJcHJpbnQgIkFjcXVpcmUgZmFpbGVkOiAlcyIgJSAoZXJyb3Ip
CgkjbWFpbmxvb3AucXVpdCgpCgppZiBfX25hbWVfXyA9PSAnX19tYWluX18nOgoJaWYgbGVuKHN5
cy5hcmd2KSA8IDI6CgkJcHJpbnQgInVzYWdlOiAlcyAvdHJhbnNwb3J0L3BhdGgvdG8vZmRYIiAl
IChzeXMuYXJndlswXSkKCQlzeXMuZXhpdCgxKQoKCWRidXMubWFpbmxvb3AuZ2xpYi5EQnVzR01h
aW5Mb29wKHNldF9hc19kZWZhdWx0PVRydWUpCgoJYnVzID0gZGJ1cy5TeXN0ZW1CdXMoKQoJbWVk
aWFfdHJhbnNwb3J0ID0gZGJ1cy5JbnRlcmZhY2UoYnVzLmdldF9vYmplY3QoIm9yZy5ibHVleiIs
IHN5cy5hcmd2WzFdKSwgIm9yZy5ibHVlei5NZWRpYVRyYW5zcG9ydCIpCgltZWRpYV90cmFuc3Bv
cnQuQWNxdWlyZSgicnciLCByZXBseV9oYW5kbGVyPWFjcXVpcmVfY2IsIGVycm9yX2hhbmRsZXI9
YWNxdWlyZV9lcnJvcikKCgltYWlubG9vcCA9IGdvYmplY3QuTWFpbkxvb3AoKQoJbWFpbmxvb3Au
cnVuKCkKCg==
--=====================_3026390==_--

