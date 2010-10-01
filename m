Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 1 Oct 2010 11:55:09 +0530
Message-ID: <AANLkTimDw_obL=cV-CjU5OPCH+PiTqSyQ+0JTy1o+=3Q@mail.gmail.com>
Subject: How to ensure pairing is done
From: "Yedire, Sandeep" <syedire@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi there,
I am currently working with A2DP. I have installed Bluez-4.69 for
target(MIPS). I have also set-up dbus-daemon and bluetoothd deamon. By
executing the test programs on Bluez-4.69

./l2test -c <bdaddr>

I get below error message
l2test[476]: Can't connect: Connection refused (146)

I could connect the device by SOCK_RAW mode and able to send. But in
SOCK_SEQPACKET,  I am unable to connect and will get the above error.

Now my doubt: How do I ensure pairing is done properly?

I followed these steps below for dbus-daemon, bluetoothd
<>dbus-uuidgen --ensure
<>export DBUG_VERBOSE=1
<>adduser -DH messagebus
<>addgroup messagebus messagebus
<>dbus-daemon --system
<>bluetoothd -d
<>ps -ef to check dbus-daemon, bluetoothd running
<>./agent 0000 <baddr>

After executing the last command (./agent 000 <baddr>) the headset
changes its blinking pattern from red-blue blink to blue-blue blink.
The same behaviour happens with my mobile during pairing with my
mobile.

Please let me know if any one is aware why in  SOCK_SEQPACKET mode,
connect system call will fail.
 What is the cause of this error? I get <146> connection refused.

 How to ensure this pairing is done?

below is log message attached during execution of (./agent 0000 <baddr>)
________________________________________________________________
./agent --adapter hci0 0000 00:1E:7C:00:B7:AD
lockd: cannot monitor 136.170.194.184
lockd: failed to monitor 136.170.194.184
lockd: cannot monitor 136.170.194.184
lockd: failed to monitor 136.170.194.184
lockd: cannot monitor 136.170.194.184
lockd: failed to monitor 136.170.194.184
lockd: cannot monitor 136.170.194.184
lockd: failed to monitor 136.170.194.184
lockd: cannot monitor 136.170.194.184
lockd: failed to monitor 136.170.194.184
lockd: cannot monitor 136.170.194.184
lockd: failed to monitor 136.170.194.184
lockd: cannot monitor 136.170.194.184
lockd: failed to monitor 136.170.194.184
lockd: cannot monitor 136.170.194.184
lockd: failed to monitor 136.170.194.184
Pincode request for device /org/bluez/379/hci0/dev_00_1E_7C_00_B7_AD
lockd: cannot monitor 136.170.194.184
lockd: failed to monitor 136.170.194.184
lockd: cannot monitor 136.170.194.184
lockd: failed to monitor 136.170.194.184
lockd: cannot monitor 136.170.194.184
lockd: failed to monitor 136.170.194.184
lockd: cannot monitor 136.170.194.184
lockd: failed to monitor 136.170.194.184
Agent has been released
<>
Regards,
Sandeep.Yedire

----------------------------------------------------------
T.Jefferson, 'Victory and defeat are each of the same price"
