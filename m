Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030717171104.091fb2c0@unixmail.qualcomm.com>
Date: Thu, 17 Jul 2003 17:19:01 -0700
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>, Stephen Crane <steve.crane@rococosoft.com>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: Version 3 libs/utils
Cc: Philip Blundell <pb@nexus.co.uk>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1057163407.963.122.camel@pegasus>
References: <1057134871.523.123.camel@baroque.rococosoft.com>
	<5.1.0.14.2.20030630170200.0e4c3e28@unixmail.qualcomm.com>
	<1057107686.15797.101.camel@pegasus>
	<1057134871.523.123.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 09:29 AM 7/2/2003, Marcel Holtmann wrote:
 
>> Asynchronous interface to inquiry?
>
>Yes, of course. I forgot this point. A common inquiry interface can
>maybe also included into btmgr and forward inquiry event to the
>application. Any ideas how to implement this in a clean way?
Should be easy. And there is no need to go via btmgr.
HCI core can simply filter hci_inquiry command and drop it if inquiry is already
in progress. Applications will simply listen on raw socket and invoke callbacks 
for each inquiry_info event.

Max
