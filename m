Return-Path: <cyrus@holtmann.org>
From: "Zheng, Wu" <wu.zheng@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 21 Nov 2011 16:43:54 +0800
Subject: Problems for obex-0.42 (obex-client)
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4736EBDA617@shsmsx501.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi:

We use the test script of obexd-0.42/test/ftp-client for testing ftp.
Obex-0.41 is ok for the test. 
However, for obex-0.42, We find the following issue:

obex-client[4144]: obex-client daemon 0.42
obex-client[4144]: client/main.c:main() Entering main loop
obex-client[4144]: client/session.c:session_ref() 0x9d80af8: ref=2
obex-client[4144]: client/session.c:manager_reply() adapter path /org/bluez/345/hci0
obex-client[4144]: manager replied with an error: org.bluez.Error.AgentNotAvailable, Agent Not Available
obex-client[4144]: client/session.c:session_unref() 0x9d80af8: ref=1
obex-client[4144]: client/session.c:owner_disconnected()
obex-client[4144]: client/session.c:session_shutdown() 0x9d80af8

After checking the code of obexd-0.42 and obexd-0.41, we find that obexd-0.42 need to send dbus a message call to bluez for invoking RequestSession() 

In the function of RequestSession() in the file of adapter.c, 
	if (!adapter->agent)
		return btd_error_agent_not_available(msg);

The root cause is that obex-client did not register a agent for bluez, therefore, the error is " manager replied with an error: org.bluez.Error.AgentNotAvailable, Agent Not Available ".

For the cases, I think that obex-client need to register a agent for bluez? Or the other idea?
Someone has comments for it?

Best regards
Zheng wu
