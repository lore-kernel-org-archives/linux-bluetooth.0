Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1361810317-4005-5-git-send-email-dean_jenkins@mentor.com>
References: <1361810317-4005-1-git-send-email-dean_jenkins@mentor.com>
	<1361810317-4005-5-git-send-email-dean_jenkins@mentor.com>
Date: Tue, 26 Feb 2013 00:08:41 +0100
Message-ID: <CANq1E4Tb1rgY0A9RpAarNo-saQ5YSnvk8LZT6UgL6U-A1qwcBA@mail.gmail.com>
Subject: Re: [PATCH 4/6] Bluetooth: Remove RFCOMM session refcnt
From: David Herrmann <dh.herrmann@gmail.com>
To: dean_jenkins@mentor.com
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, gustavo@padovan.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

On Mon, Feb 25, 2013 at 5:38 PM,  <dean_jenkins@mentor.com> wrote:
> From: Dean Jenkins <Dean_Jenkins@mentor.com>
>
> Previous commits have improved the handling of the RFCOMM session
> timer and the RFCOMM session pointers such that freed RFCOMM
> session structures should no longer be erroneously accessed. The
> RFCOMM session refcnt now has no purpose and will be deleted by
> this commit.
>
> Note that the RFCOMM session is now deleted as soon as the
> RFCOMM control channel link is no longer required. This makes the
> lifetime of the RFCOMM session deterministic and absolute.
> Previously with the refcnt, there was uncertainty about when
> the session structure would be deleted because the relative
> refcnt prevented the session structure from being deleted at will.
>
> It was noted that the refcnt could malfunction under very heavy
> real-time processor loading in embedded SMP environments. This
> could cause premature RFCOMM session deletion or double session
> deletion that could result in kernel crashes. Removal of the
> refcnt prevents this issue.
>
> There are 4 connection / disconnection RFCOMM session scenarios:
> host initiated control link ---> host disconnected control link
> host initiated ctrl link ---> remote device disconnected ctrl link
> remote device initiated ctrl link ---> host disconnected ctrl link
> remote device initiated ctrl link ---> remote device disc'ed ctrl link
>
> The control channel connection procedures are independent of the
> disconnection procedures. Strangely, the RFCOMM session refcnt was
> applying special treatment so erroneously combining connection and
> disconnection events. This commit fixes this issue by removing
> some session code that used the "initiator" member of the session
> structure that was intended for use with the data channels.

I tried to do a similar cleanup for the HIDP code (pending on the ML).
Did you check whether the "device_find_child()" and "device_move()"
calls in hci_sysfs.c hci_conn_del_sysfs() are still needed with this
cleanup? The HIDP cleanup doesn't need it, anymore, and if the rfcomm
code got rid of it, too, then we can finally drop that code.

I really think the *_hold() calls in the Bluetooth-core are flawed. We
should try to fix it to split ref-counting and life-time tracking.
Ref-counting for objects can be non-deterministic and this is totally
ok. But life-time tracking must be deterministic. That is, the
device_del() calls must be predictable so we can tell when objects get
deleted. Whether they get freed is minor, this doesn't harm anybody.

Thanks for the nice cleanup.
David
