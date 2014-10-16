Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: 'Bharat Panda' <bharat.panda@samsung.com>,
	'Dmitry Kasatkin' <d.kasatkin@samsung.com>, cpgs@samsung.com
Subject: Query regarding creation of multiple MAS Instance ID:
Date: Thu, 16 Oct 2014 19:48:23 +0530
Message-id: <000b01cfe94c$216de430$6449ac90$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

I am working on obexd MAP profile. Is it possible to create multiple MAS
Instance in bluez? 
Because right now bluez has only one MAS Instance support (only one
MAS_UUID), which is advertised to MCE based on the XML format followed in
src/profile.c.
When I add one more record to MAS_RECORD XML format by changing the value as
0x01, I am not able see two instances getting loaded.
		<attribute id=\"0x0315\">				\
			<uint8 value=\"0x01\"/>			\
		</attribute>						\

Do we need to create one more UUID like OBEX_MAS1_UUID and OBEX_MAS2_UUID to
support multiple mas instances?  
Or what could be the possible solutions?

Regards.
Gowtham Anandha Babu

