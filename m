Return-Path: <cyrus@holtmann.org>
Message-ID: <4B1B7EBF.8020803@pricom.com.au>
Date: Sun, 06 Dec 2009 20:51:59 +1100
From: Philip Rhoades <phil@pricom.com.au>
Reply-To: phil@pricom.com.au
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: LG U880 mobile phone "Connection dropped" message
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

People,

Trying to send a file from an LG U880 mobile phone to my Fedora 12 
server after a few seconds gives a "Connection dropped" message.  The 
bluetoothd on the server logs:

bluetoothd[714]: link_key_request (sba=00:11:67:55:91:FC, 
dba=00:12:56:CC:63:B6)
bluetoothd[714]: kernel auth requirements = 0x00
bluetoothd[714]: stored link key type = 0x00
bluetoothd[714]: adapter_get_device(00:12:56:CC:63:B6)

which does not give me much info about why the connection was dropped (I 
can send files from the server to the phone OK).

Any ideas about what the problem is?  Is there some way of getting a 
more verbose log? (I am already using the -d switch).

Thanks,

Phil.
-- 
Philip Rhoades

GPO Box 3411
Sydney NSW	2001
Australia
E-mail:  phil@pricom.com.au
