Return-Path: <cyrus@holtmann.org>
From: Dave Zielinski <DZielinski@righthandtech.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 25 Jan 2012 11:59:08 -0600
Subject: RE: AVRCP Use Question
Message-ID: <69FA8BA3444DD443841AF768F2F6C65A01611E9B3C9D@SERVER2.righthandtech.local>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,
  I'm trying to set up a system running bluez that will essentially be a "headset" for a device playing audio (cellphone).   So far I've been successful able to get the audio stream aspect (A2DP) of it working and now I'm trying to add some AVRCP 1.0 control (play, pause, fwd, rev).   Looking through some of the git logs, I'm seeing that some of this control was added a long before the version I'm using, which is 4.96, but I'm having a rough time figure out where/what the interface is.  

My best guess at this point is that it can be accessed via the "uinput" driver however the only example that I'm seeing is where evtest is used to listen for events coming from headset for example.  This is actually opposite of what I'm doing.  The device running bluez is the "headset" and I want to sent the commands to the device playing audio.  

Can anyone confirm this AVRCP 1.0 "uinput" interface from 4.96 is "uni-directional" and will not do what I need?

In digging around I see that there was dbus controls added after the 4.96 tag that implements org.bluez.Control.ChangePlayback.  I would just try this but upgrading is not going to be trivial on my system it seems.

Can anyone tell me if I'm on the right track or provide any hints?  

Thank you!
Dave Z.
