Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTim4d+RaySzaKUFg7yy0gHz-LL4avbYE7_EpDeip@mail.gmail.com>
References: <1299058614-8904-1-git-send-email-lkslawek@gmail.com>
	<AANLkTikGvm5bjwyypJA6Pb47QmBcE1677dJdGQxo+3G7@mail.gmail.com>
	<AANLkTim4d+RaySzaKUFg7yy0gHz-LL4avbYE7_EpDeip@mail.gmail.com>
Date: Thu, 3 Mar 2011 08:25:32 -0300
Message-ID: <AANLkTi=Hu0tKrrt4_RMSijgvPkJ+WP7Y3TS4Ve5RbkeH@mail.gmail.com>
Subject: Re: [PATCH 0/4] Message Access Profile plugin
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Mar 3, 2011 at 6:58 AM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
> Hi,
>
> On Wed, Mar 2, 2011 at 10:12 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> I guess naming the file and plugin 'map' would make more sense here,
>> we don't want to confuse people what this file is about.
>
> There are two things which makes MAP - MAS and MNS. It is not like any
> other plugin we have here. The communication goes both ways, i.e. in
> full implementation there are OBEX server and OBEX client present on
> _both_ sides. As generally architecture of obexd and obex-client
> currently allows OBEX servers to be implemented only in obexd and OBEX
> clients in obex-client, it is easy to imagine that in order to add
> full MAP client role, there would be need for another plugin in obexd
> for MNS.

But that doesn't solve any problem since the profile as a whole need
both client and server side it make no sense to have one without the
other, we can still have different drivers for each sides but the
plugin should be the same, it is a single profile not two.

> So there can be mns.c and mas.c, both in obexd, both completely
> independent - each one of them having nothing in common, i.e. user can
> run mns when he wants to be MAP client, mas when he wants to be MAP
> server or mas and mns when he likes to be both.
>
> Therefore naming it "map" would confuse more those who know what is
> MAP and what they really want.

Again if they cannot be qualified separately then it make no sense to
separate them in two plugin, the logical separation can happen on
driver level.

>> Also Ive been thinking on removing this internal APIs for backend,
>> each would implemented as plugin/mimetype driver directly and we can
>> create basic drivers for pbap and map and export its callbacks on
>> pbap.h and map.h respectively as we do for pcsuite which uses ftp
>> driver callbacks.
>
> I really hope that you will keep this in "thinking stage" for now. I
> see problems coming. I'd rather prefer to use what we have now and
> what works. There might be some parts that won't fit well in this new
> philosophy. It would be better to postpone considering such changes in
> MAP to the point when it will be in repository in a more complete
> form.

It should not cause any problem, because core only knows about the
mimetype drivers, the backend interface is a plugin specific API. In
theory one could re implement pbap plugin which would have another
backend interface. If we have the backend implementing the mimetype
driver the only thing that changes is that no API is needed between
e.g. pbap plugin and the backend.

Note that one of the worst problems with current pbap implementation
is the backend API, because it has to handle things like asynchronous
requests and cancel requests which comes from mimetype driver it had
to change several times during the development, I don't want this to
happen with map.

-- 
Luiz Augusto von Dentz
Computer Engineer
