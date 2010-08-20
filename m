Return-Path: <cyrus@holtmann.org>
From: "Cayetanot, Sebastien" <sebastien.cayetanot@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 20 Aug 2010 23:15:44 +0100
Subject: HCIConfig - BD Address not updated automatically
Message-ID: <79C392C3A040A44895195AED5DB296F7AC3F2A46@irsmsx502.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All,

I'm currently facing an issue regarding the command hciconfig.

On my device :

I have run hciconfig hci0 in order to check if the hci interface is up and to get the BD_Addr.

I sent an hcitool cmd to change the BD_Addr. The command is accepted.

Just after I run the Ifconfig command but the BD_Addr is not changed it still the old one.

If I use a linux laptop to scan BT device, the device is seen with changed BD_Addr.

I have sent the hci command manually to read th BD_Addr on my device and the BD_Addr return is the one modified.

Just after by running Ifconfig, the BD_Addr is updated.

Is it normal that hciconfig never read the BD_Addr automatically ? even if I do a HIC reset.

My feeling is that the BD_Addr is read one time at the beginning and never updated until we manually read the BD_Addr using the hci command.

Any idea? 

Regards
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

