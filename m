Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTikhFOl6UiI6BN5-xunik9w0FJwW_a7FMbm0-vq7@mail.gmail.com>
References: <t2m2c3916b71004261612i68ccba50h78c83ab3a02713cb@mail.gmail.com>
	 <g2l2d5a2c101004270020mb94d092cnef88b98b147beba0@mail.gmail.com>
	 <n2h2d5a2c101004270133xa4ea7dd5za238a58f9e67613@mail.gmail.com>
	 <q2z2c3916b71004270451r957e5befp631d413d4f316afe@mail.gmail.com>
	 <AANLkTikhFOl6UiI6BN5-xunik9w0FJwW_a7FMbm0-vq7@mail.gmail.com>
Date: Wed, 12 May 2010 22:00:34 -0300
Message-ID: <AANLkTin9BM5XmKKtITtlmkcbFKwGuubyZ_Vt4efMFPfS@mail.gmail.com>
Subject: Re: obexd OPP pull problem
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: Daniel Abraham <daniel.shrugged@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

First, thanks for the interesting bug report.

On Wed, May 12, 2010 at 6:21 PM, Daniel Abraham
<daniel.shrugged@gmail.com> wrote:
> On Tue, Apr 27, 2010 at 2:51 PM, Daniel Abraham
> <daniel.shrugged@gmail.com> wrote:
>> On Tue, Apr 27, 2010 at 11:33 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>>
>>> This should fix at least the D-Bus error:
>>>
>>> http://gitorious.org/obexd/vudentzs-clone/commit/32e48446b6b8cd72e15988c673a60c7fb47b0862
>>
>> Actually, that's not what I see. I'm using the "pull-business-card"
>> script (which doesn't use any try-except block), and it doesn't crash
>> with an exception, even though "dbus-monitor --session" shows the
>> error (below). Is it lost somehow before it reaches Python's D-Bus
>> caller object?
>>
>> method call sender=:1.147 -> dest=:1.142 serial=4 path=/;
>> interface=org.openobex.Client; member=PullBusinessCard
>>   array [
>>      dict entry(
>>         string "Destination"
>>         variant             string "00:1C:26:FC:15:AF"
>>      )
>>   ]
>>   string "d.vcf"
>> method call sender=:1.142 -> dest=org.freedesktop.DBus serial=18
>> path=/org/freedesktop/DBus; interface=org.freedesktop.DBus;
>> member=AddMatch
>>   string "type='signal',interface='org.freedesktop.DBus',member='NameOwnerChanged',arg0=':1.147'"
>> method return sender=:1.142 -> dest=:1.147 reply_serial=4
>> error sender=:1.142 -> dest=:1.147
>> error_name=org.openobex.Error.Failed reply_serial=4
>>   string "Method not allowed"
>> method call sender=:1.142 -> dest=org.freedesktop.DBus serial=21
>> path=/org/freedesktop/DBus; interface=org.freedesktop.DBus;
>> member=RemoveMatch
>>   string "type='signal',interface='org.freedesktop.DBus',member='NameOwnerChanged',arg0=':1.147'"
>> signal sender=org.freedesktop.DBus -> dest=(null destination)
>> serial=10 path=/org/freedesktop/DBus; interface=org.freedesktop.DBus;
>> member=NameOwnerChanged
>>   string ":1.147"
>>   string ":1.147"
>>   string ""
>
> I revisited the issue above, and a problem still reproduces, sorta...
>
> I use the following setup: Fedora 12, BlueZ 4.64, obexd 0.23 on both sides.
> And after a while "PullBusinessCard" started to work, i.e. I pull the
> default vcard (of 50 bytes) from 1 side to the other.
>
> But... Even though the HCI dump shows that the text passed through,
> the vCard file isn't found anywhere.
>
> Also, it looks as if there's some timing issue:
> 1. If I pull a 50-byte card, the remote computer recognize successful
> completion event
> 2. If I pull a 20-KB card, the remote computer doesn't recognize any
> completion event
>
> Either way, the local computer claims to be successful, even though
> there's no saved vcard file.
>
> Another thing I noticed is that the remote host from which I try to
> pull the vcard (also BlueZ 4.64 + obexd 0.23) writes this in
> "/var/log/messages":
>
> obexd[...] New connection from: <BD address>, channel <...>
> (and immediately, with the same timestamp:)
> obexd[...] obexd_handle_input: poll event HUP ERR
>
> I'm also attaching 2 hcidumps (saved on the local computer trying to
> do the pulling).
>
> Any idea how to work around these failures?

I requested a proposed fix to be merged upstream, it is here[1] on the
for-upstream branch. I also set up a 0.23-patched branch that has
those fixes on top of the 0.23 tag, if it makes your life any easier.
But this last option is not even compile tested ;-)

>
> Thanks
>


Cheers,
-- 
Vinicius

[1] http://git.infradead.org/users/vcgomes/obexd.git
