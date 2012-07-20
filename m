Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 20 Jul 2012 15:39:38 -0500
Message-ID: <CABUK1ahRsy+JtP-pqTcHeVSD=OxQ=_Yb29gCKZCzxxa-httdmw@mail.gmail.com>
Subject: AVRCPv1.3 NOTIFY from CT per notification from TG
From: Pavan Savoy <pavan_savoy@sify.com>
To: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Went through the archives, don't see this being discussed.
I read the AVRCPv1.3 spec section mentioned below and to me it looks
like it's been implemented the way it is supposed to be, However, the
question is WHY ?

        /* Unregister event as per AVRCP 1.3 spec, section 5.4.2 */
        player->registered_events ^= 1 << id;

Does that mean - A car-kit product would keep asking for new
notifications time and again ? That too, It needs to be requesting for
notification for each individual EVENT_ID again and again ? Since 1
notification request is good for 1 notification & for 1 particular
event ?

Wouldn't this make the devices more chatty then they are supposed to
be? Why not enable/disable notifications - And capability to OR
various event IDs ?

Thanks & Regards,
Pavan Savoy.
