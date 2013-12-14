Return-Path: <cyrus@holtmann.org>
Message-ID: <52AC4425.7080109@ahsoftware.de>
Date: Sat, 14 Dec 2013 12:42:29 +0100
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Shouldn't bluez serialize connection/authorization attempts?
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I've experienced a small problem which makes me wonder how userspace is 
expected to handle that.

To explain the problem, I use simple-agent and rfcomm on the local side 
(Linux with bluez) and a remote device with a fixed pin (without user 
interaction, it refuses or allows connections based on the pin), but I 
think the underlying problem is independent of that configuration.

Furthermore, I did a small patch to the local simple-agent:
-----------------
diff --git a/test/simple-agent b/test/simple-agent
index 854e1af..63b705b 100755
--- a/test/simple-agent
+++ b/test/simple-agent
@@ -64,8 +64,9 @@ class Agent(dbus.service.Object):
                                         in_signature="o", 
out_signature="s")
         def RequestPinCode(self, device):
                 print("RequestPinCode (%s)" % (device))
-               set_trusted(device)
-               return ask("Enter PIN Code: ")
+               #set_trusted(device)
+               #return ask("Enter PIN Code: ")
+               return "666"

         @dbus.service.method(AGENT_INTERFACE,
                                         in_signature="o", 
out_signature="u")
-----------------

That means it now always returns 666 as pin without asking the user. 
This pin doesn't match the pin of the remote device.

If I now call

for i in $(seq 1 100); do rfcomm connect rfcomm666 aa:bb:cc:dd:ee:ff ; done

in a shell, only one Pin request (the first) ends up at simple-agent but 
all connection attempts are refused.

So besides the first connection attempt, all others do die somewhere 
where userspace has no control over.

What happens is likely that connection attempts are refused by the 
remote side, because an ongoing connection or authorization attempt 
isn't finished while a new one arrives.

The problem I see here is, that userspace has no control about what 
happens during a connection attempt. And userspace doesn't know if any 
other process just did a connection attempt too. How should userspace 
behave to make sure every connection attempt ends up in a pin-request 
for the user?

Shouldn't those connection/pairing/authorization attempts to the same 
remote device be serialized by bluez?

Regards,

Alexander Holler
