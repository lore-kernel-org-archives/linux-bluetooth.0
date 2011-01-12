Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 12 Jan 2011 02:02:01 -0500
Message-ID: <AANLkTinFt0Rsbk6LoTk8YnYeqGqzxwTwrWgRakCaQoWo@mail.gmail.com>
Subject: Any flag indicating bt/fm is ready to run "hcitool cmd"
From: zhangfei gao <zhangfei.gao@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Is there any flag indicating bt/fm is ready to run "hcitool cmd", ie,
"hciconfig hci0 up" is really finished.

We met error "Send failed: File descriptor in bad state", if run
hcitool immediately after "hciconfig hci0 up"
For example:
hciconfig hci0 up
hcitool cmd 3f 66 02 26 00 00 00 30

And it could be workaround adding sleep.
The reason is "hciconfig hci0 up" is asynchronous, when it return,
bt/fm is not ready in fact, so add sleep could solve the issue, but
still may fail in stress test since race condition.
We have test bit HCI_UP, but hcitool cmd still would failed, when
HCI_UP=1, which is set in hci_dev_open instead of handler.
How about HCI_RAW?

The question is any bit user place could check and then safe to send
any command via hcitool cmd.

Thanks in advance.
