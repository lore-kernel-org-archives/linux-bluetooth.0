Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: james pruett <gpscruise@gmail.com>
Date: Tue, 9 Aug 2011 12:14:13 -0500
Message-ID: <CAHymeZq774dz2nsP0Jonb_W4Oqu=O6XXV=hPuxBV0LM0_5Yf7A@mail.gmail.com>
Subject: can BT create N independent channels?
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am writing an Android APP using BT for a control application.

Q: If I am on a BT-headset call already, can I create a second BT-connection?

Eg, will the stack allow two independent BT audio channels?

I want normal calls in one channel, and I create a second signalling
channel for an unrelated purpose. I know there is Serial protocol, but
I want to avoid that if possible (Serial devices are more expensive
than audio devices...) I am going to send the audio into a DTMF
decoder to get ON/OFF control bits only.

Thanks for any leads!
jim pruett
wikiSPEEDia.org
