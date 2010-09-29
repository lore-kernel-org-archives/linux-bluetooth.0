Return-Path: <cyrus@holtmann.org>
From: Sander van Grieken <sander@outrightsolutions.nl>
To: linux-bluetooth@vger.kernel.org
Subject: Re: a2dp, myth, pulse
Date: Wed, 29 Sep 2010 13:37:39 +0200
References: <AANLkTingVh3OaAGQzsxWJQddqrPwgFssMeOq5Rp_DbS6@mail.gmail.com> <AANLkTim27JkfgsumEwd3jK+n1DzYvTYWJGCLGreuw7y3@mail.gmail.com>
In-Reply-To: <AANLkTim27JkfgsumEwd3jK+n1DzYvTYWJGCLGreuw7y3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201009291337.40197.sander@outrightsolutions.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 28 September 2010 09:05:18 Brad Midgley wrote:
> Hey
> 
> > can avrcp be used to drive mythtv? I've got a setup where the myth
> > frontend is rarely the foreground app
> 
> So if avrcp were to present events in a /dev/input/eventX device, I
> could use inputlircd to connect those events to lirc clients. It might
> make it easier if a udev rule created something like /dev/input/avrcp0
> so we could find it more easily for the inputlircd config.
> 
> And I see now that it is by virtue of the use of liblirc that myth can
> get remote events even if it's not the foreground app.
> 
> Control is enabled by default in 4.60, is there anything I can check
> to see why I don't see any log messages about avrcp, no input device
> appear, nothing logged, etc? The main connection is initiated by the
> headset and the audio connection is initiated by the computer. If I
> remember tinkering with this stuff, bluez would need to initiate the
> control connection in this case.

Currently there is support in bluez to act as a AVRCP target, and it will deliver these 
events through the input layer. No new input device will appear, it will go through 
/dev/uinput (which I think you can open for reading then)


The Control connection is ONLY (implicitly) established when an audio connection 
(HS,HF,A2DP) is succesfully started, so you should be able to control myth (through lirc 
perhaps) with a headset that has some controls. If this is done, you should be able to see 
some debug logging w.r.t. RCP. You probably need to run bluetoothd using -d -n.


--
Sander
