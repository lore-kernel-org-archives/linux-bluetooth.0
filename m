Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
References: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 1 Aug 2011 10:25:11 -0300
Message-ID: <CAMOw1v4bHdNNAoc4BARgKt4b8z-g48RkmLcMkiQGihgQt8meMw@mail.gmail.com>
Subject: Re: [PATCH hcidump 00/13] AVRCP 1.3 pdus
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz

On Mon, Aug 1, 2011 at 5:42 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds parsing for remaining pdus defined by AVRCP 1.3 spec, here is
> an example of what it would generate using current upstream agains Sony
> MW600 headset (note that current upstream has a bug in which it sets an
> invalid pdu length for not implemented response):
>
>> AVCTP: Command : pt 0x00 transaction 5 pid 0x110e
>    AV/C: Status: address 0x48 opcode 0x00
>      Subunit: Panel
>      Opcode: Vendor Dependent
>      Company ID: 0x001958
>      AVRCP: GetCapabilities: pt 0x00 len 0x0001
>        CapabilityID: 0x02 (CompanyID)
> < AVCTP: Response : pt 0x00 transaction 5 pid 0x110e
>    AV/C: Not Implemented: address 0x48 opcode 0x00
>      Subunit: Panel
>      Opcode: Vendor Dependent
>      Company ID: 0x001958
>      AVRCP: GetCapabilities: pt 0x00 len 0x0001
>      PDU Malformed
>> AVCTP: Command : pt 0x00 transaction 6 pid 0x110e
>    AV/C: Notify: address 0x48 opcode 0x00
>      Subunit: Panel
>      Opcode: Vendor Dependent
>      Company ID: 0x001958
>      AVRCP: RegisterNotification: pt 0x00 len 0x0005
>        EventID: 0x02 (EVENT_TRACK_CHANGED)
>        Interval: 0x0000000a (10 seconds)
> < AVCTP: Response : pt 0x00 transaction 6 pid 0x110e
>    AV/C: Not Implemented: address 0x48 opcode 0x00
>      Subunit: Panel
>      Opcode: Vendor Dependent
>      Company ID: 0x001958
>      AVRCP: RegisterNotification: pt 0x00 len 0x0005
>      PDU Malformed
>
> Same thing but now using Lucas's tree:
>
> < AVCTP: Response : pt 0x00 transaction 5 pid 0x110e
>    AV/C: Stable: address 0x48 opcode 0x00
>      Subunit: Panel
>      Opcode: Vendor Dependent
>      Company ID: 0x001958
>      AVRCP: GetCapabilities: pt 0x00 len 0x0005
>        CapabilityID: 0x02 (CompanyID)
>        CapabilityCount: 0x01
>        CompanyID: 0x001958
>> AVCTP: Command : pt 0x00 transaction 6 pid 0x110e
>    AV/C: Status: address 0x48 opcode 0x00
>      Subunit: Panel
>      Opcode: Vendor Dependent
>      Company ID: 0x001958
>      AVRCP: GetCapabilities: pt 0x00 len 0x0001
>        CapabilityID: 0x03 (EventsID)
> < AVCTP: Response : pt 0x00 transaction 6 pid 0x110e
>    AV/C: Stable: address 0x48 opcode 0x00
>      Subunit: Panel
>      Opcode: Vendor Dependent
>      Company ID: 0x001958
>      AVRCP: GetCapabilities: pt 0x00 len 0x0004
>        CapabilityID: 0x03 (EventsID)
>        CapabilityCount: 0x02
>        EventsID: 0x01 (EVENT_PLAYBACK_STATUS_CHANGED)
>        EventsID: 0x02 (EVENT_TRACK_CHANGED)
>> AVCTP: Command : pt 0x00 transaction 7 pid 0x110e
>    AV/C: Notify: address 0x48 opcode 0x00
>      Subunit: Panel
>      Opcode: Vendor Dependent
>      Company ID: 0x001958
>      AVRCP: RegisterNotification: pt 0x00 len 0x0005
>        EventID: 0x02 (EVENT_TRACK_CHANGED)
>        Interval: 0x0000000a (10 seconds)
> < AVCTP: Response : pt 0x00 transaction 7 pid 0x110e
>    AV/C: Interim: address 0x48 opcode 0x00
>      Subunit: Panel
>      Opcode: Vendor Dependent
>      Company ID: 0x001958
>      AVRCP: RegisterNotification: pt 0x00 len 0x0009
>        EventID: 0x02 (EVENT_TRACK_CHANGED)
>        Identifier: 0xffffffffffffffff (Reserved)
>> AVCTP: Command : pt 0x00 transaction 8 pid 0x110e
>    AV/C: Status: address 0x48 opcode 0x00
>      Subunit: Panel
>      Opcode: Vendor Dependent
>      Company ID: 0x001958
>      AVRCP: GetElementAttributes: pt 0x00 len 0x000d
>        Identifier: 0x0 (PLAYING)
>        AttributeCount: 0x01
>        Attribute: 0x00000001 (Title)
> < AVCTP: Response : pt 0x00 transaction 8 pid 0x110e
>    AV/C: Stable: address 0x48 opcode 0x00
>      Subunit: Panel
>      Opcode: Vendor Dependent
>      Company ID: 0x001958
>      AVRCP: GetElementAttributes: pt 0x00 len 0x0009
>        AttributeCount: 0x01
>        Attribute: 0x00000001 (Title)
>        CharsetID: 0x006a (UTF-8)
>        AttributeValueLength: 0x0000
>        AttributeValue:
>

Nice, I've been using this with my implementation of AVRCP 1.3 and
it's working fine.

thanks,
Lucas De Marchi
