Return-Path: <cyrus@holtmann.org>
Message-ID: <639511.66794.qm@web94914.mail.in2.yahoo.com>
Date: Wed, 26 Aug 2009 17:06:24 +0530 (IST)
From: Pavan Savoy <pavan_savoy@yahoo.co.in>
Subject: shared hci transport
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A lot of recent BT chips intefaced by UART also tend to have another radio [mostly FM] on the same chip sharing the transport interface i.e the UART. [bcm4325 for example has bt, fm and wlan].

I just wanted to know, from the user-space the hci0 socket interface allows me to concurrently use the uart from several applications, but
is there a way in kernel to do the same ?

[say hci_h4 is also used by the fm core to understand some vendor specific commands ?]
or in an usb case - the fm has int endpoint for control data of fm [+ hci-event/cmd packets] and bulk for rds[+ acl] [assuming the audio data path - is isolated from all these ...]

regards,
Pavan



      See the Web&#39;s breaking stories, chosen by people like you. Check out Yahoo! Buzz. http://in.buzz.yahoo.com/

