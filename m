Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: 'Bharat Panda' <bharat.panda@samsung.com>, cpgs@samsung.com,
	'Dmitry Kasatkin' <d.kasatkin@samsung.com>
Subject: Query regarding sdptool
Date: Tue, 11 Nov 2014 18:50:13 +0530
Message-id: <000601cffdb2$4e3e8580$eabb9080$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

I am currently testing sdptool. 
The issues I am facing are, 

1) When I run ./sdptool del PBAP, I am getting the below error: 
" No local SDP server!"

2) When I run ./sdptool get PBAP, I am getting the below error: 
"Failed to connect to SDP server on FF:FF:FF:00:00:00: Connection refused"

3) when I run ./sdptool add PBAP, Nothing is printing, I don't know whether
it is added or not.

Bluetoothd is running and hci0 is up. Is there any file/script that I need
to run to make Local SDP server UP?

Regards,
Gowtham Anandha Babu

