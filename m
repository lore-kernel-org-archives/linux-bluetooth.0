Return-Path: <cyrus@holtmann.org>
From: "Wu, JiangboX" <jiangbox.wu@intel.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: Obexed support mutli-user issue
Date: Wed, 19 Nov 2014 13:24:02 +0000
Message-ID: <ACB402E679F3454EAE433BF5E93F4EAA01663F65@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,
	As I know the bluetoothd is running on root privilege level, obexd is runn=
ing on app privilege level. The obexd is running on app privilege level to =
support user can only transfer the user's own file. Maybe it has other reas=
ons.
	And if the OS has many users can run at the same time. For example. User A=
 named 'blob', User B named 'Alice', and the root. The three user run on OS=
 at the time. As mentioned before, can I say that 'blob' and 'Alice' will h=
ave its owner obexd daemon? That I mean multi-user. And does it be able to =
use independent?
	For example, 'blob' use BlueZ to pair device A, and 'Alice' use BlueZ to p=
air device B. Dose 'blob' can send/receive file from device A? and 'Alice' =
can send/receive file form device B? I test the usage case, and the result =
is that, 'blob' and 'Alice' can send file to device A and Device B simultan=
eously. But it's have difference behavior in turn. Only one obexd can recei=
ve the OPP request, another will never get the OPP request.
	Do you have any idea to support multi-user case by running different obexd=
 daemon in the different users? If obexd don't support multi-user, can you =
give me some sugguestions? Thanks. :)

Best regards
Jiangbo
