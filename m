Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Dec 2008 15:09:33 +0200 (IST)
Message-Id: <200812251309.mBPD9Xqm011800@indigo.cs.bgu.ac.il>
From: "eial@cs.bgu.ac.il" <eial@cs.bgu.ac.il>
To: linux-bluetooth@vger.kernel.org
Subject: can't seem to be able to get bluez working with motorola H500 headset
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


hello, I got a gentoo 64 bit os, with kernel 2.6.27, I'm trying to make my motorola h500 work but after starting the service and the headset, scanning after the headsets wont return findings...

got the following installed bluez programs:
bluez-utils-3.36, bluez-libs-3.36.

here is my relevant .config section
CONFIG_BT=y
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m

#
# Bluetooth device drivers
#
CONFIG_BT_HCIBTUSB=m
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_LL=y
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
# CONFIG_AF_RXRPC is not set

here is lsusb output:
Bus 003 Device 005: ID 0a5c:4500 Broadcom Corp.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 Full speed (or root) hub
  bMaxPacketSize0         8
  idVendor           0x0a5c Broadcom Corp.
  idProduct          0x4500
  bcdDevice            1.00
  iManufacturer           1 Broadcom
  iProduct                2 BCM2046B1
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower               94mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0001  1x 1 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             3
  wHubCharacteristic 0x0004
    Ganged power switching
    Compound device
    Ganged overcurrent protection
  bPwrOn2PwrGood       50 * 2 milli seconds
  bHubContrCurrent    100 milli Ampere
  DeviceRemovable    0x0e
  PortPwrCtrlMask    0xff
 Hub Port Status:
   Port 1: 0000.0103 power enable connect
   Port 2: 0000.0103 power enable connect
   Port 3: 0000.0100 power
Device Status:     0x0001
  Self Powered

here are the config files:
# Configuration file for the audio service

# This section contains options which are not specific to any
# particular interface
[General]

# Switch to master role for incoming connections (defaults to true)
#Master=true

# If we want to disable support for specific services
# Defaults to supporting all implemented services
#Disable=Control,Source

# SCO routing. Either PCM or HCI (in which case audio is routed to/from ALSA)
# Defaults to HCI
#SCORouting=PCM

# Headset interface specific options (i.e. options which affect how the audio
# service interacts with remote headset devices)
[Headset]

# Set to true to support HFP (in addition to HSP only which is the default)
# Defaults to false
HFP=false

# HFP Gateway features
# Defaults to false
3WayCalling=false
EchoCancelNoiseCancel=false
VoiceRecognition=false
InBandRingtone=false
VoiceTags=false
RejectingCalls=false
EnhancedCallStatus=false
EnhancedCallControl=false
ExtendedErrorResultCodes=false

# Just an example of potential config options for the other interfaces
#[A2DP]
#SBCSources=1
#MPEG12Sources=0
#
# HCI daemon configuration file.
#

# HCId options
options {
        # Automatically initialize new devices
        autoinit yes;

        # Security Manager mode
        #   none - Security manager disabled
        #   auto - Use local PIN for incoming connections
        #   user - Always ask user for a PIN
        #
        security auto;

        # Pairing mode
        #   none  - Pairing disabled
        #   multi - Allow pairing with already paired devices
        #   once  - Pair once and deny successive attempts
        pairing multi;

        # Default PIN code for incoming connections
        passkey "0000";
}

# Default settings for HCI devices
device {
        # Local device name
        #   %d - device id
        #   %h - host name
        name "BlueZ (%d)";

        # Local device class
        class 0x000100;

        # Default packet type
        #pkt_type DH1,DM1,HV1;

        # Inquiry and Page scan
        iscan enable; pscan enable;

        # Default link mode
        #   none   - no specific policy
        #   accept - always accept incoming connections
        #   master - become master on incoming connections,
        #            deny role switch on outgoing connections
        lm accept;

        # Default link policy
        #   none    - no specific policy
        #   rswitch - allow role switch
        #   hold    - allow hold mode
        #   sniff   - allow sniff mode
        #   park    - allow park mode
        lp rswitch,hold,sniff,park;
}
# Configuration file for the input service

# This section contains options which are not specific to any
# particular interface
[General]

# Set idle timeout (in minutes) before the connection will
# be disconnect (defaults to 0 for no timeout)
#IdleTimeout=30
# Configuration file for the network service

# This section contains options which are not specific to any
# particular interface
[General]

# If we want to disable support for specific services
# Defaults to supporting all implemented services
#Disable=Connection,Server

# Disable link encryption: default=false
#DisableSecurity=true

[PANU Role]

# Network interface name for PANU for connections. default:bnep%d
# (up to 16 characters)
#Interface=

# PAN user connection interface up script. default:none
Script=avahi-autoipd

[GN Role]

# Network Interface name for Group Network server. default:pan0
#Interface=

# Group Network connection interface up script. default:none
Script=avahi-autoipd

[NAP Role]

# Network Interface name for Network Access Point server. default:pan1
#Interface=

# Network Access Point connection interface up script. default:none
Script=dhclient
#
# RFCOMM configuration file.
#

#rfcomm0 {
#       # Automatically bind the device at startup
#       bind no;
#
#       # Bluetooth address of the device
#       device 11:22:33:44:55:66;
#
#       # RFCOMM channel for the connection
#       channel 1;
#
#       # Description of the connection
#       comment "Example Bluetooth device";
#}

anymore needed data I'll provide, just ask, thanks in advance for the help.


