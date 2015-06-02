Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH 1/2] Bluetooth: Add reset_resume function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+5PVA6o2=dF5BrJQojhMjJhsAiM9vaADd_ix3SAvVEbLXkjCQ@mail.gmail.com>
Date: Tue, 2 Jun 2015 17:07:25 +0200
Cc: Laura Abbott <labbott@fedoraproject.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Takashi Iwai <tiwai@suse.de>, Oliver Neukum <oneukum@suse.com>,
	Ming Lei <ming.lei@canonical.com>,
	"David S. Miller" <davem@davemloft.net>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	USB list <linux-usb@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>
Message-Id: <1AD01E7E-4D71-444A-AB0F-F8261C925542@holtmann.org>
References: <1433207682-15064-1-git-send-email-labbott@fedoraproject.org> <BB3BCC01-8BF0-4A17-B8E6-F17B875F1997@holtmann.org> <CA+5PVA6o2=dF5BrJQojhMjJhsAiM9vaADd_ix3SAvVEbLXkjCQ@mail.gmail.com>
To: Josh Boyer <jwboyer@fedoraproject.org>
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Josh,

>>> Bluetooth devices off of some buses such as USB may lose power across
>>> suspend/resume. When this happens, drivers may need to have the setup
>>> function called again and behave differently than a cold power on.
>>> Add a reset_resume function for drivers to call. During the
>>> reset_resume case, the flag HCI_RESET_RESUME will be set to allow
>>> drivers to differentate.
>>> 
>>> Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
>>> ---
>>> This matches with what hci_reset_dev does and also ensures
>>> the setup function gets called again.
>>> ---
>>> include/net/bluetooth/hci.h      |  1 +
>>> include/net/bluetooth/hci_core.h |  1 +
>>> net/bluetooth/hci_core.c         | 16 ++++++++++++++++
>>> 3 files changed, 18 insertions(+)
>>> 
>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>>> index d95da83..6285410 100644
>>> --- a/include/net/bluetooth/hci.h
>>> +++ b/include/net/bluetooth/hci.h
>>> @@ -185,6 +185,7 @@ enum {
>>>      HCI_RAW,
>>> 
>>>      HCI_RESET,
>>> +     HCI_RESET_RESUME,
>>> };
>> 
>> no more addition to this list of flags please. These are userspace exposed flags and with that ABI that we are never ever touching again. If you need flags on a per device basis, then use the second list.
> 
> It would be helpful for other developers if you added a comment to
> that effect above the enum definition.  Otherwise you're going to wind
> up repeating yourself over time.

nobody has done that so far ;)

> Also, if they're exposed to userspace, should this file be using the
> uapi mechanism?  I'm confused how they're exposed today, given that
> they aren't installed via 'make headers_install'.  Is this manually
> synced with some other .h file in a userspace package?

This code is from 2.4.6 and with that pretty much ancient and predates UAPI. The BlueZ userspace library provides userspace versions of these defines etc.

Regards

Marcel

