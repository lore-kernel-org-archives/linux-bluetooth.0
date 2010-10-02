Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=bx1Bv1GD9SuMGbYcE-NNK5e0x5N3Oz-FkH-Zm@mail.gmail.com>
References: <AANLkTingVh3OaAGQzsxWJQddqrPwgFssMeOq5Rp_DbS6@mail.gmail.com>
	<201009291337.40197.sander@outrightsolutions.nl>
	<AANLkTi=voJHxhTa4VXNnhUBm2v8ouX6cQNWgToip=wVi@mail.gmail.com>
	<201009291708.01026.sander@outrightsolutions.nl>
	<AANLkTi=bx1Bv1GD9SuMGbYcE-NNK5e0x5N3Oz-FkH-Zm@mail.gmail.com>
Date: Fri, 1 Oct 2010 18:45:49 -0600
Message-ID: <AANLkTikuh82wX5ZhwihKC+WBwdJD78SSDq13Ks=qZCc6@mail.gmail.com>
Subject: Re: a2dp, myth, pulse
From: Brad Midgley <bmidgley@gmail.com>
To: Sander van Grieken <sander@outrightsolutions.nl>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Guys

> unfortunately there isn't a clear way to merge a udp/hdhomerun remote
> coming in on lircd with avrcp events from inputlircd. I'll take it up
> with the lirc folks and summarize here later.

lirc should be used to inject input events and probably nothing else.
There are three different lirc daemon flavors, each one missing key
features. If you need to merge multiple sources, you have to do a
confusing dance with tcp sockets, master servers, etc. Unfortunately,
the event driver interface is one thing in lirc that apparently
doesn't work at all.

I made it work instead with gizmod talking to the mythtv telnet
control connection, see script.

Gizmod does have a problem with its compile prefix, see
https://bugs.launchpad.net/ubuntu/+source/gizmod/+bug/645058

So, the complete hack under ubuntu 10.04...

* add uinput to /etc/modules
* tell myth to use the pulse device
* add to /etc/pulse/default.pa: load-module module-alsa-sink device=plug:dmix
* click the headset button to connect it
* use pavucontrol to move the myth stream over to the headset
* install the script below in ~/.gizmod/modules.d/001-AVRCP-MythTV.py
* sudo ln -s /etc /usr/etc
* sudo gizmod

-- 
Brad Midgley

from GizmoDaemon import *
from GizmoScriptEnableChecker import *
import sys
import telnetlib

ENABLED = True
VERSION_NEEDED = 3.2

class AVRCPMythTV(GizmoScriptEnableChecker):

	def msend(self, msg):
		telnet = telnetlib.Telnet("localhost", 6546)
		telnet.read_until("# ")
		telnet.write(msg + "\n")
		telnet.close
	
	def onEvent(self, Event, Gizmo = None):
		if Event.Remote:
			return False
		
		if Event.Class != GizmoEventClass.Standard:
			return False

		if Event.Type != GizmoEventType.EV_KEY:
			return False

		if Event.Value != 1:
			return False

		name = str(Event.Code)
		if name == "KEY_NEXTSONG":
			self.msend("key right")
	   		return True
		elif name == "KEY_PLAYCD" or name == "KEY_PAUSECD":
			self.msend("key p")
	   		return True
	   	elif name == "KEY_STOPCD":
			self.msend("key escape")
	   		return True
	   	elif name == "KEY_PREVIOUSSONG":
			self.msend("key left")
	   		return True	

		return False

	def __init__(self):
		GizmoScriptEnableChecker.__init__(self, ENABLED, VERSION_NEEDED)
