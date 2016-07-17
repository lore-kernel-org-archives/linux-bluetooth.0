Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: keep alive
To: Sriram V <vshrirama@gmail.com>
References: <CAH9_wRNYizT3piDpbyT1MMwU7T10u6-z9iQws_+6BiJvB8-TGA@mail.gmail.com>
From: Loic Poulain <loic.poulain@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Message-ID: <578B7275.50703@intel.com>
Date: Sun, 17 Jul 2016 13:56:37 +0200
MIME-Version: 1.0
In-Reply-To: <CAH9_wRNYizT3piDpbyT1MMwU7T10u6-z9iQws_+6BiJvB8-TGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sriram,

> I am using a broadcom's bcm bt chip. I wanted to find if there is some
> sort of "Keep Alive" Feature so that connections are not lost?

You should have a look at the spec, but to make it short, Physical link
is monitored/supervised at controller level (Master-Slave(s) polling).
No need to explicitly send NULL data packet like WiFi/802.11.

> I am keeping the bt chip turned on during sleep/suspend. However, I am
> not sure if BT sends keep alive probe periodically. Can someone
> clarify on this.

Connection is maintained, but If there is some incoming logical link
data (ACL, SCO...), Host needs to be active in order to retrieve and
process this data. Actually, any data causing HCI transfer from
controller to host.

In case of system suspend, that means BT controller needs wakeup
capability (via USB resume, out of band gpio...) to move host from
suspend to active.

If host does not wake up, this can cause issues at higher level
(timeout, data lost...) and potentially trigger physical disconnection.

Regards,
Loic
