Return-Path: <cyrus@holtmann.org>
Message-Id: <1360448522.23439.140661189177761.7087C9E4@webmail.messagingengine.com>
From: Rebecca Menessec <rebecca.menessec@ironhavoc.org>
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain
Subject: Missing manpage for main.conf
Reply-To: rebecca.menessec@ironhavoc.org
Date: Sat, 09 Feb 2013 17:22:02 -0500
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I was looking for a way to disable BlueZ logging (Ubuntu machine), and
came across this, in the bluetoothd manpage:

'bluetoothd itself does not accept many command-line options, as most of
its configuration is done in the /etc/bluetooth/main.conf file, which
has its own man page.'

That doesn't appear to be true. I can't find any trace in any distro, or
in the source. I've found a bug filed here and there against the lack of
manpage, but no manpage.

There's definitely logging going on by default:

localhost ~ [0]# lsof -n 2> /dev/null | grep blue | grep log
rsyslogd   804          syslog    2w      REG               0,21    
2027       8482 /var/log/bluetoothd.log
rs:main    804  813     syslog    2w      REG               0,21    
2027       8482 /var/log/bluetoothd.log
rsyslogd   804  814     syslog    2w      REG               0,21    
2027       8482 /var/log/bluetoothd.log
rsyslogd   804  815     syslog    2w      REG               0,21    
2027       8482 /var/log/bluetoothd.log

Unfortunately, there's no hint anywhere what's causing bluetoothd to
log, or how to stop it.
