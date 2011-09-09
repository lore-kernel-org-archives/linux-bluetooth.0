Return-Path: <cyrus@holtmann.org>
Message-ID: <4E6A247C.5040403@nokia.com>
Date: Fri, 09 Sep 2011 17:36:44 +0300
From: Antti Julku <antti.julku@nokia.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Name resolution for mgmt interface
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hello Bluetooth experts,

Name resolution of older devices not supporting EIR is still missing 
from the management interface. I discussed with Johan, and he suggested 
the following architecture (if I understood correctly):

New command and event are added to mgmt interface:
  * Unknown Names Event
  * Resolve Names Command

When device discovery is completed, kernel sends list of BT addresses of 
devices which names are unknown (no name in EIR data) with Unknown Names 
Event.

User space can then request name resolving with Resolve Names Command, 
which takes list of BT addresses as parameter. User space gets a Remote 
Name Event for each device.

Internally kernel would have a list of found devices, to which devices 
are added during discovery. Device in the list is flagged as unknown 
unless there was name for it in EIR data. After discovery is completed, 
event with list of unknown devices is sent, and the found devices list 
is cleared (it's valid only during one discovery session).

Not sure if name resolution should be included in the discovery session 
done via mgmt interface (while Discovering Event indicates discovery is 
ongoing), and how to track discovery state in that case. Maybe another 
state is needed in hdev->flags (e.g. HCI_DISCOVERY) if HCI_INQUIRY is 
not enough?

Any opinions? I think it would be good to have wider discussion before 
making patches.

Br,
Antti

