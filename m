Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <C1D70CB9-F9E5-494A-BF0E-C8D76F5302F5@gmail.com>
References: <C1D70CB9-F9E5-494A-BF0E-C8D76F5302F5@gmail.com>
Date: Fri, 19 Jul 2013 11:13:26 +0300
Message-ID: <CABBYNZK=r-5JCa6RyOHVSzNQkhU1oxLLFu71r2a1u9vTwQiyOA@mail.gmail.com>
Subject: Re: AVRCP(-CT): Fixed volume control for devices in controller mode.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ruben Jenster <rjenster@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ruben,

On Thu, Jul 18, 2013 at 8:54 PM, Ruben Jenster <rjenster@gmail.com> wrote:
> Hi,
>
> AVRCP volume control is currently not working with bluez5 (master branch) when the device is in controller mode.
> I saw the following output when pressing the volume keys on my iPhone:
>
> profiles/audio/avrcp.c:handle_vendordep_pdu() AVRCP PDU 0x50, company 0x001958 len 0x0100
>
> I looked at the source and noticed that the event registration for the volume changed event is done differently
> when the device is in target or controller mode. Volume control works when using the method used for devices in target mode.
>
> See the patch attached. Please fix this in the next release!

That is not how it work for volume control, it is the sink/rendering
device/controller that needs to support VOLUME_CHANGED event, in fact
iPhone doesn't even support VOLUME_CHANGED event:

> ACL data: handle 12 flags 0x02 dlen 26
    L2CAP(d): cid 0x0044 len 22 [psm 23]
      AVCTP Control: Response : pt 0x00 transaction 0 pid 0x110e
        AV/C: Stable: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: GetCapabilities: pt Single len 0x0009
            CapabilityID: 0x03 (EventsID)
            CapabilityCount: 0x07
            EventsID: 0x01 (EVENT_PLAYBACK_STATUS_CHANGED)
            EventsID: 0x02 (EVENT_TRACK_CHANGED)
            EventsID: 0x08 (EVENT_PLAYER_APPLICATION_SETTING_CHANGED)
            EventsID: 0x09 (EVENT_NOW_PLAYING_CONTENT_CHANGED)
            EventsID: 0x0a (EVENT_AVAILABLE_PLAYERS_CHANGED)
            EventsID: 0x0b (EVENT_ADDRESSED_PLAYER_CHANGED)
            EventsID: 0x0c (EVENT_UIDS_CHANGED)

Instead what iPhone does is register to CTs VOLUME_CHANGED:

> ACL data: handle 12 flags 0x02 dlen 22
    L2CAP(d): cid 0x0044 len 18 [psm 23]
      AVCTP Control: Command : pt 0x00 transaction 8 pid 0x110e
        AV/C: Notify: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: RegisterNotification: pt Single len 0x0005
            EventID: 0x0d (EVENT_VOLUME_CHANGED)
            Interval: 0x00000000 (0 seconds)
< ACL data: handle 12 flags 0x00 dlen 19
    L2CAP(d): cid 0x3609 len 15 [psm 23]
      AVCTP Control: Response : pt 0x00 transaction 8 pid 0x110e
        AV/C: Interim: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: RegisterNotification: pt Single len 0x0002
            EventID: 0x0d (EVENT_VOLUME_CHANGED)
            Volume: 100.00% (127/127)

When you change the volume on iPhone side it does send a
SetAbsoluteVolume like this:

> ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(d): cid 0x0044 len 14 [psm 23]
      AVCTP Control: Command : pt 0x00 transaction 14 pid 0x110e
        AV/C: Control: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: SetAbsoluteVolume: pt Single len 0x0001
            Volume: 92.91% (118/127)
< ACL data: handle 12 flags 0x00 dlen 18
    L2CAP(d): cid 0x3c09 len 14 [psm 23]
      AVCTP Control: Response : pt 0x00 transaction 14 pid 0x110e
        AV/C: Accepted: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: SetAbsoluteVolume: pt Single len 0x0001
            Volume: 92.91% (118/127)
