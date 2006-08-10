Return-Path: <ulissesf@gmail.com>
Message-ID: <d23110170608101028v5230529dic1b9949ac7230cde@mail.gmail.com>
Date: Thu, 10 Aug 2006 14:28:24 -0300
From: "Ulisses Furquim" <ulissesf@gmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [Bluez-devel] "File descriptor in bad state" on sdp_connect()
Cc: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1155236923.4492.49.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <44D88EC1.7010009@pracucci.com> <44D8815D.4000108@infitsrl.com>
	 <d23110170608090806j2b39e87eqd84ba9843d216153@mail.gmail.com>
	 <1155236923.4492.49.camel@aeonflux.holtmann.net>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

On 8/10/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> >  - trying to list_del() the same list entry twice leading us to a page fault
>
> where do we delete the entry twice?

On the first version of the patch (the one you sent to the list) there
was a list_del() inside l2cap_conn_del(). This list_del() was causing
a page fault trying to dereference prev and next pointers that were
poisoned because of a previous list_del().

> >  - we've forgotten to INIT_LIST_HEAD() our l2cap_conn->list leading us
> > to a NULL pointer dereference
>
> This must be another bug, because it is not needed to init the list item
> itself. You only have to init the list head.

Hmm.. I think you're right as we already declare our list head with
LIST_HEAD(). I was seeing a NULL pointer dereference inside
list_del(), tough. Weird.

> The attached patch should not change any behavior, but keep track of
> L2CAP connections in creation state. Please test and check the output of
> dmesg.

Ok.

-- Ulisses
