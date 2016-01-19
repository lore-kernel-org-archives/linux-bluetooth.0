Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Manuel Reimer <manuel.reimer@mailbox.org>
Subject: PS3 controller (SIXAXIS) never gets into "IdleTimeout"
Message-ID: <569E872A.2010302@mailbox.org>
Date: Tue, 19 Jan 2016 19:57:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I want to use my PS3 controller on my Linux system. This, so far, seems 
to work pretty well, but if I forget to turn off the controller when 
leaving my PC, then the battery keeps discharging until it is finally empty.

There is a setting "IdleTimeout" in "input.conf", but at least for me 
this doesn't work for the PS3 controller.

I think the reason is, that the controller keeps sending information 
even if it is placed on my desk and noone is touching it. If I run 
"evtest" on the event device, created for the controller, then I get 
something like this (only short snippet):

Event: time 1453228629.616457, -------------- SYN_REPORT ------------
Event: time 1453228629.651514, type 3 (EV_ABS), code 1 (ABS_Y), value 124
Event: time 1453228629.651514, type 3 (EV_ABS), code 61 (ABS_MT_TOOL_Y), 
value 491
Event: time 1453228629.651514, -------------- SYN_REPORT ------------
Event: time 1453228629.683436, type 3 (EV_ABS), code 1 (ABS_Y), value 123
Event: time 1453228629.683436, type 3 (EV_ABS), code 2 (ABS_Z), value 132
Event: time 1453228629.683436, type 3 (EV_ABS), code 61 (ABS_MT_TOOL_Y), 
value 490
Event: time 1453228629.683436, -------------- SYN_REPORT ------------

Seems like the controller keeps sending axis information even if the 
axis aren't touched at all.

Is there any chance to add some handling into bluez to get the 
controller disabled, even if it keeps sending information in "idle state"?

Thank you very much in advance.

Best regards,

Manuel
