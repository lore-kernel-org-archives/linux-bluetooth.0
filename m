Return-Path: <cyrus@holtmann.org>
From: Smriti GUPTA <smriti.gupta@stericsson.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Naresh-kumar GUPTA <naresh.gupta@stericsson.com>
Date: Mon, 26 Dec 2011 11:04:03 +0100
Subject: [RFC Bluez] ATT Disconnect
Message-ID: <7E02D43720E46647A0E6521055937EC915D8CE4DAF@EXDCVYMBSTM005.EQ1STM.local>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am working on Proximity Monitor Role using BlueZ 4.96+ and I am planning to implement the "disconnect" function to terminate connection from the monitor side.
I have added a new  function "att_disconnect" in device.c for the same.

Please have a look at the patch, I am about to send and let me know your comments.

Thanks
Smriti Gupta
ST-Ericsson India
