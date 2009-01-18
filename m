Return-Path: <cyrus@holtmann.org>
From: "Christian Hoene" <hoene@uni-tuebingen.de>
To: <linux-bluetooth@vger.kernel.org>
Subject: Questions on connecting BlueZ/SBC with Ekiga
Date: Sun, 18 Jan 2009 15:12:41 +0100
Message-ID: <016701c97976$e75578d0$b6006a70$@de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I have a question on how to use A2DP and SBC for streaming of audio over the
Internet.

How would you implement an interface between Ekiga and BlueZ? The
requirements are
1 SBC frames from Ekiga
1.1 Shall be played via an A2DP device.
1.2 Shall be played via the sound card of the PC.
2. SBC frame going to Ekiga
2.1 Recorded from an A2DP device
2.2 recorded by the PC's sound card.

Due to legal reason we must use the BlueZ and are not allowed to include SBC
into Ekiga.
Does somebody has an idea on how and where to implement this?

Thanks

 Christian


--------------------------------------------------------
Dr.-Ing. Christian Hoene
Computer Networks and Internet, University of Tübingen
Sand 13, 72076 Tübingen, Germany, Phone +49 7071 2970532
http://net.informatik.uni-tuebingen.de/~hoene



