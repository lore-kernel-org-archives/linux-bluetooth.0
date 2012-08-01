Return-Path: <cyrus@holtmann.org>
Message-ID: <50191BCC.8000104@tu-ilmenau.de>
Date: Wed, 01 Aug 2012 14:06:36 +0200
From: Steffen Becker <steffen.becker@tu-ilmenau.de>
MIME-Version: 1.0
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: no security block - but connection still gets refused
References: <4FC35278.40903@tu-ilmenau.de> <20120528173938.GA4151@samus>
In-Reply-To: <20120528173938.GA4151@samus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

<snip>

Am 28.05.2012 19:39, schrieb Vinicius Costa Gomes:
> Hi Steffen,
>
> On 12:24 Mon 28 May, Steffen Becker wrote:
>> I always got a "security block"-issue while tried to connect. I
>> searched your mail-archive & you told me, this problem is solved in
>> kernel 3.3 and later.
>> I installed kernel 3.4 and - hooray - no "security block" anymore!
>> *But* the connection still doesn't work. I connect them - they are
>> connected for about 2 seconds - then connection is refused.
>> So I really hope you can have a look at the following lines and tell
>> me how to solve this problem.
>>
>> PS:
>> I'm sorry for wasting your time, but this case isn't "just for fun
>> for me"; it's important that it works. So I even would donate/pay
>> something if you can help me solve this problem.
>>
>> Here is what I get when I use test-network:
>>
>> # bluez-test-network 00:02:72:AE:58:73 NAP
>>
>> Traceback (most recent call last):
>>    File "/usr/bin/bluez-test-network", line 40, in <module>
>>      device = adapter.FindDevice(address)
>>    File "/usr/lib64/python2.7/site-packages/dbus/proxies.py", line
>> 70, in __call__
>>      return self._proxy_method(*args, **keywords)
>>    File "/usr/lib64/python2.7/site-packages/dbus/proxies.py", line
>> 145, in __call__
>>      **keywords)
>>    File "/usr/lib64/python2.7/site-packages/dbus/connection.py", line
>> 651, in
>> call_blocking
>>      message, timeout)
>> dbus.exceptions.DBusException: org.bluez.Error.DoesNotExist: Does Not Exist
>  From this and the hcidump, the answer is that it could not find a
> server running in the remote side (i.e. the SDP service search returned
> nothing).
>
>
> [snip]
>
>
Hm, i don't really understand what you mean with "could not find a 
server running": How can I start such a server on the remote side?

Regards,
Steffen
