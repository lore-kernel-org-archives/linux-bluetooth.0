Return-Path: <cyrus@holtmann.org>
Subject: Re: Tools for AVDTP / AVCTP qualification
From: Marcel Holtmann <marcel@holtmann.org>
To: Nick Pelly <npelly@google.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <35c90d960812221613u51133e39x7b18f078c0149d56@mail.gmail.com>
References: <35c90d960812221613u51133e39x7b18f078c0149d56@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 23 Dec 2008 01:50:34 +0100
Message-Id: <1229993434.8047.18.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

> Do there exist any tools to help pass Bluez AVDTP and AVCTP stack qualification?
> 
> Looking at the test spec it seems some command line tools might be
> handy. I am thinking along the lines of l2test, hcitool etc. I'll be
> writing some similar for AVDTP and AVCTP unless there are already some
> floating around?

we only have avinfo at the moment since the whole AVDTP and AVCTP is
highly integrated into our audio plugin. At some point we were thinking
of doing a AVDTP kernel layer, but never got to it and also it was not
really needed. Putting AVCTP in the kernel would make no sense anyway.

So instead of implementing the whole protocol again to just pass the
qualification tests would be totally stupid. And to be honest the
testing should be just working fine with establishing or accepting
proper A2DP connection.

For the A2DP tests of the PTS suite, I just used GStreamer's gst-launch
with a proper pipeline.

Regards

Marcel


