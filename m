Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 May 2009 22:27:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Thomas Gillespie <tjg35@cam.ac.uk>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: A2DP headset
Message-ID: <20090501192734.GA2966@jh-x301>
References: <1241201091.12079.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1241201091.12079.4.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thomas,

On Fri, May 01, 2009, Thomas Gillespie wrote:
> I'm trying to connect my A2DP headset to my computer. It works fine in
> HSP/HFP mode, but when i try to connect to the audio sink via dbus it
> won't connect. I get 
> "bluetoothd[1618]: No matching ACP and INT SEPs found"
> in my /var/log/messages file. What does this mean? 

A2DP has a concept of Stream End Points (SEPs). To create an audio stream
you need to hook up an Audio Source SEP on one device (in your case your
computer) to an Audio Sink SEP on another device (your headset). That
message you got means that bluetoothd didn't find an Audio Sink SEP in the
headset that would match in it's properties (codec, etc) an available
Audio Source SEP on your computer.

Why this all is happening is another matter though. Have you done any
special changes to /etc/bluetooth/audio.conf? Could you enable bluetoothd
debug messages (-d switch) and give us the complete log when trying to
connect A2DP to the headset. The output of hcidump -XV when connecting
A2DP might also provide some useful information.

Johan
