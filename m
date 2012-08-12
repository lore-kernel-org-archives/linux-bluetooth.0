Return-Path: <cyrus@holtmann.org>
Message-ID: <5027DC19.8020505@ntlworld.com>
Date: Sun, 12 Aug 2012 17:38:49 +0100
From: "alistair.rodger" <alistair.rodger@ntlworld.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: gstreamer a2dpSource plugin
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I am looking for some help getting audio out of the bluez stack using 
gstreamer? Are we still using an alsa source or should we be using the 
MediaTransport file descriptor.

I am able to generate a sink file descriptor, using the simple-endpoint 
script, but don't know which gstreamer plugin to use.

I am able stream to a device using the a2dpsink.

Sincerely,
alistair

