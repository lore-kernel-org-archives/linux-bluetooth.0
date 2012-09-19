Return-Path: <cyrus@holtmann.org>
Message-ID: <505A015C.5060002@ridgerun.com>
Date: Wed, 19 Sep 2012 11:31:08 -0600
From: Pablo Barrantes <pablo.barrantes@ridgerun.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: A2DP optional codecs support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

     I have successfully started audio streaming using A2DP profile from 
an Android and iOS device to an embedded system under development. The 
embedded system is using bluez, pulseaudio, ALSA and a bluetooth USB 
dongle to capture the stream. By default the system is choosing SBC 
encodification, but now I would like to use MPEG (AAC and MP3), this is 
where it got complicated since I've been looking all around for 
documentation or usage cases of A2DP with MPEG codecs with no success.

     So here are a some questions I have, hope you can help me with them:

     1. First, I'd like to have a better understanding of how will bluez 
behave under this circumstances. Assuming that the source (Android or 
iOS) is streaming MPEG data, is bluez capable of processing the packages 
and then interact with another application (a pulse module maybe?) to 
decode and play the data?

     2. Related to the previous, my current audio.conf file has this 
couple lines that are supposed to enable MPEG:

[A2DP]
SBCSources=0
MPEG12Sources=1

is that correct? Also, is there a way to "force" bluez to choose MPEG 
over SBC?

     3. How can I know which codec was selected on the negotiation process?

This one isn't directly related to bluez, but is still valid and maybe 
somebody on this mailing list can answer it:

     4. As mentioned before, I'm using an Android smartphone to stream 
data to my embedded system and Android uses bluez to support bluetooth. 
Is is possible to stream using MPEG encoded data with such devices?


     FYI the kernel/packages version on my system are:

bluez-4.98 (had problems cross-compiling 4.101)
alsa-lib-1.0.25
pulseaudio-2.1
linux-kernel-2.6.32 (pretty old, but it's the one supported ATM)


     Thanks in advance,


--Pablo
