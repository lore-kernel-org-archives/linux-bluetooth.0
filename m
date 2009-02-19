Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 19 Feb 2009 10:23:41 +0800
Message-ID: <a1c657a80902181823o17b423b1qe40f74cd1d603c5@mail.gmail.com>
Subject: About "pause" and "resume" function of bluetooth-alsaplugin
From: salyer <salyer.hy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
     My mediaplayer application is Helix , it will  backup the audio
data if audiocard do not support hardware pause and resume .
For improving the performance , how to implement those function in the
bluetooth-alsaplugin ( in the snd_pcm_ioplug_callback struct).
Do those functions need be supported by Bluetooth headset  ? thanks !


Best Regards!
Paul
