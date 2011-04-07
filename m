Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1302177682-7873-1-git-send-email-szymon.janc@tieto.com>
References: <1302177682-7873-1-git-send-email-szymon.janc@tieto.com>
Date: Thu, 7 Apr 2011 18:48:20 +0300
Message-ID: <BANLkTinwyumKSUXq7LZkWrABwD8Xwih5cw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Move Agent and Rejected classes from simple-agent to agent.py
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Apr 7, 2011 at 3:01 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Moving agent implementation to agent.py will allow to easily reuse
> this code by other tests if needed.
> ---
>  .gitignore        |    1 +
>  Makefile.tools    |    4 +-
>  test/agent.py     |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  test/simple-agent |   68 +--------------------------------------------------
>  4 files changed, 74 insertions(+), 69 deletions(-)
>  create mode 100644 test/agent.py
>
> diff --git a/.gitignore b/.gitignore
> index 2ef7cb5..1eda4d3 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -80,6 +80,7 @@ test/ipctest
>  test/btiotest
>  test/test-textfile
>  test/uuidtest
> +test/agent.pyc
>  compat/dund
>  compat/hidd
>  compat/pand
> diff --git a/Makefile.tools b/Makefile.tools
> index f6d7b13..de45371 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -205,8 +205,8 @@ EXTRA_DIST += test/apitest test/sap-client test/hsplay test/hsmicro \
>                test/test-telephony test/test-network test/simple-agent \
>                test/simple-service test/simple-endpoint test/test-audio \
>                test/test-input test/test-attrib test/test-sap-server \
> -               test/service-record.dtd test/service-did.xml test/service-spp.xml \
> -               test/service-opp.xml test/service-ftp.xml
> +               test/agent.py test/service-record.dtd test/service-did.xml \
> +               test/service-spp.xml test/service-opp.xml test/service-ftp.xml
>
>
>  if HIDD
> diff --git a/test/agent.py b/test/agent.py
> new file mode 100644
> index 0000000..d58ddd9
> --- /dev/null
> +++ b/test/agent.py
> @@ -0,0 +1,70 @@
> +#!/usr/bin/python
> +
> +import dbus
> +import dbus.service
> +
> +class Rejected(dbus.DBusException):
> +       _dbus_error_name = "org.bluez.Error.Rejected"
> +
> +class Agent(dbus.service.Object):
> +       exit_on_release = True
> +
> +       def set_exit_on_release(self, exit_on_release):
> +               self.exit_on_release = exit_on_release
> +
> +       @dbus.service.method("org.bluez.Agent",
> +                                       in_signature="", out_signature="")
> +       def Release(self):
> +               print "Release"
> +               if self.exit_on_release:
> +                       mainloop.quit()
> +
> +       @dbus.service.method("org.bluez.Agent",
> +                                       in_signature="os", out_signature="")
> +       def Authorize(self, device, uuid):
> +               print "Authorize (%s, %s)" % (device, uuid)
> +               authorize = raw_input("Authorize connection (yes/no): ")
> +               if (authorize == "yes"):
> +                       return
> +               raise Rejected("Connection rejected by user")
> +
> +       @dbus.service.method("org.bluez.Agent",
> +                                       in_signature="o", out_signature="s")
> +       def RequestPinCode(self, device):
> +               print "RequestPinCode (%s)" % (device)
> +               return raw_input("Enter PIN Code: ")
> +
> +       @dbus.service.method("org.bluez.Agent",
> +                                       in_signature="o", out_signature="u")
> +       def RequestPasskey(self, device):
> +               print "RequestPasskey (%s)" % (device)
> +               passkey = raw_input("Enter passkey: ")
> +               return dbus.UInt32(passkey)
> +
> +       @dbus.service.method("org.bluez.Agent",
> +                                       in_signature="ou", out_signature="")
> +       def DisplayPasskey(self, device, passkey):
> +               print "DisplayPasskey (%s, %d)" % (device, passkey)
> +
> +       @dbus.service.method("org.bluez.Agent",
> +                                       in_signature="ou", out_signature="")
> +       def RequestConfirmation(self, device, passkey):
> +               print "RequestConfirmation (%s, %d)" % (device, passkey)
> +               confirm = raw_input("Confirm passkey (yes/no): ")
> +               if (confirm == "yes"):
> +                       return
> +               raise Rejected("Passkey doesn't match")
> +
> +       @dbus.service.method("org.bluez.Agent",
> +                                       in_signature="s", out_signature="")
> +       def ConfirmModeChange(self, mode):
> +               print "ConfirmModeChange (%s)" % (mode)
> +               authorize = raw_input("Authorize mode change (yes/no): ")
> +               if (authorize == "yes"):
> +                       return
> +               raise Rejected("Mode change by user")
> +
> +       @dbus.service.method("org.bluez.Agent",
> +                                       in_signature="", out_signature="")
> +       def Cancel(self):
> +               print "Cancel"
> diff --git a/test/simple-agent b/test/simple-agent
> index f2cc3dd..2cba7a3 100755
> --- a/test/simple-agent
> +++ b/test/simple-agent
> @@ -3,75 +3,9 @@
>  import gobject
>
>  import sys
> -import dbus
> -import dbus.service
>  import dbus.mainloop.glib
>
> -class Rejected(dbus.DBusException):
> -       _dbus_error_name = "org.bluez.Error.Rejected"
> -
> -class Agent(dbus.service.Object):
> -       exit_on_release = True
> -
> -       def set_exit_on_release(self, exit_on_release):
> -               self.exit_on_release = exit_on_release
> -
> -       @dbus.service.method("org.bluez.Agent",
> -                                       in_signature="", out_signature="")
> -       def Release(self):
> -               print "Release"
> -               if self.exit_on_release:
> -                       mainloop.quit()
> -
> -       @dbus.service.method("org.bluez.Agent",
> -                                       in_signature="os", out_signature="")
> -       def Authorize(self, device, uuid):
> -               print "Authorize (%s, %s)" % (device, uuid)
> -               authorize = raw_input("Authorize connection (yes/no): ")
> -               if (authorize == "yes"):
> -                       return
> -               raise Rejected("Connection rejected by user")
> -
> -       @dbus.service.method("org.bluez.Agent",
> -                                       in_signature="o", out_signature="s")
> -       def RequestPinCode(self, device):
> -               print "RequestPinCode (%s)" % (device)
> -               return raw_input("Enter PIN Code: ")
> -
> -       @dbus.service.method("org.bluez.Agent",
> -                                       in_signature="o", out_signature="u")
> -       def RequestPasskey(self, device):
> -               print "RequestPasskey (%s)" % (device)
> -               passkey = raw_input("Enter passkey: ")
> -               return dbus.UInt32(passkey)
> -
> -       @dbus.service.method("org.bluez.Agent",
> -                                       in_signature="ou", out_signature="")
> -       def DisplayPasskey(self, device, passkey):
> -               print "DisplayPasskey (%s, %d)" % (device, passkey)
> -
> -       @dbus.service.method("org.bluez.Agent",
> -                                       in_signature="ou", out_signature="")
> -       def RequestConfirmation(self, device, passkey):
> -               print "RequestConfirmation (%s, %d)" % (device, passkey)
> -               confirm = raw_input("Confirm passkey (yes/no): ")
> -               if (confirm == "yes"):
> -                       return
> -               raise Rejected("Passkey doesn't match")
> -
> -       @dbus.service.method("org.bluez.Agent",
> -                                       in_signature="s", out_signature="")
> -       def ConfirmModeChange(self, mode):
> -               print "ConfirmModeChange (%s)" % (mode)
> -               authorize = raw_input("Authorize mode change (yes/no): ")
> -               if (authorize == "yes"):
> -                       return
> -               raise Rejected("Mode change by user")
> -
> -       @dbus.service.method("org.bluez.Agent",
> -                                       in_signature="", out_signature="")
> -       def Cancel(self):
> -               print "Cancel"
> +from agent import *
>
>  def create_device_reply(device):
>        print "New device (%s)" % (device)
> --

Im not sure if this is a good idea, in a single file it is easier to
copy this script around, also depending how this is installed it can
break simple-agent or make somebody to start using it agent as a
dependency in some other tool as some kind of python API so perhaps it
is better to just copy the code that you want from it.

-- 
Luiz Augusto von Dentz
Computer Engineer
