Return-Path: <cyrus@holtmann.org>
From: Vijaykumar Dadmode <Vijaykumar.Dadmode@csr.com>
To: "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
Subject: Multiple Thermometer device connections. 
Date: Tue, 3 Jan 2012 09:47:11 +0000
Message-ID: <F82830D409D80E4881C83250E051B74B4A040CBD@banasiexm01.ASIA.ROOT.PRI>
References: <F82830D409D80E4881C83250E051B74B4784BC9E@banasiexm01.ASIA.ROOT.PRI>
In-Reply-To: <F82830D409D80E4881C83250E051B74B4784BC9E@banasiexm01.ASIA.ROOT.PRI>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
Could you please help me with below query? 

Usecase:
Have 2 temperature devices connected and set the CCC(Client Char Config) to receive the temperature updates.

Issue:
-- In attio_connected_cb we are calling g_attrib_register(user_data) were we are passing the "user_data" which has the "Device Reference". 

So in the callback function "notif_handler" we are getting notified from the 1st connected device, using the "user_data" we are trying to get the "Device Reference", which has the data/info of the 2nd device rather than the 1st device. 

How do we retrieve the handle/device reference for the device which is sending the "NOTIFY"? 


Thanks,
Vijay


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
