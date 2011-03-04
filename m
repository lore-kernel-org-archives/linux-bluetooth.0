Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTim6T15=+UFQDqjOR=VchoFAWtsqo-zKjTdft3MZ@mail.gmail.com>
References: <1299058614-8904-1-git-send-email-lkslawek@gmail.com>
	<AANLkTikGvm5bjwyypJA6Pb47QmBcE1677dJdGQxo+3G7@mail.gmail.com>
	<AANLkTim4d+RaySzaKUFg7yy0gHz-LL4avbYE7_EpDeip@mail.gmail.com>
	<AANLkTi=Hu0tKrrt4_RMSijgvPkJ+WP7Y3TS4Ve5RbkeH@mail.gmail.com>
	<AANLkTimymhOiY1=9k7aB80Vy-dTJF+22uDid+ivgJZH-@mail.gmail.com>
	<AANLkTinsGUaOCe0bwuvGP=z83=YqKd9ARPOOGLU=csLq@mail.gmail.com>
	<AANLkTi=nhd5rzyL+YK6MjvUDzG8bwagZ6-Vt1j=OKq2T@mail.gmail.com>
	<AANLkTim6T15=+UFQDqjOR=VchoFAWtsqo-zKjTdft3MZ@mail.gmail.com>
Date: Fri, 4 Mar 2011 09:50:50 +0100
Message-ID: <AANLkTinpJdDanHtW96=-5GEB+Egq3COq+ukKencyskjy@mail.gmail.com>
Subject: Re: [PATCH 0/4] Message Access Profile plugin
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Luiz,

On Thu, Mar 3, 2011 at 8:54 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Thu, Mar 3, 2011 at 12:20 PM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
>> On Thu, Mar 3, 2011 at 4:08 PM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi,
>>>
>>> On Thu, Mar 3, 2011 at 11:09 AM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
>>>> On 3/3/11, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>>>> Hi,
>>>>>
>>>>> On Thu, Mar 3, 2011 at 6:58 AM, Slawomir Bochenski <lkslawek@gmail.com>
>>>>> wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Wed, Mar 2, 2011 at 10:12 PM, Luiz Augusto von Dentz
>>>>>> <luiz.dentz@gmail.com> wrote:
>>>>>>> I guess naming the file and plugin 'map' would make more sense here,
>>>>>>> we don't want to confuse people what this file is about.
>>>>>>
>>>>>> There are two things which makes MAP - MAS and MNS. It is not like any
>>>>>> other plugin we have here. The communication goes both ways, i.e. in
>>>>>> full implementation there are OBEX server and OBEX client present on
>>>>>> _both_ sides. As generally architecture of obexd and obex-client
>>>>>> currently allows OBEX servers to be implemented only in obexd and OBEX
>>>>>> clients in obex-client, it is easy to imagine that in order to add
>>>>>> full MAP client role, there would be need for another plugin in obexd
>>>>>> for MNS.
>>>>>
>>>>> But that doesn't solve any problem since the profile as a whole need
>>>>> both client and server side it make no sense to have one without the
>>>>> other, we can still have different drivers for each sides but the
>>>>> plugin should be the same, it is a single profile not two.
>>>>>
>>>>
>>>> Let me rephrase this:
>>>> +-------+-------------+---------------+
>>>> |MAP    | obex-client | client/mns.c  |
>>>> |Server |             |     / \       |
>>>> |role   |             |      |        |
>>>> |       +-------------|    D-Bus      |
>>>> |       | obexd       |      |        |
>>>> |       |             |     \ /       |
>>>> |       |             | plugins/mas.c |
>>>> +-------+-------------+---------------+
>>>>
>>>> +-------+-------------+---------------+
>>>> |MAP    | obex-client | client/mas.c  |
>>>> |Client |             |     / \       |
>>>> |role   |             |      |        |
>>>> |       +-------------|    D-Bus      |
>>>> |       | obexd       |      |        |
>>>> |       |             |     \ /       |
>>>> |       |             | plugins/mns.c |
>>>> +-------+-------------+---------------+
>>>>
>>>>>> So there can be mns.c and mas.c, both in obexd, both completely
>>>>>> independent - each one of them having nothing in common, i.e. user can
>>>>>> run mns when he wants to be MAP client, mas when he wants to be MAP
>>>>>> server or mas and mns when he likes to be both.
>>>>>>
>>>>>> Therefore naming it "map" would confuse more those who know what is
>>>>>> MAP and what they really want.
>>>>>
>>>>> Again if they cannot be qualified separately then it make no sense to
>>>>> separate them in two plugin, the logical separation can happen on
>>>>> driver level.
>>>>
>>>> So yes, they most definitely can be qualified separately.
>>>
>>> Sorry but I doubt you can, MAS and MSN are not profiles they just
>>> represent services, besides it is mandatory to support both MAS and
>>> MNS in MSE see Table 4-1:MAP features, so at least for obexd it
>>> doesn't make much sense to have them separated in two plugins, they
>>> can be separated in different files which are used by the same plugin,
>>> this make it easier to enable/disable MAP as o whole.
>> Please read me again. Especially take a longer look at the graphics
>> with roles presented. The plugins/mns.c presented here _does not_ have
>> _anything_ to do with plugins/mas.c - they are used in completely
>> different roles. Once again: they are NOT part of the same thing. See
>> chapter 2.1 in MAP specification. What will be qualified _together_ is
>> plugin/mas.c and client/mns.c.
> Yep, another design decision you took without consulting us, I believe
> MSE should be completely implemented on obexd and MCE on obex-client,
> why do you thing involving two processes here would make sense?

Actually, with this whole plethora of small decisions I did not feel
urge to discuss, this was a notable exception. Before I even wrote a
single line of notifications-related code I considered carefully
multiple possibilities. And then I shared my findings on #obexd @
freenode asking specifically what would be the preferred way to
implement this. Johan took part in the discussion addressing this and
we came to conclusion, that even though this needs two processes
running (which in fact was what personally make me a little bit
reluctant) this is the cleanest and simplest way to do this.

> There is nothing prevent us to implement client code on obexd nor server
> code on obex-client, this was a design choice you took

Are we still talking about obexd or is it obex-data-server (which do
have client and server functionality integrated in one daemon)? This
is far more complicated. As far as I know currently there is nothing
allowing implementing OBEX clients in obexd nor allowing implementing
OBEX servers in obex-client. Even in server role, when required OBEX
client is simple this would require adding large parts from
obex-client to obexd (SDP browsing, actual client event handlers) and
it might be not as easy as linking it with parts of obex-client.
Unless we want to achieve the same architecture that obex-data-server
has and eventually melt obex-client and obexd into one daemon which
binds them all ;), I don't think it is possible

For MSE I was thinking about manually adding parts for searching SDP,
making my own bluetooth socket and using openobex directly. This would
make the code horrible, but still, this is a possibility. I would not
want to go there, though. In case of MCE there is no requirement that
MNS server has to be present, so they can be left separated between
obex-client and obexd and do not even talk to each other, only to the
MCE client applications that would want to utilize them.

> which doesn't mean it can't work using MSE/MCE separation.

Please restate this sentence ending. Well, I just plainly do not get
it at all. Even whether you meant something negative or positive. :)

>>>>>>> Also Ive been thinking on removing this internal APIs for backend,
>>>>>>> each would implemented as plugin/mimetype driver directly and we can
>>>>>>> create basic drivers for pbap and map and export its callbacks on
>>>>>>> pbap.h and map.h respectively as we do for pcsuite which uses ftp
>>>>>>> driver callbacks.
>>>>>>
>>>>>> I really hope that you will keep this in "thinking stage" for now. I
>>>>>> see problems coming. I'd rather prefer to use what we have now and
>>>>>> what works. There might be some parts that won't fit well in this new
>>>>>> philosophy. It would be better to postpone considering such changes in
>>>>>> MAP to the point when it will be in repository in a more complete
>>>>>> form.
>>>>>
>>>>> It should not cause any problem, because core only knows about the
>>>>> mimetype drivers, the backend interface is a plugin specific API. In
>>>>> theory one could re implement pbap plugin which would have another
>>>>> backend interface. If we have the backend implementing the mimetype
>>>>> driver the only thing that changes is that no API is needed between
>>>>> e.g. pbap plugin and the backend.
>>>>>
>>>>> Note that one of the worst problems with current pbap implementation
>>>>> is the backend API, because it has to handle things like asynchronous
>>>>> requests and cancel requests which comes from mimetype driver it had
>>>>> to change several times during the development, I don't want this to
>>>>> happen with map.
>>>>
>>>> This already happened with MAP and it works. It is done differently than
>>>> in PBAP, for example handling of application parameters and cases when
>>>> body is sent and when it is not is done more cleanly. And I've already
>>>> seen the problems closer to the end of the MAP implementation road. What
>>>> you're proposing will make this road more bumpy.
>>>
>>> Sorry, but until this reach upstream you cannot assumed it has
>>> happened. That why we suggest sending us patches earlier so we can
>>> review and discuss architect and design aspects not only code, now
>>> that we had more experience with the backend interface we could
>>> actually experiment the direct approach without creating more APIs,
>>> usually it is easier to add API but hard to remove them once a lot of
>>> code depend on them. What you may suggest is to integrate MAP
>>> implementation as it is and latter change it, but please communicate
>>> before about design decisions, there is no need to develop this
>>> completely before sending upstream.
>> PBAP is much simpler than MAP. Thus it may be tempting to do
>> assumptions about MAP using previous experiences. This may not lead to
>> good conclusions.
>
> If mimetype driver API was not able to implement the drivers for MAP
> you would have to change it, I don't see any modification to
> mimetype.h, so it looks exactly like pbap, mimetype driver is used to
> extract the request information to pass to backend via some API.
>
> Please if you have a use case for MAP that with mimetype driver it
> cannot be implement please provide it, otherwise I would consider that
> you meant the backend is much more complex, but the requests are quite
> similar.

Let me bullet point some examples:

* When the notifications are active the backend can call plugin at any
time, not in line with any request currently processed. Backend does
it when it becomes aware of a new message in repository. This is done
by calling glue function, implemented in the plugin.

* Additionally, as backend has a better way of making decisions about
pending notifications (some of these may become outdated before we are
ready to send them), it also does the queuing. It starts queuing
notifications when transport plugin informs it that client wishes to
receive notifications, and this happens right when
SetNotificationRegistration is received. Queuing is needed:
- because of delay between getting SetNotificationRegistration and
making the connection back to MNS OBEX server on client's side,
- because we have to wait for client response on MNS channel to
previous notification before we can send the next one.

So plugin uses another glue functions to say that it is ready to send
next notification in line.

* About this theory regarding another PBAP plugin. I assume you meant
that one wouldn't want to implement exactly another PBAP plugin and
more likely someone would want to develop another profile needing the
access to the same data PBAP does (or parts of it).

I suppose that this is the relation between pcsuite and filesystem.c.
However PBAP or MAP is not a filesystem.c - the data sent is not raw
(or rather depending only on the underlaying accessed object). It is
formatted in some profile-specific fashion. I can see that current
implementation of PBAP makes the backend doing all the work of
formatting data, so this data is useless in case of some new profile
that needs to get phone book entries and possibly send them in it's
own format.

This is not what I've chosen for MAP. For instance message listing
object in MAP profile takes form of XML document. The backend role is
to get all the meta data it can possibly get that is useful in this
listing and it returns this data to transport plugin in struct. This
way the data is really reusable in any other scenarios. Escaping
strings and formatting XML is done in plugin. This also prevents
repetitions in code of multiple backends.

So again - implementing storage backends as mime drivers removes the
flexibility of choosing data structure appropriate for situation.

> --
> Luiz Augusto von Dentz
> Computer Engineer
>



-- 
Slawomir Bochenski
