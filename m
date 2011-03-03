Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTikGvm5bjwyypJA6Pb47QmBcE1677dJdGQxo+3G7@mail.gmail.com>
References: <1299058614-8904-1-git-send-email-lkslawek@gmail.com>
	<AANLkTikGvm5bjwyypJA6Pb47QmBcE1677dJdGQxo+3G7@mail.gmail.com>
Date: Thu, 3 Mar 2011 10:58:12 +0100
Message-ID: <AANLkTim4d+RaySzaKUFg7yy0gHz-LL4avbYE7_EpDeip@mail.gmail.com>
Subject: Re: [PATCH 0/4] Message Access Profile plugin
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Mar 2, 2011 at 10:12 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> I guess naming the file and plugin 'map' would make more sense here,
> we don't want to confuse people what this file is about.

There are two things which makes MAP - MAS and MNS. It is not like any
other plugin we have here. The communication goes both ways, i.e. in
full implementation there are OBEX server and OBEX client present on
_both_ sides. As generally architecture of obexd and obex-client
currently allows OBEX servers to be implemented only in obexd and OBEX
clients in obex-client, it is easy to imagine that in order to add
full MAP client role, there would be need for another plugin in obexd
for MNS.

So there can be mns.c and mas.c, both in obexd, both completely
independent - each one of them having nothing in common, i.e. user can
run mns when he wants to be MAP client, mas when he wants to be MAP
server or mas and mns when he likes to be both.

Therefore naming it "map" would confuse more those who know what is
MAP and what they really want.

> Also Ive been thinking on removing this internal APIs for backend,
> each would implemented as plugin/mimetype driver directly and we can
> create basic drivers for pbap and map and export its callbacks on
> pbap.h and map.h respectively as we do for pcsuite which uses ftp
> driver callbacks.

I really hope that you will keep this in "thinking stage" for now. I
see problems coming. I'd rather prefer to use what we have now and
what works. There might be some parts that won't fit well in this new
philosophy. It would be better to postpone considering such changes in
MAP to the point when it will be in repository in a more complete
form.


-- 
Slawomir Bochenski
