Return-Path: <cyrus@holtmann.org>
Message-Id: <201205011821.q41ILXXx011867@imr-ma03.mx.aol.com>
Date: Tue, 1 May 2012 14:20:55 -0400
From: Kal Torak <chronognosis@aim.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: main.conf issues
In-Reply-To: <CABBYNZJ2ygZ42r==cDbBFmtzmOFTA-HnDCWk_XM669pHYtfs5Q@mail.gmail.com>
References: <201204271541.q3RFfVd5006035@imr-da04.mx.aol.com>
	<4F9B0108.2000007@tu-ilmenau.de>
	<CABBYNZJ2ygZ42r==cDbBFmtzmOFTA-HnDCWk_XM669pHYtfs5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Hi,
> 
> On Fri, Apr 27, 2012 at 11:26 PM, Steffen Becker
> <steffen.becker@tu-ilmenau.de> wrote:
> > Hello Torak,
> >
> > I'm not very familiar with BlueZ (also just asking questions on
> > this mailing list), but what I can tell is that:
> > You have to setup this file:
> > /var/lib/bluetooth/<local-bdaddr>/config
> > At the moment I can't look up the right syntax for all the
> > configuration, but if i remember right, for enabling discoverable
> > mode you have to enter something like this in the config-file:
> >
> > onmode discoverable
> > mode discoverable
> >
> > For changing the name of your device, you have to edit this line in
> > the config-file:
> >
> > name <your-name>
> 

Thanks for the reply and sorry for the delay...

> Please no top-posting here, those files are not supposed to be
> manually edited, use D-Bus API otherwise you may cause
> inconsistencies.
> 
> You don't have to do that in main.conf, except for class, those values
> are only used when there is nothing already configured, so to change
> this you really should be using D-Bus. You can find under
> tests/test-adapter how to set this permanently in the configuration of
> the adapter.
> 
I do that, via tests/test-adapter, and right now it works, thanks to
both. I was paired both devices, my phone with my pc and I can use
obex-stuff and so. But when I've paired devices, then this appears
at /var/log/messages

May  1 14:10:33 p5s800-vm dbus[411]: [system] Rejected send message, 2
matched rules; type="method_call", sender=":1.37" (uid=100 pid=1037
comm="/usr/bin/pulseaudio --start ") interface="org.bluez.Device"
member="GetProperties" error name="(unset)" requested_reply="0"
destination="org.bluez" (uid=0 pid=603 comm="/usr/sbin/bluetoothd ")
M1 14:10:39 p5s800-vm dbus[411]: [system] Rejected send message, 2
matched rules; type="method_call", sender=":1.37" (uid=100 pid=1037
comm="/usr/bin/pulseaudio --start ") interface="org.bluez.Audio"ay  1
14:10:39 p5s800-vm dbus[411]: [system] Rejected send message, 2 matched
rules; type="method_call", sender=":1.37" (uid=100 pid=1037
comm="/usr/bin/pulseaudio --start ") interface="org.bluez.Audio"
member="GetProperties" error name="(unset)" requested_reply="0"
destination="org.bluez" (uid=0 pid=603 comm="/usr/sbin/bluetoothd ")
May  1 14:10:39 p5s800-vm dbus[411]: [system] Rejected send message, 2
matched rules; type="method_call", sender=":1.37" (uid=100 pid=1037
comm="/usr/bin/pulseaudio --start ") interface="org.bluez.Audio"
member="GetProperties" error name="(unset)" requested_reply="0"
destination="org.bluez" (uid=0 pid=603 comm="/usr/sbin/bluetoothd ")
May  1 14:10:39 p5s800-vm dbus[411]: [system] Rejected send message, 2
matched rules; type="method_call", sender=":1.37" (uid=100 pid=1037
comm="/usr/bin/pulseaudio --start ") interface="org.bluez.Audio"
member="GetProperties" error name="(unset)" requested_reply="0"
destination="org.bluez" (uid=0 pid=603 comm="/usr/sbin/bluetoothd ")
May  1 14:10:39 p5s800-vm dbus[411]: [system] Rejected send message, 2
matched rules; type="method_call", sender=":1.37" (uid=100 pid=1037
comm="/usr/bin/pulseaudio --start ") interface="org.bluez.Audio"
member="GetProperties" error name="(unset)" requested_reply="0"
destination="org.bluez" (uid=0 pid=603 comm="/usr/sbin/bluetoothd ")
May  1 14:10:39 p5s800-vm dbus[411]: [system] Rejected send message, 2
matched rules; type="method_call", sender=":1.37" (uid=100 pid=1037
comm="/usr/bin/pulseaudio --start ") interface="org.bluez.Audio"
member="GetProperties" error name="(unset)" requested_reply="0"
destination="org.bluez" (uid=0 pid=603 comm="/usr/sbin/bluetoothd ")
May  1 14:10:39 p5s800-vm dbus[411]: [system] Rejected send message, 2
matched rules; type="method_call", sender=":1.37" (uid=100 pid=1037
comm="/usr/bin/pulseaudio --start ") interface="org.bluez.AudioSource"
member="GetProperties" error name="(unset)" requested_reply="0"
destination="org.bluez" (uid=0 pid=603 comm="/usr/sbin/bluetoothd ")
May  1 14:10:39 p5s800-vm dbus[411]: [system] Rejected send message, 2
matched rules; type="method_call", sender=":1.37" (uid=100 pid=1037
comm="/usr/bin/pulseaudio --start ") interface="org.bluez.Audio"
member="GetProperties" error name="(unset)" requested_reply="0"
destination="org.bluez" (uid=0 pid=603 comm="/usr/sbin/bluetoothd ")
May  1 14:10:39 p5s800-vm dbus[411]: [system] Rejected send message, 2
matched rules; type="method_call", sender=":1.37" (uid=100 pid=1037
comm="/usr/bin/pulseaudio --start ") interface="org.bluez.Audio"
member="GetProperties" error name="(unset)" requested_reply="0"
destination="org.bluez" (uid=0 pid=603 comm="/usr/sbin/bluetoothd ")
May  1 14:10:39 p5s800-vm dbus[411]: [system] Rejected send message, 2
matched rules; type="method_call", sender=":1.37" (uid=100 pid=1037
comm="/usr/bin/pulseaudio --start ") interface="org.bluez.Audio"
member="GetProperties" error name="(unset)" requested_reply="0"
destination="org.bluez" (uid=0 pid=603 comm="/usr/sbin/bluetoothd ")
May  1 14:10:39 p5s800-vm dbus[411]: [system] Rejected send message, 2
matched rules; type="method_call", sender=":1.37" (uid=100 pid=1037
comm="/usr/bin/pulseaudio --start ") interface="org.bluez.Audio"
member="GetProperties" error name="(unset)" requested_reply="0"
destination="org.bluez" (uid=0 pid=603 comm="/usr/sbin/bluetoothd ")
May  1 14:10:39 p5s800-vm dbus[411]: [system] Rejected send message, 2
matched rules; type="method_call", sender=":1.37" (uid=100 pid=1037
comm="/usr/bin/pulseaudio --start ") interface="org.bluez.Audio"
member="GetProperties" error name="(unset)" requested_reply="0"
destination="org.bluez" (uid=0 pid=603 comm="/usr/sbin/bluetoothd ")
May  1 14:10:39 p5s800-vm dbus[411]: [system] Rejected send message, 2
matched rules; type="method_call", sender=":1.37" (uid=100 pid=1037
comm="/usr/bin/pulseaudio --start ") interface="org.bluez.Audio"
member="GetProperties" error name="(unset)" requested_reply="0"
destination="org.bluez" (uid=0 pid=603 comm="/usr/sbin/bluetoothd ")
May  1 14:10:39 p5s800-vm dbus[411]: [system] Rejected send message, 2
matched rules; type="method_call", sender=":1.37" (uid=100 pid=1037
comm="/usr/bin/pulseaudio --start ") interface="org.bluez.Audio"
member="GetProperties" error name="(unset)" requested_reply="0"
destination="org.bluez" (uid=0 pid=603 comm="/usr/sbin/bluetoothd ")
May  1 14:10:39 p5s800-vm dbus[411]: [system] Rejected send message, 2
matched rules; type="method_call", sender=":1.37" (uid=100 pid=1037
comm="/usr/bin/pulseaudio --start ") interface="org.bluez.Audio"
member="GetProperties" error name="(unset)" requested_reply="0"
destination="org.bluez" (uid=0 pid=603 comm="/usr/sbin/bluetoothd ")
May  1 14:10:39 p5s800-vm dbus[411]: [system] Rejected send message, 2
matched rules; type="method_call", sender=":1.37" (uid=100 pid=1037
comm="/usr/bin/pulseaudio --start ") interface="org.bluez.Audio"
member="GetProperties" error name="(unset)" requested_reply="0"
destination="org.bluez" (uid=0 pid=603 comm="/usr/sbin/bluetoothd ")
May  1 14:10:39 p5s800-vm dbus[411]: [system] Rejected send message, 2
matched rules; type="method_call", sender=":1.37" (uid=100 pid=1037
comm="/usr/bin/pulseaudio --start ") interface="org.bluez.Audio"
member="GetProperties" error name="(unset)" requested_reply="0"
destination="org.bluez" (uid=0 pid=603 comm="/usr/sbin/bluetoothd ")
May  1 14:10:39 p5s800-vm dbus[411]: [system] Rejected send message, 2
matched rules; type="method_call", sender=":1.37" (uid=100 pid=1037
comm="/usr/bin/pulseaudio --start ") interface="org.bluez.Audio"
member="GetProperties" error name="(unset)" requested_reply="0"
destination="org.bluez" (uid=0 pid=603 comm="/usr/sbin/bluetoothd ")
May  1 14:10:39 p5s800-vm dbus[411]: [system] Rejected send message, 2
matched rules; type="method_call", sender=":1.37" (uid=100 pid=1037
comm="/usr/bin/pulseaudio --start ") interface="org.bluez.Audio"
member="GetProperties" error name="(unset)" requested_reply="0"
destination="org.bluez" (uid=0 pid=603 comm="/usr/sbin/bluetoothd ")
May  1 14:10:39 p5s800-vm dbus[411]: [system] Rejected send message, 2
matched rules; type="method_call", sender=":1.37" (uid=100 pid=1037
comm="/usr/bin/pulseaudio --start ") interface="org.bluez.Audio"
member="GetProperties" error name="(unset)" requested_reply="0"
destination="org.bluez" (uid=0 pid=603 comm="/usr/sbin/bluetoothd ")
May  1 14:10:39 p5s800-vm dbus[411]: [system] Rejected send message, 2
matched rules; type="method_call", sender=":1.37" (uid=100 pid=1037
comm="/usr/bin/pulseaudio --start ") interface="org.bluez.Audio"
member="GetProperties" error name="(unset)" requested_reply="0"
destination="org.bluez" (uid=0 pid=603 comm="/usr/sbin/bluetoothd ")

and I think this say something about "why" I can't do "A2DP"

> Btw, for the class it actually gets updated automatically when you
> register the services.
> 
I'm trying to streaming audio from cellphone, to Computer, but there is
unlimited dbus and pulse errors upthere, I don't know If I should
register some services and really don't know how to do that...

Thank you for all information, I starting reading about dbus for see
if I can do something, again, if theres any information it will be
valuable... Regards
