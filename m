Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 0/4] Fix hci_dev ref-counts
From: Marcel Holtmann <marcel@holtmann.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Date: Mon, 31 Oct 2011 12:58:58 +0100
In-Reply-To: <1319806804-12230-1-git-send-email-dh.herrmann@googlemail.com>
References: <1319806804-12230-1-git-send-email-dh.herrmann@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320062340.15441.265.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> We currently have two reference counters for each hci_dev. This patchset tries
> to reduce this to one ref-count and fix several bugs with them. The two
> available ref-counts currently are:
> 
> 1) hci_dev->dev internal
> This ref-count is increased by hci_alloc_dev() and decreased inside
> hci_free_dev(). No other code currently uses this refcount. It can be set with
> get_device() and put_device().
> When this ref-count drops zero, then the hci_dev structure is deallocated (see
> bt_link_release inside hci_sysfs.c), hence, this ref-count is the most important
> one. However, we currently do not use it correctly.
> 
> 2) hci_dev->refcnt
> This ref-count is used inside hci_dev_hold/put() and practically used as if it
> would protect the hci_dev structure. However, if this ref-count drops zero, then
> the ->destruct callback is called which is used by all drivers *exclusively* to
> deallocate driver structures and *not* to deallocate or destroy the hci_dev.

actually I think we should convert the tasklets into one workqueue first
and then integrate deeper into sysfs before trying to hack around this
problem.

Our core driver registration code is from the 2.4 series and needs major
updating. The sysfs code is glued on top of it and not really well
integrated. So fixing that one properly might make some of these race
conditions go away.

Regards

Marcel


