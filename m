Return-Path: <cyrus@holtmann.org>
From: "Zheng, Wu" <wu.zheng@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
	"Hedberg, Johan" <johan.hedberg@intel.com>
Subject: obexd questions
Date: Wed, 10 Apr 2013 04:15:01 +0000
Message-ID: <2CF57A644018A745B8FE029C7223E16E1089AB8A@SHSMSX102.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I meet some questions to use bluez's OPP profiles. Please help.

1. When opp client sends files and opp server receives files, opp client and opp server uses the same transfer dbus name "org.bluez.obex.Transfer1" .

How can application know the transfer is sending file or receiving file?

Can the different transfer dbus names be used for opp client and opp server?

2. I check the function of "create_session" in obexd/client/Manager.c in Bluez.

When session creates successfully, "create_session" returns NULL.

I can't get session info (such as session path and so on) after "create_session".

Is it right? Thanks.

Best Regards
Zheng Wu


