Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 00/13] AVRCP 1.3 pdus
Date: Mon,  1 Aug 2011 11:42:05 +0300
Message-Id: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds parsing for remaining pdus defined by AVRCP 1.3 spec, here is
an example of what it would generate using current upstream agains Sony
MW600 headset (note that current upstream has a bug in which it sets an
invalid pdu length for not implemented response):

> AVCTP: Command : pt 0x00 transaction 5 pid 0x110e 
    AV/C: Status: address 0x48 opcode 0x00
      Subunit: Panel
      Opcode: Vendor Dependent
      Company ID: 0x001958
      AVRCP: GetCapabilities: pt 0x00 len 0x0001
        CapabilityID: 0x02 (CompanyID)
< AVCTP: Response : pt 0x00 transaction 5 pid 0x110e 
    AV/C: Not Implemented: address 0x48 opcode 0x00
      Subunit: Panel
      Opcode: Vendor Dependent
      Company ID: 0x001958
      AVRCP: GetCapabilities: pt 0x00 len 0x0001
      PDU Malformed
> AVCTP: Command : pt 0x00 transaction 6 pid 0x110e 
    AV/C: Notify: address 0x48 opcode 0x00
      Subunit: Panel
      Opcode: Vendor Dependent
      Company ID: 0x001958
      AVRCP: RegisterNotification: pt 0x00 len 0x0005
        EventID: 0x02 (EVENT_TRACK_CHANGED)
        Interval: 0x0000000a (10 seconds)
< AVCTP: Response : pt 0x00 transaction 6 pid 0x110e 
    AV/C: Not Implemented: address 0x48 opcode 0x00
      Subunit: Panel
      Opcode: Vendor Dependent
      Company ID: 0x001958
      AVRCP: RegisterNotification: pt 0x00 len 0x0005
      PDU Malformed

Same thing but now using Lucas's tree:

< AVCTP: Response : pt 0x00 transaction 5 pid 0x110e 
    AV/C: Stable: address 0x48 opcode 0x00
      Subunit: Panel
      Opcode: Vendor Dependent
      Company ID: 0x001958
      AVRCP: GetCapabilities: pt 0x00 len 0x0005
        CapabilityID: 0x02 (CompanyID)
        CapabilityCount: 0x01
        CompanyID: 0x001958
> AVCTP: Command : pt 0x00 transaction 6 pid 0x110e 
    AV/C: Status: address 0x48 opcode 0x00
      Subunit: Panel
      Opcode: Vendor Dependent
      Company ID: 0x001958
      AVRCP: GetCapabilities: pt 0x00 len 0x0001
        CapabilityID: 0x03 (EventsID)
< AVCTP: Response : pt 0x00 transaction 6 pid 0x110e 
    AV/C: Stable: address 0x48 opcode 0x00
      Subunit: Panel
      Opcode: Vendor Dependent
      Company ID: 0x001958
      AVRCP: GetCapabilities: pt 0x00 len 0x0004
        CapabilityID: 0x03 (EventsID)
        CapabilityCount: 0x02
        EventsID: 0x01 (EVENT_PLAYBACK_STATUS_CHANGED)
        EventsID: 0x02 (EVENT_TRACK_CHANGED)
> AVCTP: Command : pt 0x00 transaction 7 pid 0x110e 
    AV/C: Notify: address 0x48 opcode 0x00
      Subunit: Panel
      Opcode: Vendor Dependent
      Company ID: 0x001958
      AVRCP: RegisterNotification: pt 0x00 len 0x0005
        EventID: 0x02 (EVENT_TRACK_CHANGED)
        Interval: 0x0000000a (10 seconds)
< AVCTP: Response : pt 0x00 transaction 7 pid 0x110e 
    AV/C: Interim: address 0x48 opcode 0x00
      Subunit: Panel
      Opcode: Vendor Dependent
      Company ID: 0x001958
      AVRCP: RegisterNotification: pt 0x00 len 0x0009
        EventID: 0x02 (EVENT_TRACK_CHANGED)
        Identifier: 0xffffffffffffffff (Reserved)
> AVCTP: Command : pt 0x00 transaction 8 pid 0x110e 
    AV/C: Status: address 0x48 opcode 0x00
      Subunit: Panel
      Opcode: Vendor Dependent
      Company ID: 0x001958
      AVRCP: GetElementAttributes: pt 0x00 len 0x000d
        Identifier: 0x0 (PLAYING)
        AttributeCount: 0x01
        Attribute: 0x00000001 (Title)
< AVCTP: Response : pt 0x00 transaction 8 pid 0x110e 
    AV/C: Stable: address 0x48 opcode 0x00
      Subunit: Panel
      Opcode: Vendor Dependent
      Company ID: 0x001958
      AVRCP: GetElementAttributes: pt 0x00 len 0x0009
        AttributeCount: 0x01
        Attribute: 0x00000001 (Title)
        CharsetID: 0x006a (UTF-8)
        AttributeValueLength: 0x0000
        AttributeValue: 

Luiz Augusto von Dentz (13):
  Don't parse response AVRCP pdu if ctype is NOT_IMPLETED
  Add parsing for command type rejected AVRCP responses
  Add parsing for AVRCP ListPlayerApplicationSettingAttributes pdu
  Add parsing for AVRCP ListPlayerApplicationSettingValues pdu
  Add parsing for AVRCP GetCurrentPlayerApplicationSettingValue pdu
  Add parsing for AVRCP SetPlayerApplicationSettingValue pdu
  Add parsing for AVRCP GetPlayerApplicationSettingAttributeText pdu
  Add parsing for AVRCP GetPlayerApplicationSettingValueText pdu
  Add parsing for AVRCP InformDisplayableCharacterSet pdu
  Add parsing for AVRCP InformBatteryStatusOfCT pdu
  Add parsing for AVRCP GetElementAttributes pdu
  Add parsing for AVRCP GetPlayStatus pdu
  Add parsing for AVRCP RegisterNotification pdu

 parser/avrcp.c |  863 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 863 insertions(+), 0 deletions(-)

-- 
1.7.6

