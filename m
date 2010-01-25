Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 25 Jan 2010 16:14:58 -0200
Message-ID: <f9d4bd31001251014w1caaa753v39254c3031f5db0e@mail.gmail.com>
Subject: bluetoothd bug
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Johan Hedberg <johan.hedberg@nokia.com>, luiz.dentz-von@nokia.com
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan/Luiz,

I found an error "invalid read". The pastebin log shows a PBAP
connection in the RFCOMM channel 15. See line 195 of the first log,
when the connection is refused the "temporary" device is being
removed, however it seems that the "reverse" SDP query still active.
PTS is establishing RFCOMM connection before "Encrypt Change" event,
but this wrong procedure should not "harm" bluetoothd. In some cases I
noticed segmentation fault, probably due this error.

http://pastebin.com/m308f85ef
http://pastebin.com/m2d80dd71

How to reproduce:
PTS v 3.3.1.4
Simple pairing enabled
Test Case: TC_PSE_SSM_BV_08_I (phonebook)

Regards,
Claudio.

-- 
--
Claudio Takahasi
Instituto Nokia de Tecnologia
Recife - Pernambuco - Brasil
+55 81 30879999
