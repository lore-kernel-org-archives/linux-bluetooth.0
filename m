Return-Path: <cyrus@holtmann.org>
From: Simon Fels <simon.fels@canonical.com>
To: linux-bluetooth@vger.kernel.org
Subject: Closing HCI_CHANNEL_USER socket doesn't close HCI device
Date: Fri, 28 Aug 2015 12:54:29 +0200
Message-Id: <1440759270-23099-1-git-send-email-simon.fels@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey all,

I just had a discussion with Johan Hedberg on IRC about problems I am experiencing with
the hci-tester tool.

Basically what I do is:

$ sudo stop bluetooth
$ sudo hciconfig hci0 down

Verifying hci0 device is down

$ sudo hciconfig -a

Now running the hci-tester and getting

$ sudo ./hci-tester

Reset - init
Reset - setup
Reset - setup complete
Reset - run
Reset - test passed
Reset - teardown
Reset - teardown complete
Reset - done

Read Local Version Information - init
Failed to setup upper tester user channel
Read Local Version Information - pre setup failed
Read Local Version Information - done

Read Local Supported Commands - init
Failed to setup upper tester user channel
Read Local Supported Commands - pre setup failed
Read Local Supported Commands - done

Read Local Supported Features - init
Failed to setup upper tester user channel
Read Local Supported Features - pre setup failed
Read Local Supported Features - done

Read Local Extended Features - init
Failed to setup upper tester user channel
Read Local Extended Features - pre setup failed
Read Local Extended Features - done

Read Buffer Size - init
Failed to setup upper tester user channel
Read Buffer Size - pre setup failed
Read Buffer Size - done

[...]

I stripped all the last lines of the output. More detailed is at
http://paste.ubuntu.com/12213127/. The problem here seems to be
that after running the first test the HCI device stays up even
when the HCI_CHANNEL_USER socket gets closed.

Johan pointed out that the problem seems to be that the
HCI_CHANNEL_USER flag doesn't get cleared before calling hci_dev_close
which actively checks for this one being set and if it is it fails
right away to bring down the device.

I am proposing the attached patch here with keeping in mind that
this might still introduce problems somewhere else but wanted to
put this out for discussion.

regards,
Simon

