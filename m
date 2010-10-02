Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTikuh82wX5ZhwihKC+WBwdJD78SSDq13Ks=qZCc6@mail.gmail.com>
References: <AANLkTingVh3OaAGQzsxWJQddqrPwgFssMeOq5Rp_DbS6@mail.gmail.com>
	<201009291337.40197.sander@outrightsolutions.nl>
	<AANLkTi=voJHxhTa4VXNnhUBm2v8ouX6cQNWgToip=wVi@mail.gmail.com>
	<201009291708.01026.sander@outrightsolutions.nl>
	<AANLkTi=bx1Bv1GD9SuMGbYcE-NNK5e0x5N3Oz-FkH-Zm@mail.gmail.com>
	<AANLkTikuh82wX5ZhwihKC+WBwdJD78SSDq13Ks=qZCc6@mail.gmail.com>
Date: Sat, 2 Oct 2010 08:21:09 -0600
Message-ID: <AANLkTik8mQzfRnOzVn+SPLrHhfhszuSSP_C5Jhrs-D8h@mail.gmail.com>
Subject: Re: a2dp, myth, pulse
From: Brad Midgley <bmidgley@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

sorry guys, you can crash mythtv if you don't drain the socket...

    #***
  #*********************************************************************
#*************************************************************************
#***
#*** GizmoDaemon Config Script
#*** 	AVRCP controls for MythTV
#***
#*****************************************
  #*****************************************
    #***

from GizmoDaemon import *
from GizmoScriptEnableChecker import *
import sys
import telnetlib
import time

ENABLED = True
VERSION_NEEDED = 3.2

class AVRCPMythTV(GizmoScriptEnableChecker):
	"""
	CatchAll Event Mapping for Testing
	"""

	def msend(self, msg):
		telnet = telnetlib.Telnet("localhost", 6546)
		telnet.read_until("# ")
		time.sleep(0.1)
		telnet.write(msg + "\n")
		time.sleep(0.1)
		telnet.read_eager()
		telnet.write("quit\n")
		time.sleep(0.1)
		telnet.read_all()
		telnet.close

	def onEvent(self, Event, Gizmo = None):
		"""
		See GizmodDispatcher.onEvent documention for an explanation of this function
		"""

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
		"""
		Default Constructor
		"""

		GizmoScriptEnableChecker.__init__(self, ENABLED, VERSION_NEEDED)

AVRCPMythTV()
