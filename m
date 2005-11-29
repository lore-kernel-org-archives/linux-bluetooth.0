Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] avrcp start
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <438C8EDE.1010309@xmission.com>
References: <438C8EDE.1010309@xmission.com>
Content-Type: text/plain
Message-Id: <1133296630.23817.5.camel@blade>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 29 Nov 2005 21:37:10 +0100

Hi Brad,

> I've started an avrcp receiver in the btsco cvs.
> 
> I hope it doesn't seem like a case of extreme laziness to put the sdp
> stuff in sdptool. I suppose I should get serious and put it in my app
> too. Did I write the patch right with regard to protocol names, etc?
> 
> Also, is there a separate UUID for AVRCP? I only found AVCTP UUID
> definitions, but it seems like PID in the AVCTP header needs to indicate
> AVRCP specifically.
> 
> With the changes above, I got my headset to connect but it seems to put
> in the value "0e11" for the pid in the first AVRCP packet I got out of it.

you actually copied to much from on of the A2DP record handlers. The
specification definces the AVRCP CT service record like this:

        Attribute 0x0000 - ServiceRecordHandle
                UINT32 0x00010000
        Attribute 0x0001 - ServiceClassIDList
                Sequence
                        UUID16 0x110e - RemoteControl
        Attribute 0x0004 - ProtocolDescriptorList
                Sequence
                        Sequence
                                UUID16 0x0100 - L2CAP
                                UINT16 0x0017
                        Sequence
                                UUID16 0x0017 - AVCTP
                                UINT16 0x0100
        Attribute 0x0005 - BrowseGroupList
                Sequence
                        UUID16 0x1002 - PublicBrowseGroup
        Attribute 0x0009 - BluetoothProfileDescriptorList
                Sequence
                        Sequence
                                UUID16 0x110e - RemoteControl
                                UINT16 0x0100
        Attribute 0x0100
                String AVRCP CT
        Attribute 0x0311
                UINT16 0x000f

You need the supported features attribute. The correct PSM and protocol
and profile descriptors. The AVRCP TG looks like this:

        Attribute 0x0000 - ServiceRecordHandle
                UINT32 0x00010001
        Attribute 0x0001 - ServiceClassIDList
                Sequence
                        UUID16 0x110c - RemoteControlTarget
        Attribute 0x0004 - ProtocolDescriptorList
                Sequence
                        Sequence
                                UUID16 0x0100 - L2CAP
                                UINT16 0x0017
                        Sequence
                                UUID16 0x0017 - AVCTP
                                UINT16 0x0100
        Attribute 0x0005 - BrowseGroupList
                Sequence
                        UUID16 0x1002 - PublicBrowseGroup
        Attribute 0x0009 - BluetoothProfileDescriptorList
                Sequence
                        Sequence
                                UUID16 0x110e - RemoteControl
                                UINT16 0x0100
        Attribute 0x0100
                String AVRCP TG
        Attribute 0x0311
                UINT16 0x000f

Functions for both records are in the CVS now.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
