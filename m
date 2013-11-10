Return-Path: <cyrus@holtmann.org>
From: Michael Kehm <Michael@kehm.cx>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Reading RSSI value from an RFCOMM connection
Date: Sun, 10 Nov 2013 06:31:35 +0000
Message-ID: <143dd8d2d4ec433e843fc98d67dd0a55@corinto.intern.hamm.cx>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi folks,

I am trying to get the RSSI value from an established RFCOMM connection.
While searching on the Internet for hints I found the following discussions:
http://comments.gmane.org/gmane.linux.bluez.user/9986
http://stackoverflow.com/questions/2149295/android-2-1-how-do-i-poll-the-rssi-value-of-an-existing-bluetooth-connection
http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel&style=nested&viewmonth=200505&viewday=17

Most suggestions point to the hci_read_rssi API (int hci_read_rssi(int dd, uint16_t handle, int8_t *rssi, int to);).
I am using Python. As a basic skeleton I am using Albert Huang's rfcomm-client.py and rfcomm-server.py scripts.
Looking into bluez.py and inquiry-with-rssi.py samples, it helped me to understand how to access the hci layer but I am stuck in execution.

This is my script based on rfcomm-server.py:

import os, sys, struct, fcntl, array, binascii
import btcommon
import bluetooth._bluetooth as _bt
from bluetooth import *

#################################################################
# Added code
def get_acl_conn_handle (hci_sock, addr):
    hci_fd = hci_sock.fileno ()
    reqstr = struct.pack ("6sB17s", _bt.str2ba (addr), _bt.ACL_LINK, "\0" * 17)
    request = array.array ("c", reqstr)

    print "ACL_LINK:%s" % _bt.ACL_LINK
    print "hci_fd:%s" % hci_fd
    print "HCIGETCONNINFO:%s" % _bt.HCIGETCONNINFO
    print "request:%s" % request
    fcntl.ioctl (hci_fd, _bt.HCIGETCONNINFO, request, 1)

    try:
        fcntl.ioctl (hci_fd, _bt.HCIGETCONNINFO, request, 1)
    except IOError, e:
        raise BluetoothError ("There is no ACL connection to %s" % addr)

    # XXX should this be "<8xH14x"?
    handle = struct.unpack ("8xH14x", request.tostring ())[0]
    return handle
#################################################################

server_sock=BluetoothSocket( RFCOMM )
server_sock.bind(("",PORT_ANY))
server_sock.listen(1)

port = server_sock.getsockname()[1]

uuid = "94f39d29-7d6d-437d-973b-fba39e49d4ee"

advertise_service( server_sock, "SampleServer",
                   service_id = uuid,
                   service_classes = [ uuid, SERIAL_PORT_CLASS ],
                   profiles = [ SERIAL_PORT_PROFILE ], 
#                   protocols = [ OBEX_UUID ] 
                    )
                   
print "Waiting for connection on RFCOMM channel %d" % port

client_sock, client_info = server_sock.accept()
print "Accepted connection from ", client_info

#################################################################
# Added code
rssi = 0
handle = get_acl_conn_handle(server_sock._sock, client_info[0])
rssi = bluez.hci_read_rssi(server_sock._sock, handle, rssi, 1000)
#################################################################

try:
    client_sock.send(rssi)
    print "sent [%s]" % rssi
        
except IOError:
    pass

print "disconnected"

client_sock.close()
server_sock.close()
print "all done"


I have added/copied the get_acl_conn_handle function and the call to hci_read_rssi.
The problem is that I run into the following exception:

Traceback (most recent call last):
  File "rfcomm-rssi.py", line 48, in <module>
    handle = get_acl_conn_handle(server_sock._sock, client_info[0])
  File "rfcomm-rssi.py", line 16, in get_acl_conn_handle
    fcntl.ioctl (hci_fd, _bt.HCIGETCONNINFO, request, 1)
IOError: [Errno 22] Invalid argument


The print statements in get_acl_conn_handle return the following information:

ACL_LINK:1
hci_fd:3
HCIGETCONNINFO:-2147202859
request:array('c', '9\x91\x97g\x1d\x1c\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00')


I am bit lost on how to fix this. 
If anyone can help me with my script above or if anyone has sample code in Python or C how to get the RSSI data from a RFCOMM connection then I would highly appreciate it.

Thanks in advance,
Michael
