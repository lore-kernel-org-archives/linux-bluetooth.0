Return-Path: <cyrus@holtmann.org>
From: Sander van Grieken <sander@outrightsolutions.nl>
To: linux-bluetooth@vger.kernel.org
Subject: AVRCP future
Date: Wed, 1 Sep 2010 16:03:02 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201009011603.02153.sander@outrightsolutions.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

I've been looking into AVRCP a bit lately, since I'm interested in the 'Remote Control 
from Separate Controller' usecase as described in the AVRCP spec, section 2.3.1.1.

However, from the BlueZ source, it seems an AVRCP connection is only set up/allowed when 
there is a AVD sink present, which is in violation of the bluetooth spec, section 2.3.2

Also, the recent progress made by João Paulo Rechi Vita bind the control and audio stream 
closely together (basically disabling the control once audio is not pulseaudio-routed to 
the bluetooth peer).

Now, my questions:

- Is anyone working on AVRCP, besides jprvita?
- Aside from the proposed D-Bus API in doc/control-api.txt, has anyone done some research 
how an AVRCP1.4 interface should look?
- Are there objections to conforming to section 2.3.2, i.e. untying the AVRCP connection 
from the A2DP connection?

I'm willing to put some effort in improving AVRCP, but before I go off blindly coding such 
stuff, please give as much feedback as possible :)

grtz,
Sander
