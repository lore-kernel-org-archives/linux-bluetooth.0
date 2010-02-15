Return-Path: <cyrus@holtmann.org>
Date: Mon, 15 Feb 2010 17:40:16 +0100
From: pavol@klacansky.com
To: linux-bluetooth@vger.kernel.org
Subject: thinkpad laser bluetooth mouse
Message-Id: <20100215174016.9dd3beff.pavol@klacansky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hallo, I can connect my mouse by command 'hidd --search' (mouse is in pairing mode), but autoconnect not works

/etc/conf.d/bluetooth file
# Bluetooth configuraton file

# Bluetooth services (allowed values are "true" and "false")

# Run the bluetoothd daemon (default: true)
#DAEMON_ENABLE="false"

# Run hid2hci (default: false)
HID2HCI_ENABLE="true"

# Run the sdp daemon (default: false)
# If this is disabled, hcid's internal sdp daemon will be used
#SDPD_ENABLE="true"

# Run the bluetooth HID daemon (default: false)
HIDD_ENABLE="true"

# Activate rfcomm ports (default: false)
#RFCOMM_ENABLE="true"

# Run bluetooth dial-up networking daemon (default: false)
#DUND_ENABLE="true"

# Run bluetooth PAN daemon (default: false)
#PAND_ENABLE="true"

# rfcomm configuration file (default: /etc/bluetooth/rfcomm.conf)
#RFCOMM_CONFIG="/etc/bluetooth/rfcomm.conf"

# Options for hidd, dund and pand (default: none)
#HIDD_OPTIONS="--server --connect"
#DUND_OPTIONS=""
#PAND_OPTIONS=""


-- 
 <pavol@klacansky.com>
