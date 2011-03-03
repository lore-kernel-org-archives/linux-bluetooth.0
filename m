Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTinsGUaOCe0bwuvGP=z83=YqKd9ARPOOGLU=csLq@mail.gmail.com>
References: <1299058614-8904-1-git-send-email-lkslawek@gmail.com>
	<AANLkTikGvm5bjwyypJA6Pb47QmBcE1677dJdGQxo+3G7@mail.gmail.com>
	<AANLkTim4d+RaySzaKUFg7yy0gHz-LL4avbYE7_EpDeip@mail.gmail.com>
	<AANLkTi=Hu0tKrrt4_RMSijgvPkJ+WP7Y3TS4Ve5RbkeH@mail.gmail.com>
	<AANLkTimymhOiY1=9k7aB80Vy-dTJF+22uDid+ivgJZH-@mail.gmail.com>
	<AANLkTinsGUaOCe0bwuvGP=z83=YqKd9ARPOOGLU=csLq@mail.gmail.com>
Date: Thu, 3 Mar 2011 16:20:56 +0100
Message-ID: <AANLkTi=nhd5rzyL+YK6MjvUDzG8bwagZ6-Vt1j=OKq2T@mail.gmail.com>
Subject: Re: [PATCH 0/4] Message Access Profile plugin
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Mar 3, 2011 at 4:08 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Thu, Mar 3, 2011 at 11:09 AM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
>> On 3/3/11, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>> Hi,
>>>
>>> On Thu, Mar 3, 2011 at 6:58 AM, Slawomir Bochenski <lkslawek@gmail.com>
>>> wrote:
>>>> Hi,
>>>>
>>>> On Wed, Mar 2, 2011 at 10:12 PM, Luiz Augusto von Dentz
>>>> <luiz.dentz@gmail.com> wrote:
>>>>> I guess naming the file and plugin 'map' would make more sense here,
>>>>> we don't want to confuse people what this file is about.
>>>>
>>>> There are two things which makes MAP - MAS and MNS. It is not like any
>>>> other plugin we have here. The communication goes both ways, i.e. in
>>>> full implementation there are OBEX server and OBEX client present on
>>>> _both_ sides. As generally architecture of obexd and obex-client
>>>> currently allows OBEX servers to be implemented only in obexd and OBEX
>>>> clients in obex-client, it is easy to imagine that in order to add
>>>> full MAP client role, there would be need for another plugin in obexd
>>>> for MNS.
>>>
>>> But that doesn't solve any problem since the profile as a whole need
>>> both client and server side it make no sense to have one without the
>>> other, we can still have different drivers for each sides but the
>>> plugin should be the same, it is a single profile not two.
>>>
>>
>> Let me rephrase this:
>> +-------+-------------+---------------+
>> |MAP    | obex-client | client/mns.c  |
>> |Server |             |     / \       |
>> |role   |             |      |        |
>> |       +-------------|    D-Bus      |
>> |       | obexd       |      |        |
>> |       |             |     \ /       |
>> |       |             | plugins/mas.c |
>> +-------+-------------+---------------+
>>
>> +-------+-------------+---------------+
>> |MAP    | obex-client | client/mas.c  |
>> |Client |             |     / \       |
>> |role   |             |      |        |
>> |       +-------------|    D-Bus      |
>> |       | obexd       |      |        |
>> |       |             |     \ /       |
>> |       |             | plugins/mns.c |
>> +-------+-------------+---------------+
>>
>>>> So there can be mns.c and mas.c, both in obexd, both completely
>>>> independent - each one of them having nothing in common, i.e. user can
>>>> run mns when he wants to be MAP client, mas when he wants to be MAP
>>>> server or mas and mns when he likes to be both.
>>>>
>>>> Therefore naming it "map" would confuse more those who know what is
>>>> MAP and what they really want.
>>>
>>> Again if they cannot be qualified separately then it make no sense to
>>> separate them in two plugin, the logical separation can happen on
>>> driver level.
>>
>> So yes, they most definitely can be qualified separately.
>
> Sorry but I doubt you can, MAS and MSN are not profiles they just
> represent services, besides it is mandatory to support both MAS and
> MNS in MSE see Table 4-1:MAP features, so at least for obexd it
> doesn't make much sense to have them separated in two plugins, they
> can be separated in different files which are used by the same plugin,
> this make it easier to enable/disable MAP as o whole.
Please read me again. Especially take a longer look at the graphics
with roles presented. The plugins/mns.c presented here _does not_ have
_anything_ to do with plugins/mas.c - they are used in completely
different roles. Once again: they are NOT part of the same thing. See
chapter 2.1 in MAP specification. What will be qualified _together_ is
plugin/mas.c and client/mns.c.

>>>>> Also Ive been thinking on removing this internal APIs for backend,
>>>>> each would implemented as plugin/mimetype driver directly and we can
>>>>> create basic drivers for pbap and map and export its callbacks on
>>>>> pbap.h and map.h respectively as we do for pcsuite which uses ftp
>>>>> driver callbacks.
>>>>
>>>> I really hope that you will keep this in "thinking stage" for now. I
>>>> see problems coming. I'd rather prefer to use what we have now and
>>>> what works. There might be some parts that won't fit well in this new
>>>> philosophy. It would be better to postpone considering such changes in
>>>> MAP to the point when it will be in repository in a more complete
>>>> form.
>>>
>>> It should not cause any problem, because core only knows about the
>>> mimetype drivers, the backend interface is a plugin specific API. In
>>> theory one could re implement pbap plugin which would have another
>>> backend interface. If we have the backend implementing the mimetype
>>> driver the only thing that changes is that no API is needed between
>>> e.g. pbap plugin and the backend.
>>>
>>> Note that one of the worst problems with current pbap implementation
>>> is the backend API, because it has to handle things like asynchronous
>>> requests and cancel requests which comes from mimetype driver it had
>>> to change several times during the development, I don't want this to
>>> happen with map.
>>
>> This already happened with MAP and it works. It is done differently than
>> in PBAP, for example handling of application parameters and cases when
>> body is sent and when it is not is done more cleanly. And I've already
>> seen the problems closer to the end of the MAP implementation road. What
>> you're proposing will make this road more bumpy.
>
> Sorry, but until this reach upstream you cannot assumed it has
> happened. That why we suggest sending us patches earlier so we can
> review and discuss architect and design aspects not only code, now
> that we had more experience with the backend interface we could
> actually experiment the direct approach without creating more APIs,
> usually it is easier to add API but hard to remove them once a lot of
> code depend on them. What you may suggest is to integrate MAP
> implementation as it is and latter change it, but please communicate
> before about design decisions, there is no need to develop this
> completely before sending upstream.
PBAP is much simpler than MAP. Thus it may be tempting to do
assumptions about MAP using previous experiences. This may not lead to
good conclusions.
>
> --
> Luiz Augusto von Dentz
> Computer Engineer
>



-- 
Slawomir Bochenski
