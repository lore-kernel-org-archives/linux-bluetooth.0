Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Jon Maber <jon@cilnu.com>
Subject: org.bluez.ProfileManager1 RegisterProfile
Message-ID: <c0bb4290-68e7-4bbf-26dc-e1ae65f28c99@cilnu.com>
Date: Sat, 6 Jan 2018 16:15:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I hope this isn't off topic.  Please ignore if so.

In brief my problem relates to the fact that only one PSM can be passed 
to RegisterProfile in the interface org.bluez.ProfileManager1.  I want 
to use a Raspberry Pi to emulate a bluetooth HID keyboard and need 
therefore to use the two standard PSMs 17 and 19. My cludgy solution is 
to create two objects which implement org.bluez.Profile1 and register 
one with the HID UUID and PSM=19 and the other with a random UUID and 
PSM=17.

Could I achieve this in a cleaner way?

If not, would it be possible for a future version of the daemon to look 
for PSMs in the service record passed to RegisterProfile. These are 
found in the ProtocolDescriptorList and 
AdditionalProtocolDescriptorLists attributes.  [if anyone is interested 
I've pasted my annotated service record below.]

Regards,

Jon Maber


P.S. My intention is to produce a new version of Gavin Thomas' tutorial 
from five years back [ see below ] which will work with the version of 
bluez that currently comes with Raspbian, i.e. 5.43.

https://www.gadgetdaily.xyz/emulate-a-bluetooth-keyboard-with-the-raspberry-pi/



keybrec = ("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>"
     "<record>"
     " <attribute id=\"0x0001\">"        # ServiceClassIDList
     "  <sequence>"
     "   <uuid value=\"0x1124\" />"      # HID Service
     "  </sequence>"
     " </attribute>"
     " <attribute id=\"0x0004\">"        # ProtocolDescriptorList
     "  <sequence>"
     "   <sequence>"
     "    <uuid value=\"0x0100\" />"     # L2CAP
     "    <uint16 value=\"0x0011\" />"   # PSM 17    Reserved for 
HID_Control
     "   </sequence>"
     "   <sequence>"
     "    <uuid value=\"0x0011\" />"     # HIDP
     "   </sequence>"
     "  </sequence>"
     " </attribute>"
     " <attribute id=\"0x0005\">"        # BrowseGroupList
     "  <sequence>"
     "   <uuid value=\"0x1002\" />"      # PublicBrowseRoot
     "  </sequence>"
     " </attribute>"
     " <attribute id=\"0x0006\">"        # language info for human 
readable attributes
     "  <sequence>"
     "   <uint16 value=\"0x656e\" />"    # 'en', i.e. English
     "   <uint16 value=\"0x006a\" />"    # utf-8  see 
http://www.isi.edu/in-notes/iana/assignments/character-sets
     "   <uint16 value=\"0x0100\" />"    # Offset for language dependant 
name attributes
     "  </sequence>"
     " </attribute>"
     " <attribute id=\"0x0009\">"        # BluetoothProfileDescriptorList
     "  <sequence>"
     "   <sequence>"
     "    <uuid value=\"0x1124\" />"     # HID Service
     "    <uint16 value=\"0x0100\" />"   # v1.0.0
     "   </sequence>"
     "  </sequence>"
     " </attribute>"
     " <attribute id=\"0x000d\">"        # AdditionalProtocolDescriptorLists
     "  <sequence>"
     "   <sequence>"
     "    <sequence>"
     "     <uuid value=\"0x0100\" />"    # L2CAP
     "     <uint16 value=\"0x0013\" />"  # PSM 19    Reserved for 
HID_Interrupt
     "    </sequence>"
     "    <sequence>"
     "     <uuid value=\"0x0011\" />"    # HIDP
     "    </sequence>"
     "   </sequence>"
     "  </sequence>"
     " </attribute>"
     " <attribute id=\"0x0100\">"     #ServiceName
     "  <text value=\"Raspberry Pi Virtual Keyboard\" />"
     " </attribute>"
     " <attribute id=\"0x0101\">"     #ServiceDescription
     "  <text value=\"USB > BT Keyboard\" />"
     " </attribute>"
     " <attribute id=\"0x0102\">"     #ProviderName
     "  <text value=\"Raspberry Pi\" />"
     " </attribute>"

                  # See bluetooth_hid_spec_v1-1.pdf
                  # http://manualzz.com/doc/25055101/bluetooth-hid-profile

     " <attribute id=\"0x0200\">"     # HIDDeviceReleaseNumber
     "  <uint16 value=\"0x0100\" />"  # ver. 1.0.0  but this seems to be 
a redundant attribute
     " </attribute>"
     " <attribute id=\"0x0201\">"     # HIDParserVersion
     "  <uint16 value=\"0x0111\" />"  # ver 1.1.1 of HID specification used
     " </attribute>"
     " <attribute id=\"0x0202\">"     # HIDDeviceSubclass
     "  <uint8 value=\"0x40\" />"
     " </attribute>"
     " <attribute id=\"0x0203\">"     # HIDCountryCode
     "  <uint8 value=\"0x00\" />"     # Not localised
     " </attribute>"
     " <attribute id=\"0x0204\">"     # HIDVirtualCable
     "  <boolean value=\"true\" />"   # expects to automatically reconnect
     " </attribute>"
     " <attribute id=\"0x0205\">"     # HIDReconnectInitiate
     "  <boolean value=\"true\" />"   # Who reconnects? This keyboard.  
[But may delay until it has data to send.]
     " </attribute>"
     " <attribute id=\"0x0206\">"     # HIDDescriptorList
     "  <sequence>"
     "   <sequence>"                  # One and only descriptor
     "    <uint8 value=\"0x22\" />"   # A report as per USB spec.
     "    <text encoding=\"hex\" 
value=\"05010906a101850175019508050719e029e715002501810295017508810395057501050819012905910295017503910395067508150026ff000507190029ff8100c0050c0901a1018503150025017501950b0a23020a21020ab10109b809b609cd09b509e209ea09e9093081029501750d8103c0\" 
/>"
     "   </sequence>"
     "  </sequence>"
     " </attribute>"
     " <attribute id=\"0x0207\">"     # HIDLANGIDBaseList this is a 
required attribute even though irrelevant
     "  <sequence>"                   # localisation of human readable 
attributes
     "   <sequence>"
     "    <uint16 value=\"0x0409\" />"  # lang and encoding as per USB
     "    <uint16 value=\"0x0100\" />"  # attribute id offset
     "   </sequence>"
     "  </sequence>"
     " </attribute>"
     " <attribute id=\"0x020b\">"     # HIDProfileVersion
     "  <uint16 value=\"0x0100\" />"
     " </attribute>"
     " <attribute id=\"0x020c\">"     # HIDSupervisionTimeout Not 
required, must not clash with other SDP records
     "  <uint16 value=\"0x0c80\" />"  # unit = slots
     " </attribute>"
     " <attribute id=\"0x020d\">"     # HIDNormallyConnectable   will 
device remain connectable when not connected?
     "  <boolean value=\"false\" />"  # Should be true for use with 
computers
     " </attribute>"
     " <attribute id=\"0x020e\">"     # HIDBootDevice
     "  <boolean value=\"true\" />"   # 'true' also implies that we 
support Set_Protocol and Get_Protocol commands
     " </attribute>"
     " <attribute id=\"0x020f\">"     # ​HIDSSRHostMaxLatency
     "  <uint16 value=\"0x0640\" />"
     " </attribute>"
     " <attribute id=\"0x0210\">"     #​ HIDSSRHostMinTimeout
     "  <uint16 value=\"0x0320\" />"
     " </attribute>"
     "</record>")

