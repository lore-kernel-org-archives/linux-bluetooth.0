Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Seungyoun Ju <sy39.ju@samsung.com>
Date: Wed, 15 Jul 2015 13:59:09 +0900
Message-ID: <CAB512Gt-cdR_QT-Sed2W9Avp1SbtsC7eiKY+KL6gXjZeB+A86g@mail.gmail.com>
Subject: New interface to change LE connection parameters
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello, All.

I plan to provide the kernel interface which is used by user space's
bluez to change LE connection parameters.

This is my first trial to implement new feature so I need help.
Would you please give me a comment ?
Are there any better ways ?

< Why this is required >
When the LE connection is in idle state (e.g. no traffic),
it is better to increase a connection interval for power saving reason.
Or it needs to reduce a connection interval for a fast response time.
And it may need to change a supervision timeout to detect link loss
faster or looser.

It is better to control these kind of things as per application's needs.
So I want to provide the interface to change LE connection parameters.

< Current state >
There is no interface to change LE connection parameters for already
connected link.

And LE connection parameter is only configured by remote device like below ways.
- remote device(slave) requests a change using l2cap connection
parameter request.
- remote device(master) sends HCI_OP_LE_CONN_UPDATE.
- If above configured parameters are loaded during adapter init.,
   those are automatically applied during connection setup.

< How to implement >
When I roughly thought, below ways are possible.

1. Add new MGMT (e.g. MGMT_OP_UPDATE_CONN_PARAM)
   In mgmt handler, based on the role and local / remote LE features,
   do connection parameter update procedure as follows.
   - If remote and local devices both support "HCI_LE_CONN_PARAM_REQ_PROC",
   send HCI_OP_LE_CONN_UPDATE
   - If either the remote or local or both do not support
"HCI_LE_CONN_PARAM_REQ_PROC",
     - if local is master,
     send HCI_OP_LE_CONN_UPDATE.
     - if local is slave,
     send L2CAP_CONN_PARAM_UPDATE_REQ via l2cap signal channel.
   => Main concern of this way is that it is possible to access l2cap from mgmt.

2. Add new MGMT and L2CAP socket option
   - user space's bluez should know own role
   - user space's bluez may know remote / local le features.
     Or, based on the le features, net/core's l2cap may select a procedure.

3. Add new MGMT and send L2CAP command from user space's bluez
   - user space's bluez should know own role
   - user space's bluez may know remote / local le features.
     Or, based on the le features, net/core's l2cap may select a procedure.

Thanks and Regards,
Seungyoun Ju
