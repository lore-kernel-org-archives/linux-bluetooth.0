Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Apr 2009 09:17:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Xu, Martin" <martin.xu@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: patch to fix a2dp issue
Message-ID: <20090407061728.GA9223@jh-x301>
References: <1238730552-3765-1-git-send-email-forrest.zhao@gmail.com> <20090403201207.GA8156@jh-x301> <ac8af0be0904031748u4b109e11kb78a1db3d50ead71@mail.gmail.com> <9F0C1DB20AFA954FA1DA05309350433D5B0B91CC@pdsmsx503.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9F0C1DB20AFA954FA1DA05309350433D5B0B91CC@pdsmsx503.ccr.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Apr 07, 2009, Xu, Martin wrote:
> We have found a2dp issue, that bluez earphone can not work. The issue has
> filed at: https://bugzilla.moblin.org/show_bug.cgi?id=1355
> (Some one can kindly tell me where I can file the bluez bug. So I can
> transfer the bug from moblin bugzilla there.)

There's no bluez "bugzilla". The email you sent to this list should be good
enough.

> The root cause is that:
> bluez-alsa-plugin has issue at poll revents.
> alsa lib needs to poll 2 channel state. But bluez-alsa-plugin only handles
> channel1 revent, and leave another one unhandled which leads to the channel's
> poll state unpredictable, consequently, pcm stream transfer is broken for the
> wront poll state, and bluethooh earphone(a2dp) can not work.
> I have worked out a patch to fix the issue, which is listed as below.

This is a well known issue with all bluez versions after 4.27. It has been
discussed several times on the #bluez channel as well as the alsa-devel mailing
list [1]. It's caused by commit 593bd41ed861d80f498fa8cfe0cea06e0c11f442 (which
btw also has a link to the alsa-devel thread) and unfortunately it seems we
cannot revert it. The conclusion from the alsa side was that the correct
behavior for applications is to always pass just one filedescriptor in revents
and so if we try to read revents[1] we'd be accessing invalid memory with
applications that use the API correctly.

Johan

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2009-February/014392.html
