Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1320062340.15441.265.camel@aeonflux>
References: <1319806804-12230-1-git-send-email-dh.herrmann@googlemail.com>
	<1320062340.15441.265.camel@aeonflux>
Date: Tue, 1 Nov 2011 20:59:57 +0100
Message-ID: <CANq1E4Tn-_2LiuAyxhVuTQ0_i14NJzq_zZD3CvnCo1-71nC68A@mail.gmail.com>
Subject: Re: [RFC 0/4] Fix hci_dev ref-counts
From: David Herrmann <dh.herrmann@googlemail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Oct 31, 2011 at 12:58 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi David,
>
>> We currently have two reference counters for each hci_dev. This patchset tries
>> to reduce this to one ref-count and fix several bugs with them. The two
>> available ref-counts currently are:
>>
>> 1) hci_dev->dev internal
>> This ref-count is increased by hci_alloc_dev() and decreased inside
>> hci_free_dev(). No other code currently uses this refcount. It can be set with
>> get_device() and put_device().
>> When this ref-count drops zero, then the hci_dev structure is deallocated (see
>> bt_link_release inside hci_sysfs.c), hence, this ref-count is the most important
>> one. However, we currently do not use it correctly.
>>
>> 2) hci_dev->refcnt
>> This ref-count is used inside hci_dev_hold/put() and practically used as if it
>> would protect the hci_dev structure. However, if this ref-count drops zero, then
>> the ->destruct callback is called which is used by all drivers *exclusively* to
>> deallocate driver structures and *not* to deallocate or destroy the hci_dev.
>
> actually I think we should convert the tasklets into one workqueue first
> and then integrate deeper into sysfs before trying to hack around this
> problem.

I am currently playing around with several patches for that but I
still need to get away from that single-threaded workqueue as it is
quite ugly.

> Our core driver registration code is from the 2.4 series and needs major
> updating. The sysfs code is glued on top of it and not really well
> integrated. So fixing that one properly might make some of these race
> conditions go away.

Ok. I'll will reconsider sending a new RFC when we fixed the workqueue
stuff. As our system is a simple bus-system, it shouldn't be too hard
to do that.

> Regards
>
> Marcel

Regards
David
