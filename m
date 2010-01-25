Return-Path: <cyrus@holtmann.org>
Message-ID: <670422.1091.qm@web52607.mail.re2.yahoo.com>
Date: Mon, 25 Jan 2010 08:53:17 -0800 (PST)
From: Ed Tsang <netdesign_98@yahoo.com>
Subject: dynamically change the local device name
To: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,  
I am looking into if it is possible to change the local device name base on the bluetooth address of the remote device.
 i.e. when a remote device request our name, we return a different name base on the the address of the remote device.
  There seem to be a hci_write_local_name to store the local name, but I could not find something similar to hci_pin_code_request_reply which seem to allow us to return a different value each time.
   Is there any work around??

Regards, Ed



      __________________________________________________________________
Looking for the perfect gift? Give the gift of Flickr! 

http://www.flickr.com/gift/
