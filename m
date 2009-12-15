Return-Path: <cyrus@holtmann.org>
From: "Marian Harbach" <harbach@Mathematik.Uni-Marburg.de>
To: <linux-bluetooth@vger.kernel.org>
Subject: gstreamer and sbcdec problem
Date: Tue, 15 Dec 2009 22:58:51 +0100
Message-ID: <002301ca7dd1$cb5fa3c0$621eeb40$@uni-marburg.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have the same problem as described in this post:

http://www.spinics.net/lists/linux-bluetooth/msg03627.html

I found that depending on filesize, the original input is delayed by some
bytes (180-260 for 16kHz PCM input) and additionally the first few samples
are overwritten when doing sbcenc followed by sbcdec.

Is there a fix for this issue? 

Cheers
Marian



