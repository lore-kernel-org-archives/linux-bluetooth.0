Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: obexd-0.8 get OBEX_HDR_NAME NULL
Date: Wed, 4 Mar 2009 21:32:47 +0800
Message-ID: <9F2B2656C8747B498D56A7B30FF5EB9FF9DAEF@CNMAIL13.cn.utstarcom.com>
From: "Yao Ye" <yeyao@utstar.com>
To: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi, all :

I'm using obexd-0.8 and openobex-1.5 on my pxa310 platform. 
and I want to send files from a mobile phone to the platform.

but, when i start receive-file agent, it exit quickly, and no files have
been received !
I found that: in obexd-0.8/src/obex.c, line 644, func: check_put, there
is:

os->name = g_convert((const gchar *) hd.bs, hlen,
        "UTF8", "UTF16BE", NULL, NULL, NULL);
debug("OBEX_HDR_NAME: %s", os->name);

on my platform, hlen is correct, but hd.bs is empty. so get os->name is
NULL.
then, in obexd-0.8/src/obex.c, line 688, it is failure, and returned.

if (!os->name) {
        OBEX_ObjectSetRsp(obj, OBEX_RSP_BAD_REQUEST,
                OBEX_RSP_BAD_REQUEST);
        g_free(os->type);
        os->type = NULL;
        return FALSE;
}

How to fix it ? why the hd.bs is empty ?
Thanks in advance for any helps.

Best regards
yesir Yao.

The following is the loginfo:
------------------------------------------------------------------------
----------------------
[root@Linux /bttest]#dbus-uuidgen > /var/lib/dbus/machine-id
[root@Linux /bttest]#dbus-launch
DBUS_SESSION_BUS_ADDRESS=unix:abstract=/tmp/dbus-Amu3d6czKe,guid=1a75898
42235f1e5736d9643000000fd
DBUS_SESSION_BUS_PID=913
[root@Linux /bttest]#
[root@Linux /bttest]#export
DBUS_SESSION_BUS_ADDRESS=unix:abstract=/tmp/dbus-Amu3d6czKe,guid=1a75898
42235f1e5736d9643000000fd
[root@Linux /bttest]#
[root@Linux /bttest]#export DBUS_SESSION_BUS_PID=913
[root@Linux /bttest]#
[root@Linux /bttest]#obexd --nodaemon --opp --ftp -d -a -r /bttest &
[root@Linux /bttest]#
obexd[914]: Enabling debug information
obexd[914]: manager_init:
obexd[914]: Loading plugins /lib/obex/plugins
bluetoothd[892]: New attribute 0x0001
bluetoothd[892]: New attribute 0x0004
bluetoothd[892]: New attribute 0x0009
bluetoothd[892]: New attribute 0x0100
bluetoothd[892]: Text size 19 length 18: -->Object Push server<--
bluetoothd[892]: New attribute 0x0303
bluetoothd[892]: Adding record with handle 0x10007
bluetoothd[892]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[892]: Record pattern UUID 00000008-0000-1000-8000-00805f9
bluetoothd[892]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[892]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[892]: Record pattern UUID 00001105-0000-1000-8000-00805f9
bluetoothd[892]: listener_id 2
bluetoothd[892]: New attribute 0x0001
bluetoothd[892]: New attribute 0x0004
bluetoothd[892]: New attribute 0x0009
bluetoothd[892]: New attribute 0x0100
bluetoothd[892]: Text size 21 length 20: -->File Transfer server<--
bluetoothd[892]: Adding record with handle 0x10008
bluetoothd[892]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[892]: Record pattern UUID 00000008-0000-1000-8000-00805f9
bluetoothd[892]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[892]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[892]: Record pattern UUID 00001106-0000-1000-8000-00805f9
bluetoothd[892]: listener_id 3
obexd[914]: Registered: Object Push server, handle: 0x10007, folder:
/bttest
obexd[914]: Registered: File Transfer server, handle: 0x10008, folder:
/bttest

[root@Linux /bttest]ps
  PID  Uid     VmSize Stat Command

  836 root         92 S   telnetd -l /bin/sh
  838 root        952 S   -sh
  846 root        448 S < udevd -d
  880 root        212 S   hciattach /dev/ttyS0 bcsp 921600 flow
  886 messageb    844 S   dbus-daemon --system
  892 root       2104 S   bluetoothd -d
  898 root        764 S   agent 0000
  913 root        788 S   /usr/bin/dbus-daemon --fork --print-pid 4
--print-add
  914 root       1508 S   obexd --nodaemon --opp --ftp -d -a -r /bttest
  972 root        800 R   ps
[root@Linux /bttest]#

#####-----> receive-files is a dbus c agent, same as Python
scripts(obexd-0.8/test/simple-agent)

[root@Linux /bttest]#./receive-files /bttest/1.wav &

obex file path = /bttest/1.wav
Obex receiver : session bus connected
Obex sender : registered on bus as org.openobex
obexd[914]: Agent registered
register_agent OK!

##### ---->   now, send files from mobile phone (MOTO E6) to platform

bluetoothd[892]: adapter_get_device(00:1A:77:77:14:84)
obexd[914]: New connection from: 00:1A:77:77:14:84, channel 9, fd 7
obexd[914]: REQHINT(0x1), CONNECT(0x0), (null)(0x0)
obexd[914]: REQ(0x2), CONNECT(0x0), (null)(0x0)
obexd[914]: Version: 0x10. Flags: 0x00  OBEX packet length: 4000
obexd[914]: Resizing stream chunks to 3800
obexd[914]: REQDONE(0x3), CONNECT(0x0), (null)(0x0)
obexd[914]: REQHINT(0x1), PUT(0x2), (null)(0x0)
obexd[914]: REQCHECK(0xb), PUT(0x2), (null)(0x0)
obexd[914]: OBEX_HDR_LENGTH: 1040429              <----  file length is
right
obexd[914]: OBEX_HDR_NAME: (null)                <----  file name is
NULL  *************@@@
obexd[914]: OBEX_HDR_TYPE:
obexd[914]: REQDONE(0x3), PUT(0x2), (null)(0x0)
TransferCompleted, success = 0, objpath=/transfer8
obexd[914]: REQHINT(0x1), DISCONNECT(0x1), (null)(0x0)
obexd[914]: REQ(0x2), DISCONNECT(0x1), (null)(0x0)
obexd[914]: REQDONE(0x3), DISCONNECT(0x1), (null)(0x0)
obexd[914]: HUP

##### ---->   exit, and no files have been received ! 

