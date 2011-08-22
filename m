Return-Path: <cyrus@holtmann.org>
Message-ID: <4E528879.5080103@invoxia.com>
Date: Mon, 22 Aug 2011 18:48:57 +0200
From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: HFP gateway and new incoming connection
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all.

I'm currently playing with the HFP unit role provided by bluez (ie. what 
is related to audio/gateway.c)
No problem concerning the connection to a HFP gateway (ie. GSM most of 
the time).

I have more concern with the reverse side, to accept incoming HFP 
connection, as, obviously I didn't get time to register a "Handsfree 
agent" for the particular new connecting device, at the proper time.

Today, I'm using bluez v4.95, but no real difference with the upstream 
for this case.
Also, I didn't plan to use oFono.... even if it is great piece of software.

I also saw a discussions concerning the initial design in the mailling 
list : http://marc.info/?l=linux-bluetooth&m=126390401614859&w=2

_My questions:_
1) does this design is today "set in stone" ?

2) It seems the only ways to register an agent at the proper time are:
- to trace creation of new devices, and try to register an agent at this 
time.
   But what if the device doesn't show HFP SDP record when connection 
for the first time, and activate it later ?
   Any race conditions ?
or
- collect the authorization request in the adapter user agent, when 
"audio_device_request_authorization" is called.
So it means that the user agent must forward request concerning the HFP 
uuid to the HFP service.

True ?

3) What do you think of the possibility to set a "adapter based" 
Handsfree agent, and use it when there is no "device based" handsfee 
argent matching ?
(the same way "device_request_authentication" (src/device.c) is looking 
for an agent registered to the device first, then, for an agent 
registered to the adapter)

Regards,
Arnaud Mouiche
